<cfcomponent extends="/model/baseGateway">
	<cffunction name="getActions">
		<cfargument name='list'>
		<cfquery datasource="#this.datasource#" name="types">
	        select distinct activityType, activityAction from activity
	        where activityType in (#listqualify(arguments.list,"'")#)
			and communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.community.communityID#">
			order by activityType, activityAction
        </cfquery>
        <cfreturn types>
    </cffunction>
	
	<cffunction name="getCount">
    	<cfargument name="range" default="day">
		<cfargument name="activityType">
		<cfargument name="activityAction">
		<cfargument name="groupBy">
		<cfargument name="startDate" default='#now()#'>
		<cfargument name="endDate" default='#dateformat(now(),'mm-dd-yyyy')#'>
		<cfargument name="communityID" default="#request.community.communityID#">
		
        <cfscript>
			if (arguments.range eq 'day'){
				startdate = '#dateformat(now(),'yyyy-mm-dd')# 00:00:00.0';
				endDate = '#now()#';
			} else if (arguments.range eq 'month'){
				startdate = '#year(now())#-#month(now())#-1 00:00:00.0';
				endDate = '#now()#';
			}
			
			startdate = '#dateformat(startDate,'yyyy-mm-dd')# 00:00:00.0';
			endDate = '#dateformat(endDate,'yyyy-mm-dd')# 23:59:59.9';
        </cfscript>

    	<cfquery datasource="#this.datasource#" name="q_get">
        select count(id) as views, 
			<cfif arguments.groupby neq ''>
				<cfif arguments.groupBy eq 'hour'>
					date_Format(dateEntered,'%b-%e %l%p') as dateEntered
				<cfelseif arguments.groupBy eq 'day'>
					date_Format(dateEntered,'%m-%e-%Y') as dateEntered
				<cfelseif arguments.groupBy eq 'month'>
					date_Format(dateEntered,'%m-%Y') as dateEntered
				<cfelseif arguments.groupBy eq 'year'>
					date_Format(dateEntered,'%Y') as dateEntered
				</cfif>
			<cfelse>
				dateEntered
			</cfif>
		from activity 
		where communityID = #arguments.communityID#
        and dateEntered between '#startDate#' and '#endDate#'
        and activityType = '#urldecode(arguments.activityType)#'
		and activityAction = '#urldecode(arguments.activityAction)#'
		
		<cfif arguments.groupby neq ''>
			<cfif arguments.groupby eq 'hour'>
			group by month(dateEntered), day(dateEntered), year(dateEntered), hour(dateEntered)
			<cfelseif arguments.groupby eq 'day'>
			group by month(dateEntered), day(dateEntered), year(dateEntered)
			<cfelseif arguments.groupby eq 'month'>
			group by month(dateEntered), year(dateEntered)
			<cfelseif arguments.groupby eq 'year'>
			group by year(dateEntered)
			</cfif>	
		</cfif>
		</cfquery>
        <cfreturn q_get>
	</cffunction>

	<cffunction name="get" access="public" returntype="query">
		<cfargument name="activityType">
		<cfargument name="activityAction">
		<cfargument name="contentType">
		<cfargument name="contentID">
		<cfargument name="visitorID">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfscript>
			return super.get('activity', arguments);		
		</cfscript>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="visitorID" default="#cookie.visitorID#">
        <cfargument name="viewID" default="#request.stats.viewID#">
        <cfargument name="activityType">
        <cfargument name="activityAction">
        <cfargument name="contentID" default="">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfargument name="memberID" default="#request.session.memberID#">

		<cfscript>
			arguments.dateEntered = now();
			return super.save('activity', arguments);
		</cfscript>

	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="id">
		<cfscript>
			return super.delete('activity', arguments);
		</cfscript>
	</cffunction>
	
	<cffunction name="getRecentActivity">
	<cfargument name="limit" default="">		
	<cfargument name="communityID" default="#request.community.communityID#">
		
		<cfquery datasource='#this.datasource#' name="qActivity">
			SELECT a.dateEntered, a.activityType, a.activityAction, contentID, a.memberid FROM activity a
			inner join activityType at on at.activityType = a.activityType
			inner join activityAction aa on aa.activityType = at.id and aa.action = a.activityAction
			inner join visitor v on v.visitorID = a.visitorID
			where a.communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.community.communityID#">
 				and aa.displayInRecentActivity = 1 
			order by a.dateEntered desc

			<cfif arguments.limit neq ''>
				limit <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.limit#">

			</cfif>
		</cfquery>
		<cfset qResults = application.members.joinmemberdata(qActivity)>
		<cfreturn qResults>  
	</cffunction>
	
</cfcomponent>