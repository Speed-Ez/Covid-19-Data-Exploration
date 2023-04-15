-- Create a new database for the data
-- Import the data into the database

-- view and order data
select * from ['Covid deaths']
order by location,date;
select * from ['Covid vaccination']
order by location,date;

-- Changed column data type to enable calculation. From nvarchar to float
alter table ['Covid deaths']
alter column total_deaths float;

alter table ['Covid deaths']
alter column total_cases float;

alter table ['Covid deaths']
alter column population float;


-- From the Record, as of 10th April 2023

-- Total covid-19 confirmed cases 
select  sum(new_cases) as Total_Cases
from ['Covid deaths']
where continent is not null

-- Total deaths recorded 
select  sum(new_deaths) as Total_deaths
from ['Covid deaths']
where continent is not null

-- Global percentage death 
select  sum(new_cases) as Total_Cases, sum(new_deaths) as Total_deaths, (sum(new_deaths)/sum(new_cases)*100) as Death_percentage 
from ['Covid deaths']
where continent is not null

-- Confirmed cases by Continent
select continent, sum(new_cases) as Total_Cases
from ['Covid deaths']
where continent is not null
group by continent
order by Total_Cases desc;

-- Countries percentage population with covid (%)
Select location,date, Population,total_cases, ((total_cases/population)*100) as Infection_percentage
from ['Covid deaths']
order by 1,2;

-- Countries cases vs deaths (% of death of infected people)
Select location,date, total_cases,total_deaths, ((total_deaths/total_cases)*100) as Deathpercentage
from ['Covid deaths']
order by 1,2;


-- What percentage of the population in Nigeria has covid (%)
Select location,date, Population,total_cases, (total_cases/population)*100 as Infection_percentage
from ['Covid deaths']
where location like '%Nigeria'
order by 2 desc;



-- What percentage of infected people have died in Nigeria
Select location,date, Population,total_cases, (total_cases/population)*100 as Infection_percentage,(total_deaths/total_cases)*100 as death_percentage
from ['Covid deaths']
where location like '%Nigeria'
order by death_percentage desc;


--Countries and their Max percentage of infections
Select location, Population,max(total_cases) as Highest_infection_count, max((total_cases/population)*100) as Percentage_of_Population_infected
from ['Covid deaths']
group by continent,location, population
order by Percentage_of_Population_infected desc;
--Cyprus is worst infected by the number of infections to the ratio of population
-- I am addiding the #Continent column to the Group by line to enable a drill-down effect when visualizing


--Countries and their Max percentage deaths
select location,population, max(total_deaths) as max_death,max((total_deaths/population)*100) as max_death_percentage
from ['Covid deaths']
group by continent,location,population
order by max_death_percentage desc
--Peru is worst hit by the number of deaths in ratio to the number of the population


--Total cases by Countries
select location,max(population) as population, max(total_cases) as Total_cases,max(total_deaths) as Total_deaths
from ['Covid deaths']
where continent is not null
group by location
order by Total_cases desc;
--The USA has the highest record of covid cases. The USA is by followed by China, India, France, Germany etc


-- Total Deaths by Countries
select location,max(population) as population, max(total_cases) as Total_cases,max(total_deaths) as Total_deaths
from ['Covid deaths']
where continent is not null
group by location
order by Total_deaths desc;
--The USA is also worst hit by covid deaths. They are followed by Brazil, India, Russia, Mexico etc

-- When did vaccinations start (Date)?
select date, new_vaccinations
from ['Covid vaccination']
where new_vaccinations >0
order by date;

-- Adding locations to it
select location,date, new_vaccinations
from ['Covid vaccination']
where new_vaccinations >0
order by date



-- Joining Table

Select *
from ['Covid deaths'] as cd
join ['Covid vaccination'] as cv
on cd.location=cv.location

-- Comparing the Population, infections, Deaths, and Vaccination

Select cd.location, cd.date,cd.population,cd.new_cases,cd.total_cases,cd.new_deaths,cd.total_deaths,cv.new_vaccinations,cv.total_vaccinations, (cv.total_vaccinations/cd.population)*100 as Percentage_vaccinated
from ['Covid deaths'] as cd
join ['Covid vaccination'] as cv
on cd.location=cv.location
order by 1


