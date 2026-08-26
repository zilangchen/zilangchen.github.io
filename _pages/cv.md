---
layout: archive
title: "Curriculum Vitae"
permalink: /cv/
author_profile: true
redirect_from:
  - /resume
---

{% include base_path %}

## Contact

- zilang.chen@outlook.com (Personal)  
- +1 (267) 521-3967
- Philadelphia, PA, USA

## Education

**M.S.E. Mechanical Engineering and Applied Mechanics**, University of Pennsylvania, Philadelphia<br>
Aug 2026 – Present

**B.Eng. Intelligent Manufacturing Engineering**, South China University of Technology, Guangzhou  
Sep 2022 – Jul 2026 • GPA 3.8/4.0

**Visiting Student, UCLA Summer Sessions**, University of California, Los Angeles, USA<br>
Jun 2024 – Aug 2024 • GPA 4.0/4.0 • Math 156 Machine Learning

## Research Experience

**Zero-Shot Deformation Reconstruction for Soft Robots Using a Flexible Sensor Array and Cage-Based 3D Gaussian Modeling** — ISURE, University of Notre Dame (Jul 2025 – Sep 2025)<br>
Advisor: Prof. Tingyu Cheng  

- Co-developed a deformation reconstruction system that operates in real time by integrating a flexible 10 × 10 piezoresistive tactile sensor array with supervision derived from 4DGS and cage-based 3D Gaussian modeling, enabling inference without camera input. Designed, fabricated, and tested a capacitive sensor prototype made from the silicone elastomer Ecoflex to explore sensing of shear forces.
- Iterated the 10 × 10 piezoresistive sensor matrix and integrated the team's GAT cage deformer with the separate inverse distance weighting step that propagates cage motion to 3D Gaussian primitives. Applied multiview rendering of key poses and RIFE temporal interpolation to strengthen the 4DGS supervision while reducing manual data capture. Co-designed and executed the acquisition protocol using a mechanical fixture, collected and performed quality control on all structured light scans and sensor measurements, implemented per-channel R/R0 normalization, supported pipeline orchestration, and conducted the evaluations.
- The system achieved approximately 30 FPS in the coarse Gaussian setting and 5 FPS at high resolution on an RTX 3070 Ti, with a 3.48 mm mean full-body Chamfer distance, 0.67 IoU, 0.65 SSIM, and mean angular errors of 4.7° for bending and 4.9° for twisting. It demonstrated camera-free zero-shot reconstruction on two unseen soft robots without robot-specific retraining. The work was accepted to IEEE/RSJ IROS 2026; current public version: [arXiv:2603.19543](https://arxiv.org/abs/2603.19543).

**Embedded Smart Home Terminal Based on Lightweight Machine Learning** — SCUT (Sep 2024 – Jan 2025)  
Advisor: Prof. Zhicong Huang  
Developed an embedded smart home terminal to enable voice-controlled interactions, and researched how to deploy lightweight machine learning models on constrained devices with limited processing power and memory. Collected voice data and performed MFCC feature extraction. Trained and deployed a lightweight neural network on an embedded chip to achieve low-power offline speech recognition. Enabled seamless smart-home orchestration with minimal compute and memory budgets by integrating device control via OneNET and connecting the iFLYTEK Spark LLM backend for context-aware dialogues.

**A Unified, Leak-Free Comparative Study of Wine Quality** — UCLA (Jun 2024 – Aug 2024)  
Advisor: Prof. Chunyang Liao  
Investigated the relationship between wine components and quality. Employed stratified splitting, fold-wise preprocessing, SMOTE-Tomek, cost-sensitive learning, and Optuna hyperparameter search. Reported held-out performance with weighted-F1 and ablations for feature parsimony and efficiency. Built a unified, leakage-free machine-learning pipeline with strict train/validation/test separation and reproducible evaluation. The resulting paper was published in the ACM proceedings of IPMLP 2025 (pp. 162–170; DOI: 10.1145/3759928.3759955).

**Remote-Controlled Multifunctional Ball Picking and Placing Robot** — SCUT (Feb 2024 – Jul 2024)  
Advisor: Prof. Yingjie Zhang  
Implemented real-time motion control, electrical system setup, and remote wireless control in designing a pick-and-place robot to complete the task of moving balls from the field to designated locations. Utilized kinematic analysis and Mecanum wheels to achieve robot omnidirectional movement. Developed embedded code to control the robot's servos and motors with PID and PWM techniques. Modeled and fabricated the robot using SolidWorks and 3D printing for rapid iteration. Validated precise grasp-transport-drop cycles in testing where the robot demonstrated stable trajectory tracking and fast repositioning under changing target layouts.

## Publications

<ul>
  {% assign sorted_publications = site.publications | sort: "date" %}
  {% for post in sorted_publications %}
    {% include archive-single-cv.html %}
  {% endfor %}
</ul>

## Skills

- **Programming & Robotics**: C/C++, Python, R; MATLAB; SolidWorks, Blender; ROS 2, MoveIt 2, Gazebo Fortress, RViz; 3D scanner/printer workflows; mechanical assembly & debugging; soft-robot fabrication
- **ML & Deployment**: PyTorch; data processing/cleaning, model debugging & application
- **Embedded Systems & Electronics**: STM32/ESP32 MCUs; embedded/edge deployment; robust firmware practices

## Honors & Awards

- Third Prize in the Shenzhen Cup Mathematical Modeling Competition, Aug 2024
- Honorable Mention in the Mathematical Contest in Modeling (MCM), May 2024
- Second Prize in the Competition of Multifunctional Robot, May 2024
- ROBOCON Third Prize in the National College Student Robotics Competition, Aug 2023
- Third Prize in the Huashu Cup Mathematical Modeling Competition, Aug 2023
