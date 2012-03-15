<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 email marketing admin
		
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
			announceInterception('checkAdmin');
		</cfscript>

		<Cfparam name="rc.communityID" default="#request.community.communityID#">
		<cfset event.setvalue('community', application.community.setupCommunity(communityID = rc.communityID))>
		<cfif request.session.accesslevel gte 100>
			<cfset event.setvalue('communityList',application.community.gateway.get())>
		<cfelse>
			<cfset event.setvalue('communityList',application.community.getMine(memberID = request.session.memberID,adminOnly = 1))>
		</cfif>
		
	</cffunction>
	
	<!--- postHandler --->
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		</cfscript>
	</cffunction>

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			
			if (application.community.settings.getValue('MassMail',event.getValue('community').settings) eq 0){
				event.setView('emailMarketing/admin/purchase');
			}
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name="report">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();	
			event.setvalue('message',application.mailinglist.getMessage(rc.messageID));
			event.setvalue('log', application.mailinglist.getlog(rc.messageID));
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
</cfcomponent>