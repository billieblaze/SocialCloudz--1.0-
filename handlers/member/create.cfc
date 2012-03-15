<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 create member
		
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
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>

	<cffunction name="submit">
	    <cfargument name="event">
		<cfscript>
			var rc = event.getCollection();

			var formUtils = getMyPlugin("formutilities").buildFormCollections(rc); // create nested form structs *ex: form.member.memberid
			var oMember = createObject('component','/model/members/member'); // create a blank member object
			var validation = ''; 
			var checkAccount = '';
			var mailData = '';
			
		 	getPlugin("beanFactory").populateFromStruct(oMember, rc.member);
			validation = application.members.validator.validate(objectType="members",theObject=oMember, context='create');
			rc.errors = validation.getFailuresForUniForm();

	    	if (validation.getIsSuccess()){
				checkAccount = application.members.gateway.get(email=rc.member.email);
				if (checkAccount.recordcount neq 0){
					rc.member.username= checkaccount.username;
					rc.member.email = checkaccount.email;
					rc.member.memberid = checkaccount.memberid;
					rc.member.password = application.util.randstring(6);
				} else { 
					rc.member.password = checkAccount.password;
				}
				rc.member.approved = 1;
				rc.member.signupComplete = 0;
				rc.member.communityId = request.community.communityID;
				rc.member.accesslevel = 1;
				rc.member.memberid = application.members.gateway.save(rc.member);
				application.members.account.save(rc.member);
				application.members.access.save(rc.member);
				
				// send welcome mail
				maildata.inviteUsername = rc.member.username;
				maildata.inviteEmail = rc.member.email;
				maildata.invitePassword = rc.member.password;
				application.emailTemplates.send(to=rc.member.email, template="invitenewuser", data=mailData);

						announceinterception('logActivity', {	
							activityType='members', 
						 	activityAction='created member', 
							contentType = 'members', 
							contentID = rc.member.memberID, 
							memberID = request.session.memberID});
				getPlugin("messagebox").setMessage("info", "Invitation / Password has been sent.");
			}else { 
			getPlugin("messagebox").setMessage("error", "Error:", errors);
			}
			setNextEvent('member.create.index');
		</cfscript>
	</cffunction>
</cfcomponent>