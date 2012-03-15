<cfcomponent extends="../baseGateway">
	<cffunction name="get">

	</cffunction>
	
    <cffunction name="save">
		<cfargument name="memberID">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfargument name="dateExpires" default="">
		<cfargument name="item" default="">
		<cfscript>
			super.save('ban', arguments);
	    </cfscript>
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="memberID">
		<cfargument name="communityID" default="#request.community.communityID#">
	
		<cfscript>
			super.delete('ban', arguments);
	    </cfscript>
	</cffunction>

</cfcomponent>