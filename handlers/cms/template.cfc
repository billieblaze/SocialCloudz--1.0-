<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 cms template
		
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
			event.setvalue('templates',application.cms.templates.get());
			event.setLayout('layout.AJAX');
        </cfscript>
	</cffunction>

    <cffunction name="change">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.cms.changeTemplate(event.getvalue('templateID'));
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='change template', 
				contentType = 'style', 
				contentID = rc.templateID, 
				memberID = request.session.memberID});
				
			relocate('/');
        </cfscript>
     </cffunction>

</cfcomponent>