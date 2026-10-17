/* All photographs stay in the document; the map enhances the same image links. */
(function () {
  'use strict';
  function initialize() {
    const root = document.querySelector('.photo-map-page');
    if (!root) return;
    const data = JSON.parse(document.getElementById('photo-location-data').textContent);
    const cards = Array.from(root.querySelectorAll('[data-photo-id]'));
    const places = new Map(JSON.parse(document.getElementById('photo-place-data').textContent).map(place => [place.id, place]));
    const locations = new Map(data.map(point => {
      const place = places.get(point.place_id);
      if (!place) throw new Error('Unknown city/area in photo map');
      return [point.id, place];
    }));
    const photos = cards.map(card => ({card, id: card.dataset.photoId, year: card.dataset.year,
      link: card.querySelector('a'), image: card.querySelector('img'), point: locations.get(card.dataset.photoId)}));
    const yearButtons = Array.from(root.querySelectorAll('.photo-filters button'));
    const unlocatedButton = root.querySelector('[data-unlocated]');
    const clearButton = root.querySelector('[data-clear-place]');
    const mapSection = root.querySelector('.photo-map-section');
    const notice = root.querySelector('.photo-map-notice');
    const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    let year = new URLSearchParams(window.location.search).get('year') || 'all';
    if (!yearButtons.some(button => button.dataset.year === year)) year = 'all';
    let unlocated = false;
    let placeIds = null;
    let map;
    let group;
    let tileError = false;
    const markers = new Map();
    root.querySelector('.photo-filters').hidden = false;
    root.querySelector('.photo-location-filters').hidden = false;
    photos.forEach(photo => { photo.card.querySelector('.photo-unlocated-label').hidden = Boolean(photo.point); });

    function yearPhotos() { return photos.filter(photo => year === 'all' || photo.year === year); }
    function updateMapNotice() {
      const hasPoints = yearPhotos().some(photo => photo.point);
      notice.textContent = unlocated || !hasPoints
        ? 'No locations recorded for this selection. The photographs are available below.'
        : tileError ? 'Some map details could not load. Photo markers and the collection below are still available.' : '';
      notice.hidden = !notice.textContent;
    }
    function renderGallery() {
      let visible = 0;
      let located = 0;
      photos.forEach(photo => {
        const show = (year === 'all' || photo.year === year) && (!unlocated || !photo.point) && (!placeIds || placeIds.has(photo.id));
        photo.card.hidden = !show;
        if (show) { visible++; if (photo.point) located++; }
      });
      const suffix = placeIds ? ' · selected place' : unlocated ? ' · no location recorded' : ` · ${located} on the map · ${visible - located} without location`;
      root.querySelector('#photo-count').textContent = `${visible} ${visible === 1 ? 'photograph' : 'photographs'}${suffix}`;
      root.querySelector('.photo-empty').hidden = visible !== 0;
      unlocatedButton.setAttribute('aria-pressed', String(unlocated));
      clearButton.hidden = !placeIds;
      yearButtons.forEach(button => button.setAttribute('aria-pressed', String(button.dataset.year === year)));
    }
    function updateMinimumZoom() {
      const size = map.getSize();
      // A single, non-wrapping world must cover both dimensions of the frame.
      const worldSize = map.getPixelWorldBounds(0).getSize();
      const coverZoom = Math.log2(Math.max(size.x / worldSize.x, size.y / worldSize.y));
      const snap = map.options.zoomSnap;
      const minZoom = Math.max(0, Math.ceil(coverZoom / snap) * snap);
      if (minZoom === map.getMinZoom()) return;
      const needsZoom = map.getZoom() < minZoom;
      const rebuildClusters = () => {
        group.clearLayers();
        group.addLayers(yearPhotos().filter(photo => photo.point && !unlocated).map(photo => markers.get(photo.id)));
      };
      // Wait for any zoom transition before replacing its cluster grid.
      if (group && needsZoom) group.once('animationend', rebuildClusters);
      map.setMinZoom(minZoom);
      if (group && !needsZoom) rebuildClusters();
    }
    function fitCurrentLocations() {
      if (!map) return;
      const points = yearPhotos().filter(photo => photo.point).map(photo => [photo.point.latitude, photo.point.longitude]);
      if (points.length) {
        const bounds = L.latLngBounds(points);
        map.fitBounds(bounds, {paddingTopLeft: [32, 64], paddingBottomRight: [32, 32], maxZoom: 5, animate: false});
      } else map.setView([24, 0], map.getMinZoom(), {animate: false});
    }
    function refreshMap() {
      if (!group) return;
      group.clearLayers();
      group.addLayers(yearPhotos().filter(photo => photo.point && !unlocated).map(photo => markers.get(photo.id)));
      fitCurrentLocations();
      updateMapNotice();
    }
    yearButtons.forEach(button => button.addEventListener('click', () => {
      year = button.dataset.year;
      placeIds = null;
      const url = new URL(window.location.href);
      if (year === 'all') url.searchParams.delete('year'); else url.searchParams.set('year', year);
      window.history.replaceState(null, '', url);
      renderGallery(); refreshMap();
    }));
    unlocatedButton.addEventListener('click', () => { unlocated = !unlocated; placeIds = null; renderGallery(); refreshMap(); });
    clearButton.addEventListener('click', () => { placeIds = null; renderGallery(); });
    root.querySelector('[data-map-reset]').addEventListener('click', () => { placeIds = null; unlocated = false; renderGallery(); refreshMap(); });
    renderGallery();
    mapSection.hidden = false;
    if (!window.L || !window.L.markerClusterGroup) {
      root.querySelector('#photo-map').hidden = true;
      root.querySelector('[data-map-reset]').hidden = true;
      notice.textContent = 'The map could not load. All photographs are available below.';
      notice.hidden = false;
      return;
    }
    const L = window.L;
    map = L.map('photo-map', {scrollWheelZoom: false, minZoom: 0, maxZoom: 10, zoomSnap: 0.25,
      maxBounds: [[-85.05112878, -180], [85.05112878, 180]], maxBoundsViscosity: 1,
      zoomAnimation: !reducedMotion, fadeAnimation: !reducedMotion, markerZoomAnimation: !reducedMotion});
    updateMinimumZoom();
    map.on('resize', updateMinimumZoom);
    map.attributionControl.setPrefix('<a href="https://leafletjs.com/">Leaflet</a>');
    map.attributionControl.addAttribution('City locations: <a href="https://www.geonames.org/">GeoNames</a>');
    const tiles = L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19, noWrap: true, bounds: [[-85.05112878, -180], [85.05112878, 180]], attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);
    tiles.on('tileerror', () => {
      tileError = true;
      updateMapNotice();
    });
    tiles.on('loading', () => { tileError = false; });
    tiles.on('load', updateMapNotice);
    function photoIcon(photo, count) {
      const frame = document.createElement('div');
      frame.className = 'photo-map-pin';
      const image = document.createElement('img');
      image.src = photo.image.dataset.thumbnail; image.alt = ''; image.loading = 'lazy';
      frame.appendChild(image);
      if (count) {
        const badge = document.createElement('span'); badge.className = 'photo-map-pin__count'; badge.setAttribute('aria-hidden', 'true'); badge.textContent = count;
        frame.appendChild(badge);
        const label = document.createElement('span'); label.className = 'photo-visually-hidden'; label.textContent = `${count} photographs. Zoom in to explore.`; frame.appendChild(label);
      }
      return L.divIcon({html: frame, className: 'photo-map-icon', iconSize: [52, 58], iconAnchor: [26, 58], popupAnchor: [0, -56]});
    }
    const byId = new Map(photos.map(photo => [photo.id, photo]));
    group = L.markerClusterGroup({maxClusterRadius: 65, showCoverageOnHover: false, animate: !reducedMotion,
      spiderfyOnMaxZoom: true, zoomToBoundsOnClick: true,
      iconCreateFunction: cluster => photoIcon(byId.get(cluster.getAllChildMarkers()[0].options.photoId), cluster.getChildCount())});
    photos.filter(photo => photo.point).forEach(photo => {
      const marker = L.marker([photo.point.latitude, photo.point.longitude], {icon: photoIcon(photo),
        title: photo.image.alt, alt: photo.image.alt, photoId: photo.id, keyboard: true});
      const popup = document.createElement('div'); popup.className = 'photo-map-popup';
      const open = document.createElement('button'); open.type = 'button'; open.setAttribute('aria-label', `View photograph: ${photo.image.alt}`);
      const image = document.createElement('img'); image.src = photo.image.dataset.thumbnail; image.alt = photo.image.alt;
      open.appendChild(image);
      const label = document.createElement('span'); label.textContent = `${photo.point.name} · View photograph ↗`; open.appendChild(label); popup.appendChild(open);
      open.addEventListener('click', () => {
        // A marker can remain visible outside a selected cluster; keep the viewer sequence coherent.
        if (photo.card.hidden) { placeIds = null; unlocated = false; renderGallery(); }
        photo.link.click();
      });
      marker.bindPopup(popup, {maxWidth: 260, minWidth: 180});
      markers.set(photo.id, marker);
    });
    group.on('clusterclick clusterkeypress', event => {
      if (event.type === 'clusterkeypress' && event.originalEvent?.keyCode !== 13) return;
      placeIds = new Set(event.layer.getAllChildMarkers().map(marker => marker.options.photoId));
      unlocated = false; renderGallery();
    });
    map.addLayer(group);
    refreshMap();
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', initialize); else initialize();
})();
