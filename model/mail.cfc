<cfcomponent>
<cffunction name="init" returntype="mail">
  <cfargument name="datasource">
  <cfset variables.myDAO = createobject('component', 'DataMgr.DataMgr_MYSQL').init(arguments.datasource)> 
  <cfset variables.datasource = arguments.datasource>

  <cfreturn this/>
</cffunction>
<cffunction name="getMail">
  <cfargument name="memberID">
  <cfargument name="folder">
  <cfargument name="startrow" default=1>
  <cfargument name="unread" default="">
	<cfset var qMessages = ''>
	
  <cfquery datasource="#variables.datasource#" name="qMessages">
		select id,dateCreated, dateRead, subject, sourceID, targetID, `read`,'' as replied,'' as username,'' as profilepic,'' as status
		from messages
		where
		<cfif arguments.folder eq 1> <!--- Inbox --->
		targetID = #arguments.memberID# and folder = 1 and targetdelete = 0
		<cfelseif arguments.folder eq 2> <!--- Sent ---> 
		sourceID = #arguments.memberID# and sourcedelete = 0
		<cfelse>
        targetID = #arguments.memberID# and folder = #arguments.folder# and targetdelete = 0
		</cfif>
		<cfif arguments.unread neq ''>
		and `read` != 1
		</cfif>
		order by dateCreated desc
		</cfquery>
		
		  <cfloop query="qMessages">
		    <cfif arguments.folder eq 2>
		      <cfset qMessages.username[currentRow] = application.members.getusername(qMessages.targetID,0)>
		      <cfset qMessages.profilepic[currentRow] = application.members.userpic(memberID=qMessages.targetid)>
		    <cfelse>
		      <cfset qMessages.username[currentRow] = application.members.getUserName(qMessages.sourceID,0)>
		      <cfset qMessages.profilepic[currentRow] = application.members.userpic(memberID=qMessages.sourceid)>
		    </cfif>
		    
		    <cfif qMessages.read eq 0 and qMessages.replied eq 0>
		      <cfset qMessages.status[currentRow] = "New">
		    <cfelseif qMessages.read eq 1 and qMessages.replied eq 0>
		      <cfset qMessages.status[currentRow] = "Read">
		    <cfelseif qMessages.read eq 1 and qMessages.replied eq 1>
		      <cfset qMessages.status[currentRow] = "Replied">
		    </cfif>
		  </cfloop>

  <cfreturn qMessages>
</cffunction>
<cffunction name="getMessage">
  <cfargument name="messageID">
  <cfargument name="memberID">
	<Cfset var qMessages = ''>
  <cfquery datasource="#variables.datasource#" name="qMessages">
		select id,dateCreated, dateRead,`subject`, sourceID, targetID,parentID, message, `read`, replied from messages
		where
		(ID = #arguments.messageID# or parentID = #arguments.messageID# or 
		id = (select parentID from messages where ID = #arguments.messageID#))
		and (sourceID = #arguments.memberID# or targetID = #arguments.memberID#)
		
		
		order by parentID, dateCreated
		</cfquery>
  <cfif qMessages.read[qmessages.recordcount] eq 0 and qMessages.targetID[qmessages.recordcount] eq arguments.memberID>
    <cfquery datasource="#variables.datasource#">
			update messages
			set `read` = 1, dateread = #now()#
			where ID = #qMessages.ID[qMessages.recordcount]#
			</cfquery>
  </cfif>
  <cfreturn qMessages>
</cffunction>
<cffunction name="sendMail">
  <cfargument name="datastruct">
  <cfscript>
		return variables.myDAO.insertrecord('messages',arguments.datastruct, 'insert');
		</cfscript>
</cffunction>
<cffunction name="deleteMessage">
  <cfargument name="memberID" default="#request.session.memberID#">
  <cfargument name="messageID">
	<cfset var checkMessage = ''>
  <cfquery datasource="#variables.datasource#" name="checkMessage">
		select sourceID, targetID from messages 
		where ID = #arguments.messageID#
		</cfquery>
  <cfif checkMessage.sourceID eq arguments.memberID>
    <cfquery datasource="#variables.datasource#"> 
		update messages
		set sourcedelete = 1 
		where ID = #arguments.messageID#
		</cfquery>
    <cfelseif checkMessage.targetID eq arguments.memberID>
    <cfquery datasource="#variables.datasource#"> 
		update messages
		set targetdelete = 1 
		where ID = #arguments.messageID#
		</cfquery>
  </cfif>
</cffunction>

<cffunction name="getFolders">
	<cfargument name="memberID" default="#request.session.memberID#">
	
    <cfscript>
	return variables.myDAO.getrecords('messageFolders', arguments);
	</cfscript>    
</cffunction>

<cffunction name="addFolder">
	<cfargument name="datastruct">
    <cfscript>
		return variables.myDAO.saverecord('messageFolders', arguments.datastruct);
	</cfscript>    
</cffunction>

<cffunction name="deleteFolder">
	<cfargument name="datastruct">
	
    <cfscript>
	return variables.myDAO.deleterecords('messageFolders', arguments.datastruct);
	</cfscript>    
</cffunction>

<cffunction name="moveFolder">
	<cfargument name="messageID">
    <cfargument name="folderID">
    
    <cfquery datasource="#variables.datasource#">
    	update messages
        set folder = #arguments.folderID#
        where ID = #arguments.messageID#
    </cfquery>
    </cffunction>
</cfcomponent>
