<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="memberID">
		<cfargument name="communityID" default="#request.community.communityID#">
		<Cfset var qGet = ''>
		<cfquery datasource="#this.datasource#" name="qGet">
			select ma.*, pt.typeID, pt.name from  membersaccount ma
			left join profileTypes pt  on pt.typeID = ma.profileType
			where ma.memberID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
		   	
		   	<cfif arguments.communityID neq ''>		
				and ma.communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
			</cfif>
			
		</cfquery>
		<cfreturn qGet>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="datastruct">
    	<cfscript>
			if (not isdefined('arguments.datastruct.communityID')){
				arguments.datastruct.communityID = request.community.communityID;
			}
    		super.save('membersaccount', arguments.datastruct);
		</cfscript>
	</cffunction>	
	
	<cffunction name="delete">
		<cfargument name="memberID">
		<cfargument name="communityID" default="#request.community.communityID#">
	
		<cfscript>
			super.delete('membersaccount', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>