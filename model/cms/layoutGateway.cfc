<cfcomponent extends="../baseGateway">
    <cffunction name="get">
    	<cfargument name="page" default="">
   		<cfargument name="communityID" default="#request.community.communityID#">
        <cfargument name="returnType" default="struct">
				<Cfset var q_get = ''>
				<cfset var results = structNew()>
				<cfset var i = 0>
        <cfquery datasource="#this.datasource#" name="q_get">
	        select * from layout 
	        where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
	
	        <cfif arguments.page neq ''> 
			and  page = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.page#">
	        </cfif>
        </cfquery>

        <cfif arguments.returnType eq 'query'>
        	<cfreturn q_get>
        <cfelse>
	        <cfloop list="#q_get.columnlist#" index="i">
				<cfif evaluate("q_get.#i#") neq ''>	<cfset "results.#i#" = evaluate("q_get.#i#")></cfif>
			</cfloop>
			<cfreturn results>
		</cfif>
    </cffunction>
	
    <cffunction name="save">
        <cfargument name="datastruct">
		<cfargument name='communityID' default='#request.community.communityID#'>
				<Cfset var q_get = ''>
        <cfquery datasource="#this.datasource#">
	         delete from layout 
	         where page = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.datastruct.page#">
			 and communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
         </cfquery>
        <cfquery datasource="#this.datasource#" name="q_get">
	        insert into layout (`page`, `right`, `template`, `columns`, `communityID`)
	        values (
		        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.datastruct.page#">, 						
		        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.datastruct.right#">, 	
		        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.datastruct.template#">, 
		        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.datastruct.columns#">, 		
		        <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
	        );
        </cfquery>

       	<cfif arguments.datastruct.columns eq 1>
	        <cfquery datasource="#this.datasource#">
		        update modulepage 
		        set list = '1' 
		        where page = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.datastruct.page#">
			         and list in (2,3)  
		             and communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
	        </cfquery>
      	<cfelseif arguments.datastruct.columns eq 2>
	        <cfquery datasource="#this.datasource#">
		        update modulepage 
		        set list = '2' 
		        where page = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.datastruct.page#">
		  	 	and list = 3 and communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
		    </cfquery>
        </cfif>
		<Cfreturn 1>
    </cffunction> 
</cfcomponent>