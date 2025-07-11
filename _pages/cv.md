---
layout: archive
title: "Curriculum Vitae"
permalink: /cv/
author_profile: true
redirect_from:
  - /resume
---

{% include base_path %}

## Education

**B.Eng. Intelligent Manufacturing Engineering**, South China University of Technology, Guangzhou  
Sep 2022 – Jul 2026 (expected) • GPA 3.8/4.0 (Top 10 %)

Summer Session, University of California, Los Angeles, USA  
Jun 2024 – Aug 2024 • GPA 4.0/4.0 • Math 156 Machine Learning

International Summer Undergraduate Research Experience (ISURE), University of Notre Dame, USA  
Jul 2025 – Aug 2025

## Research Experience

**Real-Time Robotic-Arm Motion Planning from Temporal Logic** — SCUT (Feb 2024 – Present)  
Advisor: Prof. Gang Chen  
Implemented LCRL-based planners in ROS to guarantee task satisfaction amid dynamic obstacles.

**Flexible Electronics-Enabled Fault Detection & 3-D Reconstruction for Soft Robots** — ISURE, University of Notre Dame (Jul 2025 – Aug 2025)  
Advisor: Prof. Ting-Yu Cheng  
Engineered flexible sensor arrays for on-board fault localisation and millimetre-accurate shape reconstruction of manipulated objects.

**Climbing-Assisted Hand Exoskeleton** — Team ADDLM, SCUT (Feb 2025 – Jun 2025)  
Advisor: Prof. Jingcheng Lei  
Invented a 448 g glove with passive ratchet locking and series-elastic actuation; 0.18 s lock and zero-slip holding at 16 N.

**Offline Voice-Controlled Smart-Home Gateway** — SCUT (Sep 2024 – Jan 2025)  
Advisor: Prof. Zhicong Huang  
Collected 8 h Mandarin corpus, trained a 120 k-parameter CNN and deployed it on Cortex-M for 96.2 % on-device accuracy.

**Wine-Quality Prediction with Ensemble Trees** — UCLA (Jun 2024 – Aug 2024)  
Advisor: Prof. Chunyang Liao  
Designed a leak-free benchmarking pipeline comparing five ensemble learners; weighted-F1 0.693 (red) / 0.664 (white).

**Multifunctional Ball-Collecting Robot** — SCUT (Feb 2024 – May 2024)  
Advisor: Prof. Yingjie Zhang  
Created a 50 cm³ omnidirectional vehicle that collision-collects balls of various sizes; Silver Prize (Top 20 %).

**Bionic Water-Strider Robot** — SCUT (Sep 2022 – Jan 2023)  
Advisor: Prof. Ye Chen  
Built a Chebyshev-linkage swimmer with autonomous obstacle avoidance.

## Skills

- Programming: C/C++, Python, R, MATLAB  
- CAD & Simulation: SolidWorks, ROS  
- Embedded Systems: ARM Cortex-M, Arduino, IoT integration  

## Honors & Awards

- Honorable Mention, Mathematical Contest in Modeling (MCM), 2024  
- Second Prize, Multifunctional Robot Competition, SCUT, 2024  
- Third Prize, Shenzhen Cup Mathematical Modeling Competition, 2024  
- Third Prize, RoboCon "Angkor Bloom", 2023  
- Third Prize, Huashu Cup Mathematical Modeling Competition, 2023  

## Publications
<ul>
  {% for post in site.publications reversed %}
    {% include archive-single-cv.html %}
  {% endfor %}
</ul>
