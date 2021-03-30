SELECT   '01' as "Index",
              '01Number of policies in force at the end of the reporting period' as "Reporting Period",
	  "EffectiveMonth"::date as "Month",
          count(DISTINCT "PolicyId") as "Value"
          
                  FROM      "Kaelo_PBI"."PBIPolicyHistory"
WHERE      $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                    and "EffectiveMonth" between $P{StartDate} and $P{EndDate}
	           	    and "DependentType" = 'M'
	           	    and "CancelledBeforeResignation" <>1
group by "EffectiveMonth"
					
					union
					-----Gross Written Premium----

SELECT    '02' as "Index",
                '02State the Gross earned premium for the month at the end of the reporting period' as "Reporting Period"
				,"EffectiveMonth"::date as "Month"
                ,sum(case when cast(amount as  numeric)=0 and "DependentType"='M'
				then (SELECT   avg(cast(amount as  numeric)) as "Value"
FROM    "Kaelo_PBI"."PBIPolicyHistory" Inner Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                and "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) 
                and cast(amount as  numeric)>0
                and "CancelledBeforeResignation" <>1
				)::int else cast(amount as  numeric) end)  as "Value"
																					   
FROM    "Kaelo_PBI"."PBIPolicyHistory" Left Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode} and 
                "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
                and "CancelledBeforeResignation" <>1
		Group by "EffectiveMonth"
		
		
				union

--------new policy------

SELECT    '03' as "Index",
                '03Number of new policies issued in the reporting period'  as "Reporting Period",
                "EffectiveMonth"::date as "Month",
           COUNT(DISTINCT "PolicyId") as "Value"
FROM    "Kaelo_PBI"."PBIPolicyHistory"
WHERE   $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                 and "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
                 and "ActivePolicies" = 1
	             and "CancelledBeforeResignation" <>1
	             group by "EffectiveMonth"


union
-------new policy gross written------


SELECT   '04' as "Index", 
               '04State the total gross written premium for all new policies issued in the reporting period' as "Reporting Period"
				,"EffectiveMonth"::date as "Month"
                ,sum(case when cast(amount as  numeric)=0 and "DependentType"='M'
				then (SELECT   avg(cast(amount as  numeric)) as "Value"
FROM    "Kaelo_PBI"."PBIPolicyHistory" Left Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                and "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) 
                and cast(amount as  numeric)>0
                and  "ActivePolicies" = 1 and 
                "CancelledBeforeResignation" <>1
				)::int else cast(amount as  numeric) end)  as "Value"
																					   
FROM    "Kaelo_PBI"."PBIPolicyHistory" Inner Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode} and 
                "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) and 
          "ActivePolicies" = 1 and 
    "CancelledBeforeResignation" <>1
		Group by "EffectiveMonth"
		
		union
----------------------NTU----------------------

SELECT    '05' as "Index",
 '05NTU' as "Reporting Period",
              "EffectiveMonth"::date as "Month",
              COUNT(DISTINCT "PolicyId") AS "Value"
FROM       "Kaelo_PBI"."PBIPolicyHistory"
WHERE   $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                 and "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
                 and("CancelledBeforeResignation" =1)
			group by "EffectiveMonth"

union
--------------------	Premium for NTU	-----------------																  

SELECT   '06' as "Index",
 '06Gross Premium for NTU' as "Reporting Period"
				,"EffectiveMonth"::date as "Month"
                ,sum(case when cast(amount as  numeric)=0 and "DependentType"='M'
				then (SELECT   avg(cast(amount as  numeric)) as "Value"
FROM    "Kaelo_PBI"."PBIPolicyHistory" Inner Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                and "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) 
                and cast(amount as  numeric)>0
				and   ("CancelledBeforeResignation" =1) )::int else cast(amount as  numeric) end)  as "Value"
																					   
FROM    "Kaelo_PBI"."PBIPolicyHistory" Left Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode} and 
                "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) and 
          ("CancelledBeforeResignation" =1)
		Group by "EffectiveMonth"
		
		union
--------------------------Policy Lapsed------------------

SELECT  '07' as "Index",  
        '07Number of policies lapsed during the reporting period' as "Reporting Period",
        "ResignationMonthAudit"::date as "Month",
	    sum( case when (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) then 1 else 0 end) as "Value"
FROM      "Kaelo_PBI"."vwPBIPolicyHistoryForCBR"
WHERE    $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
         and "EffectiveMonth" between ($P{StartDate}::date - '1 month'::interval) and ($P{EndDate}::date - '1 month'::interval)
	     and "ResignationMonthAudit" between $P{StartDate} and $P{EndDate} 
	     and "DependentType" = 'M'
group by "ResignationMonthAudit"

union
--------------------	Premium for Policy Lapsed	-----------------																  

