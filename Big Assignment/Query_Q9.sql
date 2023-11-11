# The following screenshot shows the sale volume of a coupon site (https://www.savings.com/). 
# Assuming that you have collected the sale volume information of each coupon on this website on a daily basis. 
# For instance, the total sale volume for the Coupon “Macy’s” is 6,157,136 at the data collection date. 
# You want to calculate the daily sale volume for each coupon of this website (maybe because this website 
# is the competitor of your company) for further analysis. How can you do that task using MySQL? (5 points)

# Based on the data of the total sale volume for each coupon (like Table A). 
# Please calculate the daily sale volume, as shown in Table B.

# Explanation: For instance, the daily sale volume for CouponA on ‘2021-09-05’ is 25, 
# because the total sale volume for CouponA is 37 on ‘2021-09-05’ and 12 on ‘2021-09-04’. 
# The difference in total sale volumes between the two dates is the daily sale volume, which is 
# 37 – 12 = 25.

# Requirement:
#    1.  Please write code to generate the results as shown in Table B – the code will be the answer.
#    2.  You can download Table A from Mycourse (coupon_sale_volume.sql)


# Solution 1

SELECT 
    table_A.Coupon_ID,
    table_A.Sale_date,
    table_A.Total_sale_volume,
    # COALESCE function handle cases where there is no sale volume for the previous day 
	 # (which would return NULL) by treating it as 0.
    table_A.Total_sale_volume - COALESCE(table_B.Total_sale_volume, 0) AS daily_sale_volume
FROM coupon_sale_volume AS table_A
LEFT JOIN 
    coupon_sale_volume AS table_B ON table_A.Coupon_ID = table_B.Coupon_ID 
    AND table_B.Sale_date = DATE_SUB(table_A.Sale_date, INTERVAL 1 DAY)
ORDER BY 
    table_A.Coupon_ID, 
    table_A.Sale_date;

# Solution 2

SELECT 
    table_A.Coupon_ID,
    table_A.Sale_date,
    table_A.Total_sale_volume,
    table_A.Total_sale_volume - IFNULL(table_B.Total_sale_volume, 0) AS daily_sale_volume
FROM coupon_sale_volume AS table_A
LEFT JOIN 
    coupon_sale_volume AS table_B ON table_A.Coupon_ID = table_B.Coupon_ID 
    AND table_B.Sale_date = DATE_ADD(table_A.Sale_date, INTERVAL -1 DAY)
ORDER BY 
    table_A.Coupon_ID, 
    table_A.Sale_date;
