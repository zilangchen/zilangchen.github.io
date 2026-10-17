#!/usr/bin/env python3
"""Join reviewed photo IDs to original GPS. Raw metadata must remain private."""
import argparse
import hashlib
import json
import math
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def location_rows(albums, audit):
    photos = {photo['id'] for album in albums for photo in album['photos']}
    by_id = {}
    for row in audit:
        identifier = hashlib.sha256(row['file'].encode()).hexdigest()[:16]
        if identifier in by_id:
            raise ValueError('Duplicate source identity in metadata audit')
        by_id[identifier] = row
    missing = photos - by_id.keys()
    if missing:
        raise ValueError(f'Metadata audit is missing {len(missing)} published photographs; retain the previous data and review the source inventory')
    output = []
    for identifier in sorted(photos):
        row = by_id[identifier]
        if row.get('error'):
            raise ValueError('Original metadata could not be read; retain the previous location data')
        if 'latitude' not in row and 'longitude' not in row:
            continue
        lat, lon = row.get('latitude'), row.get('longitude')
        if (type(lat) not in (float, int) or type(lon) not in (float, int)
                or not math.isfinite(lat) or not math.isfinite(lon)
                or abs(lat) > 90 or abs(lon) > 180 or (lat == 0 and lon == 0)):
            raise ValueError('Invalid coordinate in metadata audit')
        output.append({'id': identifier, 'latitude': lat, 'longitude': lon})
    return output


def main():
    parser = argparse.ArgumentParser(description=__doc__, allow_abbrev=False)
    parser.add_argument('--audit', type=Path, required=True)
    args = parser.parse_args()
    audit_path = args.audit.resolve(strict=True)
    if ROOT in audit_path.parents:
        parser.error('Raw metadata audit must remain outside the public repository')
    albums = json.loads((ROOT / '_data/photography.json').read_text())['albums']
    rows = location_rows(albums, json.loads(audit_path.read_text()))
    destination = ROOT / '_data/photo_locations.json'
    with tempfile.NamedTemporaryFile(mode='w', dir=destination.parent, delete=False) as stream:
        temporary = Path(stream.name)
        json.dump(rows, stream, indent=2)
        stream.write('\n')
    temporary.replace(destination)
    print(f'GPS locations: {len(rows)}; without usable GPS: {sum(len(a["photos"]) for a in albums) - len(rows)}')


if __name__ == '__main__':
    main()
