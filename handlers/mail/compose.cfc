<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 compose a message
		
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

	<!--- preHandler --->
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkLogin');
		</cfscript>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setvalue('folders', application.mail.getFolders(memberID=request.session.memberID));
			
			if(isdefined('rc.parentID') and rc.parentID neq 0){
				event.setvalue('mail', application.mail.getMessage(rc.parentID, request.session.memberID));
			}
				
			if(isdefined('rc.parentID') and rc.parentID neq 0){
				event.setView('mail/message/index'); 
			}
		
			rc.sideBar = renderView('mail/nav');
		</cfscript>
	</cffunction>

	<cffunction name="submit">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
		rc.sourceID= request.session.memberID;
		rc.dateCreated = now();
		for (i=1; i lte listlen(rc.to); i=i+1){
			rc.targetid = listgetat(rc.to,i);
			messageID = application.mail.sendmail(rc);
			
			announceinterception('logActivity', {	activityType='messages', 
			 	activityAction='send message', 
				contentType = 'messages', 
				contentID = messageID, 
				memberID = request.session.memberID});
				
			// Send Notification
			datastruct = structnew();
			datastruct.memberID = rc.targetID;
			datastruct.linkURL=event.buildLink('mail.message.index');
			datastruct.type = 'mail';
			datastruct.message = '#request.session.username# has sent you a message';
			application.members.notification.save(datastruct);
	
			toUser = application.members.gateway.get(memberID=rc.targetID);
			application.emailTemplates.send(to=toUser.email, template='message', data={memberID=rc.targetID});
		}

		
		
		
		request.session.message = 'Message Sent';
		
		setNextEvent('mail.message.index');
		</cfscript>
	</cffunction>
</cfcomponent>