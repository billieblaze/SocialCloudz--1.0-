<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 friends
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "index,approve";
		this.allowedMethods = structnew();
	</cfscript>
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkLogin');
		</cfscript>
		<cfparam name="rc.memberID" default="#request.session.memberID#">
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
			event.setvalue('members',application.members.friend.list(memberID=rc.memberID));
			event.setLayout('layout.AJAX');
		</cfscript>
     </cffunction>

	<cffunction name="approve">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
			request.page.title = "Friend Requests";
			event.setvalue('member', application.members.gateway.list(memberID=request.session.memberID)) ;
			event.setvalue('friends',application.members.friend.list(approved=0));
			rc.sideBar = renderView('member/profile/nav');
		</cfscript>
     </cffunction>

	<cffunction name="doApprove">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
			if(rc.submit eq "Approve"){
			  rc.approved = 1;
			} else { 
			  rc.approved = -1;
			}
			application.members.friend.approve(rc.memberID, rc.approved);
						announceinterception('logActivity', {	activityType='members', 
						 	activityAction='friend approved', 
							contentType = 'friends', 
							contentID = rc.memberID, 
							memberID = request.session.memberID});
		</cfscript>
    </cffunction>

	<cffunction name="add">
        <cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			var datastruct = structnew();
			var toUser = '';
			
			application.members.friend.save(targetid = rc.memberID);

			// Send Notification
			
			datastruct.memberID = rc.memberID;
			datastruct.linkURL=buildLink('member.friends.approve');
			datastruct.type = 'friend';
			datastruct.message = '#request.session.username# has sent you a friend request';
			application.members.notification.save(datastruct);

			// Send External Email
			toUser = application.members.gateway.get(memberID=datastruct.memberID);
			application.emailTemplates.send(to=touser.email, template='friendRequest', data=datastruct);
			request.session.message = 'Friend Request sent.';
			
			announceinterception('logActivity', {	activityType='members', 
			 	activityAction='friend request', 
				contentType = 'friends', 
				contentID = rc.memberID, 
				memberID = request.session.memberID});
		</cfscript>
    </cffunction>
	
    <cffunction name="remove">
        <cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			application.members.friend.delete(sourceid= request.session.memberid, targetid = rc.memberID);
			application.members.friend.delete(targetid= request.session.memberid, sourceid = rc.memberID);
			
						announceinterception('logActivity', {	activityType='members', 
						 	activityAction='friend removed', 
							contentType = 'friends', 
							contentID = rc.memberID, 
							memberID = request.session.memberID});
							
		</cfscript>
    </cffunction>
</cfcomponent>