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
* **Summer Session, Department of Mathematics**, University of California, Los Angeles, USA  
  Jun 23 – Aug 1, 2024 • GPA: 4.0/4.0  
  Coursework: Math 156 Machine Learning and related projects
* **International Summer Undergraduate Research Experience (ISURE)**, University of Notre Dame, USA  
  Jul 6 – Aug 31, 2025

## Research Experience
* **Wine Quality Prediction with Ensemble Trees** — UCLA, Los Angeles, USA (Jun 2024 – Aug 2024)  
  Advisor: Prof. Chunyang Liao  
  Built the first leak-free benchmark comparing five ensemble learners (Random Forest, Gradient Boosting, XGBoost, LightGBM, CatBoost) on the Vinho Verde datasets; designed an end-to-end pipeline with stratified splits, SMOTE-Tomek resampling, Optuna hyper-parameter search and two-stage feature selection, achieving weighted-F1 0.693 (red) / 0.664 (white). Preprint available on arXiv.
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
* **Flexible Electronics-Enabled Fault Detection and 3D Reconstruction for Soft Robots** — ISURE Program, University of Notre Dame (Jul 2025 – Aug 2025)  
  Advisor: Prof. Ting-Yu Cheng  
  Developed flexible electronic sensor arrays for real-time fault detection in soft actuators and leveraged the same sensing data to perform accurate 3-D shape reconstruction of manipulated objects.
* **Climbing-Assisted Hand Exoskeleton** — Team ADDLM, SCUT (Feb 2025 – Jun 2025)  
  Role: Mechanical & Control Co-lead  
  Designed a fail-safe exoskeleton glove with 4-layer architecture; achieved 0.18 s lock and zero slip at 16 N; >90 % success in inclined climbing trials.

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
