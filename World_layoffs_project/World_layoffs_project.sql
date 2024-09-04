USE world_layoffs;

SELECT * 
FROM layoffs;
 
--  Data cleaing 

CREATE TABLE layoffs_Staging 
LIKE layoffs;

SELECT * 
FROM layoffs_Staging ;

INSERT layoffs_Staging
SELECT * 
FROM layoffs;


-- 1 -Remove duplicate

WITH duplicate_CTE as 
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`,
 stage, country, funds_raised_millions ) AS new_row
FROM layoffs_Staging 
)
SELECT * 
FROM duplicate_CTE
WHERE  new_row > 1 ;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `new_row` INT 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`,
 stage, country, funds_raised_millions ) AS new_row
FROM layoffs_Staging ;


SELECT * 
FROM layoffs_staging2
WHERE  new_row > 1 ;


DELETE
FROM layoffs_staging2
WHERE new_row > 1 ;


SELECT * 
FROM layoffs_staging2
WHERE  new_row > 1 ;


-- Standardizing data
SELECT company, TRIM(company) 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company) ;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%' ;


SELECT country, TRIM(country) 
FROM layoffs_staging2
WHERE country LIKE '%.';




SELECT country, TRIM(TRAILING '.' FROM country) 
FROM layoffs_staging2
WHERE country LIKE 'United States';


UPDATE layoffs_staging2
SET  country = TRIM(TRAILING '.' FROM country) 
WHERE country LIKE 'United States' ;


SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');


UPDATE layoffs_staging2
SET industry = NULL
WHERE industry IS NULL OR industry = '';


SELECT  * 
FROM layoffs_staging2
WHERE industry IS NULL ;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN  layoffs_staging2 t2
      ON  t1.company = t2.company 
      AND t1.location = t2.location
WHERE t1.industry IS NULL AND t1.industry IS NOT NULL ;



UPDATE layoffs_staging2 t1
JOIN  layoffs_staging2 t2
      ON  t1.company = t2.company 
      AND t1.location = t2.location
SET t1.industry= t2.industry
WHERE industry IS NULL OR industry = '';     

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL;

DELETE 
FROM layoffs_staging2
WHERE percentage_laid_off IS NULL;
 
ALTER TABLE layoffs_staging2
DROP COLUMN new_row;

SELECT *
FROM layoffs_staging2;

-- -------------------------------
-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

SELECT company, MAX(total_laid_off)
FROM layoffs_staging2
GROUP BY 1
ORDER BY 2;

SELECT company, location, MAX(total_laid_off) AS max_laid_off
FROM layoffs_staging2
GROUP BY 1 ,2
ORDER BY 3;


SELECT company, location, SUM(total_laid_off) AS Total_laid_off
FROM layoffs_staging2
GROUP BY 1 ,2
ORDER BY 3;


SELECT company, location, MIN(total_laid_off) AS min_laid_off
FROM layoffs_staging2
GROUP BY 1 ,2
ORDER BY 3;


SELECT industry, MAX(total_laid_off) AS max_laid_off
FROM layoffs_staging2
GROUP BY 1 
ORDER BY 2;


SELECT `date`, total_laid_off
FROM layoffs_staging2 
ORDER BY `date` desc;


SELECT YEAR(`date`), SUM(total_laid_off) AS TOTAL
FROM layoffs_staging2 
WHERE YEAR(`date`) IS NOT NULL
GROUP BY 1
ORDER BY 1 desc ;


SELECT company, location, SUM(percentage_laid_off) AS SUM_percentage_laid_off
FROM layoffs_staging2
GROUP BY 1 ,2
ORDER BY 3 desc;

SELECT company, location, AVG(percentage_laid_off) AS AVG_percentage_laid_off
FROM layoffs_staging2
GROUP BY 1 ,2
ORDER BY 3 ;


SELECT substring(`date`,1,5) AS `MOTH`, SUM(total_laid_off) AS TOTAL
FROM layoffs_staging2 
GROUP BY 1
ORDER BY 1 desc ;


SELECT substring(`date`,1,7) AS `MOTH`, SUM(total_laid_off) AS TOTAL
FROM layoffs_staging2 
WHERE substring(`date`,1,5) IS NOT NULL
GROUP BY 1
ORDER BY 1 ;


WITH Rolling_CTE AS 
(
SELECT substring(`date`,1,7) AS `MOTH`, SUM(total_laid_off) AS TOTAL
FROM layoffs_staging2 
WHERE substring(`date`,1,5) IS NOT NULL
GROUP BY 1
ORDER BY 1 
)
SELECT `MOTH`,TOTAL ,
SUM(TOTAL) OVER(ORDER BY `MOTH`) AS rolling_total
FROM Rolling_CTE ;


SELECT company, SUM(total_laid_off) AS Total
FROM layoffs_staging2 
GROUP BY 1
ORDER BY 2 DESC;



SELECT company, YEAR(`date`) , SUM(total_laid_off) AS Total
FROM layoffs_staging2 
GROUP BY 1,2
ORDER BY 3 DESC;


WITH company_year (compny, years, total_laid_off)  AS 
(
SELECT company, YEAR(`date`) , SUM(total_laid_off) AS Total
FROM layoffs_staging2 
GROUP BY 1,2
)
SELECT * ,
dense_rank() OVER(partition by years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL;



WITH company_year (compny, years, total_laid_off)  AS 
(
SELECT company, YEAR(`date`) , SUM(total_laid_off) AS Total
FROM layoffs_staging2 
GROUP BY 1,2
), company_year_ranking AS 
(

SELECT * ,
dense_rank() OVER(partition by years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL
)

SELECT *
FROM company_year_ranking
WHERE Ranking <=6
ORDER BY Ranking ASC;




