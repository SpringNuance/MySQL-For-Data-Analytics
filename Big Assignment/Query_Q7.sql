# Based on the use of cfpb consumer complaint database (2500 rows), please count the frequency of the complaints 
# that satisfy the following three conditions at the same time: i) consumer finally disputed with the company 
# (Consumer_disputed); and ii) were received on Friday (Data_received) and iii) the difference between 
# Data_received and Data_sent_to_company is more than 5 days. (10 points)

# Please specify the name of the company that has the biggest amount of the above-mentioned complaints.

# The name of the company: Bank of America (5 points)
# Frequency of the mentioned complaints of the company: 52 (5 points)

# Solution 1

SELECT Company, COUNT(*) AS mentionedComplaintsCount
FROM cfpb_complaints_2500

# i) consumer finally disputed with the company (Consumer_disputed)
WHERE Consumer_disputed = 'Yes' 
# ii) were received on Friday (Data_received)
AND DAYOFWEEK(Data_received) = 6 
# iii) the difference between Data_received and Data_sent_to_company is more than 5 days
AND DATEDIFF(Data_sent_to_company, Data_received) > 5

GROUP BY Company
ORDER BY mentionedComplaintsCount DESC
LIMIT 1;


# Solution 2

SELECT Company, COUNT(*) AS Frequency
FROM cfpb_complaints_2500
WHERE Consumer_disputed = 'Yes'
AND DAYOFWEEK(Data_received) = 6
AND DATEDIFF(Data_sent_to_company, Data_received) > 5
GROUP BY Company
ORDER BY Frequency DESC
LIMIT 1;
