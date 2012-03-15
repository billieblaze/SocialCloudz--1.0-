<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 invitation handler
		
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
			request.layout.columns = 1;
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
		</cfscript>
	</cffunction>
	
	<cffunction name="send">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
		</cfscript>
	</cffunction>

    <cffunction name="sendSubmit">
		<cfargument name="event" />
        <cfparam name="rc.landingpage" default="/">
		<cfscript>
			var rc = event.getCollection();
			var invitationCode = '';
			var i = '';
			var data = '';
			
			rc.memberid = request.session.memberid; 
			rc.communityID = request.community.communityID;
	
			if (isdefined('rc.landingPage')){ 
				replace(rc.landingpage, '[memberid]', request.session.memberid);
			}		
			
			if (isdefined('rc.invitationCode')){
				invitationCode = application.members.invitation.getByInvitationCode(inviteCode=rc.invitationCode);
				
				if (invitationcode.recordcount gt 0){ 
					request.session.message = 'There is already an existing invitation code with that name.  Please enter a different invitation code.';
					setView('member/invite/send');
				} else { 
					rc.idstring = rc.invitationCode;
					rc.tmp_invitationCode = rc.invitationcode;
					rc.invitationCode = application.members.invitation.saveCode(rc);
					application.members.invitation.save(rc);
					rc.invitationcode = rc.tmp_invitationCode;
				}
			}
			
			if(rc.source eq 'email') { 
				for( i =1; i lte listlen(rc.emails, ';'); i = i +1){
					rc.email = listgetat(rc.emails,i,';');
					
					if ( application.members.gateway.get(email = rc.email).recordcount eq 0 ){
						data.inviteID = application.members.invitation.save(rc);
						application.emailTemplates.send(to=rc.email, template="invitation", data={form=form});
					}
				}
			}
	
			if(rc.source eq 'web'){ 
					rc.webID = application.members.invitation.save(rc);
			}
			
			event.setView('member/invite/complete');
		</cfscript>	
    </cffunction>
        
    <cffunction name="respond">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
		</cfscript>	    
    </cffunction>

    <cffunction name="respondSubmit">
		<cfargument name="event" /> 
		<cfscript>
			var rc = event.getCollection();
			var invitationCode = application.members.invitation.getByInvitationCode(invitationCode=rc.invitationCode);
			if (invitationCode.recordcount eq 0){ 
				request.session.message = 'Invalid Invitation Code, Please Try Again.';
				event.setView('member.invite.respond');
			} else { 
				application.members.invitation.track(invitationID = invitationCode.id, memberid=request.session.memberID, visitorID=cookie.visitorID );			
				relocate(invitationcode.landingpage);
			}
		</cfscript>	    
    </cffunction>

	<cffunction name="inviteRespond">
	  <cfargument name="event" />
	  	<cfscript>
		  	var rc = event.getCollection();
			var invitationCode = application.members.invitation.getByInvitationCode(invitationCode=event.getvalue('invitationCode'));
			if (invitationCode.recordcount eq 0){ 
				renderData('plain','Invalid Invitation Code, Please Try Again.');
			} else { 
				application.members.invitation.track(invitationID = invitationCode.id, memberid=request.session.memberID, visitorID=cookie.visitorID );			
				renderData('plain',invitationCode.memberID);
			}
		</cfscript>
	</cffunction>
</cfcomponent>