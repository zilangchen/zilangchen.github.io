---
description: "Zilang Chen, an M.S.E. student at the University of Pennsylvania, working across tactile sensing, deep learning, and robotic systems."
layout: research
permalink: /
title: "Zilang Chen"
author_profile: false
excerpt: "Robotics, tactile sensing, and machine learning. M.S.E. student at the University of Pennsylvania."
---
<div class="profile-home">
  <header class="profile-hero">
    <div class="profile-hero__copy">
      <p class="research-eyebrow">Robotics · Sensing · Learning</p>
      <h1>Zilang Chen</h1>
      <p class="profile-affiliation">M.S.E. in Mechanical Engineering and Applied Mechanics<br>University of Pennsylvania</p>
      <p>I work across tactile sensing, deep learning, and robotic systems. My experience spans data collection, model training and evaluation, hardware prototyping, and efficient LLM inference.</p>
      <p class="profile-hero__purpose">I want to build robots that use sensory feedback to manipulate more reliably, adapt to changing conditions, and recover from mistakes.</p>
      <nav class="research-links contact-links profile-mobile-links" aria-label="Profile links">
        {% include email-contact.html %}
    <a href="https://scholar.google.com/citations?user=zOJdQf0AAAAJ&amp;hl=en"><i class="fa-solid fa-graduation-cap" aria-hidden="true"></i><span>Google Scholar</span><i class="fa-solid fa-arrow-up-right-from-square contact-arrow" aria-hidden="true"></i></a>
    <a href="https://github.com/zilangchen"><i class="fa-brands fa-github" aria-hidden="true"></i><span>GitHub</span><i class="fa-solid fa-arrow-up-right-from-square contact-arrow" aria-hidden="true"></i></a>
    <a href="https://www.linkedin.com/in/zilang-chen-54577b375/"><i class="fa-brands fa-linkedin" aria-hidden="true"></i><span>LinkedIn</span><i class="fa-solid fa-arrow-up-right-from-square contact-arrow" aria-hidden="true"></i></a>
        <a href="{{ '/cv/' | relative_url }}"><i class="fa-solid fa-file-lines" aria-hidden="true"></i><span>CV</span><i class="fa-solid fa-arrow-right contact-arrow" aria-hidden="true"></i></a>
      </nav>
    </div>
  </header>
  <section class="profile-interests" aria-labelledby="interests-title">
    <h2 id="interests-title">Research Interests</h2>
    <div>
      <p><i class="fa-solid fa-hand interest-icon" aria-hidden="true"></i><strong>Tactile Manipulation</strong><span>Learning to manipulate with tactile feedback.</span></p>
      <p><i class="fa-solid fa-robot interest-icon" aria-hidden="true"></i><strong>Reinforcement Learning for Adaptive Robot Skills</strong><span>Learning motion and manipulation skills for changing conditions.</span></p>
    </div>
  </section>

  <section class="research-section" aria-labelledby="selected-title">
    <div class="research-section-heading">
      <div><span class="section-index" aria-hidden="true">01</span><h2 id="selected-title">Selected Research</h2></div>
      <a href="{{ '/portfolio/' | relative_url }}">View all projects <span aria-hidden="true">↗</span></a>
    </div>
    <article class="research-feature">
      <div class="research-feature__copy">
        <p class="research-eyebrow">IROS 2026 · Accepted · Second author</p>
        <h3><a href="{{ '/portfolio/deformation-reconstruction' | relative_url }}">Zero-Shot Deformation Reconstruction for Soft Robots</a></h3>
        <p>Estimating a soft robot’s changing shape from a flexible sensor array, without camera input during inference.</p>
        <figure class="home-demo">
        <div class="demo-labels"><span>Physical specimen</span><span>Render · front</span><span>Render · back</span></div>
        <video controls muted playsinline preload="metadata" poster="{{ '/images/portfolio/deformation-reconstruction/web/reconstruction-poster.webp' | relative_url }}" width="1440" height="480" aria-label="Synchronized physical and reconstructed soft-robot motion" aria-describedby="home-demo-caption" loop data-autoplay>
          <source src="{{ '/images/portfolio/deformation-reconstruction/web/reconstruction-demo.mp4' | relative_url }}" type="video/mp4">
          <a href="{{ '/images/portfolio/deformation-reconstruction/web/reconstruction-demo.mp4' | relative_url }}">Watch the reconstruction demo</a>.
        </video>
        <figcaption id="home-demo-caption">The same motion, captured and reconstructed in sync. <span>20 s · silent</span></figcaption>
      </figure>
        <p class="research-role"><strong>My work.</strong> Sensor acquisition software, experimental data collection, geometric preprocessing, model training, and evaluation.</p>
        <p class="research-result">4.7° bending / 4.9° twisting mean angle error <span>· reported in the paper</span></p>
        <div class="research-links"><a href="{{ '/portfolio/deformation-reconstruction' | relative_url }}">Explore project <span aria-hidden="true">→</span></a><a href="https://arxiv.org/abs/2603.19543">Paper <span aria-hidden="true">↗</span></a></div>
      </div>
      <figure class="project-figure"><a href="/images/presentation/reconstruction-inference.webp" data-lightbox="gallery"><img src="/images/presentation/reconstruction-inference.webp" width="1773" height="405" alt="Sensor-to-cage reconstruction pipeline" loading="lazy" decoding="async"></a><figcaption>Sensor measurements become cage motion and reconstructed geometry. <span class="figure-hint">Click to enlarge.</span></figcaption></figure>
    </article>
    <article class="research-feature">
      <figure class="research-feature__visual cache-visual">
        <p class="cache-visual__title">Less storage for the KV cache</p>
        <p class="cache-visual__number">73.4<span>%</span><small>reduction vs. FP16 (approx.)</small></p>
        <dl class="cache-bars" aria-label="Relative KV-cache storage, FP16 normalized to 100 percent">
          <div><dt>FP16</dt><dd><span class="cache-bars__baseline"></span><b>100%</b></dd></div>
          <div><dt>INT4</dt><dd><span class="cache-bars__int4"></span><b>26.6%</b></dd></div>
        </dl>
        <figcaption>Across four representative configurations. KV-cache storage, not total GPU memory.</figcaption>
      </figure>
      <div class="research-feature__copy">
        <p class="research-eyebrow">Undergraduate thesis · Independent research</p>
        <h3><a href="{{ '/portfolio/kv-cache-quantization' | relative_url }}">Behavior-Guided KV-Cache Quantization</a></h3>
        <p>Reducing LLM inference storage while preserving attention behavior and long-context retrieval.</p>
        <p class="research-role"><strong>My work.</strong> Independently developed the calibration, quantized cache, Triton decoding kernels, and evaluation pipeline.</p>
        <p class="research-result">Role-aware calibration for keys and values <span>· evaluated across six instruction models</span></p>
        <div class="research-links"><a href="{{ '/portfolio/kv-cache-quantization' | relative_url }}">Explore project <span aria-hidden="true">→</span></a></div>
      </div>
    </article>
  </section>

  <section class="research-section engineering-section" aria-labelledby="engineering-title">
    <div class="research-section-heading"><div><span class="section-index" aria-hidden="true">02</span><h2 id="engineering-title">Building Robotic Systems</h2></div><span>From sensing to working prototypes</span></div>
    <div class="engineering-grid">
      <article>
        <a href="{{ '/portfolio/climbing-hand-exo' | relative_url }}"><img src="{{ '/images/home/hand-exoskeleton.webp' | relative_url }}" alt="Climbing-assistance hand exoskeleton prototype" width="640" height="480" loading="lazy" decoding="async"><h3>Climbing-Assisted Hand Exoskeleton <span aria-hidden="true">↗</span></h3></a>
        <p>Pressure sensing, Arduino control, and prototype integration.</p>
      </article>
      <article>
        <a href="{{ '/portfolio/ball-picking-robot' | relative_url }}"><img src="{{ '/images/home/ball-robot.webp' | relative_url }}" alt="Mecanum-wheel ball-collecting robot" width="640" height="480" loading="lazy" decoding="async"><h3>Ball-Collecting Robot <span aria-hidden="true">↗</span></h3></a>
        <p>STM32 motor control, PID tuning, and team leadership. Second in the course competition.</p>
      </article>
      <article>
        <a href="{{ '/portfolio/angkor-bloom' | relative_url }}"><img src="{{ '/images/home/robocon.webp' | relative_url }}" alt="Two SCUT robots developed for ROBOCON 2023" width="640" height="480" loading="lazy" decoding="async"><h3>ROBOCON 2023 <span aria-hidden="true">↗</span></h3></a>
        <p>Robot fabrication and mechanism assembly. National Third Prize with the SCUT team.</p>
      </article>
    </div>
  </section>

  {% assign recent_outputs = site.publications | sort: "date" | reverse %}
  <section class="research-section" aria-labelledby="publications-title">
    <div class="research-section-heading"><div><span class="section-index" aria-hidden="true">03</span><h2 id="publications-title">Recent Publications</h2></div><a href="{{ '/publications/' | relative_url }}">View all publications <span aria-hidden="true">↗</span></a></div>
    <div class="profile-publications">
      {% for publication in recent_outputs limit: 2 %}
      <article class="profile-publication">
        <span class="publication-year">{{ publication.date | date: '%Y' }}</span>
        <div><h3><a href="{{ publication.url | relative_url }}">{{ publication.title }}</a></h3>
          <p>{% if publication.status == 'accepted' %}Accepted to <em>{{ publication.venue }}</em>.{% else %}Published in <em>{{ publication.venue }}</em>{% if publication.venue_note %} · {{ publication.venue_note }}{% endif %}.{% endif %}</p>
        </div>
        {% if publication.paperurl %}<a class="publication-paper" href="{{ publication.paperurl }}">Paper <span aria-hidden="true">↗</span></a>{% endif %}
      </article>
      {% endfor %}
    </div>
  </section>
  {% include photography-teaser.html %}
</div>
