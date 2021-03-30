
PolicyPerBrokerLive&Pending
SELECT DISTINCT 
policy.policynumber AS policy_policynumber,
policy.alternativepolicynumber AS policy_alternativepolicynumber,
policy.umaid AS policy_umaid,
productsetup.productsetupname AS productsetup_productsetupname,
policy.concatdistinctactiveoptionname as optionname,
policy.inceptiondate AS policy_inceptiondate,
policy.cancellationdate As policy_cancellationdate,
policy.status AS policy_status,
policy.createduser AS policy_createduser,
policy.createddate AS policy_createddate,
client.firstname AS client_firstname,
client.surname AS client_surname,
client.idnumber AS client_idnumber,
client.age AS client_age,
client.residentialaddress AS client_residentialaddress,
client.residentialsuburb AS client_residentialsuburb,
client.residentialcode AS client_residentialcode,
client.postaladdress AS client_postaladdress,
client.postalsuburb AS client_postalsuburb,
client.postalcode AS client_postalcode,
client.emailaddress AS client_emailaddress,
client.cellnumber AS client_cellnumber,
intermediarygroup.intermediarygroupname AS intermediarygroup_intermediarygroupname,
salesperson.salespersonname AS salesperson_salespersonname,
policy.paymentmethod AS policy_paymentmethod,
ifnull(policygroup.policygroupname,'Individual') AS policygroup_policygroupname,
policy.concatdistinctactiveoptionname AS productoptionsetup_productoptionname,
policy.grosspremium AS policy_grosspremium,
policy.totalfees AS policy_totalfees,
policy.totalpremium AS policy_totalpremium,
policygroup.internalaccountmanager AS Administrator,
DATE_FORMAT(policy.createddate,'%Y/%m/01') as createdmonth


FROM policy,client,intermediarygroup,salesperson,policygroup,productsetup,productoptionsetup

WHERE 1=1
            and policy.status in ('Live','Pending Incept')
            and productoptionsetup.productoptionname = '$productoptionsetup.productoptionname$'
ORDER BY 
            policy.policynumber, productoptionsetup.productoptionname

PolicyPerBrokerCancelle&NTU

SELECT DISTINCT 
policy.policynumber AS policy_policynumber,
policy.alternativepolicynumber AS policy_alternativepolicynumber,
policy.umaid AS policy_umaid,
productsetup.productsetupname AS productsetup_productsetupname,
policy.concatdistinctactiveoptionname as optionname,
policy.inceptiondate AS policy_inceptiondate,
policy.cancellationdate As policy_cancellationdate,
policy.status AS policy_status,
policy.createduser AS policy_createduser,
policy.createddate AS policy_createddate,
client.firstname AS client_firstname,
client.surname AS client_surname,
client.idnumber AS client_idnumber,
client.age AS client_age,
client.residentialaddress AS client_residentialaddress,
client.residentialsuburb AS client_residentialsuburb,
client.residentialcode AS client_residentialcode,
client.postaladdress AS client_postaladdress,
client.postalsuburb AS client_postalsuburb,
client.postalcode AS client_postalcode,
client.emailaddress AS client_emailaddress,
client.cellnumber AS client_cellnumber,
intermediarygroup.intermediarygroupname AS intermediarygroup_intermediarygroupname,
salesperson.salespersonname AS salesperson_salespersonname,
policy.paymentmethod AS policy_paymentmethod,
ifnull(policygroup.policygroupname,'Individual') AS policygroup_policygroupname,
policy.concatdistinctactiveoptionname AS productoptionsetup_productoptionname,
policy.grosspremium AS policy_grosspremium,
policy.totalfees AS policy_totalfees,
policy.totalpremium AS policy_totalpremium,
DATE_FORMAT(policy.createddate,'%Y/%m/01') as createdmonth


FROM policy,client,intermediarygroup,salesperson,policygroup,productsetup

WHERE 1=1
            and policy.status in ('Cancelled','Not taken up')
            AND productsetup.productsetupname = '$Product;;autocomplete select;productsetup.productsetupname$'

ClaimsReceivedPastWeek

select 
claim.claimnumber as 'Claim Number',
claim.createddate as 'Created Date',
claim.createduser as 'Created User',
claim.incidentdate as 'Date of Loss',
claim.notificationdate as 'Notification Date',
policy.inceptiondate as 'Policy Inception Date',
client.clientname as 'Principal Member',
productsetup.productsetupname,
policy.concatdistinctactiveoptionname,
claim.manualstatus as 'Status',
claim.decisionstatus as 'Progress',
SUM(claiminsureditem.reserve) 'Original Reserve',
SUM(claiminsureditem.calculatednetreserve - claiminsureditem.previouslypaid) as 'Current Reserve',
SUM(claiminsureditem.previouslypaid) as 'Total Payments',
policygroup.policygroupname as 'PolicyGroup'

from claim,policy,policygroup,client,claiminsureditem,productsetup

where 1=1
AND DATE_FORMAT(claim.createddate,'%Y/%m/%d')>='$Created From Date:;Date;text date$'
AND DATE_FORMAT(claim.createddate,'%Y/%m/%d')<='$Created To Date:;Date;text date$'
group by claim.claimnumber
order by claim.claimnumber asc


ClaimsPaid

select	
	fingl.posteddate,
	policy.policynumber,
	claim.claimnumber,
	uma.umaname,
	'Local' as localforeign,
	'Personal Lines' as product,
	myifnull(claim.bankaccountholder,policy.bankaccountholder) as payeename,
	claim.status,
	claiminsureditem.paymentdate,
	claiminsureditem.benefittiers,
	claim.decisionrejectionreason,
	claim.notificationdate,
	claim.createddate,
	claim.incidentdate,
	CAST(SUM(fingl.amount) AS DECIMAL(16,2)) as amountwithvat,
	date_format(claim.createddate,'%Y/%m/%d') as claimcreateddate,
	productsetup.productsetupname,
	policy.concatdistinctactiveoptionname as 'option',
	intermediarygroup.intermediarygroupname,
	salesperson.salespersonname,
	policy.inceptiondate,
	policy.paymentmethod,
	client.clientname,
	client.idnumber,
	client.age,
	insureditem.insureditemname,
	insureditem.lifeidnumber,
	insureditem.liferelationshiptoprincipal,
	policygroup.policygroupname
	
from fingl,policy,claim,uma,intermediarygroup,salesperson,productsetup,policygroup,client,insureditem, claiminsureditem 
	
	
where 1=1
and fingl.posteddate>='$From Date (Fiscal Period):;;text date$'
and fingl.posteddate<='$To Date (Fiscal Period):;;text date$' 
and claim.currenthistoryflag = 'CURRENT'
and uma.currenthistoryflag = 'CURRENT'
and intermediarygroup.currenthistoryflag = 'CURRENT'
and salesperson.currenthistoryflag = 'CURRENT'
and productsetup.currenthistoryflag = 'CURRENT'
and policygroup.currenthistoryflag = 'CURRENT'
and client.currenthistoryflag = 'CURRENT'
and insureditem.currenthistoryflag = 'CURRENT'
group by	
	fingl.posteddate,
	fingl.policynumber,
	fingl.claimnumber
