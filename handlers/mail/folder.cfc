<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 message folder
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "index";
		this.allowedMethods = structnew();
	</cfscript>

	
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('mail.message.index');
		</cfscript>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>

	<cffunction name="submit">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
			rc.memberID = request.session.memberID;
			folderID = application.mail.addFolder(rc);
			
			announceinterception('logActivity', {	activityType='messages', 
			 	activityAction='add folder', 
				contentType = 'messageFolders', 
				contentID = folderID, 
				memberID = request.session.memberID});
				
		</cfscript>
    </cffunction>
	
    <cffunction name="delete">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
			rc.memberID = request.session.memberID;
			application.mail.deleteFolder(rc);
			
			announceinterception('logActivity', {	activityType='messages', 
			 	activityAction='delete folder', 
				contentType = 'messageFolders', 
				contentID = rc.folderID, 
				memberID = request.session.memberID});
				
		</cfscript>
    </cffunction>
</cfcomponent>