

-- The following is a snippet from CBR_policy_sanlam to calculate new policies:

  	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
  	
	(SELECT COUNT(*) FROM policy WHERE DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND currenthistoryflag='CURRENT' 
		#cbr_report.policy_sanlam_limit#
	),
		
I adapted this to be : 

OWLS_new_policies_20210201_2021_0318

SELECT DATE_FORMAT(inceptiondate, '%Y/%m/01') AS inceptiondate_month
    ,DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AS interval_1_month
    ,policy.policynumber AS policynumber
    FROM policy 
    WHERE 
    DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 1 MONTH, '%Y/%m/01') AND 
    currenthistoryflag='CURRENT' AND
    policy.umaproductsetupid='CENSAN'
	
SELECT DATE_FORMAT(inceptiondate, '%Y/%m/01') AS inceptiondate_month
    ,policy.policynumber AS policynumber
    FROM policy 
    WHERE 
    DATE_FORMAT(inceptiondate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AND 
    currenthistoryflag='CURRENT' AND
    policy.umaproductsetupid='CENSAN'

-- OWLS_all_policies_20210101_20210318

SELECT DATE_FORMAT(inceptiondate, '%Y/%m/01') AS inceptiondate_month
    ,DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01') AS interval_2_month
    ,policy.policynumber AS policynumber 
    FROM policy WHERE ( 
			(cancellationdate IS NULL AND DATE_FORMAT(inceptiondate, '%Y/%m/%d') < DATE_FORMAT(NOW(), '%Y/%m/01'))
			OR DATE_FORMAT(cancellationdate, '%Y/%m/01')=DATE_FORMAT(NOW() - INTERVAL 2 MONTH, '%Y/%m/01')
		) AND 
    currenthistoryflag='CURRENT' AND
    policy.umaproductsetupid='CENSAN'


  
