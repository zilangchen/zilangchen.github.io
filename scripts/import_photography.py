#!/usr/bin/env python3
"""Import reviewed local photos without changing originals or publishing metadata.

Requires Pillow and macOS sips for HEIC/RAW. See scripts/photography.md.
Unknown or iCloud-only sources are reported and left out, never assigned a guessed year.
"""
import argparse
import hashlib
import io
import json
import re
import subprocess
import tempfile
from datetime import datetime
from pathlib import Path

from PIL import Image, ImageCms, ImageOps
from photography_pages import page_sources

ROOT = Path(__file__).resolve().parents[1]
EXTENSIONS = {'.jpg', '.jpeg', '.png', '.heic', '.heif', '.raf', '.dng'}
PHOTO_BUDGET = 64 * 1024 * 1024
THUMBNAIL_BUDGET = 2 * 1024 * 1024


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def atomic_write(path, content):
    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(dir=path.parent, delete=False) as stream:
        tmp = Path(stream.name)
        stream.write(content)
    tmp.replace(path)


def capture_date(image):
    exif = image.getexif()
    details = exif.get_ifd(34665) if 34665 in exif else {}
    for raw in (details.get(36867), details.get(36868)):
        if raw:
            try:
                return datetime.strptime(str(raw)[:19], '%Y:%m:%d %H:%M:%S').date().isoformat()
            except ValueError:
                pass
    # Image modification time is deliberately not a capture-date substitute.
    return None


