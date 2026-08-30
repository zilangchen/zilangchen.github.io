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

- **Email:** zilang.chen@outlook.com
- **Phone number:** +1 (267) 521-3967
- **Location:** Philadelphia, PA, USA

## Education

**M.S.E. in Mechanical Engineering and Applied Mechanics**, University of Pennsylvania, Philadelphia<br>
Aug 2026 – Present

**B.Eng. Intelligent Manufacturing Engineering**, South China University of Technology, Guangzhou  
Sep 2022 – Jul 2026 • GPA 3.8/4.0

**Visiting Student, UCLA Summer Sessions**, University of California, Los Angeles, USA<br>
Jun 2024 – Aug 2024 • GPA 4.0/4.0

## Research Experience

**KV Cache Quantization for Efficient Large Language Model Inference** — Undergraduate Thesis, SCUT (Jan 2026 – May 2026)<br>
Advisor: Prof. Ziqian Zeng<br>

- Designed a KV-cache quantization and allocation framework for long-context LLM inference, using attention-distribution KL and perturbations in attention-weighted Value outputs to guide parameter calibration, low-bit recovery, and layer-wise precision allocation.
- Implemented offline K/V calibration, INT4-RoleAlign, AutoK sensitivity-based layer protection, and fused Triton kernels. Integrated FP16, INT8, symmetric INT4, mixed-precision, and KIVI-style paths into a unified evaluation pipeline.
- Evaluated six instruction models from the Qwen2.5, LLaMA-3.1, and Mistral families. Diagnosed 4-bit Key quantization as the primary task-level retrieval failure trigger in the evaluated Qwen settings. The role-aware INT4 path achieved 100% pass rates on both Needle tests for each of the three models with complete KIVI-style/RoleAlign comparisons, reduced measured KV-cache storage by approximately 73.4% relative to FP16 across four representative configurations, and lowered Qwen2.5-14B TPOT by approximately 40% at 32K relative to the reference INT4 path using fused Triton decoding on a single NVIDIA H20 with batch size 1. [Project details](/portfolio/kv-cache-quantization) · [GitHub](https://github.com/zilangchen/LLM_KVCache_Quantization)

**Zero-Shot Deformation Reconstruction for Soft Robots Using a Flexible Sensor Array and Cage-Based 3D Gaussian Modeling** — ISURE Summer Research Program, University of Notre Dame (Jul 2025 – Sep 2025)<br>
Advisor: Prof. Tingyu Cheng  

- Co-developed a deformation reconstruction system that operates in real time by integrating a flexible 10 × 10 piezoresistive tactile sensor array with supervision derived from 4DGS and cage-based 3D Gaussian modeling, enabling inference without camera input. Designed, fabricated, and tested a capacitive sensor prototype made from the silicone elastomer Ecoflex to explore sensing of shear forces.
- Iterated the 10 × 10 piezoresistive sensor matrix and integrated the team's GAT cage deformer with the separate inverse distance weighting step that propagates cage motion to 3D Gaussian primitives. Applied multiview rendering of key poses and RIFE temporal interpolation to strengthen the 4DGS supervision while reducing manual data capture. Co-designed and executed the acquisition protocol using a mechanical fixture, collected and performed quality control on all structured light scans and sensor measurements, implemented per-channel R/R0 normalization, supported pipeline orchestration, and conducted the evaluations.
- The system achieved approximately 30 FPS in the coarse Gaussian setting and 5 FPS at high resolution on an RTX 3070 Ti, with a 3.48 mm mean full-body Chamfer distance, 0.67 IoU, 0.65 SSIM, and mean angular errors of 4.7° for bending and 4.9° for twisting. It demonstrated camera-free zero-shot reconstruction on two unseen soft robots without robot-specific retraining. The work was accepted to IEEE/RSJ IROS 2026; current public version: [arXiv:2603.19543](https://arxiv.org/abs/2603.19543).

**Embedded Smart Home Terminal Based on Lightweight Machine Learning** — SCUT (Sep 2024 – Jan 2025)<br>
Advisor: Prof. Zhicong Huang  

- Led project planning and team coordination for an embedded smart-home terminal.
- Collected and processed speech data, implemented MFCC feature processing and neural-network training, and contributed to ESP32 firmware, system integration, and testing.
- Achieved 89.1% validation accuracy across seven local command classes, connected curtain, air-conditioner, and LED control to OneNET over MQTT, and used the iFLYTEK Spark LLM for dialogue and weather and time queries.

**A Unified, Leak-Free Comparative Study of Wine Quality** — UCLA (Jun 2024 – Aug 2024)  
Advisor: Prof. Chunyang Liao  

- Investigated the relationship between wine components and quality. Employed stratified splitting, fold-wise preprocessing, SMOTE-Tomek, cost-sensitive learning, and Optuna hyperparameter search.
- Reported held-out performance with weighted-F1 and ablations for feature parsimony and efficiency.
- Built a unified, leakage-free machine-learning pipeline with strict train/validation/test separation and reproducible evaluation. The resulting paper was published in the ACM proceedings of IPMLP 2025 (pp. 162–170; DOI: 10.1145/3759928.3759955).

**Remote-Controlled Multifunctional Ball-Collecting Robot** — SCUT (Feb 2024 – Jul 2024)<br>
Advisor: Prof. Yingjie Zhang  

- Led the team and coordinated project planning, integration, and competition preparation; solely operated the robot by remote control during the final course competition, where the team placed second overall.
- Wrote most of the STM32 control program, co-tuned the PID/PWM motor-control behavior, and shared responsibility for the electrical setup and wiring.
- Contributed to part of the SolidWorks modeling and assisted with prototype fabrication and assembly for the collision-based, Mecanum-wheel ball-collecting robot.

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
