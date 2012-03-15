<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 community admin
		
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
			request.layout.columns = 1;
			request.layout.template = 4;
			request.layout.width="doc2";
			request.layout.skinFile="/css/skin_admin.css";
			request.layout.headerFile="/views/app/admin/header.cfm";
			request.layout.menuFile = "/views/app/admin/menu.cfm";
		</cfscript>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
	  </cfscript>
	</cffunction>
	
	<cffunction name="welcome">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();	
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>

	<cffunction name="cancel">
		<cfargument name="event" />
    	<cfscript>
			var rc = event.getCollection();	
			communitydata = structnew();
			communitydata.communityid = request.community.communityid;
			communitydata.active = 0;
			application.community.gateway.save(communitydata);
			
			announceinterception('logActivity', {	activityType='app', 
			 	activityAction='deactivate community', 
				contentType = 'community', 
				contentID = communitydata.communityid, 
				memberID = request.session.memberID});
				
			setNextEvent('cms.page.index');
		</cfscript>
    </cffunction>
</cfcomponent>