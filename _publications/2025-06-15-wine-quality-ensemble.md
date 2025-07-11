---
title: "Wine Quality Prediction with Ensemble Trees: A Leak-Free Benchmark"
collection: publications
category: preprints
permalink: /publication/2025-06-15-wine-quality-ensemble
excerpt: 'A comprehensive benchmark of ensemble learning methods for wine quality assessment, featuring rigorous data leakage prevention and systematic evaluation of Random Forest, Gradient Boosting, XGBoost, LightGBM, and CatBoost on 6,497 Vinho Verde samples. Achieves 69.3% weighted F1-score while identifying key physicochemical predictors for production-ready quality control systems.'
date: 2025-06-15
venue: 'arXiv preprint'
slidesurl: # URL to slides if available
paperurl: 'https://arxiv.org/abs/2506.06327'
citation: 'Chen, Z. (2025). &quot;Wine Quality Prediction with Ensemble Trees: A Leak-Free Benchmark.&quot; <i>arXiv preprint</i> arXiv:2506.06327.'
---

## Abstract

Accurate and reproducible wine-quality assessment is critical for production control yet remains dominated by subjective, labour-intensive tasting panels. This work presents the first comprehensive, leakage-free benchmark of five state-of-the-art ensemble learners—Random Forest, Gradient Boosting, XGBoost, LightGBM and CatBoost—on the canonical Vinho Verde red- and white-wine datasets (1,599 and 4,898 instances, 11 physicochemical attributes).

## Methodology & Technical Contributions

### Rigorous Data Pipeline
Our methodology addresses common pitfalls in machine learning benchmarks through a comprehensive leakage-prevention protocol:

- **Stratified Splitting**: 80:20 train-test split with quality-score stratification to maintain class distribution
- **Nested Cross-Validation**: Five-fold `StratifiedGroupKFold` within training set for robust hyperparameter tuning
- **Per-Fold Preprocessing**: Independent standardisation (μ=0, σ=1) applied to each fold to prevent data leakage
- **Class Imbalance Handling**: SMOTE-Tomek resampling combined with inverse-frequency cost weighting to address the 3-9 quality score distribution skew

### Hyperparameter Optimization
- **Search Strategy**: Optuna Tree-structured Parzen Estimator with 120-200 trials per model
- **Multi-Objective Tuning**: Simultaneous optimization of weighted F1-score, training time, and model complexity
- **Feature Selection**: Two-stage approach using mutual information ranking followed by recursive feature elimination

### Evaluation Framework
- **Metrics**: Weighted F1, macro F1, balanced accuracy, and per-class precision/recall for comprehensive assessment
- **Statistical Validation**: Five-fold cross-validation with confidence intervals and significance testing
- **Computational Profiling**: Runtime analysis on AMD EPYC 9K84 with 128GB DDR5 and H20 GPU acceleration

## Key Results & Findings

### Performance Hierarchy
Gradient Boosting achieves the highest predictive accuracy across both datasets:
- **Red Wine**: Weighted F1 0.693 ± 0.028 (95% CI: 0.665-0.721)
- **White Wine**: Weighted F1 0.664 ± 0.016 (95% CI: 0.648-0.680)

Random Forest and XGBoost follow within three percentage points, demonstrating the competitive landscape among modern ensemble methods.

### Feature Importance Analysis
Systematic feature ranking reveals that five key physicochemical properties capture 90%+ of the predictive signal:
1. **Alcohol content** (ρ = 0.47 with quality)
2. **Volatile acidity** (ρ = -0.39 with quality)  
3. **Sulphates** (ρ = 0.25 with quality)
4. **Free sulfur dioxide** (ρ = 0.05 with quality)
5. **Chlorides** (ρ = -0.21 with quality)

Dimensionality reduction to these five variables decreases weighted F1 by only 2.6 pp (red) and 3.0 pp (white), indicating substantial redundancy in the original 11-feature space.

### Computational Efficiency
Runtime profiling reveals a steep efficiency gradient across ensemble methods:
- **Gradient Boosting**: 12.3 ± 2.1 hours per five-fold study (highest accuracy, lowest efficiency)
- **XGBoost**: 2.8 ± 0.4 hours (GPU-accelerated)
- **LightGBM**: 2.1 ± 0.3 hours (memory-optimized)
- **CatBoost**: 1.2 ± 0.2 hours (categorical feature optimization)
- **Random Forest**: 47 ± 8 minutes (highest efficiency)

## Practical Recommendations

Based on systematic accuracy-efficiency trade-off analysis:

1. **Production Deployment**: Random Forest offers the optimal cost-effectiveness for real-time quality control systems
2. **GPU-Accelerated Environments**: XGBoost and LightGBM provide 4-6× speedup with minimal accuracy loss
3. **Offline Benchmarking**: Gradient Boosting serves as the accuracy ceiling for comparison with future methods
4. **Feature Engineering**: Focus on alcohol content and volatile acidity as primary quality indicators

## Research Impact & Reproducibility

This work establishes the first standardized benchmark for wine quality prediction, addressing methodological inconsistencies in prior literature. The fully documented preprocessing pipeline, hyperparameter configurations, and evaluation metrics provide a reproducible baseline for future research in imbalanced multi-class classification problems.

**Open Science**: All code, configurations, and detailed experimental logs are available to facilitate reproducible research in agricultural machine learning applications. 