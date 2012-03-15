<cfif request.session.accesslevel gte 10> 
	<cfset edit ='yes'>
<cfelse>
	<cfset edit = 'no'>
</cfif>
<cf_dccom component="twform" instanceName="customform_#request.community.communityID#_#attributes.id#" edit="#edit#"></cf_dcCom>
    
    