def main():
    parser = argparse.ArgumentParser(description=__doc__, allow_abbrev=False)
    parser.add_argument('--source', required=True, type=Path)
    parser.add_argument('--curation', required=True, type=Path, help='Private JSON keyed by relative source filename; each entry needs alt, optional caption/order/position/date.')
    parser.add_argument('--report', required=True, type=Path, help='Private import manifest outside the public repository.')
    parser.add_argument('--previous-report', type=Path, help='Previous private report, retaining source hashes for offloaded originals.')
    args = parser.parse_args()
    source = args.source.expanduser().resolve(strict=True)
    report_path = args.report.expanduser().resolve()
    if report_path == ROOT or ROOT in report_path.parents:
        parser.error('--report must be outside the public repository')
    curation = json.loads(args.curation.read_text())
    data_path = ROOT / '_data/photography.json'
    previous = json.loads(data_path.read_text()) if data_path.exists() else {'albums': []}
    photos = {p['id']: p for a in previous['albums'] for p in a['photos']}
    manifest = {'source': str(source), 'imported': [], 'unchanged': [], 'skipped': [], 'errors': []}
    manifest['duplicates'] = []
    historical = json.loads(args.previous_report.read_text()) if args.previous_report else {}
    historical_rows = historical.get('catalog', historical.get('imported', []) + historical.get('unchanged', []))
    manifest['catalog'] = historical_rows  # Preserve last successful history even if this report records a failure.
    catalog = {row['file']: row for row in historical_rows}
    rendered_owners = {digest(ROOT / photo['url'].lstrip('/')): photo['id'] for photo in photos.values()}
    content_owners = {row['sha256']: row['id'] for row in historical_rows if row['id'] in photos}
    pixel_owners = {row['pixels']: row['id'] for row in historical_rows if row.get('pixels') and row['id'] in photos}
    staged = {}
    try:
        for path in sorted(source.rglob('*'), key=lambda p: (hashlib.sha256(p.relative_to(source).as_posix().encode()).hexdigest()[:16] not in photos, str(p))):
            if not path.is_file() or path.suffix.lower() not in EXTENSIONS:
                continue
            relative = path.relative_to(source).as_posix()
            if relative not in curation:
                manifest['skipped'].append({'file': relative, 'reason': 'Awaiting visual review and alt text'})
                continue
            if getattr(path.stat(), 'st_flags', 0) & 0x40000000:
                manifest['skipped'].append({'file': relative, 'reason': 'iCloud placeholder; original not yet local'})
                continue
            entry = curation[relative]
            if entry.get('duplicate_of'):
                manifest['duplicates'].append({'file': relative, 'duplicate_of': entry['duplicate_of'], 'reason': 'Visually verified duplicate'})
                continue
            if not entry.get('alt'):
                raise ValueError(f'Missing descriptive alt text: {relative}')
            identifier = hashlib.sha256(relative.encode()).hexdigest()[:16]
            checksum = digest(path)
            prior = catalog.get(relative)
            if prior and prior['sha256'] != checksum:
                # A replaced original no longer owns its former content fingerprint.
                if content_owners.get(prior['sha256']) == identifier:
                    del content_owners[prior['sha256']]
                if prior.get('pixels') and pixel_owners.get(prior['pixels']) == identifier:
                    del pixel_owners[prior['pixels']]
            current = photos.get(identifier)
            existing = ROOT / 'images/photography' / f'{identifier}.webp'
            if (prior and current and prior['sha256'] == checksum and prior.get('pixels') and existing.exists()
                    and current['alt'] == entry['alt'] and current['caption'] == entry.get('caption', '')
                    and current['order'] == entry.get('order', 100) and current.get('position') == entry.get('position')
                    and (not entry.get('date') or current.get('date') == entry['date'])):
                manifest['unchanged'].append(prior)
                continue
            owner = content_owners.get(checksum)
            if owner and owner != identifier:
                if identifier in photos:
                    raise RuntimeError(f'Existing original now duplicates another photograph: {relative}; review before merging IDs')
                manifest['duplicates'].append(dict(file=relative, duplicate_id=owner, reason='Identical source SHA256'))
                continue
            destination = ROOT / 'images/photography' / f'{identifier}.webp'
            # Source checksum is kept only in the private report. Re-encoding is
            # deterministic and ensures edited originals are picked up on re-import.
            with tempfile.TemporaryDirectory(prefix='photo-import-') as tmp:
                decoded = path
                if path.suffix.lower() in {'.heic', '.heif', '.raf', '.dng'}:
                    decoded = Path(tmp) / 'decoded.jpg'
                    result = subprocess.run(['/usr/bin/sips', '-s', 'format', 'jpeg', str(path), '--out', str(decoded)], capture_output=True, text=True, timeout=40)
                    if result.returncode != 0:
                        raise RuntimeError(f'Image conversion failed: {relative}: {result.stderr}')
                with Image.open(decoded) as original:
                    date = entry.get('date') or capture_date(original)
                    if date:
                        datetime.strptime(date, '%Y-%m-%d')
                    image = ImageOps.exif_transpose(original)
                    if image.info.get('icc_profile'):
                        image = ImageCms.profileToProfile(image, ImageCms.ImageCmsProfile(io.BytesIO(image.info['icc_profile'])), ImageCms.createProfile('sRGB'), outputMode='RGB')
                    else:
                        image = image.convert('RGB')
                    image.thumbnail((1600, 1600), Image.Resampling.LANCZOS)
                    pixels = hashlib.sha256(image.tobytes() + str(image.size).encode()).hexdigest()
                    output = io.BytesIO()
                    image.save(output, 'WEBP', quality=82, method=6, exif=b'', icc_profile=b'', xmp=b'')
                    image_bytes = output.getvalue()
                    width, height = image.size
            if digest(path) != checksum:
                raise RuntimeError(f'Source changed during import: {relative}')
            rendered_hash = hashlib.sha256(image_bytes).hexdigest()
            owner = pixel_owners.get(pixels) or rendered_owners.get(rendered_hash)
            if owner and owner != identifier:
                if identifier in photos:
                    raise RuntimeError(f'Existing original now duplicates another photograph: {relative}; review before merging IDs')
                manifest['duplicates'].append(dict(file=relative, duplicate_id=owner, reason='Identical normalized pixels or display copy'))
                continue
            if not date and current and ((prior and prior.get('pixels') == pixels) or (existing.exists() and existing.read_bytes() == image_bytes)):
                date = current.get('date')  # Metadata-only re-exports retain the previously verified capture date.
            if current:
                rendered_owners = {h: owner_id for h, owner_id in rendered_owners.items() if owner_id != identifier}
            rendered_owners[rendered_hash] = identifier
            content_owners[checksum] = identifier
            pixel_owners[pixels] = identifier
            year = date[:4] if date else 'undated'
            photo = dict(id=identifier, year=year, url=f'/images/photography/{identifier}.webp', alt=entry['alt'], caption=entry.get('caption', ''), width=width, height=height, format='landscape' if width > height * 1.15 else 'portrait', order=entry.get('order', 100))
            if date:
                photo['date'] = date
            if entry.get('position'):
                if not re.fullmatch(r'[0-9.]+% [0-9.]+%', entry['position']):
                    raise ValueError('Cover position must be two percentages')
                photo['position'] = entry['position']
            photos[identifier] = photo
            row = dict(file=relative, id=identifier, sha256=checksum, pixels=pixels, date=date, width=width, height=height, bytes=len(image_bytes))
            catalog[relative] = row
            if destination.exists() and destination.read_bytes() == image_bytes:
                manifest['unchanged'].append(row)
            else:
                staged[destination] = image_bytes
                manifest['imported'].append(row)
        if not photos:
            raise RuntimeError('No reviewed, locally available photographs were found')
        # Map thumbnails load first; full-size copies load only when opened or in Gallery view.
        thumbnail_bytes = {}
        for photo in photos.values():
            full_path = ROOT / photo['url'].lstrip('/')
            full = staged.get(full_path) or full_path.read_bytes()
            thumb_path = ROOT / 'images/photography/thumbs' / f"{photo['id']}.webp"
            with Image.open(io.BytesIO(full)) as image:
                image.thumbnail((240, 240), Image.Resampling.LANCZOS)
                output = io.BytesIO()
                image.save(output, 'WEBP', quality=76, method=6, exif=b'', icc_profile=b'', xmp=b'')
                thumbnail = output.getvalue()
            if len(thumbnail) > 32 * 1024:
                raise RuntimeError(f"Thumbnail too large: {photo['id']}")
            if not thumb_path.exists() or thumb_path.read_bytes() != thumbnail:
                staged[thumb_path] = thumbnail
            photo['thumbnail'] = f"/images/photography/thumbs/{photo['id']}.webp"
            thumbnail_bytes[photo['year']] = thumbnail_bytes.get(photo['year'], 0) + len(thumbnail)
        if max(thumbnail_bytes.values()) > THUMBNAIL_BUDGET:
            raise RuntimeError('An album exceeds the 2 MiB map-thumbnail budget; review loading policy')
        byte_count = sum(len(staged[ROOT / p['url'].lstrip('/')]) if ROOT / p['url'].lstrip('/') in staged else (ROOT / p['url'].lstrip('/')).stat().st_size for p in photos.values())
        byte_count += sum(thumbnail_bytes.values())
        if byte_count >= PHOTO_BUDGET:
            raise RuntimeError(f'Photography exceeds its separate 64 MiB archive budget ({byte_count} bytes); review selection/derivatives before adding more')
        albums = []
        for year in sorted({p['year'] for p in photos.values()}, key=lambda y: (y == 'undated', -int(y) if y != 'undated' else 0)):
            items = sorted((p for p in photos.values() if p['year'] == year), key=lambda p: (p['order'], p.get('date',''), p['id']))
            albums.append(dict(year=year, label=year if year != 'undated' else 'More moments', photos=items))
        staged.update(page_sources(albums))
        for path, content in staged.items():
            atomic_write(path, content)
        atomic_write(data_path, (json.dumps({'albums': albums}, ensure_ascii=False, indent=2)+'\n').encode())
        manifest['catalog'] = list(catalog.values())
        manifest['summary'] = dict(photos=len(photos), albums=len(albums), bytes=byte_count, thumbnail_bytes=thumbnail_bytes)
    except Exception as error:
        manifest['errors'].append(str(error))
        atomic_write(report_path, (json.dumps(manifest, ensure_ascii=False, indent=2)+'\n').encode())
        raise
    atomic_write(report_path, (json.dumps(manifest, ensure_ascii=False, indent=2)+'\n').encode())
    print(json.dumps(manifest['summary']))
    print(f"Imported {len(manifest['imported'])}; unchanged {len(manifest['unchanged'])}; skipped {len(manifest['skipped'])}. Private details: {report_path}")


if __name__ == '__main__':
    main()
