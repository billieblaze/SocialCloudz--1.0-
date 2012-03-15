<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 email utilities
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>

	
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			
		</cfscript>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
	
 	<cffunction name="action">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
			var messageID = event.getvalue('messageID');
			for(i = 1; i LTE  listlen(messageID); i = i +1){
				if (event.getvalue('action') eq 'Move To Folder'){ 
					application.mail.moveFolder(messageID = listgetat(messageID, i), folderID = event.getvalue('folderID'));
					announceinterception('logActivity', {	activityType='messages', 
						 	activityAction='move message', 
							contentType = 'messages', 
							contentID = listgetat(messageID, i), 
							memberID = request.session.memberID});
				} else if (event.getvalue('action') eq 'delete'){
					application.mail.deleteMessage(messageID = listgetat(messageID, i) );		
					announceinterception('logActivity', {	activityType='messages', 
					 	activityAction='delete message', 
						contentType = 'messages', 
						contentID = listgetat(messageID, i), 
						memberID = request.session.memberID});		
				}
			}
			setNextEvent('mail.message')
		</cfscript>
    </cffunction>
</cfcomponent>