<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 branding management
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
		 	request.community = application.community.setupCommunity(communityID = rc.communityID);
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
 		<cfargument name="event"> 
		<cfscript>
			var rc = event.getCollection();
           	setNextEvent('app.branding');
		</cfscript>
	</cffunction>
</cfcomponent>