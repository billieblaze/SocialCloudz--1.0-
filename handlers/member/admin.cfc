<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 member admin
		
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
			event.setvalue('community', application.community.setupCommunity(communityID = event.getValue('communityID')));
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name="delete" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			 application.members.account.delete(memberid = rc.id);
			 			announceinterception('logActivity', {	activityType='members', 
						 	activityAction='delete member', 
							contentType = 'members', 
							contentID = rc.id, 
							memberID = request.session.memberID});
		</cfscript>
	</cffunction>
	
	<cffunction name="access" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setvalue('member', application.members.gateway.list(memberID=rc.memberID, communityID = rc.communityID));
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>

	<cffunction name="accessSubmit" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		 	var	member = rc;
			param name="rc.flagged" default="0";
			
			member.flagged = rc.flagged; 
			
		   	member.communityID = request.community.communityID;
		    member.linkURL='/';
		    member.type = 'member';
			member.email = application.members.gateway.get(memberid=member.memberid).email;	
		
			if(event.getValue('approved', 0)  eq 0){
				member.approved = 0;
				member.message = 'Your membership request has been denied.';
				application.members.notification.save(member);
				application.emailTemplates.send(to=member.email, template="newuser_denied", data=member);	
			} else { 
				member.approved = 1;
				
				if(request.community.private eq 1){
					member.message = 'Your membership request has been accepted.';
					application.members.notification.save(member);
					application.emailTemplates.send(to=member.email, template="newuser", data=member);	
				}
			}	
		
		   if(event.getValue('banned',0) eq 1){
				member.message = 'You have been banned from this site.';
				application.members.notification.save(member);
				application.members.ban.save(form.memberID);
				application.emailTemplates.send(to=member.email, template="banfromsite", data=member);	
		   } else if (event.getValue('banned',0) eq 0) {
				member.message = 'Your ban has been removed from this site.';
				application.members.notification.save(member);
				application.members.ban.delete(form.memberID);
				application.emailTemplates.send(to=member.email, template="unbanfromsite", data=member);	
		   }

		   	application.members.gateway.save(member);
			application.members.account.save(member);
		    application.members.access.save(member);
			
			announceinterception('logActivity', {	activityType='members', 
						 	activityAction='change access', 
							contentType = 'access', 
							contentID = member.memberID, 
							memberID = request.session.memberID});
							
			event.renderData('plain', 'ok');
		</cfscript>
	</cffunction>
	
</cfcomponent>