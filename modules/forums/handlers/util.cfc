<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 forum utils
		
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
			announceInterception('checkLogin');
		</cfscript>
	</cffunction>
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('forums:display.thread', 'id=#rc.id#');
		</cfscript>
	</cffunction>

	
	<cffunction name="stick">
  		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.forum.stickyTopic(rc.status, rc.id);
		</cfscript>
	</cffunction>
	
	<cffunction name="lock">
	  	<cfargument name="event" />
	  	<cfscript>
		  	var rc = event.getCollection();
			application.forum.lockTopic(rc.status, rc.id);
		</cfscript>
	</cffunction>

	<cffunction name="subscribe">
	  	<cfargument name="event" />
	  	<cfscript>
		  	var rc = event.getCollection();
			application.forum.subscribeTopic(request.session.memberID, rc.id, 1);
		</cfscript>
	</cffunction>

</cfcomponent>