/* NOTE :-  THE DATA IS NOT EXACTLY TRUE, IT IS GENERATED DATA. */

/* Checking data */

SELECT TOP 100 * 
FROM [PortfolioProject ].dbo.GamesData;

-- TOTAL :--------------------------------------------------------

-- Total Games Titles 
SELECT COUNT(DISTINCT(title)) AS total_games
from [PortfolioProject ].dbo.GamesData;


-- Game Titles by YEAR 
SELECT year, COUNT(DISTINCT(title)) as title_count
from [PortfolioProject ].[dbo].[GamesData]
GROUP BY year
ORDER BY year;


-- Title Count by Genre
SELECT genre, COUNT(DISTINCT(title)) as games_count
from [PortfolioProject ].[dbo].[GamesData]
GROUP BY genre
ORDER BY games_count DESC;


-- Total Titles by Publisher
SELECT publisher, COUNT(DISTINCT(title)) as games_count
from [PortfolioProject ].[dbo].[GamesData]
GROUP BY publisher
ORDER BY games_count DESC;


-- Total Platforms
SELECT DISTINCT(platform)
from [PortfolioProject ].[dbo].[GamesData]
ORDER BY platform;





-- SALES :---------------------------------------------------------

-- Total Global Sales By Platform
SELECT platform,
       ROUND(SUM(global_sales_million),2) AS total_global_sales
FROM [PortfolioProject ].[dbo].[GamesData]
GROUP BY platform
ORDER BY total_global_sales DESC;


-- Highest Selling Platform (globaly)
SELECT  platform, MAX(global_sales_million) as highest_sale
from [PortfolioProject ].[dbo].[GamesData]
Group By platform
Order by highest_sale DESC;


-- Highest Selling Platform Company (globaly)
SELECT  platform_maker, MAX(global_sales_million) as highest_sale
from [PortfolioProject ].[dbo].[GamesData]
Group By platform_maker
Order by highest_sale DESC;


-- Global Sales by Genre
SELECT DISTINCT(genre), ROUND(SUM(global_sales_million),2) as total_global_sale
FROM [PortfolioProject ].[dbo].[GamesData]
GROUP BY genre
ORDER BY total_global_sale DESC


-- GLOBAL SALES by Publisher
SELECT publisher, ROUND(SUM(global_sales_million),2) as total_global_sale
FROM [PortfolioProject ].[dbo].[GamesData]
GROUP BY publisher
ORDER BY publisher;


-- Sales by Year
SELECT year, ROUND(SUM(global_sales_million),2) as total_global_sales 
from [PortfolioProject ].[dbo].[GamesData]
GROUP BY year
ORDER BY year DESC;




-- REVENUE :----------------------------------------------------------------


-- Estimated Revenue by titles ( million USD )
SELECT title, ROUND(SUM(estimated_revenue_million_usd), 2) as total_est_revenue_usd
FROM [PortfolioProject ].[dbo].[GamesData]
GROUP BY title
ORDER BY total_est_revenue_usd DESC;


-- Average Revenue by genre
SELECT genre, ROUND(AVG(estimated_revenue_million_usd), 2) as avg_est_revenue_usd
FROM [PortfolioProject ].[dbo].[GamesData]
GROUP BY genre
ORDER BY avg_est_revenue_usd DESC;


-- MAX revenue by publisher
SELECT publisher, MAX(estimated_revenue_million_usd) as max_est_revenue_usd
FROM [PortfolioProject ].[dbo].[GamesData]
GROUP BY publisher
ORDER BY max_est_revenue_usd DESC;


-- Top 10 Avg Revenue by Platform
SELECT TOP 10 platform, ROUND(AVG(estimated_revenue_million_usd),2) as avg_est_revenue_usd
FROM [PortfolioProject ].[dbo].[GamesData]
GROUP BY platform
ORDER BY avg_est_revenue_usd DESC;




-- REGION :------------------------------------------------------------------------


-- Sales of Genre in Different Regions
SELECT genre, ROUND(SUM(na_sales_million),2) as na_sales,
    ROUND(SUM(eu_sales_million),2) as eu_sales,
    ROUND(SUM(jp_sales_million),2) as jp_sales
FROM [PortfolioProject ].[dbo].[GamesData]
GROUP BY genre
ORDER BY genre;


