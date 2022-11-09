--SELECT location,date, new_cases, total_cases, new_deaths, total_deaths
--FROM [Portfolio Project]..CovidDeaths
--WHERE continent is not null
--ORDER BY 1

--Looking at Mortality Rate in a particular Country

--SELECT location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_percent
--FROM [Portfolio Project]..CovidDeaths 
--WHERE location='India'
--ORDER BY 1,2

--Looking at Total Cases vs Population

--SELECT location,date, total_cases, population, (total_cases/population)*100 as Infection_rate
--FROM [Portfolio Project]..CovidDeaths 
--WHERE location='India'
--ORDER BY 1,2

--Looking at the country with the highest Infection rate

--SELECT location, population, MAX(total_cases) as total_infections, (MAX(total_cases)/population)*100 as Infection_rate
--FROM [Portfolio Project]..CovidDeaths 
--WHERE continent is not null
--GROUP BY Location, Population
--ORDER BY Infection_rate DESC

--Looking at the country with the highest Infection rate

--SELECT location, population, MAX(CAST(total_deaths as INT)) as deaths, (MAX(CAST(total_deaths as INT))/population)*100 as Death_rate
--FROM [Portfolio Project]..CovidDeaths 
--WHERE continent is not null
--GROUP BY Location, Population
--ORDER BY death_rate DESC

--Looking at Data by Continent

--SELECT location, population, MAX(CAST(total_cases as INT)) as Total_Cases, MAX(CAST(total_deaths as INT)) as Total_deaths
--FROM [Portfolio Project]..CovidDeaths 
--WHERE continent is null and iso_code not like '%C' 
--GROUP BY Location, Population, iso_Code
--ORDER BY population DESC

--Looking at World Data

--SELECT date,location,sum(new_cases) as Infections,sum(cast(new_deaths as int)) as Deaths
--FROM [Portfolio Project]..CovidDeaths 
--WHERE location='World'
--GROUP BY date,location
--ORDER BY date 

--Total Population vs Vaccination

--SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations
--FROM [Portfolio Project]..CovidDeaths as D
--JOIN [Portfolio Project]..CovidVaccinations as V
--	ON d.location=v.location
--	AND d.date=v.date
--WHERE d.continent is not null
--order by location,date

--Rolling Count of Vaccination

--SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,
--	SUM(CAST(v.new_vaccinations as BIGINT)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) as Rolling_Count_Vaccination
--FROM [Portfolio Project]..CovidDeaths as D
--JOIN [Portfolio Project]..CovidVaccinations as V
--	ON d.location=v.location
--	AND d.date=v.date
--WHERE d.continent is not null
--order by location,date

--Create a CTE

--WITH popvsvac (continent, location, date,population, new_vaccination, Rolling_count_vaccination)
--as
--(
--SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,
--	SUM(CONVERT(bigint, v.new_vaccinations)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) as Rolling_Count_Vaccination
--FROM [Portfolio Project]..CovidDeaths as D
--JOIN [Portfolio Project]..CovidVaccinations as V
--	ON D.location=V.location
--	AND D.date=V.date
--WHERE d.continent is not null
--)
--Select *, (Rolling_count_vaccination/population)*100 as Percent_Vaccinated 
--FROM popvsvac

--CREATE VIEW PerPopVac as
--SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,
--	SUM(CONVERT(bigint, v.new_vaccinations)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) as Rolling_Count_Vaccination
--FROM [Portfolio Project]..CovidDeaths as D
--JOIN [Portfolio Project]..CovidVaccinations as V
--	ON D.location=V.location
--	AND D.date=V.date
--WHERE d.continent is not null

SELECT * from [Portfolio Project]..perpopvac

