# World Layoffs Analysis Project
This project is a learning project from the [AlexTheAnalyst](https://github.com/AlexTheAnalyst)  YouTube channel for the [Data Analyst Bootcamp](https://www.youtube.com/watch?v=4UltKCnnnTA&list=PLUaB-1hjhk8FE_XZ87vPPSfHqb6OcM0cF&index=20).


![tableau](https://github.com/Athari22/World-layoffs-project/blob/main/Dashboard%201.png)
## Case Description
This project aims to analyze global layoff trends across various industries and countries using a dataset on company layoffs. The analysis focuses on understanding the distribution and impact of layoffs on different sectors and regions. Data cleaning and transformation were performed using SQL (MYsql), followed by data exploration and visualization using [Tableau](https://public.tableau.com/app/profile/athari.k/vizzes).

### Dataset Overview
The dataset contains information on layoffs across different companies worldwide, including details such as the number of employees laid off, the industry, location, and the stage of the company. Key columns in the dataset include:

- **company**: Name of the company where layoffs occurred.
- **location**: Location of the company.
- **industry**: Industry category of the company.
- **total_laid_off**: Total number of employees laid off.
- **percentage_laid_off**: Percentage of the workforce laid off.
- **date**: Date when the layoffs occurred.
- **stage**: The stage of the company (e.g., startup, growth, mature).
- **country**: The country where the layoffs occurred.
- **funds_raised_millions**: Amount of funds raised by the company (in millions).


## Project Workflow

### Data Cleaning (SQL)
1. Removed duplicates and irrelevant entries.
2. Standardized data across various columns.
3. Ensured consistency in date formats and numeric fields.

### Data Exploration (Tableau)
After cleaning the dataset, the following analyses were conducted using Tableau:

#### Total Layoffs by Industry

- **Objective**: Identify which industries have experienced the highest number of layoffs.
- **Insight**: Helps in understanding the sectors most affected by economic downturns or organizational changes.

#### Layoff Trends Over Time

- **Objective**: Analyze how layoffs have trended over time on a global scale.
- **Insight**: Provides a temporal perspective on how global events, such as economic crises, impact layoffs.

#### Layoff Distribution by Country

- **Objective**: Determine which countries have been most affected by layoffs.
- **Insight**: Offers a geographical view of layoff patterns, highlighting regions with significant job losses.

#### Impact of Company Stage on Layoffs

- **Objective**: Assess whether startups, growth-stage companies, or mature companies are more likely to lay off employees.
- **Insight**: Reveals how the company’s life cycle stage influences its layoff decisions.


#### Average Layoff Percentage by Industry

- **Objective**: Calculate the average percentage of employees laid off across different industries.
- **Insight**: Provides a relative measure of the impact on employees within each industry, offering a deeper understanding of the severity of layoffs in different sectors.

## Tools Used
- **MYSQL**: For data cleaning and preparation.
- **Tableau**: For data exploration, analysis, and visualization.

## Conclusion
This project offers insights into global layoff trends, highlighting key factors such as industry, geography, and company stage. The analysis serves as a valuable resource for understanding the dynamics of layoffs across different contexts and can be used to inform decision-making in HR, business strategy, and policy formulation.

