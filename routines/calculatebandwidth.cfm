<!--- Calculate Bandwidth per site --->
<cfquery datasource="#application.database.statistics#" name="get">
	select id, host,referrer,size from log 
    where calculated = 0
	
order by id 
limit 2500
</cfquery>
<cfdump var='#get#'>



<cfloop query="get">
	<cfset data.host = replace(get.host,'http://', '')>
	<cfif host contains 'assets.socialcloudz.com'>
		<cfset data.host = replace(get.referrer,'http://', '')>
		<cfset data.host = listfirst(data.host,'/')>
		<cfif listlen(data.host,'.') eq 2>
			<cfset data.host = 'www.#data.host#'>
		</cfif>
	<cfelse>
	    	<cfif listlen(data.host,'.') eq 2>
			<cfset data.host = 'www.#data.host#'>
		<cfelse>
			<cfset data.host = data.host>
		</cfif>
	</cfif>
    <cfset data.size = get.size>
    <cfset data2.id = get.id>

    <cfscript>
		//TODO: ticket ##970 - this needs to get updated, taking into consideration the new community parenting scheme
	if(data.host neq '-' 
		and data.host does not contain 'assets.socialcloudz.com'
		and get.referrer does not contain 'assets.socialcloudz.com' 
		and get.host neq 'localhost'){
		if(data.host contains 'socialcloudz.com'){
			community = application.community.gateway.get(subdomain='#listfirst(data.host,'.')#');
		} else {
			community = application.community.gateway.get(url='#data.host#');
		}
	
		data.communityID = community.communityID;
		if(community.recordcount neq 0){
			application.server.bandwidth.save(data);
		}
	}
		
	</cfscript>
	<cfquery datasource="#application.database.statistics#">
	update log set calculated = 1 where id = #data2.id#
	</cfquery>


</cfloop>
