<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="id">
		<cfargument name="container">
		<cfargument name="file">
		<cfargument name="fkType">
		<cfargument name="memberID">	
		<cfargument name="contentID">	
		<cfargument name="communityID">	
		<cfscript>
			return super.get('files', arguments, 'dateEntered desc');
		</cfscript>
	</cffunction>
	
   <cffunction name="save">
    	<cfargument name="data">
		<cfargument name="delete" default="1">
        <cfscript>
		if (arguments.delete eq 1){
			this.delete(argumentCollection = arguments.data);
		}
		return super.save('files', arguments.data);
		</cfscript>
    </cffunction>
	
	<cffunction name="delete">
		<cfargument name="fkType" default="">
		<cfargument name="contentID" default="">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfargument name="memberID" default="#request.session.memberID#">
		
		<Cfset var qGet = this.get(argumentCollection = arguments)>
		
		<cfif qGet.recordcount gt 0>
			<cfquery datasource="#this.datasource#">
			update files  set isDeleted = 1
			where fkType = '#arguments.fkType#'
		
				<Cfif arguments.contentID neq '' >	
					and contentID = '#arguments.contentID#'
				</cfif>
				
				<Cfif arguments.communityID neq '' >
					and communityID = '#arguments.communityID#'
				</cfif>		
			</cfquery>
		</cfif>
		<Cfreturn qGet>
	</cffunction>
	
	<cffunction name="check">
    	<cfargument name="communityID">
		<cfset var q_get = ''>
    	<cfquery datasource="#this.datasource#" name="q_get">
	        select ifnull(sum(filesize),0) as total 
			from files 
			where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
        </cfquery>
	    <cfreturn q_get.total>

    </cffunction>
	
</cfcomponent>