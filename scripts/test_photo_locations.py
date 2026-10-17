"""Privacy regressions: imports cannot publish exact GPS, even for new photos."""
import copy
import hashlib
import unittest

from import_photo_locations import location_rows


class CityPrivacyTests(unittest.TestCase):
    def setUp(self):
        self.audit = [{'file': 'one.jpg', 'latitude': 23.104123456789, 'longitude': 113.372987654321},
                      {'file': 'two.jpg', 'latitude': 23.180987654321, 'longitude': 113.280123456789}]
        self.ids = [hashlib.sha256(row['file'].encode()).hexdigest()[:16] for row in self.audit]
        self.albums = [{'photos': [{'id': identifier} for identifier in self.ids]}]
        self.city = {'id': 'example-city', 'name': 'Example city', 'latitude': 23.12,
                     'longitude': 113.25, 'source': 'https://example.com/city'}
        self.catalog = {'accuracy': 'city_or_area', 'places': [self.city]}
        self.assignments = dict.fromkeys(self.ids, self.city['id'])

    def test_different_capture_points_publish_only_the_shared_city_id(self):
        rows = location_rows(self.albums, self.audit, self.catalog, self.assignments)
        self.assertEqual(rows, [{'id': identifier, 'place_id': 'example-city'} for identifier in sorted(self.ids)])
        self.assertTrue(all(set(row) == {'id', 'place_id'} for row in rows))

    def test_new_photo_needs_review_instead_of_raw_gps_fallback(self):
        del self.assignments[self.ids[1]]
        with self.assertRaisesRegex(ValueError, 'Missing reviewed city'):
            location_rows(self.albums, self.audit, self.catalog, self.assignments)

    def test_unknown_city_and_precise_representative_are_rejected(self):
        bad = copy.deepcopy(self.catalog)
        bad['places'][0]['latitude'] = 23.104123456789
        with self.assertRaisesRegex(ValueError, 'Invalid or duplicate city'):
            location_rows(self.albums, self.audit, bad, self.assignments)
        self.assignments[self.ids[0]] = 'unknown-city'
        with self.assertRaisesRegex(ValueError, 'Missing reviewed city'):
            location_rows(self.albums, self.audit, self.catalog, self.assignments)

    def test_no_gps_stays_unlocated(self):
        self.audit[1] = {'file': 'two.jpg'}
        del self.assignments[self.ids[1]]
        rows = location_rows(self.albums, self.audit, self.catalog, self.assignments)
        self.assertEqual(rows, [{'id': self.ids[0], 'place_id': 'example-city'}])

    def test_existing_assignment_cannot_disappear_with_missing_gps(self):
        self.audit[1] = {'file': 'two.jpg'}
        with self.assertRaisesRegex(ValueError, 'Previously assigned photograph lost GPS'):
            location_rows(self.albums, self.audit, self.catalog, self.assignments)

    def test_bad_or_missing_metadata_fails(self):
        for audit in [self.audit[:1], self.audit + self.audit[:1],
                      [{**self.audit[0], 'error': 'unavailable'}, self.audit[1]],
                      [{**self.audit[0], 'latitude': float('nan')}, self.audit[1]]]:
            with self.subTest(audit=audit), self.assertRaises(ValueError):
                location_rows(self.albums, audit, self.catalog, self.assignments)


if __name__ == '__main__':
    unittest.main()
