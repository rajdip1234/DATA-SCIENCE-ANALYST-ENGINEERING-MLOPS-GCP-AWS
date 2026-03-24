/*
Welcome to this Dataquest Guided Project!

For this guided project, you'll take on the role of a data analyst at a startup. The product team is considering 
launching a campaign on Kickstarter to test the viability of some offerings. You've been asked to pull data that 
will help the team understand what might influence the success of a campaign. The data source is a selection of 
fields from Kaggle(https://www.kaggle.com/datasets/kemical/kickstarter-projects).

Specifically, we'll answer the following questions:

What types of projects are most likely to be successful?
Which projects fail?
To get you started, here are the definitions of the columns in this data:

ID: Kickstarter project ID
name: Name of project
category: Category of project
main_category: Main category of project
goal: Fundraising goal
pledged: Amount pledged
state: State of project (successful, canceled, etc.)
backers: Number of project backers
The first step to working with a database is to know what data is actually in it.

Instructions
This database consists of one table, ksprojects.

List the column names and data types for the ksprojects table in the database using PRAGMA table_info
*/
PRAGMA table_info(ksprojects);

/*
We are now going to begin constructing a query with several components. Each screen of this project will guide you 
through another piece, until you have the final query.

To start, even a database with one table likely contains data that's not necessary to our analysis. In this step, 
we'll specify which columns to read from the table.

Instructions
Pull the relevant columns from the ksprojects table that will allow us to assess a project's result based on its 
main category, amount of money set as a goal, number of backers, and amount of money pledged. Return just the 
first 10 rows.
*/
SELECT main_category, goal, backers, pledged
  FROM ksprojects
 LIMIT 10;

/*
From this point on in your project each screen will build upon the existing query. To help save time, we will 
provide the suggested answer code from the previous screen in the coding environment, but if you would prefer 
to use your own code feel free to copy and paste it!

Now that you've selected the relevant columns, we'll filter the data to include only those in certain categories.

Thomas Edison famously said, "I have not failed. I've just found 10,000 ways that won't work." To that end, your 
product team would like to know more about the projects that weren't successful.

Instructions
Repeat your query from the previous screen, but this time only keep the records where the project state is either 
'failed', 'canceled', or 'suspended'.
*/
SELECT main_category, backers, pledged, goal
 FROM ksprojects
WHERE state IN ('failed', 'canceled', 'suspended')
LIMIT 10;

/*
For our analysis, we'll only want to look at projects of a certain size. This is because there are a lot of small 
projects in the database that aren't relevant to our analysis. Now that we've filtered our records to meet certain 
categories, let's also filter them to meet given quantities, too.

Instructions
Expand your query from the previous screen to find which of these projects had at least 100 backers and at least 
$20,000 pledged.
*/
SELECT main_category, backers, pledged, goal
  FROM ksprojects
 WHERE state IN ('failed', 'canceled', 'suspended')
   AND backers >= 100 AND pledged >= 20000
 LIMIT 10;

/*
In addition to selecting the relevant columns and filtering the relevant rows, sorting your results can be quite 
valuable in making sense of the data. In this case, the product team would like to view projects by categories, 
along with the percentage of the goal that was funded.

Instructions
1.Continue building on your query from the previous screen. This time, you'll sort the results by two fields:

a)Main category sorted in ascending order.
b)A calculated field called pct_pledged, which divides pledged by goal. Sort this field in descending order. 
(Add pct_pledged to the SELECT clause, too.)

2.Now, modify your query so that only projects in a failed state are returned.
*/
SELECT main_category, backers, pledged, goal,
         pledged / goal AS pct_pledged
    FROM ksprojects
   WHERE state IN ('failed')
     AND backers >= 100 AND pledged >= 20000
ORDER BY main_category, pct_pledged DESC
   LIMIT 10;
/*
It can often be helpful to make sense of a set of records by grouping them into categories based on some condition, 
which in SQL can be done with CASE statements.

While it's interesting to view the results of failed projects by metrics like the number of backers, what really 
makes or breaks a Kickstarter project is whether it meets its pledge goal.

Instructions
1.Create a field funding_status that applies the following logic based on the percentage of amount pledged to 
campaign goal:

a)If the percentage pledged is greater than or equal to 1, then the project is "Fully funded".
b)If the percentage pledged is between 75% and 100%, then the project is "Nearly funded".
c)If the percentage pledged is less than 75%, then the project is "Not nearly funded".

2.Write either a line or block comment with your observations about the funding status of the sample output. 
For example, are these failed projects failing because they don't have any backers or funding?
*/
SELECT main_category, backers, pledged, goal, 
       pledged/goal AS pct_pledged,
       CASE
       WHEN pledged/goal  >= 1 THEN "Fully funded"
       WHEN pledged/goal BETWEEN .75 AND 1 THEN "Nearly funded"
       ELSE "Not nearly funded"
       END AS funding_status 
  FROM ksprojects
 WHERE state IN ('failed')
       AND backers >= 100 AND pledged >= 20000
 ORDER BY main_category, pct_pledged DESC
 LIMIT 10;

/*
Now it's your turn to explore this database using SQL.

Instructions
Write your own query to explore the data in a way that sounds interesting to you. For example, you could look at 
projects from a given category you'd be inclined to purchase from.
Hint
Make sure to follow the style conventions presented throughout this course as you begin to write your very own 
queries!
*/
 --To be required modification for correctness with own query
 SELECT 
    category, 
    COUNT(*) AS total_projects, 
    ROUND(AVG(usd_pledged), 2) AS avg_funding, 
    MAX(usd_pledged) AS max_funded_project
FROM ksprojects
GROUP BY category
ORDER BY max_funded_project DESC
LIMIT 10;

/*
In this project, you analyzed Kickstarter projects to look for patterns in failed campaigns:

a)You wrote SQL statements to learn about the schema of your database and data types of your table.
b)You used the SELECT statement to retrieve and create columns of interest.
c)You used the WHERE statement to retrieve records meeting a variety of categorical and quantitative conditions.
d)You used the ORDER BY statement to sort your query results by one or more fields.
e)You used CASE statements to apply conditional logic to your query results.

The end users of your data now have clean tables that they can review to answer their exact questions about what 
might contribute to a successful Kickstarter 
project. In addition, your code is well-formatted and easy to recycle for additional projects.

To continue the analysis, you may consider building additional summary tables, along with visualizations and 
statistical tests to explore and confirm your insights.
*/
