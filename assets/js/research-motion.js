/* Viewport-driven previews and small, progressive enhancements. */
document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('[data-copy-email]').forEach(function (button) {
    button.hidden = false;
    button.addEventListener('click', async function () {
      const status = button.parentElement.querySelector('[role="status"]');
      const email = button.dataset.copyEmail;
      button.disabled = true;
      try {
        if (!navigator.clipboard || !navigator.clipboard.writeText) {
          throw new Error('Clipboard is unavailable');
        }
        await navigator.clipboard.writeText(email);
        status.textContent = 'Email copied.';
      } catch (error) {
        // The selectable address remains available when clipboard access is blocked.
        status.textContent = 'Could not copy. Select the address above to copy it manually.';
      } finally {
        button.disabled = false;
      }
    });
  });

  const reduce = window.matchMedia('(prefers-reduced-motion: reduce)');
  const saveData = Boolean(navigator.connection && navigator.connection.saveData);
  const videos = [...document.querySelectorAll('video[data-autoplay]')];
  const states = new Map();

  function pause(video, state) {
    if (!video.paused) {
      state.systemPause = true;
      video.pause();
    }
  }
  function sync(video, state) {
    if (!state.visible || document.hidden) {
      pause(video, state);
      return;
    }
    if (reduce.matches || saveData || state.userPaused || !video.paused) return;
    video.play().then(function () {
      video.dataset.playback = 'playing';
      if (!state.visible || document.hidden || reduce.matches) pause(video, state);
    }).catch(function (error) {
      // A blocked autoplay leaves the poster and native play control usable.
      if (error.name !== 'AbortError') video.dataset.playback = 'manual';
    });
  }
  const mediaObserver = 'IntersectionObserver' in window ? new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      const state = states.get(entry.target);
      state.visible = entry.isIntersecting && entry.intersectionRatio >= 0.35;
      sync(entry.target, state);
    });
  }, { threshold: [0, 0.35] }) : null;

  videos.forEach(function (video) {
    const state = { visible: false, userPaused: false, systemPause: false };
    states.set(video, state);
    video.muted = true;
    video.loop = true;
    video.addEventListener('pause', function () {
      if (state.systemPause) state.systemPause = false;
      else state.userPaused = true;
    });
    video.addEventListener('play', function () { state.userPaused = false; });
    if (mediaObserver) mediaObserver.observe(video);
  });
  document.addEventListener('visibilitychange', function () {
    states.forEach(function (state, video) { sync(video, state); });
  });
  reduce.addEventListener('change', function () {
    states.forEach(function (state, video) {
      if (reduce.matches) pause(video, state);
      else sync(video, state);
    });
  });

  const revealTargets = document.querySelectorAll('.project-section, .research-section, .research-feature, .project-row, .publication-row, .album-cover, .photo-album, .photography-teaser');
  if (!reduce.matches && 'IntersectionObserver' in window) {
    const revealObserver = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-revealed');
          revealObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.03, rootMargin: '0px 0px -20px 0px' });
    revealTargets.forEach(function (element) {
      // Initial content is visible immediately, including when JS is unavailable.
      if (element.getBoundingClientRect().top > window.innerHeight) {
        element.classList.add('reveal-pending');
        revealObserver.observe(element);
      }
    });
  }

  const toc = document.querySelector('.research-rail__toc');
  if (toc) {
    const headings = [...document.querySelectorAll('#main h2')].filter(function (heading) {
      return !heading.closest('.project-row, .research-details, .publication-row, .publication-body, .album-cover');
    });
    headings.slice(0, 12).forEach(function (heading, index) {
      if (!heading.id) heading.id = 'section-' + (index + 1);
      const link = document.createElement('a');
      link.href = '#' + heading.id;
      link.textContent = heading.textContent.replace(/\s+/g, ' ').trim();
      toc.appendChild(link);
    });
    if (!toc.children.length) toc.parentElement.hidden = true;
    const entries = [...toc.querySelectorAll('a')];
    function highlightSection() {
      let current = -1;
      headings.slice(0, 12).forEach(function (heading, index) {
        if (heading.getBoundingClientRect().top < window.innerHeight * 0.4) current = index;
      });
      entries.forEach(function (link, index) {
        if (index === current) link.setAttribute('aria-current', 'location');
        else link.removeAttribute('aria-current');
      });
    }
    let ticking = false;
    window.addEventListener('scroll', function () {
      if (ticking) return;
      ticking = true;
      window.requestAnimationFrame(function () { highlightSection(); ticking = false; });
    }, { passive: true });
    highlightSection();
  }
});
