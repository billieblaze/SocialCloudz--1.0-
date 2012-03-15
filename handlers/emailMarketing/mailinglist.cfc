<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 mailinglist handler
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "index,saveMailingList";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>

	
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			var currentEvent = event.getCurrentEvent();
			event.setvalue('community', application.community.setupCommunity(communityID = event.getValue('communityID')));		
		</cfscript>
	</cffunction>
	
	
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
			event.setLayout('layout.AJAX');
		</cfscript>
		
	</cffunction>
	<cffunction name="subscribers">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			announceInterception('checkAdmin');
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>

    <cffunction name="saveMailingList">
		<cfargument name="event" />
		<cfsetting showdebugoutput="False">
		<cfscript>
			var rc = event.getCollection();
			rc.dateEntered = now();	
			response = application.mailinglist.save(rc);
			application.emailTemplates.send(to=rc.email, template='mailinglist', data=rc);
			event.renderData('plain',response);
		</cfscript>
	</cffunction> 
    
	<cffunction name="save">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.mailinglist.save(rc);
			request.session.message = 'Subscriber Added.';			
			setNextEvent('massmail.subscribers.index', 'communityID=#rc.communityID#');
		</cfscript>
	</cffunction>

	<cffunction name="delete">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.mailinglist.delete(id=rc.id);
			renderData('plain','complete');
		</cfscript>
	</cffunction>

	<cffunction name="export">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			announceInterception('checkAdmin');
		</cfscript>
		
			<cfcontent type="application/vnd.ms-excel">
			<cfheader name="content-disposition" VALUE="attachment; filename=subscribers.csv">
			
		  	<cfscript>
				rc.subscribers = application.mailinglist.get(communityID=rc.community.communityID);
				csv = application.util.csvFormat(rc.subscribers,'','email,dateentered');
				event.renderData('plain', csv);
		</cfscript>
	</cffunction>
		
</cfcomponent>