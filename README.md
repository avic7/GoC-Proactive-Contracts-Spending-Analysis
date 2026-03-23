# Government of Canada Contract Spending Analysis (2017–2026)

## Project Overview
This repository contains a comprehensive data analysis of the Government of Canada's (GoC) contract spending from 2017 to 2026. By engineering a custom data pipeline to process over 1 million raw transactional records, this project resolves vendor fragmentation, reconstructs chronological project timelines, and exposes the true financial footprint of federal procurement.

## Repository Structure
To navigate this project, please refer to the following directories:

* `deliverables/`: Contains the final analytical report (`Final_Report.pdf`/`.docx`), detailing the full methodology, insights, and recommendations.
* `notebooks/`: Contains the primary Python/Jupyter Notebook (`GoC_Contract_Analysis.ipynb`) demonstrating the data exploration, NLP vendor normalization, and linear spreading algorithms used to process the data.
* `outputs/`: Includes small, exported supplementary tables (e.g., spending by commodity type samples) referenced in the main report.
* `data/`: **[NOTE: Kept local]** Per best practices and GitHub size constraints, the raw 1M+ row dataset (`contract_data.xlsx`) is not committed to this repository. 

