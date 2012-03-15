<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 page layout handler
		
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
			event.setvalue('layoutconfig',application.cms.layout.get(event.getvalue('page')));
			event.setLayout('layout.AJAX');
      	</cfscript>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			rc.communityID = request.community.communityID;
			application.cms.layout.save(rc);
			application.community.settings.save(rc);
			
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='submit layout', 
				contentType = 'cmspages', 
				contentID = rc.page, 
				memberID = request.session.memberID});
					
			relocate(request.session.lastpage);
			
		</cfscript>
	</cffunction>
</cfcomponent>