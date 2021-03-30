

-- -----------------------------------------------------------------------------------------------------
-- Praval Sooklal
SELECT 
type
,DATE_FORMAT(updateddate, '%Y/%m/01') AS month_date
,sum(grossamount)
FROM fingl
WHERE currenthistoryflag='CURRENT'  AND updateddate>='2020/09/30'
GROUP BY month_date,type


SELECT fingl.posteddate AS fingl_posteddate
,SUM(fingl.amount) AS `raised_premium_amount`
,policy.policynumber AS policynumber
,policygroupholdings.policygroupholdingsname AS policygroupholdingsname
FROM fingl,policy,policygroupholdings
WHERE(policy.policynumber = fingl.policynumber AND  
    fingl.currenthistoryflag = 'CURRENT' AND  
    policy.currenthistoryflag = 'CURRENT') AND
DATE_FORMAT(fingl_posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
LIMIT 100


-- company_premium_raised_month
SELECT DATE_FORMAT(fingl.posteddate, '%Y/%m/01') AS `premium_raised_month`
,sum(fingl.amount) AS `premium_raised_amount`
,policygroupholdings.policygroupholdingsname AS `company_name`
FROM fingl,policy,policygroupholdings
WHERE (policy.policynumber = fingl.policynumber AND  
    fingl.currenthistoryflag = 'CURRENT' AND  
    policy.currenthistoryflag = 'CURRENT') AND
    fingl.type='Premium Raised' AND
DATE_FORMAT(fingl.posteddate, '%Y/%m/01')>=DATE_FORMAT(NOW() - INTERVAL 5 MONTH, '%Y/%m/01') AND
DATE_FORMAT(fingl.posteddate, '%Y/%m/01')<=DATE_FORMAT(NOW() - INTERVAL 0 MONTH, '%Y/%m/01') AND
policygroupholdings.policygroupholdingsname<>''
GROUP BY `premium_raised_month`, `company_name`
