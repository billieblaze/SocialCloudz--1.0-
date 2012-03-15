<cfcomponent extends="../baseGateway">
	
     <cffunction name="get">
     	<cfargument name="subdomain" default="">
		<cfargument name="domain" default="">
	    <cfargument name="communityID" default="">
     	<cfargument name="adminID" default="">
	    <cfargument name="url" default="">
     	<cfargument name="private" default="">
     	<cfargument name="directory" default="">
		<cfargument name="categoryID" default="">
		<cfargument name="page" default="1">
		<cfargument name="limit" default="0">
     	<cfargument name="countonly" default="">
		<cfargument name="parentId" deafult="">
		<cfargument name="domainID" deafult="">

		<cfargument name="search" deafult="">

		<cfscript>
			var community = '';
			if (arguments.page eq '') {arguments.page = 1;}
			if (isdefined('arguments.limit')) startrow = arguments.page * arguments.limit - arguments.limit;
		</cfscript>

		<cfquery datasource="#this.datasource#" name="community">
		 	select 
		 		<cfif arguments.countonly neq ''>
	    			COUNT(c.communityID) as count
		     	<cfelse>
		     		*, d.name as domain
				</cfif> 
			from community c 
			left join 	communitycategories cc on c.categoryid = cc.id	
			inner join domains d on d.domainID = c.domainID
		    where 1=1

	        <cfif arguments.domain neq ''>
		        and d.name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Domain#">
		    </cfif>

		    <cfif arguments.subdomain neq ''>
		        and subdomain = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.subDomain#">
		    </cfif>
		 
		    <cfif arguments.communityID neq ''>
		      	and c.communityID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
		    </cfif>
			
		    <cfif arguments.categoryID neq ''>
		       	and c.categoryID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.categoryID#">
		    </cfif>
		
		    <cfif arguments.adminID neq ''>
		      	and c.adminID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.adminID#">
		    </cfif>
	
			<cfif arguments.parentID neq ''>
		      	and c.parentID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.parentID#">
		    </cfif>
		    
		    <cfif arguments.domainID neq ''>
		      	and c.domainID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.domainID#">
		    </cfif>
		    
		    <cfif arguments.private neq ''>
		       	and c.private = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.private#">
		    </cfif>
		
		    <cfif arguments.directory neq ''>
		       	and directory = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.directory#">
		    </cfif>

		    <cfif arguments.search neq ''>
		       	and site like  <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.search#">
		    </cfif>		

			<cfif arguments.limit neq 0 and arguments.limit neq ''>limit #startrow#, #arguments.limit#</cfif>
		
		</cfquery>
		  
		<cfreturn community>

     </cffunction>
	
	
	<cffunction name="save">
    	<cfargument name="dataStruct">
		<cfscript>
			return super.save('community', arguments.datastruct);		
		</cfscript>
    </cffunction>


</cfcomponent>