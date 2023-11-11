# In the data “tripadvisor_review_sample_without_reviewtext”, based on the review titles 
# that have at least two words [a total of 5 points]: 

# 1. Regarding the first word used in the review title, what is the most popular word [case-insensitive]?
# The word is: great [1 points]   The frequency of the word is: 2144 [1 points]

# 2. Regarding the second word used in the review title, what is the most popular word [case-insensitive]?
# The word is: hotel [1 points]   The frequency of the word is: 1420 [1 points] 

# 3. For those titles that start with the words “bad” OR “terrible”, 
# what are the most popular second word [case-insensitive]:
# The word is: experience [1 points]

# Note: Before answering question 8, please clean the title based on the following two requirements.
# i) Please remember to first remove six types of punctuation marks from the title, including:
#     “    ”     "    -    ,     !

# In order to obtain consistent results, please do not remove more punctuation marks than we 
# specified above and also do not replace the punctuation with an empty space.
# ii) Please remove empty spaces from both sides of the title.


# Create a new column of clean_title 

ALTER TABLE tripadvisor_review_sample_without_reviewtext
ADD COLUMN cleaned_title VARCHAR(200);

#  i) First, we remove six types of punctuation marks from the title, including:
#     “    ”     "    -    ,     !
# We do not replace the punctuation with an empty space

UPDATE tripadvisor_review_sample_without_reviewtext
SET cleaned_title = REPLACE(title, '“', '');

UPDATE tripadvisor_review_sample_without_reviewtext
SET cleaned_title = REPLACE(cleaned_title, '”', '');

UPDATE tripadvisor_review_sample_without_reviewtext
SET cleaned_title = REPLACE(cleaned_title, '"', '');

UPDATE tripadvisor_review_sample_without_reviewtext
SET cleaned_title = REPLACE(cleaned_title, '-', '');

UPDATE tripadvisor_review_sample_without_reviewtext
SET cleaned_title = REPLACE(cleaned_title, ',', '');

UPDATE tripadvisor_review_sample_without_reviewtext
SET cleaned_title = REPLACE(cleaned_title, '!', '');

# ii) Please remove empty spaces from both sides of the title.
# TRIM() function removes leading and trailing spaces from a string.

UPDATE tripadvisor_review_sample_without_reviewtext
SET cleaned_title = TRIM(cleaned_title);

# Set all titles to lower case, since the queries ask for case-insensitive
UPDATE tripadvisor_review_sample_without_reviewtext
SET cleaned_title = LOWER(cleaned_title);


# 1. Most Popular First Word

SELECT SUBSTRING_INDEX(cleaned_title, ' ', 1) AS firstWord, COUNT(*) AS firstWordCount
FROM tripadvisor_review_sample_without_reviewtext
# Title has at least 2 words if it contains at least 1 white space
WHERE LENGTH(cleaned_title) - LENGTH(REPLACE(cleaned_title, ' ', '')) >= 1
GROUP BY firstWord
ORDER BY firstWordCount DESC
LIMIT 1;


# 2. Most Popular Second Word

SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(cleaned_title, ' ', 2), ' ', -1) AS secondWord, COUNT(*) AS secondWordCount
FROM tripadvisor_review_sample_without_reviewtext
# Title has at least 2 words if it contains at least 1 white space
WHERE LENGTH(cleaned_title) - LENGTH(REPLACE(cleaned_title, ' ', '')) >= 1
GROUP BY secondWord
ORDER BY secondWordCount DESC
LIMIT 1;


# 3. Most Popular Second Word for Titles Starting with "bad" or "terrible"

SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(cleaned_title, ' ', 2), ' ', -1) AS secondWord, COUNT(*) AS secondWordCount
FROM tripadvisor_review_sample_without_reviewtext
# Titles with first word as bad or terrible
WHERE (cleaned_title LIKE 'bad %' OR cleaned_title LIKE 'terrible %')
GROUP BY secondWord
ORDER BY secondWordCount DESC
LIMIT 1;


# Drop the cleaned_title column from the table
# so queries above can be rerun without error
ALTER TABLE tripadvisor_review_sample_without_reviewtext DROP COLUMN cleaned_title;