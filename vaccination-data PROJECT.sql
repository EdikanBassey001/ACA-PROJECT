Use PROJECT;

--The table was already cleaned using Excel.

--Check all data from [vaccination-data - cleaned] table
SELECT * 
FROM [vaccination-data - cleaned];

				--QUESTIONS
-- 1. What is the distribution of Total Vaccinations by Region?
SELECT WHO_REGION, 
       sum(TOTAL_VACCINATIONS) AS REGIONAL_DISTRIBUTION
FROM [vaccination-data - cleaned]
GROUP BY WHO_REGION;


-- 2. Which Country had the most vaccinations by head count?
SELECT Top 1 COUNTRY, 
       TOTAL_VACCINATIONS
FROM [vaccination-data - cleaned]
ORDER BY TOTAL_VACCINATIONS DESC;

-- 3. What is the percentage distribution of fully vaccinated persons by Country?
SELECT COUNTRY,
       round(CAST(PERSONS_FULLY_VACCINATED AS FLOAT) / TOTAL_VACCINATIONS * 100, 0) AS PERCENTAGE_OF_FULLY_VACCINATED_PERSONS
FROM [vaccination-data - cleaned]
WHERE PERSONS_FULLY_VACCINATED IS NOT NULL 
      AND TOTAL_VACCINATIONS IS NOT NULL
ORDER BY PERCENTAGE_OF_FULLY_VACCINATED_PERSONS DESC;

-- 4. Which Region had the most fully vaccinated persons?
SELECT Top 1 WHO_REGION, 
       sum(PERSONS_FULLY_VACCINATED) AS FULL_VACCINATIONS
FROM [vaccination-data - cleaned]
GROUP BY WHO_REGION
ORDER BY FULL_VACCINATIONS DESC;

-- 5. How many Total Vaccinations were recorded in EURO?
SELECT WHO_REGION, 
       sum(TOTAL_VACCINATIONS) AS TOTAL_VACCINATIONS_IN_EURO
FROM [vaccination-data - cleaned]
WHERE WHO_REGION = 'EURO'
GROUP BY WHO_REGION;

-- 6. Which Country was the first to start vaccination?
SELECT Top 1 COUNTRY, 
       FIRST_VACCINE_DATE AS VACCINATION_COMMENCEMENT_DATE
FROM [vaccination-data - cleaned]
WHERE FIRST_VACCINE_DATE IS NOT NULL
ORDER BY FIRST_VACCINE_DATE ASC;

-- 7. How many persons were not fully vaccinated in Nigeria?
SELECT COUNTRY, 
       TOTAL_VACCINATIONS, 
	   PERSONS_FULLY_VACCINATED, 
	   (TOTAL_VACCINATIONS - PERSONS_FULLY_VACCINATED) AS PERSONS_NOT_FULLY_VACCINATED
FROM [vaccination-data - cleaned]
WHERE COUNTRY = 'Nigeria';

-- 8. Which countries used AstraZeneca - Vaxzevria?
SELECT COUNTRY, 
       WHO_REGION, 
	   VACCINES_USED
FROM [vaccination-data - cleaned]
WHERE VACCINES_USED LIKE '%AstraZeneca - Vaxzevria%';

-- 9. Which Country received the most booster dose?
SELECT Top 1 COUNTRY, 
       PERSONS_BOOSTER_ADD_DOSE
FROM [vaccination-data - cleaned]
WHERE PERSONS_BOOSTER_ADD_DOSE IS NOT NULL
ORDER BY PERSONS_BOOSTER_ADD_DOSE DESC;

-- 10. Countries with the least supply of vaccines
SELECT COUNTRY, 
       sum(NUMBER_VACCINES_TYPES_USED) AS NUMBER_OF_VACCINES_TYPES_USED
FROM [vaccination-data - cleaned]
WHERE NUMBER_VACCINES_TYPES_USED = 1 
      AND NUMBER_VACCINES_TYPES_USED IS NOT NULL
GROUP BY COUNTRY;