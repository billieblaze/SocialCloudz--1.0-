<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 member groups handler
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "create";
		this.allowedMethods = structnew();
	</cfscript>
	
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkLogin');
		</cfscript>
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			relocate('/index.cfm/content/group/#rc.contentID#');
		</cfscript>
	</cffunction>

	<cffunction name="create">
    	<cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			var data = structNew();

			data.name = rc.title;
			data.desc = rc.desc; 
			data.active = 1;
			data.isVisible = 1;
			data.communityID = request.community.communityID;
			data.groupid = rc.contentID;
			data.contentid = rc.contentid;	
			data.memberid = request.session.memberid;
			data.admin = 1;
			data.groupID = application.members.group.save(data);
			application.members.group.saveMember(data);
			application.content.favorite.save(rc.contentID);


			announceinterception('logActivity', {	activityType='members', 
				 	activityAction='created group', 
					contentType = 'groups', 
					contentID = data.groupid, 
					memberID = request.session.memberID});
							
	    </cfscript>
	</cffunction>

	<cffunction name="join">
    	 <cfargument name="event">
	     <cfscript>
			var rc = event.getCollection();
			var data = structNew();
			
			data.memberid = request.session.memberid;
			data.groupID = application.members.group.get(contentID=rc.contentID).id;
			application.members.group.saveMember(data);
			application.content.favorite.save(rc.contentID);
			announceinterception('logActivity', {	activityType='members', 
						 	activityAction='joined group', 
							contentType = 'groups', 
							contentID = data.groupID, 
							memberID = request.session.memberID});
		 </cfscript>
	</cffunction>

	<cffunction name="unjoin">
		<cfargument name="event">
	   	<cfscript>
		   	var rc = event.getCollection();
			var groupID = application.members.group.get(contentID=rc.contentID).id;
			application.members.group.deleteMember(groupid=groupid, memberid = request.session.memberid);
			application.content.favorite.delete(rc.contentID);

			announceinterception('logActivity', {	activityType='members', 
						 	activityAction='un-joined group', 
							contentType = 'groups', 
							contentID = groupID, 
							memberID = request.session.memberID});
		</cfscript>
	</cffunction>
	
</cfcomponent>