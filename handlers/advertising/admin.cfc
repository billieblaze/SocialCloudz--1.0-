<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 advertising manager
		
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

	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('advertising.admin');
		</cfscript>
	</cffunction>
			
  	<cffunction name="index">
	    <cfargument name="event">
	    <cfscript>
		    var rc = event.getCollection();
		
			if (application.community.settings.getValue('Ads') eq 1 or isdefined('rc.global')){
				event.setvalue('sizes', application.advertising.getAdSizes());
				event.setvalue('banners', application.advertising.getBanners());
				event.setvalue('categories', application.community.category.get());
			} else {
				Event.setView(name="advertising/admin/purchase");
			}
			event.setLayout('layout.AJAX');
		</cfscript>
    </cffunction>
    
    <cffunction name="add">
	    <cfargument name="event">
	    <cfscript>
		    var rc = event.getCollection();	
			application.advertising.savebanner(rc);
			announceinterception('logActivity', {	activityType='advertising', 
			 	activityAction='add / edit banner', 
				contentType = 'advertising', 
				contentID = rc.id, 
				memberID = request.session.memberID});
		</cfscript>
    </cffunction>
    
	<cffunction name="delete">
	    <cfargument name="event">
	    <cfscript>
		var rc = event.getCollection();	
		application.advertising.deletebanner(rc.id);
		announceinterception('logActivity', {	activityType='advertising', 
			 	activityAction='delete banner', 
				contentType = 'advertising', 
				contentID = rc.ID, 
				memberID = request.session.memberID});
				
		</cfscript>
    </cffunction>
</cfcomponent>