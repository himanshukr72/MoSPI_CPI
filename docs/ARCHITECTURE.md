# MoSPI CPI Pipeline Architecture

The repository follows this analytical flow:

~~~text
MoSPI CPI source data
        |
        v
Python ingestion + cleaning
        |
        v
Validated analytical dataset
        |
        v
PostgreSQL
   |          |
   v          v
 SQL       Power BI
aggregations DirectQuery
   |          |
   +-----> Dashboard
        |
        v
Temporal ML experiments
        |
        v
Prediction + error analysis
~~~

Reusable database and cleaning helpers live under `src/mospi_cpi/`. The notebooks remain as transparent analysis artifacts and should be treated as experiments/documentation rather than as the production pipeline itself.
