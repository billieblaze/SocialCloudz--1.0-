<cfcomponent extends="../baseGateway">
    <cffunction name="get">
		<cfargument name="categoryID" default="0">
		<cfset var qCategory = ''>
	    <cfquery datasource="#this.datasource#" name="qCategory">
	       select * from communitycategories	
	       
	       <cfif isdefined('categoryID') and categoryID neq 0> 
	       where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#categoryID#">
		   </cfif>
	       
	       order by category
	    </cfquery>

		<cfreturn qCategory>

    </cffunction>

    <cffunction name="getCount" output="false">
		<cfargument name="categoryID" default="0">
		<cfargument name="parentID" default="0">
    	<cfset var qCategory = ''>
	    <cfquery datasource="#this.datasource#" name="qCategory">
	        select count(communityID) as count from community
		    where categoryid = <cfqueryparam cfsqltype="cf_sql_integer" value="#categoryID#">
			and directory = 1
			<cfif arguments.parentId neq 0>
				and parentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#parentID#">
			</cfif>
        </cfquery>

		<cfreturn qCategory.count>

    </cffunction>
</cfcomponent>