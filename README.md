# MoSPI CPI — Inflation Analytics & Prediction

An end-to-end analysis of India's Consumer Price Index (CPI) using data from the **Ministry of Statistics and Programme Implementation (MoSPI), Government of India**.

The project combines **Python, PostgreSQL/SQL, Power BI and machine learning** to turn CPI observations into an analytical workflow and interactive dashboard.

> **Project recognition:** the repository documents that this work received a Consolation Prize in a Government of India/MoSPI data-visualization hackathon.

## What this project does

- Cleans and validates CPI observations with Python/pandas.
- Organizes observations by year, month, state, sector, group and subgroup.
- Loads the analytical dataset into PostgreSQL.
- Uses SQL for year-wise, sector-wise and group-wise aggregations.
- Connects Power BI to PostgreSQL using DirectQuery.
- Experiments with temporal CPI prediction, treating 2020–2021 separately from the main training period.
- Keeps notebooks available as an audit trail for the analysis.

## Architecture

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

~~~text
MoSPI data
   |
   v
Python cleaning / validation
   |
   v
PostgreSQL
   |------------------|
   v                  v
SQL analysis      Power BI DirectQuery
                      |
                      v
               CPI Dashboard

Historical CPI
   |
   v
Temporal ML experiments
   |
   v
Prediction + evaluation
~~~

## Repository structure

~~~text
MoSPI_CPI/
├── docs/
│   └── ARCHITECTURE.md
├── notebooks/
│   ├── MoSPI_final_12-24.ipynb
│   ├── cpi_25_pred_ml.ipynb
│   ├── data_25-26.ipynb
│   ├── merge_cpi_notebook.ipynb
│   └── merged_cpi_cal_index_25.ipynb
├── src/
│   └── mospi_cpi/
│       ├── __init__.py
│       ├── cleaning.py
│       └── database.py
├── CPI_Dashboard_MoSPI_GOI.pbix
├── CPI_Dashboard_MoSPI_GOI.pbit
├── SQL_COMMAND.sql
├── .env.example
├── pyproject.toml
├── tests/
│   └── test_cleaning.py
└── README.md
~~~

Local environments, credentials and generated files should not be committed.

## Data

The analytical data contains fields such as:

| Field | Meaning |
|---|---|
| `BYear` | CPI base year |
| `Year_i` | Observation year |
| `Month_i` | Observation month |
| `State_i` | State/region |
| `Sector` | Combined / Rural / Urban |
| `Group_i` | CPI group |
| `SubGroup` | CPI subgroup |
| `Index_i` | CPI index |
| `Inflation` | Inflation measure |

The historical analytical dataset used in the notebooks contains roughly **216k observations**.

## Tech stack

**Data:** Python, pandas, NumPy  
**Database:** PostgreSQL, SQLAlchemy, psycopg2  
**BI:** Power BI, DirectQuery  
**ML:** scikit-learn and tree-based modelling experiments  
**Environment:** uv / pyproject.toml

## Reproducibility

### 1. Clone

~~~bash
git clone https://github.com/himanshukr72/MoSPI_CPI.git
cd MoSPI_CPI
~~~

### 2. Environment

~~~bash
uv sync
~~~

A standard Python virtual environment can also be used with the dependencies in `pyproject.toml`.

### 3. PostgreSQL

Copy the template:

~~~bash
cp .env.example .env
~~~

Then configure your own connection:

~~~text
DATABASE_URL=postgresql+psycopg2://USER:PASSWORD@HOST:5432/DATABASE
~~~

Never commit `.env` or database credentials.

### 4. Analysis

The principal historical analysis is in:

`notebooks/MoSPI_final_12-24.ipynb`

The prediction experiment is in:

`notebooks/cpi_25_pred_ml.ipynb`

### 5. SQL and Power BI

Run `SQL_COMMAND.sql` against your PostgreSQL database.

Open `CPI_Dashboard_MoSPI_GOI.pbix` in Power BI Desktop and configure the PostgreSQL connection for your environment. The `.pbit` template is also included.

## ML methodology

The prediction notebook treats CPI as a temporal problem instead of randomly splitting observations.

The current experiment:

- trains on historical observations,
- evaluates a later year as a holdout,
- treats 2020–2021 separately because of the COVID-period disruption,
- reports regression metrics for held-out observations.

This is an **experimental forecasting workflow**, not a claim to reproduce official CPI forecasts. It should be interpreted alongside simple baselines and temporal validation.

## Dashboard

The Power BI model supports interactive analysis across:

- year/month
- state
- rural/urban/combined sector
- CPI group
- CPI subgroup

The Power BI files are included so the report and data model can be inspected locally.

## Security

No database password, API key or local credential belongs in this repository.

Database configuration is now expected through `DATABASE_URL`. If a credential was previously committed to a public repository, rotate it before reusing it.

## Roadmap

- automated data-quality tests
- scripted ingestion pipeline
- temporal cross-validation and baseline models
- model comparison and error analysis
- CI checks for formatting, tests and accidental secrets
- dashboard screenshots and selected analytical findings

## Attribution

CPI data is sourced from MoSPI. Check applicable MoSPI/Government of India terms before redistributing source data outside this project.

## Author

**Himanshu Kumar**  
Birla Institute of Technology, Mesra  
Quantitative Economics & Data Science
