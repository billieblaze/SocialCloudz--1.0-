<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 cms settings handler
		
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
			announceInterception('checkAdmin');
		</cfscript>
	</cffunction>

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setLayout('layout.AJAX');
			request.page.id = rc.page;
		</cfscript>
	</cffunction>
	
    <cffunction name="submit">
		<cfargument name="event" />
    	<cfscript>
			var rc = event.getCollection();	
			application.cms.settings.save(rc);	
			
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='update page settings', 
				contentType = 'pagesettings', 
				contentID = rc.page, 
				memberID = request.session.memberID});
			getPlugin("messagebox").setMessage("info", "Saved.");	
			setNextEvent('cms.settings.index', 'page=#rc.page#&contentType=#rc.contentType#');
		</cfscript> 
    </cffunction>
</cfcomponent>