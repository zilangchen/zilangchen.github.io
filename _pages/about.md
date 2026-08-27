---
layout: archive
permalink: /
title: "Zilang Chen"
author_profile: true
---

<section class="home-section home-intro" aria-labelledby="about-heading">
  <h2 id="about-heading">About</h2>

  <p>I am an M.S.E. student in Mechanical Engineering and Applied Mechanics at the University of Pennsylvania, with a background in intelligent manufacturing. My work brings together robotics, machine learning, and embedded systems.</p>

  <p>I want robots to infer their physical state from limited sensing, learn representations that transfer across platforms, and operate reliably under hardware and data constraints. My projects span tactile sensing and 3D reconstruction for soft robots, wearable mechanisms, and embedded inference. I am most drawn to work in which experimental design, sensing, data processing, modeling, and physical testing have to function as one system. These experiences shape my current interests in embodied perception, learning from limited data, and transferring skills safely from simulation to real robots.</p>
</section>

<section class="home-section" aria-labelledby="research-directions-heading">
  <h2 id="research-directions-heading">Research Directions</h2>

  <div class="home-direction-grid">
    <article class="home-direction-card">
      <h3>Embodied Perception</h3>
      <p>Tactile sensing and 3D state estimation for robots whose deformation or contact state is difficult to observe directly.</p>
    </article>

    <article class="home-direction-card">
      <h3>Simulation and Transfer</h3>
      <p>Learning from limited physical data and using simulation or structured supervision to support transfer across objects and platforms.</p>
    </article>

    <article class="home-direction-card">
      <h3>Robot Hardware and Embedded Systems</h3>
      <p>Mechanism design, embedded sensing and control, and real-time deployment under physical and computational constraints.</p>
    </article>
  </div>
</section>

{% assign featured_projects = site.portfolio | where: "homepage_featured", true | sort: "homepage_order" %}
<section class="home-section" aria-labelledby="selected-work-heading">
  <div class="home-section-heading">
    <h2 id="selected-work-heading">Selected Work</h2>
    <a class="home-section-link" href="{{ '/portfolio/' | relative_url }}">View all projects <i class="fa fa-arrow-right" aria-hidden="true"></i></a>
  </div>

  <div class="home-project-grid">
    {% for project in featured_projects %}
      {% assign project_title = project.title | strip_html | strip_newlines | escape %}
      <article class="home-project-card">
        <a class="home-project-card__media" href="{{ project.url | relative_url }}" aria-label="View project: {{ project_title }}">
          <img src="{{ project.header.teaser | relative_url }}" alt="" loading="lazy" decoding="async">
        </a>
        <div class="home-project-card__body">
          {% if project.projects.first %}<p class="home-card-label">{{ project.projects.first }}</p>{% endif %}
          <h3><a href="{{ project.url | relative_url }}">{{ project.title }}</a></h3>
          <p>{{ project.homepage_excerpt | default: project.excerpt }}</p>
          <p class="home-project-card__role"><strong>My role.</strong> {{ project.homepage_role }}</p>
        </div>
      </article>
    {% endfor %}
  </div>
</section>

{% assign recent_outputs = site.publications | sort: "date" | reverse %}
<section class="home-section" aria-labelledby="recent-publications-heading">
  <div class="home-section-heading">
    <h2 id="recent-publications-heading">Recent Publications</h2>
    <a class="home-section-link" href="{{ '/publications/' | relative_url }}">View all publications <i class="fa fa-arrow-right" aria-hidden="true"></i></a>
  </div>

  <div class="home-output-list">
    {% for publication in recent_outputs limit: 2 %}
      <article class="home-output-card">
        <h3><a href="{{ publication.url | relative_url }}">{{ publication.title }}</a></h3>
        <p class="home-output-card__meta">
          {% if publication.status == 'accepted' %}
            Accepted to <em>{{ publication.venue }}</em>.
          {% else %}
            Published in <em>{{ publication.venue }}</em>.
          {% endif %}
        </p>
        <p class="home-output-card__links">
          <a href="{{ publication.url | relative_url }}">Read summary</a>
          {% if publication.paperurl %}<a href="{{ publication.paperurl }}">{{ publication.paperlabel | default: "View paper" }}</a>{% endif %}
        </p>
      </article>
    {% endfor %}
  </div>
</section>

<section class="home-section home-explore" aria-labelledby="explore-heading">
  <h2 id="explore-heading">Explore</h2>
  <p>For a complete chronology, see my CV. Technical details, figures, and demonstrations are available in the Portfolio, while publication records and paper links are collected under Publications.</p>
  <p class="home-explore__links">
    <a class="btn" href="{{ '/portfolio/' | relative_url }}">Portfolio</a>
    <a class="btn" href="{{ '/publications/' | relative_url }}">Publications</a>
    <a class="btn" href="{{ '/cv/' | relative_url }}">CV</a>
  </p>
</section>
