# Indian CPI & Inflation Forecasting (2014–2025)

## Overview

This project focuses on analyzing India's Consumer Price Index (CPI) data and forecasting inflation using machine learning techniques. It combines historical CPI datasets, standardizes data across different base years, engineers time-series features, and predicts inflation using tree-based regression models.

The project uses historical CPI observations from the Ministry of Statistics and Programme Implementation (MoSPI) and explores machine learning approaches such as **LightGBM and Random Forest** for inflation prediction.

## Objectives

- Clean and standardize historical CPI data.
- Integrate CPI datasets across different base years.
- Calculate and forecast inflation using historical CPI information.
- Engineer seasonal, lagged, and categorical features for prediction.
- Train regression models to predict inflation for 2025.
- Reconstruct CPI index values from predicted inflation.
- Establish a framework for comparing different machine learning models.

## Dataset

The project uses Indian CPI data containing information such as:

| Feature | Description |
|---|---|
| `BYear` | CPI index base-year information |
| `Year_i` | Observation year |
| `Month_i` | Observation month |
| `State_i` | State or geographical category |
| `Sector` | Sector classification |
| `Group_i` | CPI expenditure group |
| `SubGroup` | CPI expenditure subgroup |
| `Index_i` | CPI index value |
| `Inflation` | Inflation rate (%) |

The data covers historical observations and is used to generate predictions for 2025.

**Data source:** Ministry of Statistics and Programme Implementation (MoSPI), Government of India.

## Project Workflow

### 1. Data Cleaning and Standardization

- Standardized categorical labels and removed unwanted whitespace.
- Converted year, CPI index, and inflation columns to numeric types.
- Standardized month names and established chronological ordering.
- Prepared consistent group, subgroup, state, and sector identifiers.

### 2. CPI Dataset Integration

- Combined historical CPI observations with newer CPI data.
- Standardized classifications to improve consistency across datasets.
- Applied base-year linking and rebasing procedures where required to maintain comparability between CPI series.

### 3. Feature Engineering

The forecasting pipeline constructs several features from historical CPI and inflation observations.

**Seasonal features**

- `sin_month`
- `cos_month`

These represent the cyclical nature of monthly observations.

**Lagged features**

- `Inflation_Lag_12M`: Inflation from the corresponding month in the previous year.
- `Inflation_Lag_24M`: Inflation from the corresponding month two years earlier.
- `Index_Lag_12M`: CPI index from the corresponding month in the previous year.
- `Log_Index_Lag_12M`: Log-transformed lagged CPI index.
- `Subgroup_Macro_Mean_Lag_12M`: Lagged subgroup-level inflation information.

**Categorical features**

- Month
- State
- Sector
- Group
- Subgroup

These features help the models learn differences in inflation patterns across geographical areas and consumption categories.

### 4. Target Preparation

The target variable is `Inflation_Target`, derived from the inflation column.

The current pipeline clips target values at the 1st and 99th percentiles to reduce the influence of extreme observations during model training.

### 5. Model Training

The models use observations from **2016–2024**, excluding 2020 and 2021, according to the current training configuration.

#### LightGBM Regressor

LightGBM is a gradient boosting algorithm that builds decision trees sequentially to improve prediction accuracy.

The implementation uses:

- Huber loss objective
- 350 boosting iterations
- Learning rate of 0.03
- Maximum tree depth of 6
- 31 leaves per tree

#### Random Forest Regressor

Random Forest is an ensemble learning algorithm that averages predictions from multiple decision trees.

The implementation uses:

- 300 decision trees
- Maximum depth of 15
- Minimum 10 samples required for a split
- Minimum 3 samples per leaf
- Square-root feature sampling
- Fixed random seed for reproducibility

Categorical variables are encoded using `OrdinalEncoder`, while the numerical features are passed through the preprocessing pipeline.

### 6. Inflation Forecasting for 2025

After training, the selected model predicts inflation for observations belonging to 2025.

The predicted inflation values are inserted into the corresponding records.

### 7. CPI Index Reconstruction

The pipeline reconstructs the CPI index using the predicted inflation rate and the corresponding index from the previous year:

\[
CPI_t=CPI_{t-12}\left(1+\frac{\pi_t}{100}\right)
\]

where:

- \(CPI_t\) is the reconstructed CPI index.
- \(CPI_{t-12}\) is the CPI index for the corresponding month in the previous year.
- \(\pi_t\) is the predicted year-on-year inflation rate.

This provides a consistent way to derive index estimates from predicted inflation, provided both series use compatible definitions and base-year conventions.

## Technologies Used

- **Python** — Core programming language
- **Pandas** — Data cleaning and manipulation
- **NumPy** — Numerical computations and seasonal feature engineering
- **Scikit-learn** — Random Forest, preprocessing, and model pipelines
- **LightGBM** — Gradient boosting regression
- **Jupyter Notebook** — Experimentation and analysis
- **Matplotlib** — Data visualization, where used

## Model Comparison

The project can be extended to compare models using a common chronological validation period.

Recommended evaluation metrics include:

| Metric | Purpose |
|---|---|
| MAE | Measures average absolute prediction error |
| RMSE | Penalizes larger prediction errors |
| MAPE | Measures percentage prediction error, where actual values are nonzero |
| \(R^2\) | Measures explained variation in a validation dataset |

A fair comparison requires the same forecast horizon, target definition, and validation observations for every model.

## Repository Structure

A suggested repository structure is:

```text
CPI-Inflation-Forecasting/
│
├── notebooks/
│   ├── data_cleaning.ipynb
│   ├── cpi_integration.ipynb
│   ├── linear_regression.ipynb
│   ├── random_forest.ipynb
│   └── lightgbm_forecasting.ipynb
│
├── data/
│   └── README.md
│
├── README.md
├── requirements.txt
└── .gitignore
```

Adjust the notebook names to match the actual files in your repository.

## Installation

Clone the repository:

```bash
git clone <YOUR_REPOSITORY_URL>
cd CPI-Inflation-Forecasting
```

Create a virtual environment:

```bash
python -m venv .venv
```

Activate it on Windows:

```bash
.venv\Scripts\activate
```

Install the required packages:

```bash
pip install numpy pandas scikit-learn lightgbm matplotlib jupyter openpyxl
```

Launch Jupyter Notebook:

```bash
jupyter notebook
```

Open the relevant notebook and run the cells in order.

## Important Considerations

- Time-series features must be constructed without using future observations.
- Training and validation should be separated chronologically to avoid data leakage.
- Excluding 2020 and 2021 from training is a modelling choice that should be justified and evaluated against alternative specifications.
- Missing lagged features and fallback index values should be reviewed carefully.
- Predictions should be validated against actual observations before being used for substantive conclusions.
- The current 2025 predictions are model estimates, not official MoSPI figures.

## Future Improvements

- Compare Linear Regression, Random Forest, LightGBM, XGBoost, and CatBoost.
- Incorporate ARIMA and SARIMA as econometric forecasting baselines.
- Explore ADF, Phillips–Perron, and seasonal unit-root tests.
- Apply rolling-origin or expanding-window validation.
- Perform hyperparameter tuning and feature-importance analysis.
- Investigate LSTM and Transformer-based time-series forecasting.

## Conclusion

This project develops a data-driven pipeline for Indian CPI and inflation analysis, from historical data preparation and integration to feature engineering, machine learning-based inflation prediction, and CPI index reconstruction.

It provides a foundation for comparing econometric and machine learning approaches to inflation forecasting using official CPI data.

## Acknowledgements

Data source: Ministry of Statistics and Programme Implementation (MoSPI), Government of India.
