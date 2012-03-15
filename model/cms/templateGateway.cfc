<cfcomponent extends="../baseGateway">
	 <cffunction name="get">
    	<cfargument name="templateID" default="">
		<cfset var q_get = ''>
    	<cfquery datasource="#this.datasource#" name="q_get">
        	select * from template
            <cfif arguments.templateID neq ''>
	            where ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.templateID#">
            </cfif>
        </cfquery>
        <cfreturn q_get>
    </cffunction>

	<cffunction name='save'>
		<cfargument name="data">
		<cfscript>
			super.save('templateData',data, 'update');
		</cfscript>
	</cffunction>

	 <cffunction name="getData">
    	<cfargument name="templateID" default="">
		<cfset var q_get = ''>
    	<cfquery datasource="#this.datasource#" name="q_get">
        	select * from templateData
            where templateID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.templateID#">        
		</cfquery>
        <cfreturn q_get>
    </cffunction>
	
</cfcomponent>