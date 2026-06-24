SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is not NULL
order by 3,4

-------------------------------------------------------------------------------------------

--SELECT *
--FROM PortfolioProject..CovidVaccination
--order by 3,4

--Select the Data that we are going to Use...--------------------------------------------------

SELECT location,date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent is not NULL
order by 1,2


-- Total Cases vs Total Deaths -----------------------------------------------------------------------
SELECT location,date, total_cases, total_deaths, 
(CONVERT(DECIMAL(18,2), total_deaths) / CONVERT(DECIMAL(18,2), total_cases))* 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'India'
and continent is not NULL
order by 1,2


-- Total Cases vs Population ---------------------------------------------------------------------------
-- what percent of people got Covid...
SELECT location, date, total_cases, population, 
(CONVERT(DECIMAL(18,2), total_cases) / CONVERT(DECIMAL(18,2), population))* 100 AS CovidPercentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'India'
order by 1,2


-- Countries with Highest Infection rate compared to Population -------------------------------------------------
SELECT location,  population, MAX(CONVERT(DECIMAL(18,2), total_cases)) AS HighestInfectionCount, 
MAX(CONVERT(DECIMAL(18,2), total_cases) / CONVERT(DECIMAL(18,2), population))* 100 AS InfectionPercent 
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
order by InfectionPercent DESC


-- Countries with Highest Death Count --------------------------------------------------------
SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount, 
MAX(CONVERT(DECIMAL(18,2), total_deaths) / CONVERT(DECIMAL(18,2), population))* 100 AS DeathsPercent 
FROM PortfolioProject..CovidDeaths
WHERE continent is not NULL
GROUP BY location
order by TotalDeathCount DESC

-- can add 'WHERE continent is not NULL' , for better result ONLY...

-- Now Based on Continent ..------------------------------------------------------.
-- continents with Highest death count per populations 
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not NULL
GROUP BY continent
order by TotalDeathCount DESC


-- Global data ----------------------------------------------------------------
SELECT date, SUM(new_cases) AS CaseTotal, SUM(new_deaths) AS DeathTotal, 
(SUM(new_deaths)/NULLIF(SUM(new_cases), 0))*100 as DeathPercent
FROM PortfolioProject..CovidDeaths
WHERE continent is not NULL
and new_cases is not NULL 
Group By date
order by 1,2

-- can comment the - group by , to get total answer in 1 row



-- Joining both tables : ------------------------------------------------------
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations as int)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) AS TotalVaccinated
, (TotalVaccinated / dea.population) as PercentVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not NULL
order by 2,3





-- CTE : ----------------------------------------------------------------------------
with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, TotalVaccinated)
AS
( 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations as int)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) AS TotalVaccinated
--, (TotalVaccinated / dea.population) as PercentVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not NULL
--order by 2,3
)
SELECT *, (TotalVaccinated / Population)*100 as PercentVaccinated
FROM PopvsVac
order by 2,3



-- CREATE Temp Table :---------------------------------------------
DROP TABLE if exists #PercentVaccinated
Create Table #PercentVaccinated
( 
Continent nvarchar(255)
, Location nvarchar(255)
, Date datetime
, Population numeric
, New_Vaccinations numeric
, TotalVaccinated numeric
)

INSERT Into #PercentVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations as int)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) AS TotalVaccinated
--, (TotalVaccinated / dea.population) as PercentVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not NULL
order by 2,3

SELECT *, (TotalVaccinated / Population)*100 as PercentVaccinated
FROM #PercentVaccinated
order by 2,3



-- Creating View to store Data for later Visualizations ------------------------------------------------
Create View PercentVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations as int)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) AS TotalVaccinated
--, (TotalVaccinated / dea.population) as PercentVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not NULL
--order by 2,3


SELECT *
FROM PercentVaccinated
