# In the cfpb_complaints_2500 database, you can find “closed with relief” in Company_response column. 
# Please find the name of the company that has the highest ratio of cases that is ‘closed with relief’? 
# Only those companies with more than 30 cases [all different kinds of cases, no matter whether they are featured 
# with ‘closed with relief’ or not] in the database are considered (10 points).
# ratio [or percentage] for an individual company is calculated as:
# The amount of its cases featured with ‘closed with relief’ / the amount of its total cases

# The name of the company: Barclays (5 points)
# The ratio of the cases for the company: 0.4286 (5 points) 

# Solution 1
SELECT Company,
       SUM(CASE WHEN Company_response = 'Closed with relief' THEN 1 ELSE 0 END) AS ReliefCases,
       COUNT(*) AS TotalCases,
       (SUM(CASE WHEN Company_response = 'Closed with relief' THEN 1 ELSE 0 END) / COUNT(*)) AS ReliefRatio
FROM cfpb_complaints_2500
GROUP BY Company
HAVING COUNT(*) > 30
ORDER BY ReliefRatio DESC
LIMIT 5;


