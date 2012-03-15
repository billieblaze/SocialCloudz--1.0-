<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="ID" default="">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfargument name="active" default="1">
		<cfargument name="isVisible" default="1">
		<cfargument name="type" default="">
		<cfargument name="contentID" default="">
		
		<cfset var qGetGroup = ''>
		<cfquery name="qGetGroup" datasource='#this.datasource#'>
			select * from groups
			where 1 = 1 
			
			<cfif arguments.id neq ''>
			and id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfif>

			<cfif arguments.contentid neq ''>
			and contentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.contentid#">
			</cfif>
		
		</cfquery>
		<cfreturn qGetGroup>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="dataStruct">
	
		<cfscript>
		return super.save('groups', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="datastruct">

		<cfscript>
			arguments.datastruct.communityid = request.community.communityid;
			super.delete('groups', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name="mine">
		<cfargument name="memberID" default="#request.session.memberid#">
		<cfset var qMember = ''>
		<cfquery name="qMember" datasource="#this.datasource#">
			select g.contentID
			from  groupMember gm
			inner join groups g on g.id = gm.groupID 
			where gm.memberid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
		</cfquery>
	
		<cfreturn qMember>
		
	</cffunction>

	<cffunction name="getMembers">
		<cfargument name="groupID" default="">
		<cfargument name="contentID" default="">
		<cfset var qGetGroupMembers = ''>
		<cfquery name="qGetGroupMembers" datasource="#this.datasource#">
			select m.memberid, username, firstname, lastname
			from members m
			inner join groupMember gm on gm.memberID = m.memberID
			inner join groups g on g.id = gm.groupID 
			where 1=1 
			<cfif arguments.groupid neq ''> and g.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.groupID#"></cfif>
			<cfif arguments.contentid neq ''> and g.contentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.contentID#"></cfif>
		</cfquery>
		<cfreturn qGetGroupMembers>
	</cffunction>
	
    <cffunction name="saveMember">
		<cfargument name="dataStruct">
		<cfscript>
			super.save('groupMember', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteMember">
		<cfargument name="groupid">
		<cfargument name="memberID" default="">

		<cfquery datasource='#this.datasource#'>
			delete from groupMember 
			where groupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.groupid#">

			<cfif arguments.memberid neq ''>
				and memberid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberid#">
			</cfif>
		</cfquery>

	</cffunction>
</cfcomponent>