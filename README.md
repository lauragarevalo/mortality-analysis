# Mortality Analysis in Colombia 1950 - 2023

A usual analysis we use in actuarial calculation is the Mortality analysis for particular populations. This sort of information is used to determine actuarial hypothesis in order to be able to proyect liabilities or further calculations for the future. 

In this project we analyze the death counts by age for Colombia from 1950 to 2023 in order to determine the tendencies throughout the decades, understand the information according to the local context, measure the impact of the COVID-19 pandemic and finally determine if the latest data should be included in order to update actuarial hypothesis. 

## Data

The data comes from the UN World Population Prospects 2024 and contains death counts for Colombia from 1950 to 2023, disaggregated by single year of age (0 to 100+) for both sexes combined — 7,474 rows in total. The raw Excel file was processed in Python to produce a clean three-column CSV: year, age, and deaths.

Data Source:

United Nations, Department of Economic and Social Affairs, Population Division (2024).
World Population Prospects 2024, Online Edition.
File: MORT/F01-1 — Deaths (both sexes combined) by single age, 1950–2023.
License: Creative Commons CC BY 3.0 IGO.

## Metodology

The data was loaded into PostgreSQL database, where eight queries were written to explore mortality trend over time. These queries gather information about total deaths per year, the deadliest age group in the period, the mortality improvement over time, number of deaths by age group, the average age at death for each year and the impact of the pandemic. 

The SQL results were pulled into Python via SQLAlchemy and visualized through some informative charts. Finally we built a simple actuarial model that describes the actuarial calculation called annuity, which represents a series of periodic payments made over a person's lifetime. In pension modeling, the annuity value represents the present value of paying one unit of currency per year to a retiree for the rest of their life, it serves as a multiplier that, when applied to the actual pension benefit, gives the total liability a company must recognize. In order to do this, we used survival curves calculated from the mortality data. Two sensitivity analyses were conducted, one varying the discount rate and one varying the retirement age to illustrate how these assumptions affect pension liabilities.

## Limitations

Throughout the analysis we realized that the project has some limitations we should consider if we want to proceed with further projections and to determine accurate actuarial assumptions.

The combined-sex data affects the accuracy of the annuity calculations due to the survival rate differences between genders, and the different retirement ages (57 years for women and 62 years for men).

Aditionally, we would need population information by year to conduct proper mortality rates, we worked around that using only the deathcounts but a deeper actuarial analysis would need population information.

Finally, we used fixated discount rates that might be different to the reality of the market. In practice, discount rates are calculated through yield courves or market bonuses. Also the annuity calculations tend to add other parameters that improve the accuracy of the same. 