SELECT   '08' as "Index",
 '08Gross Premium for lapsed policies during the reporting period' as "Reporting Period"
				,   "ResignationMonthAudit"::date as "Month"
                ,sum(case when cast(amount as  numeric)=0 and "DependentType"='M' and (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) 
				then (SELECT   avg(cast(amount as  numeric)) as "Value"
FROM   "Kaelo_PBI"."vwPBIPolicyHistoryForCBR" Inner Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                and "EffectiveMonth" between ($P{StartDate}::date - '1 month'::interval) and ($P{EndDate}::date - '1 month'::interval)
	            and "ResignationMonthAudit" between $P{StartDate} and $P{EndDate}
                and cast(amount as  numeric)>0
				)::int else ((CASE WHEN (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) THEN (cast(amount as  numeric)) else 0 END)) end)  as "Value"
																					   
FROM    "Kaelo_PBI"."vwPBIPolicyHistoryForCBR" Left Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode} 
         and "EffectiveMonth" between ($P{StartDate}::date - '1 month'::interval) and ($P{EndDate}::date - '1 month'::interval)
	     and "ResignationMonthAudit" between $P{StartDate} and $P{EndDate}
group by "ResignationMonthAudit"
		
			union

-------------------------policies lapsed during the reporting period because of Non Payment-------------------------------------------------------------


SELECT    '09' as "Index",
 '09policies lapsed during the reporting period because of Non Payment' as "Reporting Period",
	  "EffectiveMonth"::date as "Month",
	  sum( case when (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) then 1 else 0 end) as "Value"


                  FROM      "Kaelo_PBI"."PBIPolicyHistory"
WHERE      $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                    and "EffectiveMonth" between $P{StartDate} and $P{EndDate}
	            and "DependentType" = 'M'
                    and "PolicyCancellationDate" between $P{StartDate} and $P{EndDate}
                    and "ResignationCode" IN ('A','R')  
				group by "EffectiveMonth"

union
--------------------	Premium for Non Policy Lapsed	-----------------																  

SELECT   '10' as "Index",
 '10Gross Premium for policies lapsed during the reporting period because of Non Payment' as "Reporting Period"
				,"EffectiveMonth"::date as "Month"
                ,sum(case when cast(amount as  numeric)=0 and "DependentType"='M' and (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) 
				then (SELECT   avg(cast(amount as  numeric)) as "Value"
FROM    "Kaelo_PBI"."PBIPolicyHistory" Inner Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                and "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) 
                and cast(amount as  numeric)>0
				and   "PolicyCancellationDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
                and "ResignationCode" IN ('A','R')
				)::int else ((CASE WHEN (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) THEN (cast(amount as  numeric)) else 0 END)) end)  as "Value"
																					   
FROM    "Kaelo_PBI"."PBIPolicyHistory" Left Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode} and 
                "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) and 
          "PolicyCancellationDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
          and "ResignationCode" IN ('A','R')
		Group by "EffectiveMonth"
		
		union
		
		------------------NON count---------------------------
		
		(with cte as (
	SELECT     
sum( case when (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) then 1 else 0 end) as count1,
"EffectiveMonth"

                  FROM      "Kaelo_PBI"."PBIPolicyHistory"
WHERE      $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                   and "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) and 
          "PolicyCancellationDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
	           	    and "DependentType" = 'M'
					group by "EffectiveMonth"
),cte2 as (
	SELECT     
sum( case when (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) then 1 else 0 end) as count2 ,
"EffectiveMonth"

                  FROM      "Kaelo_PBI"."PBIPolicyHistory"
WHERE      $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                    and "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) and 
                     "PolicyCancellationDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
	           	    and "DependentType" = 'M'
	                and "ResignationCode" IN ('A','R')
					group by "EffectiveMonth"
) select  '11' as "Index",
'11State the number of policies Cancelled by Policyholder during the reporting period' as "Reporting Period",
cte."EffectiveMonth"::date,
count1-count2 as "Value"
from cte left join cte2 on cte."EffectiveMonth"=cte2."EffectiveMonth"
		)
		
		-------------Gross Premium for policies Cancelled by Policyholder during the reporting period-------------
		union
		
(with cte as (   select
				"EffectiveMonth"
                ,sum(case when cast(amount as  numeric)=0 and "DependentType"='M' and (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) 
				then (SELECT   avg(cast(amount as  numeric)) as "Value"
FROM    "Kaelo_PBI"."PBIPolicyHistory" Inner Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                and "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) 
                and cast(amount as  numeric)>0
				and "PolicyCancellationDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
				)::int else ((CASE WHEN (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) THEN (cast(amount as  numeric)) else 0 END)) end)  as "Value1"
																					   
FROM    "Kaelo_PBI"."PBIPolicyHistory" Left Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode} and 
                "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) and 
          "PolicyCancellationDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
        
		Group by "EffectiveMonth"

),cte2 as (
	select
				"EffectiveMonth"
                ,sum(case when cast(amount as  numeric)=0 and "DependentType"='M' and (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) 
				then (SELECT   avg(cast(amount as  numeric)) as "Value"
FROM    "Kaelo_PBI"."PBIPolicyHistory" Inner Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}
                and "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) 
                and cast(amount as  numeric)>0
				and "PolicyCancellationDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
                and "ResignationCode" IN ('A','R')
				)::int else ((CASE WHEN (to_char(("EffectiveMonth"::date),'MM'))=(to_char(("PolicyCancellationDate"::date),'MM')) THEN (cast(amount as  numeric)) else 0 END)) end)  as "Value2"
																					   
