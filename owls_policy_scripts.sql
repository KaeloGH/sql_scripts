-- CBR_Policy_AG --------------------------------------------------------------------------------------------------------------------------

SELECT * FROM (
  	SELECT 
  	(SELECT 'Active Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS '2 Month',
  	
	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS '1 Month',
		
	(SELECT COUNT(*) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS 'Current Month'
) AS `a`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	)
) AS `b`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average Gross Premium') AS 'Type',
  	
  	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
  	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
		
	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	)
) AS `c`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Fees') AS 'Type',
  	
  	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
  	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
		
	(SELECT SUM(totalfees) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	)
) AS `d`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'New Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
		
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	)
) AS `e`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of New Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	)
) AS `f`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Cancelled Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
		
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	)
) AS `g`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of Cancelled Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT'
		#cbr_report.policy_ag_limit#
	)
) AS `h`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'NTU Policies') AS 'Type',
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS i1,
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS i2,
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS i3,
		
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS i4
) AS `i`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of NTU Policies') AS 'Type',
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS j1,
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS j2,
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS j3,
		
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS j4
) AS `j`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Lapsed Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS k1,
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS k2,
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS k3,
		
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT'
		#cbr_report.policy_ag_limit#
	) AS k4
) AS `k` 
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of Lapsed Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS l1,
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS l2,
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS l3,
		
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_ag_limit#
	) AS l4
) AS `l`

-- CBR_Policy_Kaelo ----------------------------------------------------------------------------------------------------------------------------

SELECT * FROM (
  	SELECT 
  	(SELECT 'Active Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS '2 Month',
  	
	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS '1 Month',
		
	(SELECT COUNT(*) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS 'Current Month'
) AS `a`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	)
) AS `b`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average Gross Premium') AS 'Type',
  	
  	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
  	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
		
	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	)
) AS `c`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Fees') AS 'Type',
  	
  	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
  	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
		
	(SELECT SUM(totalfees) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	)
) AS `d`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'New Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
		
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	)
) AS `e`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of New Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	)
) AS `f`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Cancelled Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
		
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	)
) AS `g`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of Cancelled Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT'
		#cbr_report.policy_kaelo_limit#
	)
) AS `h`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'NTU Policies') AS 'Type',
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS i1,
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS i2,
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS i3,
		
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS i4
) AS `i`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of NTU Policies') AS 'Type',
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS j1,
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS j2,
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS j3,
		
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS j4
) AS `j`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Lapsed Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS k1,
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS k2,
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS k3,
		
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT'
		#cbr_report.policy_kaelo_limit#
	) AS k4
) AS `k` 
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of Lapsed Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS l1,
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS l2,
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS l3,
		
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_kaelo_limit#
	) AS l4
) AS `l`

-- CBR_Policy_Sanlam -------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM (
  	SELECT 
  	(SELECT 'Active Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS '2 Month',
  	
	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS '1 Month',
		
	(SELECT COUNT(*) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS 'Current Month'
) AS `a`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	)
) AS `b`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average Gross Premium') AS 'Type',
  	
  	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
  	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
		
	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	)
) AS `c`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Fees') AS 'Type',
  	
  	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
  	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
		
	(SELECT SUM(totalfees) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	)
) AS `d`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'New Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
		
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	)
) AS `e`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of New Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	)
) AS `f`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Cancelled Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
		
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	)
) AS `g`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of Cancelled Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT'
		#cbr_report.policy_sanlam_limit#
	)
) AS `h`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'NTU Policies') AS 'Type',
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS i1,
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS i2,
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS i3,
		
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS i4
) AS `i`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of NTU Policies') AS 'Type',
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS j1,
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS j2,
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS j3,
		
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS j4
) AS `j`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Lapsed Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS k1,
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS k2,
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS k3,
		
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT'
		#cbr_report.policy_sanlam_limit#
	) AS k4
) AS `k` 
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of Lapsed Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS l1,
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS l2,
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS l3,
		
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	) AS l4
) AS `l`


-- CBR_Policy_Western --------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM (
  	SELECT 
  	(SELECT 'Active Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS '3 Month',
  	
  	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS '2 Month',
  	
	(SELECT COUNT(*) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS '1 Month',
		
	(SELECT COUNT(*) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS 'Current Month'
) AS `a`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	)
) AS `b`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Average Gross Premium') AS 'Type',
  	
  	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
  	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
		
	(SELECT ROUND(AVG(getnum(grosspremium)), 2) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	)
) AS `c`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Fees') AS 'Type',
  	
  	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
  	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
	(SELECT SUM(totalfees) FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
		) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
		
	(SELECT SUM(totalfees) FROM policy WHERE (status='Live' OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01')) AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	)
) AS `d`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'New Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
		
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	)
) AS `e`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of New Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	)
) AS `f`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Cancelled Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
		
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	)
) AS `g`

UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of Cancelled Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
  	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
  	
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	),
		
	(SELECT SUM(grosspremium) FROM policy WHERE DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW(), '%Y/%m/01') AND currenthistoryflag='CURRENT'
		#cbr_report.policy_western_limit#
	)
) AS `h`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'NTU Policies') AS 'Type',
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS i1,
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS i2,
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS i3,
		
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS i4
) AS `i`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of NTU Policies') AS 'Type',
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS j1,
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS j2,
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS j3,
		
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 		/* Cancelled one day before */
			DATE_FORMAT(inceptiondate, '%Y/%m/%d')=DATE_FORMAT(DATE(cancellationdate) + INTERVAL 1 DAY, '%Y/%m/%d')
	 	/* Find the date the status changed to not taken up */
	 	AND DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Not Taken Up' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Not Taken Up'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS j4
) AS `j`
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Lapsed Policies') AS 'Type',
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS k1,
  	
  	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS k2,
  	
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS k3,
		
	(SELECT COUNT(*) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT'
		#cbr_report.policy_western_limit#
	) AS k4
) AS `k` 
	
UNION

SELECT * FROM (
  	SELECT 
  	(SELECT 'Gross Premium of Lapsed Policies') AS 'Type',
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS l1,
  	
  	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS l2,
  	
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS l3,
		
	(SELECT SUM(grosspremium) FROM policy 
	 WHERE 
	 	/* Find the date the status changed to not taken up */
	 		DATE_FORMAT((SELECT updateddate FROM policy AS p3 WHERE p3.policynumber=policy.policynumber AND
			 updateddate > (SELECT updateddate FROM policy AS p2 WHERE p2.policynumber=policy.policynumber AND status <> 'Lapsed' ORDER BY updateddate DESC LIMIT 1)
			 ORDER BY updateddate DESC LIMIT 1), '%Y/%m/01') = DATE_FORMAT(NOW(), '%Y/%m/01')
	 	AND status='Lapsed'
	 	AND cancellationdate IS NOT NULL
	 	AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_western_limit#
	) AS l4
) AS `l`