---
title: "Low-Power Smart-Home Voice Terminal"
excerpt: "Offline MFCC + 120-k-param CNN deployed on ARM Cortex-M for always-on voice control."
image: /images/portfolio/smart-home/main.jpg
header:
  teaser: /images/portfolio/smart-home/main.jpg
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
gallery:
  - image_path: portfolio/smart-home/6.png
  - image_path: portfolio/smart-home/7.png
  - image_path: portfolio/smart-home/8.jpg
  - image_path: portfolio/smart-home/9.png
---

### Highlights

* Collected an 8 h Mandarin voice dataset and extracted 13-dim MFCC features.  
* Trained a 120 k-parameter CNN achieving 96.2 % on-device command accuracy.  
* Integrated with OneNet IoT cloud and Xinghuo LLM for conversational control of lights, HVAC and curtains.  
* Idle power just 28 mW enables >3 months of battery-powered standby.

{% include gallery %}

### Lightweight Audio-Interactive Smart-Home Hub (Embedded TinyML Gateway)
*Published: December 13, 2024*

Developed by the ADDLM team, this low-power gateway embeds a custom keyword-spotting neural network and iFlytek Spark LLM dialogue on dual MCUs, enabling private, real-time voice control of household devices without permanent cloud streaming.

---

#### Key Features

* **Dual-processor architecture:** STM32F4-Discovery runs a 6-layer CNN for on-device speech recognition while an ESP32-C3 Wi-Fi coprocessor handles MQTT telemetry to the OneNET cloud; an ESP32-Wroom module provides optional Bluetooth provisioning.
* **Integrated I/O stack:** IMP441 digital mic, class-D amplifier, full-range speaker and 2.0-inch TFT display deliver always-on voice capture, feedback tones and GUI status.
* **Custom 4-layer PCB:** separates TinyML inference, power regulation and RF stages; KiCad-designed board includes expansion header for additional environmental sensors.
* **Edge-first privacy & latency:** all wake-word spotting (<50 ms window) and intent parsing executed locally; only high-level state changes published to the cloud, eliminating raw-audio exposure.
* **Modular software:** CMSIS-NN optimised model (<20 kB weights) plus FreeRTOS task scheduler; OTA update pipeline permits hot-swapping new models or firmware over Wi-Fi.

#### Performance

* Reliable recognition of 10 Mandarin/English wake-words and sub-200 ms command-to-actuation latency while controlling simulated lights, fans and thermostat dashboards through OneNET.
* Continuous listening current <45 mA (3.3 V) on the STM32, enabling coin-cell battery life for remote nodes.
* Stable Wi-Fi connectivity through 24-hour soak tests with zero packet loss in congested 2.4 GHz environment.

#### Future Work

* Replace IMP441 with MEMS mic-array and beam-forming DSP for far-field (>3 m) capture.
* Expand command set via multi-label classification and incremental learning on-device.
* Integrate Zigbee/Thread radios for hub-less local mesh control; migrate cloud back-end from OneNET to open-source Home Assistant for wider community adoption. 