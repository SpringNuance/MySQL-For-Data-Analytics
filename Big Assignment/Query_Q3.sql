# In the classicmodels database, one sales representative is responsible for one or 
# several customers [see “salesRepEmployeeNumber” in table “customers”]. 
# Customers make different payments on different dates [See table “payments”]. 
# In other words, we can say sales representatives help the company get customers to 
# make payments. Now the question is, who is the sales representative that brings the 
# most revenue [or the total amount of the payments from customers in the table payments] 
# to the company?

# Note: 
# i) Ignoring those customers who are not assigned to any sales representative – 
# they have not made any purchases yet.

# The salesRepEmployeeNumber of the sales representative 
# who brings the most revenue is: 1370 [12 points].

# Solution 1
SELECT salesRepEmployeeNumber, SUM(amount) AS total_revenue
FROM customers
JOIN payments ON customers.customerNumber = payments.customerNumber
WHERE salesRepEmployeeNumber IS NOT NULL
GROUP BY salesRepEmployeeNumber
ORDER BY total_revenue DESC
LIMIT 1;

# Solution 2
SELECT c.salesRepEmployeeNumber, SUM(p.amount) AS total_revenue
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
WHERE c.salesRepEmployeeNumber IS NOT NULL
GROUP BY c.salesRepEmployeeNumber
ORDER BY total_revenue DESC
LIMIT 1;



