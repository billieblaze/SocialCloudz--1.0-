<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="contentType" default="">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfset var qryContentTypes = ''>
		<cfquery datasource="#this.datasource#" name="qryContentTypes">
	        select * from contenttype
	        where (communityID = 0 
	        or communityID = #arguments.communityID#)
	        <cfif arguments.contentType neq ''>
	        	and contentType = '#arguments.contentType#'
	        </cfif>
        </cfquery>
        <cfreturn qryContentTypes>
	</cffunction>
</cfcomponent>