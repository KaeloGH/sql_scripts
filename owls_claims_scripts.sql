
-- CBR_Claim_Western -------------------------------------------------------------------------------------------------------------------
SELECT * FROM (
  	SELECT 
  	(SELECT 'Claims Created') AS 'Type',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `a`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Claims Created') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `b`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Highest Claim Paid') AS 'Type',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '3 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '2 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '1 Month',
	
	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS 'Current Month'
) AS `c`

UNION 

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Claims Paid') AS 'Type',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `d`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Claims Paid') AS 'Type',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `e`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average Cost Per Claim') AS 'Type',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `f`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Repudiated Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `g`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Repudiated Claims') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `h`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average of Repudiated Claims') AS 'Type',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
		AND policy.umaid='AG'
	) AS 'Current Month'
) AS `i`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Outstanding Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `j`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Outstanding Claims') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `k`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Total Outstanding Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_western_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `l`

-- CBR_Claim_Sanlam -------------------------------------------------------------------------------------------------------------------

SELECT * FROM (
  	SELECT 
  	(SELECT 'Claims Created') AS 'Type',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `a`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Claims Created') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `b`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Highest Claim Paid') AS 'Type',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '3 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '2 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '1 Month',
	
	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS 'Current Month'
) AS `c`

UNION 

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Claims Paid') AS 'Type',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `d`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Claims Paid') AS 'Type',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `e`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average Cost Per Claim') AS 'Type',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `f`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Repudiated Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `g`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Repudiated Claims') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `h`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average of Repudiated Claims') AS 'Type',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
		AND policy.umaid='AG'
	) AS 'Current Month'
) AS `i`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Outstanding Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `j`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Outstanding Claims') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `k`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Total Outstanding Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `l`

-- CBR_Claim_Kaelo --------------------------------------------------------------------------------------------------------------------

SELECT * FROM (
  	SELECT 
  	(SELECT 'Claims Created') AS 'Type',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `a`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Claims Created') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `b`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Highest Claim Paid') AS 'Type',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '3 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '2 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '1 Month',
	
	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS 'Current Month'
) AS `c`

UNION 

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Claims Paid') AS 'Type',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `d`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Claims Paid') AS 'Type',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `e`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average Cost Per Claim') AS 'Type',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `f`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Repudiated Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `g`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Repudiated Claims') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `h`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average of Repudiated Claims') AS 'Type',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
		AND policy.umaid='AG'
	) AS 'Current Month'
) AS `i`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Outstanding Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `j`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Outstanding Claims') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `k`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Total Outstanding Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `l`

-- CBR_Claim_AG --------------------------------------------------------------------------------------------------------------------
SELECT * FROM (
  	SELECT 
  	(SELECT 'Claims Created') AS 'Type',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT COUNT(*) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `a`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Claims Created') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve) FROM claim, policy 
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
		AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `b`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Highest Claim Paid') AS 'Type',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '3 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '2 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS '1 Month',
	
	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	 GROUP BY fingl.policynumber, fingl.claimnumber
	 ORDER BY getnum(SUM(amount)) DESC LIMIT 1
	) AS 'Current Month'
) AS `c`

UNION 

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Claims Paid') AS 'Type',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT COUNT(DISTINCT fingl.claimnumber) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `d`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Claims Paid') AS 'Type',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT SUM(amount) FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `e`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average Cost Per Claim') AS 'Type',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT ROUND(SUM(amount) / COUNT(DISTINCT fingl.claimnumber), 2) 
	 FROM fingl, claim, policy FORCE INDEX(stats)
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND fingl.claimnumber=claim.claimnumber
	 	AND fingl.policynumber=fingl.policynumber
	 	AND fingl.gltype = 'Liability - Claim'
		AND DATE_FORMAT(fingl.posteddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `f`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Repudiated Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `g`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Repudiated Claims') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `h`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average of Repudiated Claims') AS 'Type',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT ROUND(SUM(claim.calculatedtotalreserve) / COUNT(claim.claimnumber))
	 FROM claim, policy
	 WHERE claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND claim.status='Claim Rejected'
		AND DATE_FORMAT((SELECT updateddate FROM claim AS c3 WHERE c3.claimnumber=claim.claimnumber AND
			 updateddate > (SELECT updateddate FROM claim AS c2 WHERE c2.claimnumber=claim.claimnumber AND status <> 'Claim Rejected' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
		AND policy.umaid='AG'
	) AS 'Current Month'
) AS `i`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Number of Outstanding Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `j`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Value of Outstanding Claims') AS 'Type',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT SUM(claim.calculatedtotalreserve)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `k`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Total Outstanding Claims') AS 'Type',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
  	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
	 	AND DATE_FORMAT(claim.createddate, '%Y/%m/01')<DATE_FORMAT(NOW(), '%Y/%m/01')
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
	
	(SELECT COUNT(claim.claimnumber)
	 FROM usertasks, claim, policy
	 WHERE usertasks.currenthistoryflag='CURRENT' 
	 	AND claim.currenthistoryflag='CURRENT' 
	 	AND policy.currenthistoryflag='CURRENT' 
	 	AND claim.policynumber=policy.policynumber
	 	AND usertasks.pk=claim.claimnumber
	 	AND usertasks.p_claimnumber=claim.claimnumber
	 	AND usertasks.p_policynumber=policy.policynumber
	 	AND usertasks.taskgroup='claim-workflow'
	 	AND usertasks.status='In Progress'
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `l`