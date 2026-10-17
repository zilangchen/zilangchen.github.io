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
layout: "publication"
author_profile: false
authors: "Zilang Chen"
project_url: "/portfolio/wine-quality-analysis"
---

## Summary


This paper presents a unified, leakage-free comparison of five ensemble learners—Random Forest, Gradient Boosting, XGBoost, LightGBM, and CatBoost—on the canonical Vinho Verde red- and white-wine datasets. The evaluation covers 1,599 red-wine and 4,898 white-wine samples, each described by 11 physicochemical attributes.

<details class="research-details" markdown="1">
<summary>Methodology</summary>

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

</details>

## Results


### Predictive Performance

Gradient Boosting achieved the highest weighted F1 score on both full-feature datasets:

- **Red wine**: 0.693 ± 0.028.
- **White wine**: 0.664 ± 0.016.

Random Forest and XGBoost followed within approximately three percentage points of the leading result.

### Feature-Selection Impact

Compressing the input from 11 variables to five reduced median weighted F1 by 2.6 percentage points for red wine and 3.0 percentage points for white wine. The selected variables varied by model and dataset; alcohol, volatile acidity, sulphates, chlorides, free sulfur dioxide, and fixed acidity were among the frequently retained features.

### Computational Efficiency

The full-feature mean optimization times plotted in Figure 7 were **46.3 minutes** for Random Forest, **58.9 minutes** for CatBoost, **92.3 minutes** for XGBoost, **122.5 minutes** for LightGBM, and **746.2 minutes** for Gradient Boosting. These are search-study times in the reported compute environment, not single-prediction latency. The paper's prose rounds or summarizes these values differently; the project page follows the plotted full-feature results.

## Reproducibility


The paper documents the preprocessing protocol, hyperparameter search spaces, feature-selection procedure, software environment, and fixed random seeds. A public code repository is not currently linked with this project; the paper's statement about released baselines should not be read as a verified download link.

<details class="research-details" markdown="1">
<summary>Publication Details</summary>

- **Conference**: The 2nd International Conference on Image Processing, Machine Learning, and Pattern Recognition (IPMLP 2025), Kunming, China.
- **Proceedings pages**: 162–170.
- **Conference date**: July 12–13, 2025.
- **DOI**: [10.1145/3759928.3759955](https://doi.org/10.1145/3759928.3759955).

</details>
