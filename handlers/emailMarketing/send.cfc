<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 	send 
 
		
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
			announceInterception('checkAdmin');
			event.setvalue('community', application.community.setupCommunity(communityID = event.getValue('communityID')));		
		</cfscript>
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();	
		</cfscript>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setvalue('members', application.members.gateway.list());
			event.setvalue('mailinglist', application.mailinglist.get());
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>

	<cffunction name="send">
		<cfargument name="event" />
		<Cfabort>
		<cfscript>
			var rc = event.getCollection();			
			for(i=1; i lte listlen(rc.email); i=i+1){
				application.mailinglist.send(rc.messageID, listGetAt(rc.email,i));
				application.mailinglist.savelog(rc.messageID, listGetAt(rc.email,i));
			}
			request.session.message = 'Email sent to #listlen(rc.email)# people';
			relocate('/index.cfm/emailMarketing/admin/index?communityID=#rc.communityID#');
		</cfscript>
	</cffunction>

	<cffunction name="test">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();			
			application.mailinglist.send(rc.messageID, rc.email);
			request.session.message = 'Test email sent to: #rc.email#';
			relocate('/index.cfm/emailMarketing/admin/index?communityID=#rc.communityID#');
		</cfscript>
	</cffunction>
</cfcomponent>