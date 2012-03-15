<cfcomponent extends="../baseGateway">
 	<cffunction name="get">
		<cfargument name="ID" default="">
		<cfargument name="url" default="">
		<cfargument name="communityID" default="#request.community.communityID#">	
		<cfargument name="sort" default="">
		<cfargument name="limit" default="0">
		<cfargument name="rows" default="">
		<cfargument name="page" default="1">
		<cfargument name="countOnly" default="0">
		<cfscript>
			var qry = '';
			if (arguments.rows neq ''){ arguments.limit = arguments.rows;}
			if (arguments.page eq '') {arguments.page = 1;}
			if (isdefined('arguments.limit')) startrow = arguments.page * arguments.limit - arguments.limit;
		</cfscript>
		<cfquery name="qry" datasource="#this.datasource#">
			select 
			<cfif arguments.countOnly eq 0>
			* 
			<cfelse>
			count(id) as count
			</cfif>
			from cmsPages 
			where 1=1
			
			<cfif arguments.url neq ''>
				and url = '#arguments.url#'
			</cfif>
			
			<cfif arguments.id neq ''>
				and ID = '#arguments.id#'
			</cfif>

			<cfif arguments.communityid neq ''>
				and communityID = '#arguments.communityID#'
			</cfif>
			
			<cfif arguments.countOnly neq 1 and arguments.limit neq 0 and arguments.limit neq ''>limit <cfqueryparam cfsqltype="cf_sql_integer" value="#startrow#">
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.limit#">
			</cfif>
		</cfquery>
		<cfreturn qry>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="dataStruct">
		<cfset var data = ''>
		<cfparam name="arguments.datastruct.communityID" default='#request.community.communityID#'>
		<cfscript>
			if (not isdefined('arguments.datastruct.url')){
				arguments.datastruct.url = '#reReplaceNoCase(arguments.datastruct.title, "[^a-z0-9]", "_", "all")#';
			}
		</cfscript>

        <cfif isdefineD('arguments.datastruct.id') and arguments.datastruct.id neq '' and arguments.datastruct.id neq 0>
			<cfset data = this.get(id=arguments.datastruct.id)>

	        <cfquery datasource="#this.datasource#">
	        	update modulepage 
	            set page = '#arguments.datastruct.url#'
	            where page = '#data.url#'
	            and communityID = '#request.community.communityID#'
	        </cfquery>
	        <cfquery datasource="#this.datasource#">
	        	update layout 
	            set page = '#arguments.datastruct.url#'
	            where page = '#data.url#'
	            and communityID = '#request.community.communityID#'
	        </cfquery>

        </cfif>
        <cfscript>
			arguments.datastruct.dateUpdated = now();
			return super.save('cmsPages', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="id">
		<cfargument name="communityID" default="#request.community.communityID#">	
		<cfscript>
		super.delete('cmsPages', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>