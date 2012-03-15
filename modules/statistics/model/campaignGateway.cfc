<cfcomponent extends="/model/baseGateway">
	<cffunction name="get">
			<cfargument name="sort" default="dateEntered">
  		<cfargument name="countonly" default="">
    	<cfargument name="page" default="1">
   		<cfargument name="limit" default="0">
		<cfscript>
			if (arguments.page eq '') {arguments.page = 1;}
			if (isdefined('arguments.limit')) startrow = arguments.page * arguments.limit - arguments.limit;
		</cfscript>

	    <cfquery datasource="#variables.datasource#" name="Campaigns">
			<cfif arguments.countonly eq 1>
				SELECT	count(id) as count
			<cfelse>
		
      			SELECT (SELECT COUNT(id)
				 FROM activity a
				 left join visitor v on v.visitorID = a.visitorID
		         WHERE activityType = 'Campaign'
		   		 and activityAction = 'Visit'
		         and contentID = c.id
		         AND ifnull(v.memberID,0) = 0) AS visitors,
				c.*, 'http://#cgi.http_host#?t='+id as url
			</cfif>
			FROM campaigns c
			where c.communityID = '#request.community.communityID#'
			order By #arguments.sort#
		
			<cfif arguments.limit neq 0 and arguments.limit neq ''>limit #startrow#, #arguments.limit#</cfif>
		</cfquery>

    <cfreturn campaigns>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="datastruct">
		<cfscript>
			arguments.datastruct.communityID = request.community.communityID;
			return super.get('campaigns', arguments.datastruct);
		</cfscript>

	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="id">
		<cfscript>
			return super.delete('campaigns', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>