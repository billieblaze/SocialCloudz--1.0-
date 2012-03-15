<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 member signup handler
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "index,details,detailsSubmit";
		/* HTTP Methods Allowed for actions. */
		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods = structnew();
	</cfscript>

 <cffunction name="details">
        <cfargument name="event">
		<cfscript>	
			var rc = event.getCollection();
			request.layout.columns = 1;
			event.setvalue('types',application.members.profile.getTypes(communityID = request.community.communityID));
		</cfscript>		
    </cffunction>

	<cffunction name="detailsSubmit">
        <cfargument name="event">

		<cfscript>
		
			var rc = event.getCollection();
			var formUtils = '';
			var oMember = createObject('component','/model/members/member'); // create a blank member object
			var validation = ''; 
		
			if (event.getCurrentEvent() eq 'member.signup.detailsSubmit'){
				formUtils  = getMyPlugin("formutilities").buildFormCollections(rc); // create nested form structs *ex: form.member.memberid			
				rc.member.signupcomplete = 1;
			}
			
		 	getPlugin("beanFactory").populateFromStruct(oMember, rc.member);
			validation = application.members.validator.validate(objectType="members",theObject=oMember, context='register');
			rc.errors = validation.getFailuresForUniForm();
			
	    	if (not validation.getIsSuccess())
	    		{
	    		runEvent('member.signup.details');
				event.setView('member/signup/details');
				} 
			else 
				{
				// save the member
			
				rc.memberid = application.members.gateway.save(oMember.getMemento()); 
				request.session.memberID = rc.memberID; 
				
				application.one.save(request.session.one);
			
				// save their account				
				rc.account = {  memberID = rc.memberID,
								accesslevel = 1,
								communityID = request.community.communityID,
								approved = 1,
								profileType = rc.member.profileType };

				if (request.community.private eq 1){	rc.account.approved = 0;	}

				application.members.account.save(rc.account);
				application.members.access.save(rc.account);
				
				request.session.one.addProvider(
					{ oneID = request.session.one.getOneID(),
					  provider = 'socialcloudz', 
					  userID = rc.memberID, 
					  memberID = rc.memberID,
					  authKey = '',
					  privacy = 0
					}
				);
				application.one.save(request.session.one);
				
				announceinterception('logActivity', {	activityType='members', 
						 	activityAction='signup', 
							contentType = 'members', 
							contentID = rc.memberID, 
							memberID = request.session.memberID});
										this.postHandler(event=arguments.event);	
			}
		</cfscript>
    </cffunction>
	
	
	
	<cffunction name="facebook">
        <cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			rc.provider = 'facebook';
			rc.context = 'personal';
			if (not isdefined('session.oauth.facebook')){
				session.oauth.facebook = createObject('component','/model/oauth/oauth').init(useJavaLoader = 1);
			}
			
			apiResponse = session.oauth.facebook.doAPICall(
				providerName='facebook', 
				apiURL = 'https://graph.facebook.com/me',
				oauth_verifier=event.getValue('code',''),
				returnURL = 'http://#cgi.http_host#/index.cfm/member/auth/facebook',
				scope='email,user_birthday,user_groups,read_friendlists,read_stream',
				key = application.community.settings.getValue('facebookAPI'),
				secret = application.community.settings.getValue('facebookAppSecret')
			);
			rc.profile = deserializeJSON(apiResponse);
			
			if (isdefined('rc.profile.error')){
				structClear(session.oauth);
				setNextEvent('member.signup.facebook');
			}

			application.one.populateFromIdentity('facebook', rc.profile.id);
			
			checkOne = request.session.one.getProviders();
		
			if (arrayLen(checkOne) and isDefined('checkOne[1].memberID')){
				request.session.showLogin = 1;
				request.session.loginMessage = 'You already have an account associated with Facebook. Please login now.';
				application.session.savesession(cookie.token, request.session);
				relocate('/index.cfm/');
			} 
			
			rc.userID = rc.profile.id;
			rc.member.email = rc.profile.email;
			rc.member.username = rc.profile.name;
			rc.member.username = REreplace(rc.member.username, "[^a-zA-Z0-9]",  "","all")
			rc.member.firstname = rc.profile.first_name;
			rc.member.lastname = rc.profile.last_name;
			rc.member.birthdate = rc.profile.birthday;
			rc.member.timezone = rc.profile.timezone;
			rc.member.signupcomplete = 1;
			rc.member.heardabout = 'facebook';
			rc.member.password = application.util.randstring(6);
			rc.member.repassword = rc.member.password;
			rc.member.image = 'http://graph.facebook.com/#rc.profile.id#/picture';//todo: fix this..  need to download it and stash it on cloudfiles..
			rc.member.identity = rc.profile.id;
			rc.member.profileType = 1; 
			
			if (rc.profile.gender eq 'Male'){
				rc.member.gender = 1;				
			}else { 
				rc.member.gender = 2;
			}
				
			runEvent('member.signup.detailsSubmit', true);	

			request.session.one.addProvider(
				{ oneID = request.session.one.getOneID(),
				  provider = 'facebook', 
				  userID = rc.userID, 
				  memberID = request.session.memberID,
				  authKey = '',
				  privacy = 0
				}
			);
			application.one.save(request.session.one);
		</cfscript>

    </cffunction>
	
	<cffunction name="linkedIn">
        <cfargument name="event">
		<cfparam name="url.oauth_verifier" default="">
		<cfscript>
			var rc = event.getCollection();
			rc.provider = 'linkedin';
			
			if (not isdefined('session.oauth.linkedin')){
				session.oauth.linkedIn = createObject('component','/model/oauth/oauth').init(useJavaLoader = 1);
			}
			
			apiResponse = session.oauth.linkedIn.doAPICall(
				providerName='linkedin', 
				apiURL = 'http://api.linkedin.com/v1/people/~:(id,first-name,last-name,location:(name),picture-url,main-address,date-of-birth)',
				oauth_verifier=url.oauth_verifier,
				returnURL = 'http://#cgi.http_host#/index.cfm/member/auth/linkedin',
				key = application.community.settings.getValue('linkedInAPI'),
				secret = application.community.settings.getValue('linkedInSecret')
			);
			
			rc.profile =xmlParse(apiResponse);
				
			rc.userID = rc.profile.xmlroot.xmlchildren[1].xmlText;
			
			application.one.populateFromIdentity('linkedIn', rc.userid);
			checkOne = request.session.one.getProviders();

			if (arrayLen(checkOne) and isDefined('checkOne[1].memberID')){
				request.session.showLogin = 1;
				request.session.loginMessage = 'You already have an account associated with LinkedIn. Please login now.';
				application.session.savesession(cookie.token, request.session);
				relocate('/index.cfm/');
			} 
			
			rc.member.email = '#rc.userid#@linkedin.com';
			rc.member.username = rc.profile.xmlroot.xmlchildren[2].xmlText&rc.profile.xmlroot.xmlchildren[3].xmlText;
			rc.member.username = REreplace(rc.member.username, "[^a-zA-Z0-9]",  "","all")
			rc.member.firstname = rc.profile.xmlroot.xmlchildren[2].xmlText;
			rc.member.lastname = rc.profile.xmlroot.xmlchildren[3].xmlText;
			rc.member.signupcomplete = 0;
			rc.member.heardabout = 'linkedin';
			rc.member.password = application.util.randstring(6);
			rc.member.repassword = rc.member.password;
			//rc.member.image = rc.profile.xmlroot.xmlchildren[5].xmlText; //todo: fix this..  need to download it and stash it on cloudfiles..
			rc.member.accesslevel = 1;
			rc.member.profileType = 1; 
			rc.member.gender = 0;				

			rc.email = rc.member.email;
			rc.password = rc.member.password;
			
			runEvent('member.signup.detailsSubmit', true);	
			
			request.session.one.addProvider(
				{ oneID = request.session.one.getOneID(),
				  provider = rc.provider, 
				  userID = rc.userID, 
				  memberID = request.session.memberID,
				  authKey = '',
				  privacy = 0
				}
			);
			application.one.save(request.session.one);
		</cfscript>
    </cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		
		<cfscript>	
			var rc = event.getCollection();
			
			rc.member = application.members.authenticate(memberid = request.session.memberID );
		
			structappend(request.session,rc.member.data,true);
			application.session.savesession(cookie.token, request.session);
				
			// friends with the site owner
			application.members.friend.save(request.community.adminID, request.session.memberID, 1);
				
			// Send Member welcome letter
			if(request.community.private eq 0){
				application.emailTemplates.send(to=request.session.email, template='newUser');
			} else { 
				application.emailTemplates.send(to=request.session.email, template='newUser_privateSite');
			}
			
			// Send owner new member notification
			if (request.community.notifications eq 1){
				application.emailTemplates.send(to=valueList(request.community.owner.email), template='owner_newuser',data=structNew());
			}
			
			application.session.savesession(cookie.token, request.session);

				setNextEvent('member.account.index', 'profileType=#event.getValue('member').data.profileType#');
		</cfscript>

	</cffunction>
	
</cfcomponent>