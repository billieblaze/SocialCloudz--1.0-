<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 community settings handler
		
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
			event.setvalue('community', application.community.setupCommunity(communityID = event.getValue('communityID')));
			event.setvalue('menuFeatures', application.cms.menu.getFeatures());
			event.setvalue('categories', application.community.category.get());
			event.setLayout('layout.AJAX');
			event.setView('community/settings/'&event.getValue('viewName','index'))
		</cfscript>
	</cffunction>
	
  	<cffunction name="submit">
		<cfargument name="event" />
		<cfparam name="rc.watermarkImages" default="0">
		<cfscript>
			var rc = event.getCollection();
			application.community.save(rc);			
			
			announceinterception('logActivity', {	activityType='community', 
			 	activityAction='update settings', 
				contentType = 'communitysettings', 
				contentID = rc.communityId, 
				memberID = request.session.memberID});

			event.renderData('plain','ok');
			//setNextEvent(linkTo='admin.configure.index', qrc.tring='communityID=#form.communityID#');
		</cfscript>
	</cffunction>

</cfcomponent>