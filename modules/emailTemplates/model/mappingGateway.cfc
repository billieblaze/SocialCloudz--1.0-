<cfcomponent extends="/model/baseGateway">
    <cffunction name="get">
		<cfargument name="ID">
		<cfargument name="emailID">
	    <cfset var qGet = ''>
		<cfquery datasource="#this.datasource#" name="qGet">
			select * from emailMapping em
			inner join emailTag et on em.tagID = et.id
			where 1 = 1
			
			<cfif isdefined('arguments.ID')>
				and em.ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ID#">
			</cfif>
			
			<cfif isdefined('arguments.emailID')>
				and em.emailID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emailID#">
			</cfif>
		</cfquery>
		<cfreturn qGet>
	</cffunction>

    <cffunction name="save">
		<cfargument name="datastruct">
	
		<cfscript>
		return super.save('emailMapping', arguments.datastruct);
	    </cfscript>

	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="ID">
	
		<cfscript>
		return super.delete('emailMapping', arguments);
	    </cfscript>
	</cffunction>
	
</cfcomponent>