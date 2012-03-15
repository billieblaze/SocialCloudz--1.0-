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
			announceInterception('checkLogin');
		</cfscript>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			
			request.layout.columns = 1;
		</cfscript>
	</cffunction>
	
	<cffunction name="submit" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			
			event.renderData('plain','OK');
		</cfscript>
	</cffunction>

			<cffunction name="facebook">
        <cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			var apiResponse = '';
		
			rc.provider = 'facebook';
			
			if (not isdefined('session.oauth.facebook')){
				session.oauth.facebook = createObject('component','/model/oauth/oauth').init(useJavaLoader = 1);
			}
			
			apiResponse = session.oauth.facebook.doAPICall(
				providerName='facebook', 
				apiURL = 'https://graph.facebook.com/me',
				oauth_verifier=event.getValue('code',''),
				returnURL = 'http://#cgi.http_host#/index.cfm/member/auth/facebook'
			);
			rc.profile = deserializeJSON(apiResponse);

			rc.userID = rc.profile.id;
			
			request.session.one.addProvider(
				{ provider = rc.provider, 
				  userID = rc.userID, 
				  memberID = request.session.memberID,
				  authKey = '',
				  privacy = 0
				}
			);
			application.one.save(request.session.one);
			application.one.populateFromIdentity(memberID = request.session.memberID, provider='socialcloudz');
			setNextEvent('member.one.index');
		</cfscript>

    </cffunction>
	
	<cffunction name="linkedIn">
        <cfargument name="event">
		<cfparam name="url.oauth_verifier" default="">
		<cfscript>
			var rc = event.getCollection();
			var apiResponse = '';
			
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
			
			request.session.one.addProvider(
				{ provider = rc.provider, 
				  userID = rc.userID, 
				  memberID = request.session.memberID,
				  authKey = '',
				  privacy = 0
				}
			);
			application.one.save(request.session.one);
			application.one.populateFromIdentity(memberID = request.session.memberID, provider='socialcloudz');
			application.session.savesession(cookie.token, request.session);
			setNextEvent('member.one.index');
		</cfscript>
    </cffunction>
	
</cfcomponent>