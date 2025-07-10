---
title: "Wine Quality Prediction with Ensemble Trees: A Leak-Free Benchmark"
collection: publications
category: preprints
permalink: /publication/2025-06-15-wine-quality-ensemble
excerpt: 'Unified, reproducible benchmark of five ensemble learners on the Vinho Verde datasets with rigorous leakage-free pipeline.'
date: 2025-06-15
venue: 'arXiv preprint'
paperurl: 'https://arxiv.org/abs/2506.06327'
citation: 'Chen, Z. (2025). "Wine Quality Prediction with Ensemble Trees: A Leak-Free Benchmark." <i>arXiv preprint</i> arXiv:2506.06327.'
---

Accurate and reproducible wine-quality assessment is critical for production control yet remains dominated by subjective, labour-intensive tasting panels. This work presents the first unified benchmark of five ensemble learners—Random Forest, Gradient Boosting, XGBoost, LightGBM and CatBoost—on the canonical Vinho Verde red- and white-wine datasets (1,599 and 4,898 instances, 11 physicochemical attributes).

Our leakage-free workflow employs an 80:20 stratified train-test split, five-fold `StratifiedGroupKFold` within the training set, per-fold standardisation, SMOTE-Tomek resampling, inverse-frequency cost weighting, Optuna hyper-parameter search (120–200 trials per model) and a two-stage feature-selection refit. Gradient Boosting achieves the highest accuracy (weighted F1 0.693 ± 0.028 for red and 0.664 ± 0.016 for white), followed within three percentage points by Random Forest and XGBoost.

Limiting each model to its five top-ranked variables lowers dimensionality by 55 % while reducing weighted F1 by only 2.6 pp (red) and 3.0 pp (white), indicating that alcohol, volatile acidity, sulphates, free SO₂ and chlorides capture most predictive signal. Runtime profiling on an EPYC 9K84/H20 node reveals a steep efficiency gradient: Gradient Boosting averages 12 h per five-fold study, XGBoost and LightGBM require 2–3 h, CatBoost 1 h, and Random Forest under 50 min.

We therefore recommend Random Forest as the most cost-effective production model, XGBoost and LightGBM as GPU-efficient alternatives, and Gradient Boosting as the accuracy ceiling for offline benchmarking. The fully documented pipeline and metric set provide a reproducible baseline for future work on imbalanced multi-class wine-quality prediction. 