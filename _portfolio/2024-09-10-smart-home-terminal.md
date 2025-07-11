---
title: "Low-Power Smart-Home Voice Terminal"
excerpt: "Offline MFCC + lightweight NN deployed on ARM Cortex-M for always-on voice control."
image: /images/portfolio/smart-home-1.png
collection: portfolio
permalink: /portfolio/smart-home-terminal
date: 2024-12-24
links:
  - label: Demo Video
    url: "#"
  - label: GitHub (partial)
    url: "#"
projects:
  - Embedded AI
---

* Collected 8 h Mandarin voice dataset; extracted 13-dim MFCCs.
* Trained 120-k-param CNN achieving 96.2 % command accuracy on-device.
* Integrated with OneNet IoT cloud & Xinghuo LLM for conversational control of lights, HVAC, curtains.
* Idle power 28 mW, enabling battery operation >3 months. 