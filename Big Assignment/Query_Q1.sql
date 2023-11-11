# In the table orders at the car retailer (classicmodels) database, 
# what is the customerNumber of the customer who has the highest frequency of 
# placing orders to the company in 2004 [orderDate in 2004]? 

# You don’t need to consider whether the products have been finally shipped or not.
# The customerNumber of the customer: 141 (6 points)
# The highest frequency is: 9 (6 points)

# Solution 1
SELECT customerNumber, COUNT(orderNumber) AS orderCount FROM orders
WHERE YEAR(orderDate) = 2004
GROUP BY customerNumber
ORDER BY orderCount DclassicmodelsclassicmodelsESC
LIMIT 1;

# Solution 2
SELECT customerNumber, COUNT(*) AS frequency
FROM orders
WHERE YEAR(orderDate) = 2004
GROUP BY customerNumber
ORDER BY frequency DESC
LIMIT 1;





