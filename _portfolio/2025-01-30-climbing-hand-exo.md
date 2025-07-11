---
title: "Climbing-Assisted Hand Exoskeleton"
excerpt: "Passive locking + series-elastic actuation delivers fail-safe grip and transparent free motion for climbers."
image: /images/portfolio/climb-exo/main.jpg
header:
  teaser: /images/portfolio/climb-exo/main.jpg
collection: portfolio
permalink: /portfolio/climbing-hand-exo
date: 2025-06-30
links:
  - label: Final Report (PDF)
    url: "#"
projects:
  - Wearable Robotics
  - Exoskeleton
gallery:
  - image_path: /images/portfolio/climb-exo/alt2.png
  - image_path: /images/portfolio/climb-exo/alt3.png
  - image_path: /images/portfolio/climb-exo/alt1.jpg
---

Developed a lightweight exoskeleton glove (Feb 2025 – Jun 2025) that locks a climber’s grip within 0.18 s upon slip detection while remaining transparent during free motion.

* Four-layer architecture (sensing, control, actuation, safety) driven by Arduino R3 and HX08L serial servo.
* Thin-film pressure sensors + 3-point-contact algorithm (100 Hz) decide lock/release; bi-directional ratchet ensures power-off safety.
* Spatial four-bar linkage yields 2.5 × mechanical advantage; full glove weight 448 g, total system < 1.5 kg.
* Bench tests: zero slip at 16 N load; climbing-rig trials (75° incline) showed > 90 % successful transitions and instant arrest on deliberate failure. 

{% include gallery %}

### System Architecture

The glove follows a four-layer stack:
1. **Sensing** – RP-L-110 thin-film pressure pads on phalanges sample grip forces at 100 Hz.
2. **Control** – Arduino UNO executes a three-point-contact algorithm and watchdog e-stop.
3. **Actuation** – HX08L serial servo + spatial four-bar linkage amplify torque 2.5×; a cable release disengages dual-ratchet lock.
4. **Safety** – Passive bidirectional ratchet holds pose on power loss; hardware kill-switch severs 7.4 V rail.

### Mechanical Design

PLA-printed dorsal shell houses servo and linkage; aluminium ratchet wheels and brass standoffs reinforce high-stress joints. Glove module mass 448 g; arm electronics 900 g; backpack battery 1.4 kg. Four-bar kinematics yield 65 mm fingertip stroke with <1.5 ° angular error.

### Bench & Climbing Tests

* **Lock Time**: 0.18 s average (HS-camera, 60 fps).
* **Holding Load**: Zero slip at 16 N on 25 mm bar over 10 s.
* **Cycle Durability**: ≥90 % full-stroke completion across 50 cycles.
* **Inclined Rig Trials**: At 75° wall the glove achieved >90 % successful transitions; deliberate single-hand failure arrested instantly.

### Future Enhancements

* Replace UNO with STM32F4 for 400 Hz control and built-in IMU logging.
* Introduce flex-sensor feedback for closed-loop impedance modes.
* Swap PLA linkage for PA12-CF to cut weight by 80 g and raise fatigue life 3×. 