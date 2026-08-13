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
Sep 2022 – Jul 2026 • GPA 3.8/4.0 (Top 10%)

**Research Workshop: Computer Vision and Robot Sensors**, Carnegie Mellon University, Online  
Oct 2024 – Dec 2024 • Tutored by Prof. Cameron Riviere

**Summer Session**, University of California, Los Angeles, USA  
Jun 2024 – Aug 2024 • GPA 4.0/4.0 • Math 156 Machine Learning

**International Summer Undergraduate Research Experience (ISURE)**, University of Notre Dame, USA  
Jul 2025 – Sep 2025

## Research Experience

**Real-Time Robotic Arm Motion Control Algorithm Based on Temporal Logic** — SCUT (Feb 2024 – Present)  
Advisor: Prof. Gang Chen  
Studied the LCRL (Linear Temporal Logic with Conditional Reasoning) algorithm and robotic arm control principles. Completed real-time control strategies modeling and testing with ROS in motion analysis and simulation. Developed real-time motion control algorithms and optimized path planner for robotic arms, to fulfill precise motion control with integrated temporal logic and improve real-time responsiveness in dynamic environments. Currently writing a paper that aims to enhance robotic motion accuracy and decision-making in real-time scenarios.

**Real-Time Camera-Free Deformation Reconstruction on Soft Robot via Flexible Sensor Array and Cage-Based Deformation Model** — ISURE, University of Notre Dame (Jul 2025 – Sep 2025)<br>
Advisor: Prof. Tingyu Cheng  
Achieved a camera-free, real-time deformation reconstruction system for soft robotics by developing a complete pipeline with a low-cost flexible piezoresistive sensor array and a 4D Gaussian model. Designed and produced the sensor array and soft robots. Iterated the flexible pressure-sensor matrix, used a GAT-based cage deformer with inverse-distance-weighted propagation on 4DGS, and applied key-pose multi-view rendering + frame interpolation to strengthen supervision and reduce data-collection overhead. Implemented the GNN cage-deformer and GPU propagation, integrated the real-time renderer, collected data, and ran evaluations. Achieved ≈ 30 FPS real-time rendering, < 5 % mean 3D displacement error, and < 4.7° bending-angle error under bending/twisting/pressing. Demonstrated zero-shot camera-free reconstruction on unseen objects. Paper accepted to IEEE/RSJ IROS 2026.

**Embedded Smart Home Terminal Based on Lightweight Machine Learning** — SCUT (Sep 2024 – Jan 2025)  
Advisor: Prof. Zhicong Huang  
Developed an embedded smart home terminal to enable voice-controlled interactions, and researched how to deploy lightweight machine learning models on constrained devices with limited processing power and memory. Collected voice data and performed MFCC feature extraction. Trained and deployed a lightweight neural network on an embedded chip to achieve low-power offline speech recognition. Enabled seamless smart-home orchestration with minimal compute and memory budgets through integrating device control via OneNet and connecting the Xinghuo LLM backend for context-aware dialogues.

**A Unified, Leak-Free Comparative Study of Wine Quality** — UCLA (Jun 2024 – Aug 2024)  
Advisor: Prof. Chunyang Liao  
Investigated the relationship between wine components and quality. Employed stratified splitting, fold-wise preprocessing, SMOTE-Tomek, cost-sensitive learning, and Optuna hyperparameter search. Reported held-out performance with weighted-F1 and ablations for feature parsimony and efficiency. Built a unified, leakage-free ML pipeline to benchmark to ensure strict separation of train/validation/test and reproducible evaluation. Paper accepted by ACM IPMLP 2025 (DOI: 10.1145/3759928.3759955).

**Remote-Controlled Multifunctional Ball Picking and Placing Robot** — SCUT (Feb 2024 – Jul 2024)  
Advisor: Prof. Yingjie Zhang  
Implemented real-time motion control, electrical system setup, and remote wireless control in designing a pick-and-place robot to complete the task of moving balls from the field to designated locations. Utilized kinematic analysis and Mecanum wheels to achieve robot omnidirectional movement. Developed embedded code to control the robot's servos and motors with PID and PWM techniques. Modeled and fabricated the robot using SolidWorks and 3D printer for rapid iteration. Validated precise grasp-transport-drop cycles in testing where the robot demonstrated stable trajectory tracking and fast repositioning under changing target layouts.

## Skills

- **Programming & Robotics**: C/C++, Python, R; MATLAB; SolidWorks, Blender; ROS 2, MoveIt 2, Gazebo Fortress, RViz; 3D scanner/printer workflows; extensive mechanical assembly & debugging; soft robot manufacture
- **ML & Deployment**: PyTorch; data processing/cleaning, model debugging & application
- **Embedded & Electronics**: STM32/ESP32 MCUs; embedded/edge deployment (TinyML, on-chip inference); robust firmware practices  

## Honors & Awards

- Third Prize, Shenzhen Cup Mathematical Modeling Competition (Top 20%), Aug 2024  
- Honorable Mention, Mathematical Contest in Modeling Certificate of Achievement (MCM) (Top 20%), May 2024  
- Second Prize, Competition of Multifunctional Robot (Top 20% in School of Intelligent Engineering), May 2024  
- Third Prize, National College Student Robotics Competition "Angkor Bloom" (Top 30%), Aug 2023  
- Third Prize, Huashu Cup Mathematical Modeling Competition (Top 30%), Aug 2023  

## Publications

<ul>
  {% for post in site.publications reversed %}
    {% include archive-single-cv.html %}
  {% endfor %}
</ul>
