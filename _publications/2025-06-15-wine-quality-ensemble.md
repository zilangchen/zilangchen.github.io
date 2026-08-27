---
title: "Wine Quality Prediction with Ensemble Trees: A Unified, Leak-Free Comparative Study"
collection: publications
category: conferences
permalink: /publication/2025-06-15-wine-quality-ensemble
excerpt: 'A unified, leakage-free comparison of Random Forest, Gradient Boosting, XGBoost, LightGBM, and CatBoost on 6,497 Vinho Verde samples. Gradient Boosting achieved the highest weighted F1 scores, while Random Forest offered the strongest accuracy–efficiency trade-off.'
date: 2025-07-12
venue: 'IPMLP 2025'
venue_note: 'Proceedings published by ACM'
status: published
paperurl: 'https://doi.org/10.1145/3759928.3759955'
paperlabel: 'View ACM Record'
pdfurl: '/files/Wine Quality IPMLP2025.pdf'
pdflabel: 'Download PDF'
citation: 'Chen, Z. (2025). &quot;Wine Quality Prediction with Ensemble Trees: A Unified, Leak-Free Comparative Study.&quot; In <i>Proceedings of the 2nd International Conference on Image Processing, Machine Learning, and Pattern Recognition (IPMLP 2025)</i>, 162–170. https://doi.org/10.1145/3759928.3759955.'
---

## Summary

This paper presents a unified, leakage-free comparison of five ensemble learners—Random Forest, Gradient Boosting, XGBoost, LightGBM, and CatBoost—on the canonical Vinho Verde red- and white-wine datasets. The evaluation covers 1,599 red-wine and 4,898 white-wine samples, each described by 11 physicochemical attributes.

## Methodology

### Leakage-Controlled Evaluation

- **Held-out evaluation**: An 80:20 stratified train–test split preserves the quality-score distribution while keeping the test set untouched during model selection.
- **Training-set cross-validation**: Five-fold `StratifiedGroupKFold` is used within the training data for hyperparameter tuning.
- **Per-fold preprocessing**: Standardization, SMOTE-Tomek resampling, and inverse-frequency class weighting are fitted within each training fold to prevent data leakage.

### Hyperparameter Optimization and Feature Selection

- **Optuna search**: Each model is tuned with the Tree-structured Parzen Estimator and a fixed budget of 120–200 trials.
- **Optimization objective**: Weighted F1 is the sole hyperparameter-optimization objective.
- **Two-stage feature selection**: Each model first ranks all 11 variables using its native tree-based importance measure; it is then retrained on its five highest-ranked features, subject to a 5% minimum importance threshold.

### Evaluation Metrics and Compute

- **Primary metric**: Weighted F1.
- **Auxiliary metrics**: Macro F1, macro ROC-AUC, Matthews correlation coefficient, and Brier score.
- **Compute environment**: AMD EPYC 9K84 with 128 logical cores, 512 GB RAM, and one NVIDIA H20 GPU.

## Results

### Predictive Performance

Gradient Boosting achieved the highest weighted F1 score on both full-feature datasets:

- **Red wine**: 0.693 ± 0.028.
- **White wine**: 0.664 ± 0.016.

Random Forest and XGBoost followed within approximately three percentage points of the leading result.

### Feature-Selection Impact

Compressing the input from 11 variables to five reduced median weighted F1 by 2.6 percentage points for red wine and 3.0 percentage points for white wine. The selected variables varied by model and dataset; alcohol, volatile acidity, sulphates, chlorides, free sulfur dioxide, and fixed acidity were among the frequently retained features.

### Computational Efficiency

- **Gradient Boosting**: Approximately 12 hours for a five-fold optimization study.
- **XGBoost and LightGBM**: Approximately 2–3 hours with GPU acceleration.
- **CatBoost**: Approximately 1 hour.
- **Random Forest**: Approximately 49–50 minutes on CPU.

These results position Gradient Boosting as the accuracy ceiling and Random Forest as the most economical default for regular retraining. XGBoost offers a balanced GPU-accelerated alternative.

## Reproducibility

The paper documents the preprocessing protocol, hyperparameter search spaces, feature-selection procedure, software environment, and fixed random seeds. It reports releasing preprocessing scripts, hyperparameter grids, and feature-selection protocols as repeatable baselines.

## Publication Details

- **Conference**: The 2nd International Conference on Image Processing, Machine Learning, and Pattern Recognition (IPMLP 2025), Kunming, China.
- **Proceedings pages**: 162–170.
- **Conference date**: July 12–13, 2025.
- **DOI**: [10.1145/3759928.3759955](https://doi.org/10.1145/3759928.3759955).
