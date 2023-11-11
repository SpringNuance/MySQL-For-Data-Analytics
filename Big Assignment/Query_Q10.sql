# Assuming you are now a business analyst offering consultant service to the tourism minister of Finland 
# (a total of 5 points). The minister wants to know how tourists travel within Finland between different cities. 


#  Note: 
#  Please read the assignment questions carefully!

#  Please download the “assignment_tourist_Finland.sql” dataset from MyCourse.

#    It would be good to remove previous review-related tables before you import the database file 
#    so that you won’t mix the current assignment tables with previous review-related tables.

#    The sql file contains two tables of “hotel” [431 records] and “review2” [56,709 records]. 
#    Column ‘Id’ of the table ‘hotel’ is connected to the column ‘hotel_id’ of the table ‘review2’ 

#  It may happen that a traveler wrote multiple reviews about hotels in different cities as his/her 
#  first reviews (on the same but earliest review date). If one of these ‘first’ reviews includes 
#  Helsinki city, the traveler should be counted as a tourist whose first visit to Finland is Helsinki city. 
#  If one of these ‘first’ reviews includes ‘Rovaniemi_Lapland’ city, that trip is NOT considered visiting 
#  ‘Rovaniemi_Lapland’ city. “In the future” means future trips after these first reviews that were written 
#  on the same but earliest review day - I know this does not sound so logical, but it is good to increase 
#  the difficulty of the assignment question for training your mind). 

#  Assume that different values in the column “city” of the “hotel” table represent different cities. 
#  For instance, “Saariselka” and “Rovaniemi” are two different cities. 


# Specifically, for those tourists whose first visit to Finland is Helsinki city 
# [i.e., the first review in the database (in terms of review_date) is about a hotel in Helsinki_Uusimaa], 
# which city would most likely be visited by those tourists in the future?
 
 
 
# For those tourists whose first visit to Finland is Helsinki city 
# [i.e., the first review in the database (in terms of review_date) is about a hotel in Helsinki_Uusimaa], 
# they also visited “Rovaniemi_Lapland” for 184 times in the future (2 points).



# Count the number of times tourists who first visited Helsinki also visited Rovaniemi_Lapland in the future

SELECT COUNT(*) AS visitsToRovaniemi
FROM (
  # Subquery for find the user IDs where their first review_date is in Helsinki_Uusimaa
  SELECT r2.user_id
  FROM review2 r2
  JOIN hotel h ON r2.hotel_id = h.id
  WHERE h.city = 'Helsinki_Uusimaa'
  GROUP BY r2.user_id
  HAVING MIN(r2.review_date) = ANY (
    # This subsubquery means if a user's earliest review date in Helsinki is the same as their earliest 
	 # review date in general, then their first recorded stay (according to the reviews) was in Helsinki
    SELECT MIN(r2_sub.review_date)
    FROM review2 r2_sub
    WHERE r2_sub.user_id = r2.user_id
  )
) AS firstVisitorsHelsinki
JOIN review2 r2_future ON r2_future.user_id = firstVisitorsHelsinki.user_id
JOIN hotel h_future ON r2_future.hotel_id = h_future.id
WHERE h_future.city = 'Rovaniemi_Lapland'
AND r2_future.review_date > (
  # Visits to Rovaniemi on the first review date in general are not counted
  SELECT MIN(r2_sub.review_date)
  FROM review2 r2_sub
  WHERE r2_sub.user_id = firstVisitorsHelsinki.user_id
);


# For those tourists whose first visit to Finland is to Helsinki city 
# [i.e. first review in the database (in terms of review_date) is about a hotel in Helsinki_Uusimaa], 
# ___________ of them also visited both “Saariselka_Lapland” and “Rovaniemi_Lapland” cities 
# in the future (3 points).

# Count the number of tourists who first visited Helsinki also 
# visited Rovaniemi_Lapland or Saariselka_Lapland in the future

SELECT COUNT(DISTINCT user_id) AS NumberOfTouristsVisitBothCities
FROM (
  SELECT r2.user_id
  FROM review2 r2
  JOIN hotel h ON r2.hotel_id = h.id
  WHERE h.city = 'Helsinki_Uusimaa'
  GROUP BY r2.user_id
  HAVING MIN(r2.review_date) = ANY (
    SELECT MIN(r2_sub.review_date)
    FROM review2 r2_sub
    WHERE r2_sub.user_id = r2.user_id
  )
) AS firstVisitorsHelsinki
WHERE EXISTS (
  SELECT 1
  FROM review2 r2
  JOIN hotel h ON r2.hotel_id = h.id
  WHERE r2.user_id = firstVisitorsHelsinki.user_id
  AND h.city = 'Saariselka_Lapland'
  AND r2.review_date > (
    SELECT MIN(r2_sub.review_date)
    FROM review2 r2_sub
    WHERE r2_sub.user_id = firstVisitorsHelsinki.user_id
  )
)
AND EXISTS (
  SELECT 1
  FROM review2 r2
  JOIN hotel h ON r2.hotel_id = h.id
  WHERE r2.user_id = firstVisitorsHelsinki.user_id
  AND h.city = 'Rovaniemi_Lapland'
  AND r2.review_date > (
    SELECT MIN(r2_sub.review_date)
    FROM review2 r2_sub
    WHERE r2_sub.user_id = firstVisitorsHelsinki.user_id
  )
);
