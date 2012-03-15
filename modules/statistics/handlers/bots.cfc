<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 bot list admin
		
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

	<!--- preHandler --->
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkSuperAdmin');		
		</cfscript>
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('statistics:bots');
		</cfscript>
	</cffunction>
	
	<cffunction name="index">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			event.setvalue('bots', application.statistics.bots.get());	
			event.setLayout('layout.AJAX');
		</cfscript>
  	</cffunction>
  	
	<cffunction name="submit">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			rc.dateEntered = now();
			application.statistics.bots.save(rc);
		</cfscript>
  	</cffunction>
  
	<cffunction name="delete">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.statistics.bots.delete(rc.id);
		</cfscript>
  	</cffunction>

</cfcomponent>