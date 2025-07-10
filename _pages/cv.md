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
* **B.Eng. Intelligent Manufacturing Engineering**, South China University of Technology, Guangzhou, China  
  Sep 2022 – Jul 2026 (expected) • GPA: 3.8/4.0 (Top 10%)

## Research Experience
* **Analysis of Wine Quality Based on Multiple Machine Learning Methods** — UCLA, Los Angeles, USA (Jun 2024 – Aug 2024)  
  Advisor: Prof. Chunyang Liao  
  Explored bagging, boosting, SVM, neural networks and KNN to model non-linear relationships in high-dimensional wine data; identified key factors influencing quality and price.
* **Real-Time Robotic Arm Motion Control Algorithm Based on Temporal Logic** — SCUT (Feb 2024 – Present)  
  Advisor: Prof. Gang Chen  
  Implementing LCRL-based planners within ROS for real-time robotic arm control in dynamic environments.
* **Embedded Smart Home Terminal with Lightweight Speech Recognition** — SCUT (Sep 2024 – Jan 2025)  
  Advisor: Prof. Zhicong Huang  
  Built voice dataset, applied MFCC, trained lightweight neural network, and deployed on embedded chip for offline smart-home control.
* **Remote-Controlled Multifunctional Ball Picking and Placing Robot** — SCUT (Feb 2024 – Jul 2024)  
  Advisor: Prof. Yingjie Zhang  
  Designed Mecanum-wheel omni-directional robot; integrated PID motor control and wireless communication; project won silver medal.
* **Biomimetic Water-Surface Robot with Automatic Obstacle Avoidance** — SCUT (Sep 2022 – Feb 2023)  
  Advisors: Prof. Ye Chen, Prof. Glenn Joseph Violett  
  Developed Arduino-based control, 3D-printed waterproof chassis, and autonomous obstacle-avoidance strategy.

## Skills
* Programming: C/C++, Python, R, MATLAB
* CAD & Simulation: SolidWorks, ROS
* Embedded Systems: ARM-based microcontrollers, Arduino, IoT integration

## Honors & Awards
* Honorable Mention, Mathematical Contest In Modeling (MCM), 2024
* Second Prize, Multifunctional Robot Competition, SCUT, 2024
* Third Prize, Shenzhen Cup Mathematical Modeling Competition, 2024
* RoboCon Third Prize, National College Student Robotics Competition “Angkor Bloom”, 2023
* Third Prize, Huashu Cup Mathematical Modeling Competition, 2023

## Publications
  <ul>{% for post in site.publications reversed %}
    {% include archive-single-cv.html %}
  {% endfor %}</ul>

## Talks
  <ul>{% for post in site.talks reversed %}
    {% include archive-single-talk-cv.html  %}
  {% endfor %}</ul>

## Teaching
  <ul>{% for post in site.teaching reversed %}
    {% include archive-single-cv.html %}
  {% endfor %}</ul>
