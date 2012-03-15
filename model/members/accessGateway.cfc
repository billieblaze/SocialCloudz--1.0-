<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="memberID">
		<cfargument name="communityID">
		<cfset var check = ''>
		<cfquery datasource="#this.datasource#" name="check">
    		select accesslevel from access
       		where memberID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
	     	and  communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
    	</cfquery>
		<cfreturn check>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="dataStruct">
	    <cfscript>
			if (not isdefined('arguments.datastruct.communityID')){
				arguments.datastruct.communityID = request.community.communityID;
			}		    
	    	super.save('access', arguments.datastruct);
		</cfscript>
	</cffunction>
	
</cfcomponent>