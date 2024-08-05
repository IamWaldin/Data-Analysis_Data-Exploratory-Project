-- EXPLORATORY DATA ANALYSIS
-- IN THIS PROJECT WE WILL BE RUNNING DIFFERENT QUERIES EXPLORING OUR DATA THAT WE HAVE CLEANED IN OUR PREVIOUS DATA CLEANING PROJECT

select *
FROM layoffs_staging2

select MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off = 1;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off DESC;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions DESC;


SELECT company, country, sum(total_laid_off)
from layoffs_staging2
group by company, country
order by 3 desc;

select min(`date`), max(`date`)
from layoffs_staging2


SELECT industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select `date`, sum(total_laid_off)
from layoffs_staging2
group by `date`
order by 1 desc;


select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 1 desc;


SELECT company, sum(percentage_laid_off)
from layoffs_staging2
group by company, country
order by 2 desc;


select substring(`date`,1,7) as `MONTH`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
group by `MONTH`
order by 1 asc;


WITH ROLLING_TOTAL AS
(
select substring(`date`,1,7) as `MONTH`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
group by `MONTH`
order by 1 asc;
)
SELECT `MONTH`, total_off
,sum(total_off) over(order by `MONTH`) as rolling_total 
FROM Rolling_Total;

SELECT company, sum(total_laid_off)
from layoffs_staging2
group by company, country
order by 2 desc;


SELECT company, YEAR(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, YEAR(`date`);
ORDER BY 3 desc;

-- CREATING A CTE

with Company_YEAR (company, years, total_laid_off) AS
(
select company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
group by company, YEAR(`date`)
)
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off desc) as Ranking
from Company_Year
where years is not null
order by Ranking ASC;