FROM    "Kaelo_PBI"."PBIPolicyHistory" Left Join "Kaelo_PBI"."Rate" 
						  On "PolicyId" = replace(replace(replace("ms_pk",'"',''),')',''),'.','')::int
                          and "SchemeCode" = "scheme_code"::int
						  and "EffectiveMonth" = "effectivemonth"
						  and "Dependants"::int = dep_fk
WHERE  $X{IN,(cast("SchemeCode" as varchar)),SchemeCode} and 
                "EffectiveMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date)) and 
         "PolicyCancellationDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
        and "ResignationCode" IN ('A','R')
		Group by "EffectiveMonth"
          
) select '12' as "Index",
'12Gross Premium for Cancelled Policies by Policy Holder during Reporting Period' as "Reporting Period",
cte."EffectiveMonth"::date,
"Value1"-"Value2" as "Value"
from cte left join cte2 on cte."EffectiveMonth"=cte2."EffectiveMonth"	)

union
------------------Number of claims that were reported to the insurer in the reporting period------------------------------

SELECT   '13' as "Index",
 '13Number of claims that were reported to the insurer in the reporting period' as "Reporting Period",
           "IncurredMonth"::date as "Month",
                 COUNT( *)  as "Value"
FROM      "Kaelo_PBI"."PBIClaimsHistory"
WHERE    $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}  
                  and "IncurredMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
       group by "IncurredMonth"
       
       union
------------------Value of claims that were reported in the reporting period------------------------------ 

SELECT     '14' as "Index",
'14Value of claims that were reported in the reporting period' as "Reporting Period",
                   "IncurredMonth"::date as "Month",
                  SUM("Cftotalclaim") as "Value"
FROM       "Kaelo_PBI"."PBIClaimsHistory"
WHERE      $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}  
                    and "IncurredMonth" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
   group by "IncurredMonth"

union
------------------Number of claims that were paid in the reporting period------------------------------

SELECT '15' as "Index",   
 '15Number of claims that were paid in the reporting period' as "Reporting Period",
           CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date as "Month",
                 COUNT( *)  as "Value"
FROM      "Kaelo_PBI"."PBIClaimsHistory"
WHERE    $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}  
                  and "ClaimPayDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
                  and "ClaimStatusDesc" = 'Paid'
       group by CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date

union
------------------Value of Paid claims that were reported in the reporting period------------------------------ 

SELECT    '16' as "Index",
 '16Value of claims that were paid in the reporting period' as "Reporting Period",
                   CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date as "Month",
                  SUM("Cftotalclaim") as "Value"
FROM       "Kaelo_PBI"."PBIClaimsHistory"
WHERE      $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}  
                    and "ClaimPayDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
                    and "ClaimStatusDesc" = 'Paid'
   group by CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date

union
------------------Number of claims that were repudiated in the reporting period------------------------------

SELECT  '17' as "Index", 
              '17Number of claims that were repudiated in the reporting period' as "Reporting Period",
           CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date as "Month",
                 COUNT( *)  as "Value"
FROM      "Kaelo_PBI"."PBIClaimsHistory"
WHERE    $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}  
                  and "ClaimPayDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
                  and "ClaimStatusDesc" = 'Rejected'
       group by CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date


union
------------------Value of claims that were repudiated in the reporting period------------------------------ 

SELECT '18' as "Index",    
 '18Value of claims that were repudiated in the reporting period' as "Reporting Period",
                   CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date as "Month",
                  SUM("Cftotalclaim") as "Value"
FROM       "Kaelo_PBI"."PBIClaimsHistory"
WHERE      $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}  
                    and "ClaimPayDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
                    and "ClaimStatusDesc" = 'Rejected'
   group by CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date

union
------------------Number of claims outstanding at the end of the reporting period------------------------------

SELECT    '19' as "Index",
'19Number of claims outstanding at the end of the reporting period' as "Reporting Period",
           CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date as "Month",
                 ((COUNT( *) * (11))/100) as "Value"
FROM      "Kaelo_PBI"."PBIClaimsHistory"
WHERE    $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}  
                  and "ClaimPayDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
         
       group by CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date

union
------------------Value of claims outstanding at the end of the reporting period------------------------------ 

SELECT    '20' as "Index",
 '20Value of claims outstanding at the end of the reporting period' as "Reporting Period",
                   CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date as "Month",
                   ((SUM("Cftotalclaim")  * (11))/100) as "Value"
FROM       "Kaelo_PBI"."PBIClaimsHistory"
WHERE      $X{IN,(cast("SchemeCode" as varchar)),SchemeCode}  
                    and "ClaimPayDate" between (cast($P{StartDate} as date)) and (cast($P{EndDate} as date))
                    
   group by CAST( date_trunc('MONTH', CAST("ClaimPayDate" AS DATE)) AS TIMESTAMP)::date