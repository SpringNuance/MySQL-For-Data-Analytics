# In the Chile database, let’s assume that an income less than 10,000 is a low income; an income between 
# 10,000 and 100,000 is a middle income; an income higher than 100,000 is a high income. We would like to 
# know whether the income level and the statusquo have a certain relationship for females who voted yes 
# to Pinochet. To answer this question, you need to provide the average statusquo value for the females who voted yes to Pinochet in correspondence to their different income levels. (9 points)

# [Please carefully read the question so that you will not miss any important condition when answering the question; 
# Please provide three digits after the decimal point in the results]

# Suggestion: you may need to update the table by adding a new column of income_level to answer the question.

#   Income level    Mean statusquo
#   High_income          1.077
#   Middle_income        0.927
#   Low_income           0.937

#SELECT
#    ID,
#    CASE
#        WHEN income < 10000 THEN 'Low_income'
#        WHEN income BETWEEN 10000 AND 100000 THEN 'Middle_income'
#        ELSE 'High_income'
#    END as income_level
#FROM
#    chile;

# Solution 1
-- Add the income_level column to the table
ALTER TABLE chile ADD COLUMN income_level VARCHAR(15);

-- Update the income_level based on the income ranges
UPDATE chile
SET income_level = CASE
    WHEN income < 10000 THEN 'Low_income'
    WHEN income BETWEEN 10000 AND 100000 THEN 'Middle_income'
    ELSE 'High_income'
END;

-- Select the average statusquo for females who voted 'Y', grouped by income level
SELECT income_level, ROUND(AVG(statusquo), 3) AS "Mean statusquo" FROM chile
WHERE sex = 'F' AND vote = 'Y'
GROUP BY income_level
ORDER BY CASE 
    WHEN income_level = 'High_income' THEN 1
    WHEN income_level = 'Middle_income' THEN 2
    WHEN income_level = 'Low_income' THEN 3
END;

# drop the income_level column from the chile table
# so queries above can be rerun without error
ALTER TABLE chile DROP COLUMN income_level;


# Solution 2

# We add a column "income_level" to the "chile" table

ALTER TABLE chile ADD COLUMN income_level VARCHAR(30);

# Then, we populate the "income_level" based on the "income"

UPDATE chile
SET income_level = CASE
    WHEN income < 10000 THEN 'Low_income'
    WHEN income > 100000 THEN 'High_income'
    ELSE 'Middle_income'
END;

# Finally, we calculate the mean statusquo value for females who voted yes to 
# Pinochet at different income levels. 
# After obtaining the table, we order the mean statusquo by high, middle and low income

SELECT income_level, ROUND(AVG(statusquo), 3) AS "Mean statusquo" FROM chile
WHERE vote = 'Y' AND sex = 'F'  
GROUP BY income_level
ORDER BY CASE 
    WHEN income_level = 'High_income' THEN 1
    WHEN income_level = 'Middle_income' THEN 2
    WHEN income_level = 'Low_income' THEN 3
END;

# We drop the income_level column from the "chile" table
# so the queries above can be rerun without error

ALTER TABLE chile DROP COLUMN income_level;


