<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 auth handler
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "index,facebook,linkedin";
		this.allowedMethods = structnew();
	</cfscript>
	
	<cffunction name="prehandler" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setLayout('layout.AJAX');			
		</cfscript>
		<Cfparam name="rc.provider" default="socialcloudz">
	</cffunction>
			 
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
	
	<cffunction name="login" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = event.getCollection(); 
			var startPage = '';
			var member = application.members.authenticate(
					email=event.getValue('email',''), 
					password=event.getValue('password',''));		

			
			if (member.success eq 0) { 
				variables.activity = member.error;
				event.renderdata('JSON', {status: 0, message: member.errorDetail});							
			} else { 
				structappend(request.session,member.Data,true);
				variables.activity = 'Success';	
		
				if(member.data.signupComplete eq 0){
					rc.nextpage = '/index.cfm/member/account/index/signupcomplete/0';
				} else { 
					startpage = #application.community.settings.getValue('startPage')#;
	
					if (startpage eq 'lastPage'){
						if(request.community.private eq 1){
							rc.nextpage = '/';	
						} else { 
							if ( request.session.lastpage contains 'signup/details'){
								rc.nextPage = '/';
							} else { 
								rc.nextpage = request.session.lastpage;
							}
						}
					} else {
						rc.nextpage = startpage;	
					}
				}
				application.one.populateFromIdentity(provider= 'socialcloudz', memberID=request.session.memberID);
				
				application.session.savesession(cookie.token, request.session);
				
							announceinterception('logActivity', {	activityType='members', 
						 	activityAction='login', 
							contentType = 'members', 
							contentID = request.session.memberID, 
							memberID = request.session.memberID});
			
				event.renderdata('JSON', {status: 1, url: rc.nextPage});							
			}
		</cfscript>

	</cffunction>
	
	<cffunction name="facebookLogout" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			request.session.one.deleteProvider('facebook');
		</cfscript>
	</cffunction>	
	
	<cffunction name="facebook" returntype="Void" output="false">
		<cfargument name="event" type="any">
	
		<cfscript>
		 	var rc = event.getCollection();
			var apiResponse = '';
			var checkOne = '';
			var member = '';
			
			if (not isdefined('session.oauth.facebook')){
				session.oauth.facebook = createObject('component','/model/oauth/oauth').init(useJavaLoader = 1);
			}
			
			apiResponse = session.oauth.facebook.doAPICall(
				providerName='facebook', 
				apiURL = 'https://graph.facebook.com/me',
				oauth_verifier=event.getValue('code',''),
				returnURL = 'http://#cgi.http_host#/index.cfm/member/auth/facebook/',
				key = application.community.settings.getValue('facebookAPI'),
				secret = application.community.settings.getValue('facebookAppSecret')
			);
			
			rc.provider = 'facebook';
			rc.profile = deserializeJSON(apiResponse);
			
			
			application.one.populateFromIdentity('facebook', rc.profile.id);
			
			checkOne = request.session.one.getProviders();
			if (arrayLen(checkOne) and isDefined('checkOne[1].memberID')){
				member = application.members.gateway.get(memberID = checkOne[1].memberID);
				rc.email = member.email;
				rc.password = member.password;
				runEvent('member.auth.login', true);
				relocate(rc.nextpage);
				
			} else { 
				request.session.message='We could not locate an account with this provider, please signup.'
				relocate('/index.cfm/member/signup/details');
			}
		</cfscript>
	</cffunction>

	<cffunction name="linkedIn" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfset var rc = event.getCollection()>
		<cfset var apiResponse = ''>
		<cfset var checkOne = ''>
		<cfset var member = ''>
		
		<cfparam name="url.oauth_verifier" default="">
			
		<cfscript>
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
			
			rc.provider = 'linkedin';
			rc.profile =xmlParse(apiResponse);
			
			application.one.populateFromIdentity('linkedIn', rc.profile.xmlroot.xmlchildren[1].xmlText);
			
			checkOne = request.session.one.getProviders();
			if (arrayLen(checkOne) and isDefined('checkOne[1].memberID')){
				member = application.members.gateway.get(memberID = checkOne[1].memberID);
				rc.email = member.email;
				rc.password = member.password;
				runEvent('member.auth.login', true);
				relocate(rc.nextpage);
			} else { 
				request.session.message='We could not locate an account with this provider, please signup.'
				relocate('/index.cfm/member/signup/details');
			}
		</cfscript>

	</cffunction>
	

</cfcomponent>