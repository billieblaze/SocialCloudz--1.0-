<cfcomponent extends="../baseGateway">

	<cffunction name="get">
		<Cfset var q_get = ''>
    	<cfquery datasource="#this.datasource#" name="q_get">
        	select * from style
		 	where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.community.communityID#">
        	order by selector, attribute
        </cfquery>
       <cfreturn q_get>
    </cffunction>
	
	<cffunction name="save">
		<cfargument name="data">
		<cfscript>
			super.save('style',arguments.data, 'update');
		</cfscript>
	</cffunction>
	
    <cffunction name="delete">
		<cfargument name="communityID" default="#request.community.communityID#">
        <cfquery datasource="#this.datasource#">
	        delete from style
	        where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
	        </cfquery>
        <cfquery datasource="#this.datasource#">
	        delete from styleExtra
	        where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
        </cfquery>
	</cffunction>
	
	<cffunction name="getCSS">
		<Cfset var q_get = ''>
    	<cfquery name="q_get" datasource="#this.datasource#">
        	select extracss 
			from styleExtra 
			where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.community.communityID#">
        </cfquery>
        <cfreturn q_get.extracss>
    </cffunction>

    <cffunction name="saveCSS">
    	<cfargument name="extracss">
        <cfargument name="communityID" default="#request.community.communityID#">
        <cfscript>
			super.save('styleExtra', arguments);
		</cfscript>
    </cffunction>

	<cffunction name="getElements">
		<cfargument name="itemID" defualt="">
		<cfargument name="element" defualt="">
		<cfargument name="text" defualt="">
		
		<cfset var q_get = ''>	
		<cfquery datasource="community" name="q_get">
	        select * from styleElementList
	        where 1=1 
	        
	        <cfif arguments.itemID neq ''>
	        	and itemID = #arguments.itemID#
	        </cfif>
	        
	        <cfif arguments.element neq ''>
	        	and item = '#urldecode(arguments.element)#'
	        </cfif>
	        
	        <cfif arguments.text neq ''>
				and description = '#urldecode(arguments.text)#'
			</cfif>
			
			and advanced = 1
        </cfquery>	
		<cfreturn q_get>
	</cffunction>
	
	<cffunction name="getProperties">
		<cfargument name="ID">
		<cfset var q_get = ''>	
		<cfquery datasource="community" name="q_get">
	        select * from stylePropertyList
	        where elementID = #arguments.ID#
        </cfquery>	
		<cfreturn q_get>
	</cffunction>
</cfcomponent>