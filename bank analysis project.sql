CREATE DATABASE Finance; 
USE finance;
select * from financedata;
select count(*) from financedata;

-- KPI Cards
-- 1.Number of Customers
SELECT COUNT(DISTINCT `Finance_1.member_id`) AS number_of_customers
FROM financedata; 

-- 2.Total Loan Amount
SELECT SUM(`Finance_1.loan_amnt`) / 1000000 AS total_loan_amount_million
FROM financedata;

-- 3.Average Interest Rate
SELECT AVG(`Finance_1.int_rate`) * 100 AS average_interest_rate
FROM financedata;

-- 4.Total Revolve Balance
SELECT SUM(revol_bal) / 1000000 AS total_revolve_balance_million
FROM financedata;

-- 5.Average DTI
SELECT AVG(`Finance_1.dti`) AS average_dti
FROM financedata;

-- CHARTS
-- 1.Year-wise Loan Amount Status
SELECT YEAR(STR_TO_DATE(earliest_cr_line, '%d-%m-%Y')) AS year,
       SUM(`Finance_1.loan_amnt`) / 1000000 AS total_loan_amount_million
FROM financedata
GROUP BY YEAR(STR_TO_DATE(earliest_cr_line, '%d-%m-%Y'))
ORDER BY year;
  
-- 2.Verified vs Not Verified Loan Payment
SELECT `Finance_1.verification_status`,
       SUM(total_pymnt) AS total_payment,
       ROUND(SUM(total_pymnt) * 100.0 / (SELECT SUM(total_pymnt) FROM financedata), 2) AS percentage
FROM financedata
GROUP BY `Finance_1.verification_status`;

-- 3.Grade and Subgrade-wise Revolve Balance
SELECT `Finance_1.grade`,
       `Finance_1.sub_grade`,
       SUM(revol_bal) / 1000000 AS total_revolve_balance_million
FROM financedata
GROUP BY `Finance_1.grade`, `Finance_1.sub_grade`
ORDER BY `Finance_1.grade`, `Finance_1.sub_grade`;

-- 4.State-wise Loan Status
SELECT `Finance_1.addr_state`,
       COUNT(*) AS total_loans
FROM financedata
GROUP BY `Finance_1.addr_state`
ORDER BY total_loans DESC;

-- 5.Home Ownership vs Last Payment Date
SELECT YEAR(STR_TO_DATE(last_pymnt_d, '%d-%m-%Y')) AS year,
       `Finance_1.home_ownership`,
       SUM(total_pymnt) AS total_payment
FROM financedata
WHERE last_pymnt_d IS NOT NULL
GROUP BY YEAR(STR_TO_DATE(last_pymnt_d, '%d-%m-%Y')), `Finance_1.home_ownership`
ORDER BY year, `Finance_1.home_ownership`;






