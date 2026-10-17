#!/usr/bin/env python3
"""Maintain redirects from annual photo URLs to the single collection."""
import json
import re
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def legacy_album_content(year, label):
    slug = 'more-moments' if year == 'undated' else year
    title = json.dumps(f"{label} — Photography", ensure_ascii=False)
    description = json.dumps(f"Photographs by Zilang Chen — {label}.", ensure_ascii=False)
    return f'---\nlayout: photography-album\ntitle: {title}\ndescription: {description}\npermalink: /photography/{slug}/\nalbum_year: "{year}"\nauthor_profile: false\n---\n'.encode()


def legacy_moved_content(year):
    slug = 'more-moments' if year == 'undated' else year
    return (f'---\nlayout: research\ntitle: "Photography collection"\npermalink: /photography/{slug}/\nsitemap: false\nauthor_profile: false\n---\n'
            '<section class="research-project photography-page"><header class="photo-hero"><h1>Find this moment.</h1>'
            '<p>These photographs have been regrouped by year.</p>'
            '<a href="{{ \'/photography/\' | relative_url }}">Browse the annual collections →</a></header></section>\n').encode()


def album_content(year, label):
    slug = 'more-moments' if year == 'undated' else year
    return (f'---\nlayout: null\ntitle: "Photography"\npermalink: /photography/{slug}/\n'
            f'redirect_to: /photography/?year={year}\nsitemap: false\n---\n').encode()


def moved_content(year):
    slug = 'more-moments' if year == 'undated' else year
    return (f'---\nlayout: null\ntitle: "Photography"\npermalink: /photography/{slug}/\n'
            'redirect_to: /photography/\nsitemap: false\n---\n').encode()


def page_sources(albums, root=ROOT):
    pages = {}
    seen = set()
    for album in albums:
        year = album['year']
        if not isinstance(year, str) or not re.fullmatch(r'(?:[0-9]{4}|undated)', year):
            raise ValueError(f'Invalid photography year: {year!r}')
        if not album['photos']:
            raise ValueError(f'Empty photography album: {year}')
        if year in seen:
            raise ValueError(f'Duplicate photography year: {year}')
        seen.add(year)
        slug = 'more-moments' if year == 'undated' else year
        path = root / '_pages' / f'photography-{slug}.html'
        content = album_content(year, album['label'])
        if path.exists() and path.read_bytes() not in (content, moved_content(year), legacy_album_content(year, album['label']), legacy_moved_content(year)):
            raise RuntimeError(f'Album page has custom changes; review before replacing: {path}')
        if not path.exists() or path.read_bytes() != content:
            pages[path] = content
    # Keep old links useful when date corrections empty an automatically generated album.
    for path in (root / '_pages').glob('photography-*.html'):
        match = re.fullmatch(r'photography-([0-9]{4}|more-moments)\.html', path.name)
        if not match:
            continue
        year = 'undated' if match[1] == 'more-moments' else match[1]
        if year in seen:
            continue
        content = path.read_bytes()
        moved = moved_content(year)
        if content == moved:
            continue
        if content not in (album_content(year, year), legacy_album_content(year, 'More moments' if year == 'undated' else year), legacy_moved_content(year)):
            raise RuntimeError(f'Old album page has custom changes; review before replacing: {path}')
        pages[path] = moved
    return pages


def main():
    data = json.loads((ROOT / '_data/photography.json').read_text())
    pages = page_sources(data['albums'])
    for path, content in pages.items():
        path.parent.mkdir(parents=True, exist_ok=True)
        with tempfile.NamedTemporaryFile(dir=path.parent, delete=False) as stream:
            temporary = Path(stream.name)
            stream.write(content)
        temporary.replace(path)
    print(f'Updated {len(pages)} generated album pages; custom pages are preserved.')


if __name__ == '__main__':
    main()
