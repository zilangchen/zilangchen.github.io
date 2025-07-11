---
title: "Bionic Water-Strider Robot (Intelligent Swimmer)"
excerpt: "Chebyshev-linkage propulsion and foam-float legs let the robot skim the surface while ultrasonic sensing enables autonomous obstacle avoidance."
image: /images/portfolio/water-robot/main.png
collection: portfolio
permalink: /portfolio/water-surface-robot
date: 2023-01-12
projects:
  - Biomimetic Design
links:
  - label: Design Files (STL)
    url: "#"
---

Developed within the Set Sail team, this spider-shaped swimmer imitates the biomechanics of a water strider to achieve agile motion on the water surface.

**Key Features**

* Four rigid legs tipped with adjustable foam boards supply buoyancy; total mass 1.66 kg.
* Dual Chebyshev linkages convert TT geared-motor rotation into elliptic paddling, providing both thrust and heave for forward/backward motion and zero-radius turns.
* Ultrasonic ranging front sensor and simplified PID logic enable automatic obstacle detection and avoidance; colour sensor recognises target marker for autonomous stop.
* Modular 3-D-printed chassis (resin body + PLA drivetrain) plus swappable floats allow rapid iteration; electronics centred on Arduino UNO + twin L298N drivers.

**Performance**

Stage-II pool trials (2.61 m × 1.72 m, 0.36 m depth) demonstrated reliable straight-line travel, turning and obstacle circumnavigation. The robot cleared a 30 cm long, 10 cm wide, 21 cm tall block without contact and reached the goal area autonomously.

**Future Work**

We plan to boost propulsion efficiency with lighter carbon-fibre legs, refine balancing via on-board IMU feedback, and integrate a monocular vision module for high-speed target tracking.

### Gallery

![Prototype](/images/portfolio/water-robot/22.png)
![Testing](/images/portfolio/water-robot/23.jpg) 