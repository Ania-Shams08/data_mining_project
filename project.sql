SELECT * FROM datamining_project.onlineretail_final_1;
use dataminig_project;
#What is the distribution of order values across all customers in the dataset?
select CustomerID, count(Quantity) as ordervalues
from onlineretail_final_1
group by CustomerID;


SELECT CustomerID,
    AVG(Quantity*UnitPrice) AS Averageoforders,
    MAX(Quantity*UnitPrice) AS maximumofOrders,
    MIN(Quantity*UnitPrice) AS MinimumofOrders
FROM onlineretail_final_1
GROUP BY CustomerID
LIMIT 0, 1000;






#  How many unique products has each customer purchased?
select distinct CustomerID, count(StockCode) as purchaseUniqueProducts
from onlineretail_final_1
group by CustomerID;
#  Which customers have only made a single purchase from the company?
select distinct CustomerID, Quantity 
from onlineretail_final_1 WHERE Quantity=1
group by CustomerID;
# Which products are most commonly purchased together by customers in the dataset?
select distinct CustomerID, max(Quantity) as MostCommonlyPurchased
from onlineretail_final_1
group by CustomerID;
#Group customers into segments based on their purchase frequency, such as high, medium, and low frequency customers. This can help you identify your most loyal customers and those who need more attention.
select CustomerID, case
when count(*) >=100 then 'High Frequency'
when count(*) >=50 then 'Medium Frequency'
else 'low frequency' 
end as purchasedfrequency
from onlineretail_final_1
group by CustomerID;
#Calculate the average order value for each country to identify where your most valuable customers are located.
select Country, avg(Quantity) as averageordervalue
from onlineretail_final_1
group by Country order by averageordervalue DESC;
# Identify customers who haven't made a purchase in a specific period (e.g., last 6 months) to assess churn
select CustomerID, Quantity
from onlineretail_final_1 where Quantity=0
group by CustomerID;





#Determine which products are often purchased together by calculating the correlation between product purchases.
SELECT t1.Description AS Product1, t2.Description AS Product2, COUNT(*) AS Frequency
FROM onlineretail_final_1 t1
JOIN onlineretail_final_1 t2 ON t1.CustomerID = t2.CustomerID AND t1.InvoiceNo = t2.InvoiceNo AND t1.Description < t2.Description
WHERE t1.Description IS NOT NULL AND t2.Description IS NOT NULL
GROUP BY t1.Description, t2.Description
ORDER BY Frequency desc
LIMIT 15;
#  Explore trends in customer behavior over time, such as monthly or quarterly sales patterns.
select quarter(InvoiceDate) as quarter, count(distinct CustomerID) as unique_customers, sum(InvoiceNo) as total_sales
FROM onlineretail_final_1
GROUP BY quarter(InvoiceDate)
ORDER BY quarter;