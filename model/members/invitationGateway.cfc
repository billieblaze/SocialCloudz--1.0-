<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="memberID" default="#request.session.memberID#">
	    <cfargument name="communityID" default="#request.community.communityID#">
		<cfset var qGetInvites = ''>
	    <cfquery name="qGetInvites" datasource="#this.datasource#">
		    select I.*, ic.idstring, 
				(select count(id) from invitationTracking 
			 	 where memberid = 0 and invitationID = I.id) as visitors,  
			 	(select count(id) from invitationTracking 
			 	 where memberid <> 0 and invitationID = I.id) as members 
			from invitation I
		    left join invitationCode ic on ic.id = I.invitationCode
		    where I.memberid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
		    and communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
	    </cfquery>
	  
	    <cfreturn qGetInvites> 
	</cffunction> 

	<cffunction name="getByInvitationCode">
		<cfargument name="invitationCode" default="">
	    <cfargument name="communityID" default="#request.community.communityID#">
	    <cfset var qGetInvitation = ''>
	    <cfquery name="qGetInvitation" datasource="#this.datasource#">
		    select I.* from invitation I
		    left join invitationCode ic on ic.id = I.invitationCode
		    where communityID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.communityID#">
		   	and	ic.idstring = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.invitationCode#">
	    </cfquery>
	  
	    <cfreturn qGetInvitation> 
	</cffunction> 

	<cffunction name="save">
		<cfargument name="datastruct">
	    
	    <cfscript>
			return super.save('invitation', arguments.datastruct);
		</cfscript>
	</cffunction>

	<cffunction name="saveCode">
		<cfargument name="datastruct">
	    
	    <cfscript>
			return super.save('invitationCode', arguments.datastruct);
		</cfscript>
	</cffunction>	

	<cffunction name="track">
		<cfargument name="invitationID">
		<cfargument name="memberID">
	    <cfargument name="visitorID" default="#cookie.visitorID#">
	    <cfscript>
			return super.save('invitationTracking', arguments); 
		</cfscript>
	</cffunction>
	
	<cffunction name="delete">

	</cffunction>
</cfcomponent>