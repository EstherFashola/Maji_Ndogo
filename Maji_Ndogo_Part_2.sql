-- How to update data by including email addresses in the employee table of md_water_services
-- But the first stage is to replace space between the first and last names with fullstop sign by using replace
SELECT 
	employee_name,
REPLACE(employee_name, ' ','.') AS employee_name
FROM employee;
-- The next stage is change the name employee_name to lowercase
SELECT
	employee_name,
lower(Replace(employee_name, " ", ".")) AS employee_name_in_lowercase
FROM employee;

-- The next stage is to use concat function to add the mail with lower and replace functions
SELECT
	CONCAT( 
    LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov') AS new_email 
    FROM employee;
    
-- The last stage is to update the new mail that is generated with the old mail addresses, 
-- BUT before the update I need to remove my SQL from safe update mode 
SET SQL_safe_updates = 0;

UPDATE employee 
SET email = CONCAT(LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov');

-- Retrieving phone_number column in the employee table
SELECT phone_number
FROM employee;

-- Using length function to check how many characters consist a phone number
SELECT 
	length(phone_number) AS phone_number_length
FROM employee;

-- The results return 13 characters instead of 12 characters, because of the space after the number. TRIM function will be used to remove any space
SELECT
	trim(phone_number) AS Trim_phone_number
FROM employee;
-- Updating the 12 phone_number
UPDATE employee
SET phone_number = trim(phone_number);

-- Checking the length of the phone_number after updating 
SELECT
	length(phone_number) AS phone_number_Length
FROM employee;


-- Using COUNT function to known the total numbers of employees
SELECT
	count(assigned_employee_id) AS Total_numbers_of_employees
FROM employee;

-- Also use employee table to count how many employees that live in each town
SELECT  town_name,
	COUNT(assigned_employee_id) AS num_employees
FROM employee
GROUP BY town_name;


-- Find the first three field surveyors, but the best way to get the information is to find the first assigned_employee_id and highest number of the location visited
SELECT  
	assigned_employee_id,
	COUNT(*) AS number_of_visits
FROM visits
GROUP BY assigned_employee_id
ORDER BY assigned_employee_id ASC
LIMIT 3;

--  Counts the number of records per town in location table
SELECT  town_name ,
	count(*) AS records_per_town
FROM location
GROUP BY town_name
ORDER BY records_per_town DESC;

-- Counts the number of records per province in location table
SELECT
	province_name,
	COUNT(*) AS records_per_province
FROM location
GROUP BY province_name
ORDER BY province_name ASC;

-- Retrieve province_name and town_name ,then counts the number of records per town in location table
SELECT 
		town_name ,
		province_name,
	count(*) AS records_per_town
FROM location
GROUP BY province_name,town_name
ORDER BY records_per_town DESC;

--  Retrieve province_name, town_name , then counts the number of records per province from location table
SELECT province_name,town_name,
	count(*) AS records_per_province
FROM location
GROUP BY province_name,town_name
ORDER BY province_name,
		records_per_province DESC;

-- Finding numbers of records for each location types 
SELECT location_type,
		count(*) AS Number_of_sources
FROM location 
GROUP BY location_type
ORDER BY Number_of_sources ASC;

-- Writing our results in percentage for the records of location_type and use round function 
SELECT 23740 / (15910 + 23740) * 100;
SELECT round(59.8739);

-- Checking and familiarizing myself with water_source table
SELECT *
FROM water_source;

-- Sum the total number of people served
SELECT 
	sum(number_of_people_served) AS People_surved_in_total
FROM water_source;

-- How many different type_of_water_source
SELECT
	 type_of_water_source,
    count(*) AS Number_of_source_of_water
FROM water_source
GROUP BY type_of_water_source
ORDER BY type_of_water_source;

-- How many people share a particular source of water on average
SELECT 
		type_of_water_source, 
	round(AVG(number_of_people_served)) AS Avg_water_source
FROM water_source
GROUP BY type_of_water_source
ORDER BY type_of_water_source;

-- How many people are getting water from each source
SELECT 
	type_of_water_source,
	sum(number_of_people_served) AS Population_served
FROM water_source
GROUP BY type_of_water_source
ORDER BY type_of_water_source;

-- The total sum of the people served 
SELECT
SUM(number_of_people_served) AS total_num_of_people_served
FROM water_source;


--   TO get percentage of the TOTAL people servved
SELECT 27628140/27628140*100;

-- Getting percentage of the people served per type_of_water_source
SELECT 
		type_of_water_source,
	ROUND((sum(number_of_people_served)/ 27628140)*100)AS Population_served 
FROM water_source
GROUP BY type_of_water_source
ORDER BY Population_served  DESC;


-- Use a window function on the total people served column, converting it into a rank. 
SELECT 
	type_of_water_source,
	sum(number_of_people_served) AS Population_served,
     RANK() OVER (ORDER BY sum(number_of_people_served) DESC) AS rank_by_population   
FROM water_source
GROUP BY type_of_water_source;

-- Write a querry to retrieve  source_id,type_of_water_source,number_of_people_served from water_source table , use window function and partion
SELECT
	source_id,
    type_of_water_source,
    number_of_people_served,
    RANK() OVER (partition by type_of_water_source
    ORDER BY (number_of_people_served ) DESC) AS Priority_rank 
FROM water_source
WHERE type_of_water_source <>' tap_in_home'
ORDER BY
	type_of_water_source,
    Priority_rank ;
    
    SELECT
	sum(number_of_people_served),
    type_of_water_source,
    number_of_people_served,
    dense_rank() OVER (partition by type_of_water_source
    ORDER BY (number_of_people_served) DESC) AS Priority_rank 
FROM water_source
ORDER BY
	type_of_water_source,
    Priority_rank ;
    select *
    from water_source;

-- Look at visits table, especially the time_of_record column,get the first and the last dates and subtract them
SELECT 
	min(time_of_record) AS First_date,
    max(time_of_record) AS Last_date,
datediff(max(time_of_record),  min(time_of_record))
 FROM visits;
 
 
 -- See how long people have to queue on average in Maji Ndogo, use nullif funtion to exclude people that got their water from tap in home, because there is no queue 
	SELECT 
		Round(AVG(nullif(time_in_queue, 0))) AS Avg_queue
        FROM visits;
        
--  Look for queue times aggregated across the different days of the week.
SELECT
	 DAYNAME(time_of_record) AS Days_of_the_week,
    ROUND(AVG(NULLIF(time_in_queue, 0))) AS Avg_times_in_queue
    FROM visits
    GROUP BY  DAYNAME(time_of_record);
    
    
-- We can also look at what time during the day people collect water
SELECT
	hour(time_of_record) AS hours_of_the_day,
    ROUND(AVG(NULLIF(time_in_queue, 0))) AS Avg_times_in_queue
    FROM visits
    GROUP BY  hour(time_of_record)
    ORDER BY hour(time_of_record);
    
    
    -- Try another time format by using time format 
    SELECT
	TIME_FORMAT(TIME(time_of_record), '%H:00' ) AS hours_of_the_day,
    ROUND(AVG(NULLIF(time_in_queue, 0))) AS Avg_times_in_queue
    FROM visits
    GROUP BY  TIME_FORMAT(TIME(time_of_record), '%H:00' )
    ORDER BY TIME_FORMAT(TIME(time_of_record), '%H:00' );
    
    -- Use a CASE() function for each day to separate the queue time column into a column for each day. Let’s begin by only focusing on Sunday.This is simple case
    SELECT
    TIME_FORMAT(TIME(time_of_record), '%H:00' ) AS hours_of_the_day,
	DAYNAME(time_of_record) AS Days_of_the_week,
    CASE 
    WHEN DAYNAME(time_of_record) = 'Sunday' THEN 'time_in_queue'
    ELSE NULL
    END AS SUNDAY
    FROM visits
WHERE time_in_queue != 0;


-- Add aggregate function around the case function, and do it for each day in the week . This is searched case 
SELECT
    TIME_FORMAT(TIME(time_of_record), '%H:00' ) AS hours_of_the_day,
	-- Sunday
    ROUND(AVG(
    CASE 
    WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
    ELSE NULL
    END ),0) AS Sunday,
    
    -- Monday
    ROUND(AVG(
    CASE 
    WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue
    ELSE NULL
    END ),0) AS Monday,
    
    -- Tuesday
    ROUND(AVG(
    CASE 
    WHEN DAYNAME(time_of_record) = 'Tuesday' THEN time_in_queue
    ELSE NULL
    END ),0) AS Tuesday,
   
   -- Wednesday
    ROUND(AVG(
    CASE 
    WHEN DAYNAME(time_of_record) = 'Wednesday' THEN time_in_queue
    ELSE NULL
    END ),0) AS Wednesday,
    
    -- Thursday
    ROUND(AVG(
    CASE 
    WHEN DAYNAME(time_of_record) = 'Thursday' THEN time_in_queue
    ELSE NULL
    END ),0) AS Thursday,
    
    -- Friday
    ROUND(AVG(
    CASE 
    WHEN DAYNAME(time_of_record) = 'Friday' THEN time_in_queue
    ELSE NULL
    END ),0) AS Friday,
    
    -- Saturday
    ROUND(AVG(
    CASE 
    WHEN DAYNAME(time_of_record) = 'Saturday' THEN time_in_queue
    ELSE NULL
    END ),0) AS Saturday
    
    FROM visits
    WHERE time_in_queue != 0
    GROUP BY  hours_of_the_day
    ORDER BY  hours_of_the_day;


    
		
    
    
    
    
        
