<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/13/2010
Description : 			
 forgotpassword handler
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		/* HTTP Methods Allowed for actions. */
		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods = structnew();
	</cfscript>

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
    <cffunction name="submit">
        <cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			var member = '';
			var mailData = '';
			
			if(rc.email eq '' or not isvalid('email', rc.email)){
				request.message = 'Invalid Email Address';
			} else {
				member = application.members.gateway.get(email =  '#rc.email#');

				if(member.recordcount eq 0 ){
					getPlugin("MessageBox").setMessage(type="error", message="Email address not found");
				} else {
					mailData = application.util.queryRowToStruct(member);
					application.emailTemplates.send(to=maildata.email, template='forgotpw', data={member = member});
	
					announceinterception('logActivity', {	activityType='app', 
						 	activityAction='retrieve password', 
							contentType = 'members', 
							contentID = member.memberID, 
							memberID = request.session.memberID});
							
					getPlugin("MessageBox").setMessage(type="info", message="Password sent");
				}
			}

			event.setView('member/forgotpw/index')
			runEvent('member.forgotpw.index');
		</cfscript>
    </cffunction>
</cfcomponent>