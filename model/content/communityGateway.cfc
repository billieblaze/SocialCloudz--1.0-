<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name='contentid'>
		<cfscript>
			return super.get('community',arguments);
		</cfscript>
	</cffunction>
	
    <cffunction name="save" hint="I transpose a list of communities selected for a content entry">
		<cfargument name="contentID">
		<cfargument name="communityList">
		<cfset var i = ''>
	    <cfloop list="#arguments.communityList#" index="i">
			<cfset this.delete(arguments.contentID, i)>
			<cfquery datasource="#this.datasource#">
		        insert into community
		        (contentID,  communityID)
		        values
		        ('#arguments.contentID#',  '#i#')
	        </cfquery>
	    </cfloop>
	</cffunction>
	
	<cffunction name="delete">
	 	<cfargument name="contentID">
	 	<cfargument name="communityID">
	    <cfquery datasource="#this.datasource#">
		    delete from community
		    where 1=1 
		    and contentID = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="35" value="#arguments.contentId#">
		    
		    <cfif isdefined('arguments.communityID')>
		    and communityID = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="35" value="#arguments.communityId#">
		    </cfif>
	    </cfquery>
	</cffunction>
</cfcomponent>