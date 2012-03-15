<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="memberID" default="#request.session.memberID#">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfargument name="viewed" default="0">
		
		<cfscript>
			return super.get('notifications', arguments);
		</cfscript>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="Datastruct">
		<cfscript>
			arguments.datastruct.communityID = request.community.communityID;
			arguments.datastruct.dateEntered = createODBCDateTime(application.timezone.castFromServer(now(), application.community.settings.getValue('timezone')));
			super.save('notifications', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="ID" default="0">
		<cfargument name="memberID" default="#request.session.memberID#">
		<cfargument name="communityID" default="#request.community.communityID#">
		
		<cfquery datasource="#this.datasource#"> 
			update notifications 
			set `viewed` = 1 
			where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			and memberID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
			and communityID=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
		</cfquery>
	</cffunction>
</cfcomponent>