SELECT  
case when "mem-num" is null then 'N' else 'Y' end as "Registered Chronic",
c.scheme_fk,
scheme_name, 
ms_fk,
 c.dep_fk as dependent_no,
upper(dep_type) as dep_type,
gender,
b.first_name,
b.surname,
birth_date,
 claim_fk,
 claim_date,
 pr_fk as practice_no,
pr_descr as doctor_name,
 pr_type,
pr_type_descr, 
pr_group_descr,
 tariff_fk, 
claim_type, 
c.claim_code,
description as claim_code_description,
icd10_fk,
icd10_descr,
 three_letter_level as icd10_group_description,
 auth_fk, 
units, 
pmb, 
(Case WHEN c.claim_code = 'K' THEN 'Y' 
		WHEN c.claim_code IN ('C','P') AND c.claim_code = '80' THEN 'Y' 
		WHEN pr_type = '62' AND c.claim_code = '31' THEN 'Y'
		WHEN pr_type IN ('87','88','90') THEN 'Y'
		ELSE 'N' 
	END) as In_Hospital_Indicator,

claimed_amount, 
benefit_amount,
(case when (claimed_amount > 0 AND benefit_amount = 0) and paid_date is not null then 'Rejected' else
case when ((claimed_amount > 0 AND benefit_amount > 0)) and paid_date is not null then 'Paid' else
case when claimed_amount> 0 and benefit_amount > 0  and paid_date is null and assess_date is not null then 'Pending' else 'Unpaid' end end end ) as "ClaimsStatus",
rcvd_date,
assess_date, 
paid_date,
tariff_amount,
 discount,
owes, 
override,
 gen_no,
 suspend_until,
 suspended,
 assessed_datetime,
b.comp_fk,
b.comp_name ,
coalesce(g.comp_name,'none') as group_name,
broker_fk,
broker_descr

	FROM mipbi_dbo.tf_claim_head_curr c
	left join mipst_dbo.tsd_ccdesc cc on c.claim_code=cc.claim_code and scheme_fk=scheme_code::int
	left join mipst_dbo.tsd_icd10 on icd10_fk=icd10_pk 
	left join mipst_dbo.tsd_practice on pr_fk=pr_pk
	left join mipst_dbo.tsd_provider on pr_type_pk=pr_type
	inner join mipbi_dbo.td_beneficiary b on ms_pk=ms_fk and b.scheme_fk=c.scheme_fk and b.dep_fk=c.dep_fk
                 left join mipst_dbo.tsd_ben_memcom g  on  (case when b.group_code='0' then b.comp_fk else b.group_code end)=g.comp_fk
                 left join mipst_dbo.tsd_broker on broker_pk=broker_fk
                 left join (select distinct
"mem-num",
dependant
from
mipst_dbo.tsd_depcond A
inner JOIN
mipst_dbo.tsd_condition_3 B on (A."cond-code" = B.cond_fk)
where
cdl_fk is not null
and "reference-auth-num" <> ''
and cdl_fk <> '' AND cond_descr <> ''
group by
"mem-num",
dependant) a on "mem-num"=ms_fk and
dependant=c.dep_fk
	where claim_date>=20200101 --and ms_fk='026927';