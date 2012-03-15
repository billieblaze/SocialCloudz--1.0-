<cfcomponent extends="/model/baseGateway">

    <cffunction name="get">
		<Cfargument name="commuityID">
		<cfargument name="ID">
		<cfargument name="name">

		<cfset var qGet = ''>
		<cfquery datasource="#this.datasource#" name="qGet">
			select * from emailTemplate
			where 1=1
			
			<cfif isdefined('arguments.editable') and arguments.editable eq 1>
				and (editable = 0 or editable = 1)
			<cfelse>
				and editable = 0
			</cfif>
			
			<!--- TODO: should allow for master template or the communities variant
			<cfif isdefined('arguments.communityID')>
				and communityID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.communityID#">
			</cfif>
			 --->
			
			<cfif isdefined('arguments.ID')>
				and id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ID#">
			</cfif>
			
			<cfif isdefined('arguments.name')>
				and name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">
			</cfif>
		</cfquery>
		<cfreturn qGet>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="datastruct">
		<cfscript>
		return 	super.save('emailTemplate', arguments.datastruct);
	    </cfscript>
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="ID">
		<cfscript>
		return super.delete('emailTemplate', arguments);
	    </cfscript>
	</cffunction>
	
</cfcomponent>