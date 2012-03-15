<cfcomponent extends="../baseGateway">

	 <cffunction name="get">
    	<cfargument name="communityID" default="#request.community.communityID#">
		<cfset var q_get = ''>
    	<cfquery datasource="#this.datasource#" name="q_get">
        	select m.*, mf.url as featureURL from menu m 
			left join menuFeatures mf on mf.id = m.feature
            where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
            order by sortorder
        </cfquery>
        <cfreturn q_Get>
    </cffunction>	
    
     <cffunction name="save">
    	<cfargument name="data">
        <cfscript>
			super.save('menu', arguments.data, 'update');
		</cfscript>
    </cffunction>

    <cffunction name="delete">
    	<cfargument name="communityID" default="#request.community.communityID#">
    	<cfquery datasource="#this.datasource#">
        	delete from menu 
			where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
        </cfquery>
    </cffunction>
	
	<cffunction name="getFeatures">
		<cfargument name="ID" default="">
    	<cfset var q_get="">
		<cfquery datasource="#this.datasource#" name="q_Get"> 
	        select * from menuFeatures 

	        <cfif arguments.ID neq ''>
	        	where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
	        </cfif>

			order by name
        </cfquery>
		<cfreturn q_get>
    </cffunction>

</cfcomponent>