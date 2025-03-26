--Create a join table
SELECT *
FROM Absenteeism_at_work as a
LEFT JOIN compensation as c ON a.ID = c.ID
LEFT JOIN Reasons as r ON a.Reason_for_absence = r.Number;

--- Find the healthiest employees for the bonus
SELECT * 
FROM Absenteeism_at_work
WHERE Social_drinker = 0 AND Social_smoker = 0 AND Body_mass_index < 25
AND Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work);
	
--- Compensation rate increase for non-smokers/ budget = 983,221. So a 0.68 increase per hour, which equates to $1,414.4 per year
SELECT COUNT(*) as non_smokers
FROM Absenteeism_at_work
WHERE Social_smoker = 0;


--Optimize the query
SELECT a.ID,
r.Reason,  
a.Body_mass_index,
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
	 WHEN Body_mass_index between 18.5 AND 24.9 THEN 'Healthy weight'
	 WHEN Body_mass_index between 25 AND 30 THEN 'Overweight'
	 WHEN Body_mass_index > 18.5 THEN 'Obese'
	 ELSE 'Unknown' END AS BMI_Category,
CASE WHEN Month_of_absence IN (12,1,2) THEN 'Winter' 
	WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
	WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
	WHEN Month_of_absence IN (9,10,11) THEN 'Fall'
	ELSE 'Unknown' END AS Season_names,
Month_of_absence, Day_of_the_week, Transportation_expense, Education,
Son, Social_drinker, Social_smoker, Pet, Disciplinary_failure,Age, Work_load_Average_day, Absenteeism_time_in_hours
FROM Absenteeism_at_work as a
LEFT JOIN compensation as c ON a.ID = c.ID
LEFT JOIN Reasons as r ON a.Reason_for_absence = r.Number;