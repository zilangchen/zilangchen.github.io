#!/usr/bin/env python3
"""Publish reviewed city assignments, never original photograph GPS coordinates."""
import argparse
import hashlib
import json
import math
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def valid_coordinate(lat, lon):
    return (type(lat) in (float, int) and type(lon) in (float, int)
            and math.isfinite(lat) and math.isfinite(lon)
            and abs(lat) <= 90 and abs(lon) <= 180 and (lat, lon) != (0, 0))


def city_index(catalog):
    if catalog.get('accuracy') != 'city_or_area':
        raise ValueError('Only city/area representatives may be published')
    cities = {}
    for city in catalog['places']:
        lat, lon = city.get('latitude'), city.get('longitude')
        if (not valid_coordinate(lat, lon) or round(lat, 2) != lat or round(lon, 2) != lon
                or not city.get('name') or not city.get('source') or city['id'] in cities):
            raise ValueError('Invalid or duplicate city representative')
        cities[city['id']] = city
    return cities


def location_rows(albums, audit, catalog, assignments):
    photos = {photo['id'] for album in albums for photo in album['photos']}
    cities = city_index(catalog)
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
            if identifier in assignments:
                raise ValueError('Previously assigned photograph lost GPS metadata; retain the previous location data and review the source')
            continue
        if not valid_coordinate(row.get('latitude'), row.get('longitude')):
            raise ValueError('Invalid coordinate in private metadata audit')
        place_id = assignments.get(identifier)
        if place_id not in cities:
            raise ValueError(f'Missing reviewed city assignment for photo {identifier}; supply --assignments instead of publishing raw GPS')
        output.append({'id': identifier, 'place_id': place_id})
    return output


def main():
    parser = argparse.ArgumentParser(description=__doc__, allow_abbrev=False)
    parser.add_argument('--audit', type=Path, required=True)
    parser.add_argument('--assignments', type=Path, help='Private reviewed JSON mapping photo IDs to city IDs; merges with existing assignments.')
    args = parser.parse_args()
    audit_path = args.audit.resolve(strict=True)
    if audit_path == ROOT or ROOT in audit_path.parents:
        parser.error('Raw metadata audit must remain outside the public repository')
    destination = ROOT / '_data/photo_locations.json'
    existing = json.loads(destination.read_text()) if destination.exists() else []
    assignments = {}
    for row in existing:
        if set(row) != {'id', 'place_id'} or row['id'] in assignments:
            parser.error('Existing locations must contain only unique photo IDs and reviewed place IDs')
        assignments[row['id']] = row['place_id']
    if args.assignments:
        assignment_path = args.assignments.resolve(strict=True)
        if assignment_path == ROOT or ROOT in assignment_path.parents:
            parser.error('The review input must remain outside the public repository')
        incoming = json.loads(assignment_path.read_text())
        if not isinstance(incoming, dict) or any(not isinstance(k, str) or not isinstance(v, str) for k, v in incoming.items()):
            parser.error('Assignments must map photo IDs to city IDs')
        assignments.update(incoming)
    albums = json.loads((ROOT / '_data/photography.json').read_text())['albums']
    catalog = json.loads((ROOT / '_data/photo_places.json').read_text())
    rows = location_rows(albums, json.loads(audit_path.read_text()), catalog, assignments)
    with tempfile.NamedTemporaryFile(mode='w', dir=destination.parent, delete=False) as stream:
        temporary = Path(stream.name)
        json.dump(rows, stream, indent=2)
        stream.write('\n')
    temporary.replace(destination)
    print(f'City/area assignments: {len(rows)}; without location: {sum(len(a["photos"]) for a in albums) - len(rows)}')


if __name__ == '__main__':
    main()
