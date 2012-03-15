<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="sourceID"  default="#request.session.memberID#">
		<cfargument name="targetID">
		<cfset var check = ''>
		<cfquery datasource="#this.datasource#" name="check">
	    	select distinct sourceid, targetid, approved from friends
	       	where (sourceID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sourceID#"> and targetID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.targetID#">)
	        or (sourceID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.targetID#"> and targetID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sourceID#">)
	    </cfquery>
		<cfreturn check>
	</cffunction>
	
	<cffunction name="list">
		<cfargument name="memberID" default="#request.session.memberid#">
		<cfargument name="online" default="0">
		<cfargument name="limit" default="">
		<cfargument name="approved" default="1">
		<Cfargument name="countOnly" default="0">
		<cfset var qry = ''>
		<cfquery datasource="#this.datasource#" name="qry">
		    select distinct m.memberid  from friends f
		    inner join members m on m.memberid = CASE f.sourceID WHEN  #arguments.memberID# THEN f.targetID ELSE  f.sourceID END
			inner join membersaccount ma on ma.memberID = m.memberID and (ma.communityID =#request.community.communityID# or ma.communityID in (select communityID from community.community where parentID = '#request.community.communityID#'))
			WHERE     (f.sourceID = #arguments.memberID#  OR  f.targetID = #arguments.memberID#)
	   	    and f.approved = #arguments.approved#
		    <cfif arguments.online eq 1>
		 	   and ma.online = 1
		    </cfif>
		   	order by m.memberid
			<cfif arguments.limit neq ''>limit #arguments.limit#</cfif>
	    </cfquery>
		<cfreturn qry>
	</cffunction>
	
   <cffunction name="save">
    	<cfargument name="sourceID" default="#request.session.memberID#">
    	<cfargument name="targetID">
    	<cfargument name="approved" default="0">

		<cfscript>
			super.save('friends', arguments);
	    </cfscript>
	</cffunction>
	
	<cffunction name="approve">
	    <cfargument name="sourceID">  
	    <cfargument name="approved">
	    <cfargument name="targetID" default="#request.session.memberID#">
	
	    <cfquery datasource="#this.datasource#">
			Update friends set approved = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.approved#">
			where (sourceID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sourceID#"> and targetID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.targetID#">) 
			or  (sourceID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.targetID#"> and targetID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sourceID#">)
	    </cfquery>
	</cffunction>

	<cffunction name="delete">
		<cfargument name="sourceID"  default="#request.session.memberID#">
		<cfargument name="targetID">

		<cfscript>
			super.delete('friends', arguments);
	    </cfscript>
	</cffunction>
</cfcomponent>