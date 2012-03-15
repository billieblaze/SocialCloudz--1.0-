<cfcomponent extends="/model/baseGateway">
	<cffunction name="get">
		<cfargument name="id">
		<cfargument name="fkType">
		<cfargument name="fkID">
		<cfargument name="visitorID">
		<cfargument name="sort" default="d.id asc">
		
		<cfset var qGetAudit = ''>

		<cfquery name="qGetAudit" datasource="#variables.instance.datasource#">
			select * from dataAudit d
			inner join views v on v.id = d.viewID
			where 1 = 1
			
			<cfif isdefined('arguments.id')>
			and id = #arguments.id#
			</cfif>
			
			<cfif isdefined('arguments.fkType')>
			and fkType = #arguments.fkType#
			</cfif>
			
			<cfif isdefined('arguments.fkID')>
			and fkID = #arguments.fkID#
			</cfif>
			
			<cfif isdefined('arguments.visitorID')>
			and visitorID = #arguments.visitorID#
			</cfif>
			order by #arguments.sort#
		</cfquery>
		
		<cfreturn qGetAudit>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="fkType">
		<cfargument name="fkID">
		<cfargument name="field">
		<cfargument name="visitorID">
		<cfargument name="originalValue">
		<cfargument name="newValue">
		<cfscript>
			arguments.dateUpdated = now();
			return super.save('dataAudit', arguments);
		</cfscript>
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="id">
		<cfscript>
			return super.delete('dataAudit', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>