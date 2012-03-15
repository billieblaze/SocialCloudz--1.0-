<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 email marketing handler
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "index,preview";
		this.allowedMethods = structnew();
	</cfscript>

	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');			
			thisEvent = event.getCurrentEvent();
			event.setvalue('community', application.community.setupCommunity(communityID = event.getValue('communityID')));		
			event.setLayout('layout.AJAX');
			
		</cfscript>
		<cfparam name="rc.messageID" default="0">
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('emailMarketing.admin.index', 'communityID=#rc.communityID#');
		</cfscript>
	</cffunction>

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			var query = application.mailinglist.getMessage(messageID = rc.messageid);
			var tmp = application.util.queryRowToStruct(query);
			structappend(rc, tmp, false);
			
		</cfscript>
	</cffunction>

	<cffunction name="preview">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			event.setvalue('messages', application.mailinglist.getMessage(messageID = rc.messageid));
		</cfscript>
	</cffunction>

	<cffunction name="submit">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.mailinglist.saveMessage(argumentcollection=rc);
		</cfscript>
    </cffunction>

	<cffunction name="delete">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.mailinglist.deleteMessage(messageID=rc.messageID);
		</cfscript>
    </cffunction>
</cfcomponent>