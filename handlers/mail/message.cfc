<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 message handler
		
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
			announceInterception('checkLogin');
		</cfscript>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
	
		<cfscript>
			var rc = event.getCollection();	
		
			event.setvalue('folders', application.mail.getFolders(memberID=request.session.memberID));
			rc.sideBar = renderView('mail/nav');
		</cfscript>
	</cffunction>
	
	<cffunction name="read">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
				event.setvalue('folders', application.mail.getFolders(memberID=request.session.memberID));
				event.setvalue('mail', application.mail.getMessage(rc.message, request.session.memberID));
				announceinterception('logActivity', {	activityType='messages', 
			 	activityAction='read message', 
				contentType = 'messages', 
				contentID = rc.message, 
				memberID = request.session.memberID});
				
		</cfscript>
	</cffunction>

</cfcomponent>