<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="sourceID">
		<cfargument name="targetID">
		<cfset var check = ''>
		<cfquery datasource="#this.datasource#" name="check">
	    	select isnull(count(*),0) as value from blocks
	       	where (sourceID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sourceID#"> and targetID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.targetID#">)
	        or (sourceID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.targetID#"> and targetID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sourceID#">)
	    </cfquery>
	
	    <cfreturn check.value>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="sourceID">
		<cfargument name="targetID">
	
		<cfscript>
		super.save('block', arguments);
	    </cfscript>

	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="sourceID">
		<cfargument name="targetID">
	
		<cfscript>
		super.delete('block', arguments);
	    </cfscript>
	</cffunction>
	
</cfcomponent>