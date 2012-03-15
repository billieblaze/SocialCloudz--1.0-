<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 announcement handler
		
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
			announceInterception('checkAdmin');

			event.setLayout('layout.AJAX');	

		</cfscript>
	</cffunction>
	
	<cffunction name="alert">
		<cfargument name="event" />
    	<cfscript>
			var rc = event.getCollection();	
			event.setvalue('announcement', application.community.Announcements.get(type='Popup', limit=1));
			event.setLayout('layout.AJAX');
		</cfscript>
    </cffunction>

	<cffunction name="submit">
		<cfargument name="event" />
    	<cfscript>
			var rc = event.getCollection();	
			form.dateExpires = replace(form.dateexpires, ',',' ');
		 	id = application.community.announcements.save(form);	
		 	
		 	announceinterception('logActivity', {	activityType='community', 
			 	activityAction='add announcement', 
				contentType = 'announcement', 
				contentID = id, 
				memberID = request.session.memberID});
				
		</cfscript>
    </cffunction>

	<cffunction name="delete">
		<cfargument name="event" />
    	<cfscript>
			var rc = event.getCollection();	
			application.community.announcements.delete(id = rc.id);
	
			announceinterception('logActivity', {	activityType='community', 
			 	activityAction='delete announcement', 
				contentType = 'announcement', 
				contentID = rc.id, 
				memberID = request.session.memberID});
		</cfscript>
    </cffunction>
		
</cfcomponent>