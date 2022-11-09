SELECT location, MAX(total_cases) as total_infections, MAX(CAST(total_deaths as INT)) as Deaths, (MAX(CAST(total_deaths as INT))/MAX(total_cases)*100) as Death_rate
FROM [Portfolio Project]..CovidDeaths
WHERE location='World'
GROUP BY location

SELECT location,  MAX(total_cases) as total_infections, MAX(CAST(total_deaths as INT)) as Deaths
FROM [Portfolio Project]..CovidDeaths
WHERE continent is null and iso_code NOT LIKE '%C'
GROUP BY location

SELECT location,  MAX(total_cases) as total_infections, population, MAX(CAST(total_deaths as INT)) as Deaths, (MAX(total_cases)/population*100) as infection_rate,(MAX(CAST(total_deaths as INT))/MAX(total_cases)*100) as Mortality_Rate
FROM [Portfolio Project]..CovidDeaths
WHERE continent is not null 
GROUP BY location, population
order by 1

SELECT location, date, (MAX(total_cases)/population*100) as infection_rate
FROM [Portfolio Project]..CovidDeaths
WHERE continent is not null 
GROUP BY location, date, population
order by 1

---INTERMEDIATE------

SELECT location,  (MAX(total_cases)/population*100) as total_infections, (MAX(CAST(total_deaths as INT))/MAX(total_cases)*100) as Deaths
FROM [Portfolio Project]..CovidDeaths
WHERE continent is null and iso_code NOT LIKE '%C'
GROUP BY location,population

SELECT  d.continent,AVG(CAST(V.positive_rate as FLOAT))
FROM [Portfolio Project]..CovidDeaths d
JOIN [Portfolio Project]..CovidVaccinations v
ON d.location=v.location AND d.date=v.date
WHERE d.continent is not null --AND d.iso_code NOT LIKE '%C'
GROUP BY d.continent

SELECT d.date, d.location, MAX(d.new_deaths) as new_deaths, MAX(d.new_cases) as new_Cases, (MAX(d.new_cases)/MAX(d.new_cases)*100) as Mortality_Rate
FROM [Portfolio Project]..CovidDeaths d
JOIN [Portfolio Project]..CovidVaccinations v
ON d.location=v.location AND d.date=v.date
WHERE d.continent is null AND d.iso_code NOT LIKE '%C' AND d.location='World' 
GROUP BY d.location,d.date