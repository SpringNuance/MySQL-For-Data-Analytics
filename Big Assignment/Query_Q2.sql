# In the classicmodels database, customer names and customer numbers can be found 
# [see table “customers”]. Customers make different payments on different dates 
# [See table “payments”]. Please specify the names of two customers who are most often 
# (count frequency) to make payments during the weekend [12 points].
# Name of Customer 1: Mini Gifts Distributors Ltd.
# Name of Customer 2: Marseille Mini Autos
# Note: i) Please provide “customerName”, not the contact names from table “customers”

# Solution 1
SELECT c.customerName, COUNT(*) AS weekendPaymentCount FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
WHERE DAYOFWEEK(p.paymentDate) IN (1, 7) -- 1 = Sunday, 7 = Saturday
GROUP BY c.customerName
ORDER BY weekendPaymentCount 
DESC LIMIT 2;

# Solution 2
SELECT c.customerName, COUNT(*) AS weekendPaymentCount FROM payments p
JOIN customers c ON p.customerNumber = c.customerNumber
WHERE DAYOFWEEK(p.paymentDate) IN (1, 7)
GROUP BY c.customerName
ORDER BY weekendPaymentCount 
DESC LIMIT 2;

