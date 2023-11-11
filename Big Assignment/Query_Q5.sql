# In the cfpb_complaints_2500 database, many complaints are related to ‘loan’ 
# (those cases where the word ‘loan’ is included in the column ‘Issue’). 
# Please specify the name of the company that has the most issues related to ‘loan’ 
# on Wednesday (DATA_received). Only complaints with the column ‘State’ starting with 
# character “A” are considered (8 points). 

# The name of the company: Bank of America (8 points)


# Solution 1
SELECT Company, COUNT(*) AS LoanIssuesOnWednesday
FROM cfpb_complaints_2500
WHERE Issue LIKE '%loan%' 
AND DAYOFWEEK(Data_received) = 4 -- MySQL treats Monday as 1, so Wednesday is 4
AND State LIKE 'A%' -- States starting with "A"
GROUP BY Company
ORDER BY LoanIssuesOnWednesday DESC
LIMIT 1;


# Solution 2
SELECT Company, COUNT(*) AS loan_issues_Wednesday
FROM cfpb_complaints_2500
WHERE Issue LIKE '%loan%'
AND DAYOFWEEK(Data_received) = 4
AND State LIKE 'A%'
GROUP BY Company
ORDER BY loan_issues_Wednesday DESC
LIMIT 1;


