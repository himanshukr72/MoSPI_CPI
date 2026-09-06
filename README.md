📈 Inflation-Trends

This project provides a comprehensive analysis of inflation trends using Consumer Price Index (CPI) data from the Ministry of Statistics and Programme Implementation (MoSPI), Government of India. It integrates Python, SQL, and Power BI into a unified data pipeline for real-time insights.

🏆 Project Recognition

This project was awarded a Consolation Prize in a Data Visualization Hackathon conducted by the Government of India in collaboration with MoSPI.

📂 Project Contents

📓 MoSPI_final.ipynb → Jupyter Notebook for data cleaning, preprocessing, and exploratory data analysis (EDA) using pandas & numpy.

🗄️ SQL_COMMAND.sql → SQL scripts for creating relational tables, inserting cleaned data, and performing aggregated calculations.

📊 CPI_Dashboard_MoSPI_GOI.pbix / .pbit → Interactive Power BI dashboard visualizing CPI inflation trends.

📑 README.md → Documentation of the project workflow, methodology, and usage.

📊 Data Overview

The primary dataset is cpi Group data.csv, sourced from MoSPI (Government of India).
Key columns include:

📌 BaseYear → Reference year for CPI calculations.

📅 Year & Month → Temporal resolution of data.

🏙️ State & Sector → Regional and sectoral analysis (Combined, Rural, Urban).

🏷️ Group & SubGroup → Categorization of goods & services.

📈 Index → CPI value.

💹 Inflation (%) → Annual inflation metric.

⚠️ Missing values (*) are cleaned and imputed in the Python Notebook.

🔎 Analysis and Visualization Strategy

🐍 Python-based Analysis

Used pandas & numpy in MoSPI_final.ipynb for cleaning and exploratory analysis.

🛢️ SQL Database Integration

Implemented via SQL_COMMAND.sql to create a PostgreSQL database.

Efficient storage, queries, and aggregation for large datasets.

📊 Real-Time Power BI Dashboard

Connected with DirectQuery for live data analysis.

✅ No data storage in Power BI server (lightweight and scalable).

🔄 Real-time insights directly from the SQL database.

⚡ Getting Started

Clone the Repository

git clone [repository URL]


Run Data Processing

Open MoSPI_final.ipynb in Jupyter Notebook or JupyterLab.

Execute the preprocessing steps.

Setup Database

Run SQL scripts from SQL_COMMAND.sql to create and populate PostgreSQL tables.

Launch Dashboard

Install Power BI Desktop.

Open CPI_Dashboard_MoSPI_GOI.pbix.

Connect directly to PostgreSQL for real-time insights.

✅ Conclusion

This project demonstrates a complete data pipeline:

📥 Raw data collection (MoSPI CPI dataset).

🧹 Cleaning & preprocessing (Python).

🛢️ Structured storage & queries (PostgreSQL).

📊 Real-time dashboards (Power BI with DirectQuery).

By combining these technologies, it transforms raw economic data into actionable insights, providing a scalable and dynamic solution for monitoring inflation trends.
