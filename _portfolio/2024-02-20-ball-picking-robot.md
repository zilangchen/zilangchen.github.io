---
title: "Multifunctional Ball-Collecting Vehicle"
excerpt: "Collision-based collection mechanism picks ping-pong to basketball-size balls; Mecanum drive, 24 V power, and suspension for agile contest performance."
image: /images/portfolio/ball-robot/main.png
header:
  teaser: /images/portfolio/ball-robot/main.png
collection: portfolio
permalink: /portfolio/ball-picking-robot
date: 2024-05-31
links:
  - label: Competition Video
    url: "#"
projects:
  - Mobile Robotics
---

Designed and built a 50 cm × 50 cm × 50 cm vehicle that gathers balls of multiple diameters via collision dynamics—no gripper required.

* Collision pickup funnels balls into on-board hopper; rear gate servo releases payload.
* Four Mecanum wheels driven by 24 V planetary-gear motors enable omni-directional motion; independent spring suspension smooths vibration.
* Nylon/aluminium hybrid chassis survives contest impacts; PS2 wireless controller offers intuitive tele-op.
* Prototype handles ping-pong to basketballs, stores >15 tennis-ball equivalents, and completes arena run in 45 s; total BOM ≈ ¥3.4 k. 

### Gallery

![Design](/images/portfolio/ball-robot/12.png)
![Suspension](/images/portfolio/ball-robot/14.jpg) 

### Architecture & Mechanics

The robot marries a lightweight aluminium-nylon chassis with a four-wheel Mecanum drivetrain. A front impact panel and 35° inclined guide plate transform frontal collisions into vertical lift, allowing balls to roll into a 12-litre hopper. A spring-latched rear gate—driven by a 20 kg·cm digital servo—dumps the payload on command. Independent coil-spring suspensions (1-10 kg rating) mitigate the Mecanum vertical oscillation, protecting battery and control boards.

### Electronics & Control

The STM32-based C50C controller communicates with dual L298N drivers for the 24 V 1∶51 planetary gear motors. A PS2 wireless pad provides tele-op; speed commands are closed-loop via motor encoders and PID PWM to ensure straight-line tracking (<3 ° deviation over 3 m). The servo gate is mapped to a face button for rapid score drops. A 7.4 V 5200 mAh Li-ion pack sustains >20 min continuous run.

### Performance

Bench push tests confirm 28 N stall thrust; top planar speed 1.2 m s⁻¹. During the June 2024 college contest the vehicle completed the pick-and-place course in 45 s—30 % faster than baseline—and withstood multiple side impacts without structural damage. Capacity: 6 basketballs or 60 ping-pong balls.

### Future Work

* Vision module for auto-centred collision trajectory.
* Replace nylon side panels with carbon-PETG to shave 180 g.
* Upgrade gate servo to magnetic-encoder model for closed-loop throw angle. 