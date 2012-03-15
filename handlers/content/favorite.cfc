<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 favorite content
		
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
			announceInterception('checkLogin');
		</cfscript>
	</cffunction>
	
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			relocate(request.session.lastpage);
		</cfscript>
	</cffunction>

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
	
			event.setValue('favorites', application.content.favorite.get(memberID = request.session.memberID, contentType = event.getValue('contentType','')));
			event.setvalue('member', application.members.gateway.list(request.session.memberID));	

			rc.sideBar = renderView('member.profile.nav');
		</cfscript>	
	</cffunction>
	
	<cffunction name="add">
		<cfargument name="event" />
	  	<cfscript>
			var contentID = event.getvalue('contentid','');
			var level = event.getvalue('level','1');

			application.content.favorite.save(contentID, level);
			
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='favorited content', 
				contentType = 'favorites', 
				contentID = rc.contentId, 
				memberID = request.session.memberID});

		</cfscript>
	</cffunction>

	<cffunction name="remove">
		<cfargument name="event" />
  		<cfscript>
			application.content.favorite.delete(rc.contentID);
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='un-favorited content', 
				contentType = 'favorites', 
				contentID = rc.contentId, 
				memberID = request.session.memberID});

		</cfscript>
	</cffunction>

</cfcomponent>