# Mortality Analysis in Colombia 1950 - 2023

A common analysis used in actuarial calculations is the mortality analysis for particular populations. This sort of information is used to determine actuarial assumptions in order to project liabilities and further calculations for the future.

In this project we analyze the death counts by age for Colombia from 1950 to 2023 in order to determine the tendencies throughout the decades, understand the information according to the local context, measure the impact of the COVID-19 pandemic and finally determine if the latest data should be included in order to update actuarial assumptions.


## Data

The data comes from the UN World Population Prospects 2024 and contains death counts for Colombia from 1950 to 2023, disaggregated by single year of age (0 to 100+) for both sexes combined — 7,474 rows in total. Since the raw file contains data for all countries and is structured in wide format (one column per age), it was filtered and reshaped to only include Colombia's death counts by age and year in a clean long format suitable for SQL and Python analysis.

Data Source:

United Nations, Department of Economic and Social Affairs, Population Division (2024).
World Population Prospects 2024, Online Edition.
File: MORT/F01-1 — Deaths (both sexes combined) by single age, 1950–2023.
License: Creative Commons CC BY 3.0 IGO.


## Metodology

The raw Excel file was processed in Python to filter Colombia's data and reshape it from wide format to long format, producing a clean three-column CSV: year, age, and deaths. This was then loaded into a PostgreSQL database, where eight queries were written to explore mortality trends over time. These queries gather information about total deaths per year, the deadliest age group in the period, the mortality improvement over time, number of deaths by age group, the average age at death for each year and the impact of the pandemic.

The SQL results were pulled into Python via SQLAlchemy and visualized through informative charts. Finally we built a simple actuarial model that describes the actuarial calculation called annuity, which represents a series of periodic payments made over a person's lifetime. In pension modeling, the annuity value represents the present value of paying one unit of currency per year to a retiree for the rest of their life, it serves as a multiplier that, when applied to the actual pension benefit, gives the total liability a company must recognize. In order to do this, we used survival curves calculated from the mortality data. Two sensitivity analyses were conducted, one varying the discount rate and one varying the retirement age, to illustrate how these assumptions affect pension liabilities.


## Limitations

Throughout the analysis we identified some limitations to consider if proceeding with further projections or determining accurate actuarial assumptions.

The combined-sex data affects the accuracy of the annuity calculations due to the survival rate differences between genders, and the different retirement ages (57 years for women and 62 years for men).

Additionally, we would need population information by year to calculate proper mortality rates. We worked around this using only death counts, but a deeper actuarial analysis would require population exposure data.

We also used 2019 as the sole pre-pandemic baseline for the COVID-19 excess deaths analysis. A more robust approach would use a multi-year average (e.g. 2017–2019) to reduce sensitivity to anomalies in any single year.

Finally, we used fixed discount rates which in practice would be derived from yield curves or market bond rates. Additionally, the annuity model could be improved by incorporating salary growth and other benefit assumptions.


