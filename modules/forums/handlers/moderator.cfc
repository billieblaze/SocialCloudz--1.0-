<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 forum moderator handler
		
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
		</cfscript>
	</cffunction>
	
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('forums:admin');
		</cfscript>
	</cffunction>

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setvalue('mods', application.forum.getmoderators(rc.id));
			event.setLayout('layout.AJAX');
			event.setView('moderator');
		</cfscript>
	</cffunction>
	
	<cffunction name="submit">
	  <cfargument name="event" />
	  <cfscript>
		  	var rc = event.getCollection();
	   		application.forum.saveModerator(rc);
	  </cfscript>
	</cffunction>
	
	<cffunction name="delete">
	  	<cfargument name="event" />
	  	<cfscript>
			var rc = event.getCollection();
			application.forum.deleteModerator(rc);
		</cfscript>
	</cffunction>
</cfcomponent>