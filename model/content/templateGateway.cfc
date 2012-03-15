<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="contentType">
		<cfset var qUISettings = ''>
		<cfquery datasource='#this.datasource#' name="qUISettings">
			select * from UISettings 
			where contentType = '#arguments.contentType#'
			and communityID in (0, #request.community.communityID#)
			order by communityID desc
			limit 1
		</cfquery>	
		<cfreturn qUISettings>
	</cffunction>
	
    <cffunction name="save">

	</cffunction>
	
	<cffunction name="delete">

	</cffunction>
</cfcomponent>