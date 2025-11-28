---
title: "Real-Time Camera-Free Deformation Reconstruction via Flexible Sensor Array and Cage-based Deformation Model"
collection: publications
category: conferences
permalink: /publication/2026-05-31-deformation-reconstruction
excerpt: 'Camera-free, real-time 3D deformation reconstruction system for soft robots using flexible piezoresistive sensors and a learned cage-based Gaussian deformation model. Achieves ≈30 FPS real-time rendering, <5% mean 3D displacement error, and <4.7° bending-angle error under bending/twisting/pressing deformations.'
date: 2026-05-31
venue: 'IEEE ICRA 2026 (Under Review)'
slidesurl: # URL to slides if available
paperurl: '/files/Real_Time_Camera_Free_Deformation_Reconstruction_via_Flexible_Sensor_Array_and_Cage_based_deformation_mode.pdf'
citation: 'Shou, L.; Chen, Z.; Xu, W.; Luo, Y.; Cheng, T. (2026). &quot;Real-Time Camera-Free Deformation Reconstruction via Flexible Sensor Array and Cage-based Deformation Model.&quot; <i>IEEE International Conference on Robotics and Automation (ICRA)</i> — Under Review.'
---

## Abstract

We present a camera-free, real-time deformation reconstruction system for soft objects that uses a flexible piezoresistive sensor array and a learned cage-based Gaussian deformation model. Our approach combines innovations in sensor design, dynamic scene representation, and graph neural networks to achieve high-fidelity shape tracking without external cameras.

## Key Contributions

### Flexible Sensor Array Design

- **10×10 Piezoresistive Sensor Array** (3×3 cm): Provides sparse pressure-induced resistance readings on the object's surface in real-time
- **Silicon-based Flexible Capacitance Sensors**: Conformable to soft robot surfaces, enabling seamless integration
- **Tileable Design**: Flexible, tileable piezoresistive array deployed on the robot's nominal STL mesh

### 4D Gaussian Splatting Representation

- **Multi-view Reconstruction**: Stop-motion protocol to scan key static poses and render dense multi-view images with accurate poses via Blender's virtual cameras
- **Temporal Densification**: Video frame interpolation to densify time and enable temporally trackable Gaussian models for every frame
- **Per-frame Primitives**: Each frame yields Gaussian primitives that capture fine surface details of the soft robot's deformation

### Cage-based Deformation Framework

- **Graph Attention Network (GNN)**: Estimates low-dimensional control displacements for sparse cage control points
- **Inverse-Distance-Weighted Propagation**: Displacements propagated to millions of Gaussians using local weighting strategies
- **Zero-shot Generalization**: Canonicalization per sensed region enables reconstruction on unseen objects

## Performance Results

- **Real-time Rendering**: Achieved ≈ 30 FPS real-time rendering of photorealistic RGB images
- **Deformation Accuracy**: < 5% mean 3D displacement error and < 4.7° bending-angle error under bending/twisting/pressing deformations
- **Zero-shot Capability**: Demonstrated zero-shot camera-free reconstruction on unseen objects
- **Fine-grained Tracking**: Successfully tracked three representative deformation types – bending, twisting, and pressing

## Applications

This camera-free deformation reconstruction system serves as an effective solution for soft robotics and other applications in:

- Dark or low-light environments where cameras are ineffective
- Confined spaces with limited camera access (e.g., endoscopic scenes, minimally invasive instruments)
- Privacy-sensitive environments where visual recording is restricted
- Real-time manipulation tasks requiring precise geometry recovery

## Publication Status

Manuscript submitted to **IEEE ICRA 2026** (International Conference on Robotics and Automation).

**Authors**: Linrui Shou; Zilang Chen; Wenjia Xu; Yiyue Luo; Tingyu Cheng

**Affiliation**: University of Notre Dame, South China University of Technology

## Acknowledgments

This work was conducted during the ISURE Summer Research Program at University of Notre Dame (Jul 2025 – Sep 2025) under the supervision of Prof. Tingyu Cheng.





