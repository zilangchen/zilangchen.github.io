---
title: "Zero-Shot Deformation Reconstruction for Soft Robots Using a Flexible Sensor Array and Cage-Based 3D Gaussian Modeling"
collection: publications
category: conferences
permalink: /publication/2026-05-31-deformation-reconstruction
excerpt: 'A camera-free framework that maps real-time tactile signals from a flexible piezoresistive sensor array to cage-controlled 3D Gaussian deformation. The current public arXiv version reports zero-shot reconstruction on unseen soft robots without robot-specific retraining.'
date: 2026-06-16
venue: 'IEEE/RSJ IROS 2026'
status: accepted
paperurl: 'https://arxiv.org/abs/2603.19543'
paperlabel: 'View arXiv'
pdfurl: 'https://arxiv.org/pdf/2603.19543'
pdflabel: 'Download arXiv PDF'
citation: 'Shou, L.; Chen, Z.; Xu, W.; Luo, Y.; Cheng, T. (2026). &quot;Zero-Shot Deformation Reconstruction for Soft Robots Using a Flexible Sensor Array and Cage-Based 3D Gaussian Modeling.&quot; <i>2026 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS)</i> — Accepted.'
---

## Summary

This work presents a camera-free, zero-shot deformation reconstruction framework for soft robots. A flexible piezoresistive sensor array provides local tactile measurements, a graph attention network predicts low-dimensional cage-control displacements, and cage-based interpolation propagates those displacements to dense 3D Gaussian primitives for globally coherent reconstruction and photorealistic rendering.

Here, **zero-shot** means that the system can be deployed on previously unseen soft robots without collecting object-specific deformation data or retraining the model. It still requires a static geometric proxy of each undeformed object, such as an STL model, to initialize its canonical Gaussian representation.

## System Overview

### Flexible Tactile Sensing

- **10×10 piezoresistive array**: A 3×3 cm flexible patch records real-time resistance changes caused by surface deformation.
- **Conformable and tileable design**: The patch conforms to soft surfaces and can be attached to the sensing region of a new robot.
- **Camera-free inference**: Cameras and rendered supervision are not used during deployment.

### Cage-Based 3D Gaussian Modeling

- **Graph Attention Network (GAT)**: Maps encoded tactile measurements to displacements of sparse cage-control nodes.
- **Structure-aware propagation**: Inverse-distance-weighted interpolation transfers cage motion to dense Gaussian primitives while encouraging spatial continuity.
- **Real-time visualization**: The deformed Gaussian representation produces photorealistic RGB views for monitoring and interpretation.

## Evaluation

The current public arXiv version evaluates zero-shot deployment on two previously unseen pneumatic soft robots undergoing bending and twisting. Their undeformed geometries are initialized from fabrication STL files, with no robot-specific retraining, geometry-specific fine-tuning, or additional adaptation.

- **Average full-body reconstruction**: 0.67 IoU, 0.65 SSIM, and 3.48 mm Chamfer distance.
- **Angular accuracy**: 4.7° average error for bending and 4.9° average error for twisting.
- **Runtime**: Approximately 30 FPS with the coarse Gaussian setting and 5 FPS with the high-resolution setting on a single NVIDIA RTX 3070 Ti.
- **Additional demonstration**: A wallet-pressing experiment provides a qualitative proof of concept beyond the two soft-robot evaluation cases.

## Scope and Limitations

- Each new object requires an offline geometric initialization step to construct its canonical Gaussian representation.
- Reconstruction quality can decrease under extreme deformation, abrupt curvature transitions, imperfect sensor attachment, or strongly nonlinear material behavior.
- The current system prioritizes low-latency, structured geometric propagation rather than explicit material simulation.

## Publication Status

Accepted to the **2026 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS 2026)** on **June 16, 2026**.

The linked arXiv manuscript is the current public version and may differ slightly from the eventual conference proceedings version.

**Authors**: Linrui Shou; Zilang Chen; Wenjia Xu; Yiyue Luo; Tingyu Cheng

**Affiliations in the current arXiv version**: University of Notre Dame; University of Washington

## Acknowledgments

This work was conducted during the ISURE Summer Research Program at the University of Notre Dame (Jul 2025 – Sep 2025) under the supervision of Prof. Tingyu Cheng.
