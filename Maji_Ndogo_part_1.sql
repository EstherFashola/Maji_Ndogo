-- Selecting/Retrirving from database
USE md_water_services;

-- Retrieving all columns but limitimg the data to location table
SELECT *
FROM location;


-- Retrieve data from visits table
SELECT *
FROM visits;

-- Retrieve data from water_source table
SELECT *
FROM water_source;


-- Retrieve unique type_of_water_source from water_source table
SELECT DISTINCT type_of_water_source
FROM water_source;

-- Retrieve all records from visits table where time_in_queue is more than 500 minutes
SELECT *
FROM visits
WHERE time_in_queue > 500;


-- Retrieve source_id column from water_source table
SELECT source_id
FROM water_source;
-- OR I can select all records from water_source
SELECT *
FROM water_source;


-- Retrieve records from water_quality table, where the subject_quality_score is 10, and where the source was visited a second time.
SELECT *
FROM water_quality
WHERE subjective_quality_score = 10
AND visit_count =2;

-- Retrieve all records from well_pollution
SELECT *
FROM well_pollution;

-- Retrieve all records from well_pollution table, where  results column is Clean but the biological column is > 0.01.
SELECT *
FROM well_pollution
WHERE results="clean"
AND biological > 0.01;

-- Identifying the errors in the result column of the well_pollution table
SELECT *
FROM well_pollution
WHERE description LIKE "clean %";

-- Updating  the results column from Clean to Contaminated:Biological where the biological column has a value greater than 0.01.
-- However, before I can update the data , I need to turn off safe updates in my querey
SET SQL_SAFE_UPDATES =0;

UPDATE 
	well_pollution 
SET 
	description = "Bacteria: E. coli"
 WHERE 
	description = "Clean Bacteria: E. coli";


UPDATE 
	 well_pollution 
SET
	description = "Bacteria: Giardia Lamblia"
 WHERE 
	  description = "Clean Bacteria: Giardia Lamblia";


-- I  need to create a new_table so that I can confirm if there is not error in the new update data, and if there and I will need to run it again
CREATE TABLE 
		md_water_services.well_pollution_copy
 AS (
	SELECT
		*
		FROM 
 md_water_services.well_pollution
 );
 
 -- Insert the update in the Well_pollution_copy
 UPDATE 
	well_pollution_copy
SET 
	description = "Bacteria: E. coli"
 WHERE 
	description = "Clean Bacteria: E. coli";


UPDATE 
	 well_pollution_copy
SET
	description = "Bacteria: Giardia Lamblia"
 WHERE 
	  description = " Clean Bacteria: Giardia Lamblia";
      
UPDATE 
	 well_pollution_copy
SET
	results = "Contaminated Biological"
 WHERE 
      biological >0.01 AND results = "clean";
      
-- Cross  checking that there are no  errors in  the well_pollution_copy table
SELECT *
FROM Well_pollution_copy
WHERE description LIKE "CLEAN_%"
OR (Results = "clean" AND biological > 0.01);


-- Once you can identify and correct the errors, then you can delete well_pollution_copy
UPDATE 
	well_pollution_copy
SET 
	description = "Bacteria: E. coli"
 WHERE 
	description = "Clean Bacteria: E. coli";

UPDATE 
	 well_pollution_copy
SET
	description = "Bacteria: Giardia Lamblia"
 WHERE 
	  description = " Clean Bacteria: Giardia Lamblia";
      
UPDATE 
	 well_pollution_copy
SET
	results = "Contaminated Biological"
 WHERE 
      biological >0.01 AND results = "clean";

DROP TABLE 
md_water_services_well_pollution_copy;


 







 