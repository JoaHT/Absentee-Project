# PROJECT - EMPLOYEE HEALTH

![](images/AbsenteeProject.jpg)

In this project we are aiming to use analytics and the data on employers to reward a healthy employee lifestyle. We are going to create a SQL Database, Query it and do Exploratory Data Analysis, before we connect the Database to Power BI and create an informative Dashboard on the topic. The problems we are going to solve are; Provide a list of Healthy Individuals and employees with low absent for a healthy bonus program with a total budget of $1000, and calculate a wage increase or annual compensation for Non-Smokers with a budget of $983,221. And finally create a Dashboard explaining Absenteeism at work.

STEP 1 = Create our database in SSMS called EmployeeHealth, then we import our three CSV files.

STEP 2 = We join the tables together using a simple left join.

	SELECT *
	FROM Absenteeism_at_work as a
	LEFT JOIN compensation as c ON a.ID = c.ID
	LEFT JOIN Reasons as r ON a.Reason_for_absence = r.Number

STEP 3 = We query the healthies employees to find out how many people are going to be sharing the $1000 bonus. And we find out its 111 people.

	SELECT * 
	FROM Absenteeism_at_work
	WHERE Social_drinker = 0 AND Social_smoker = 0 AND Body_mass_index < 25
	AND Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work)

STEP 4 = We count how many people are non-smokers, to find out how much money each person will be earning as a compensation rate. Which we do by finding out how many hours of work they do per year = 5*8*52 = 2080 * 686 (amount of non-smokers) = 1,426,880. Then we divide our budget by total hours = 983,221/1,426,880 = ~0.68 cents increase per hour. Or $1,414.4 per year for each employee.

	SELECT COUNT(*) as non_smokers
	FROM Absenteeism_at_work
	WHERE Social_smoker = 0;
	
STEP 5 = We then take our join statement from before, and we optimize our Query to only have columns we need, to not inflate the data we are pulling into Power BI. As well as create CASE statements to get a BMI_category and a Season_names.

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
	LEFT JOIN Reasons as r ON a.Reason_for_absence = r.Number

STEP 6 = Connect Power BI to the SQL Server and add the Query into the SQL statement, to make sure we are getting the optimized data.

STEP 7 = Start by inserting shapes to make the background of the dashboard nice and clean. 

STEP 8 = Create multiple KPI's in "Average of Absenteeism in hours", "Employees" and "Absentee hours" to give us quick insights into our data.

STEP 9 = Create multiple Pie visuals that show a distribution of BMI, Social Drinker, Social Smoker, and the amount of Children.

STEP 10 = Create 2 Line visuals portraying the average Absenteeism time in hours by both the Month of absence and the Day of the week. 

STEP 11 = Create a table of the reasons for absence and the count of reason, to see why the employees are most often absent.

STEP 12 = Create a scatter plot showing a comparison between BMI and Absenteeism in hours, and add a Trend line.

STEP 13 = Finally create a Slicer for the Seasons, so you can filter the whole dashboard based on which season you want to examine.


# SUMMARIZE -
In this project we had 3 tasks, two questions to answer and one dashboard creation. The first question asked us to find a list of the healthiest employees in the company for a healthy bonus program where they are splitting $1000. We made a Query that gave us a list of 111 people to split the bonus for; 

	SELECT * 
	FROM Absenteeism_at_work
	WHERE Social_drinker = 0 AND Social_smoker = 0 AND Body_mass_index < 25
	AND Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work)

The second question asked us to calculate a wage increase or annual compensation for Non-Smokers with a budget of $983,221. We made a Query to get an answer to how many non-smokers there was in the company;

	SELECT COUNT(*) as non_smokers
	FROM Absenteeism_at_work
	WHERE Social_smoker = 0;
	
Which turned out to be 686, and then we did some simple calculations as shown above, that gave us the answer that non-smokers will be earning ~$0.68 more per hour, which totals out to $1,414.4 per year for each employee. 

And finally we created an interactive dashboard that features key insights such as showing us that the month of the most average absent hours is July, and that the reason for the most absences is a medical consultation. There are many more insights to take from the dashboard and I suggest taking a peak and playing around with the slicers. 


