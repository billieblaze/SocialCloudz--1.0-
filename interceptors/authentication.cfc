<cfcomponent name="authInterceptor"	output="false">
	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptor" output="false" >
	</cffunction>
	
	<cffunction name="checkLogin" interceptionPoint="true" output="false" >
    	<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
    	<cfscript>
		if(request.session.login eq 0){
			request.session.showLogin = 1;
			application.session.savesession(cookie.token, request.session);
			relocate('/');
		}
		</cfscript>
    </cffunction>
	
	<cffunction name="checkEditor" interceptionPoint="true" output="false" >
    	<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
    	<cfscript>
		if(request.session.login eq 0 or (request.session.login and request.session.accesslevel eq 10)){
			request.session.message = 'You are not authorized to access this area.';
			application.session.savesession(cookie.token, request.session);
			relocate('/');
		}
		</cfscript>
    </cffunction>

	<cffunction name="checkAdmin" interceptionPoint="true" output="false" >
    	<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
    	<cfscript>
		if(request.session.login eq 0 or (request.session.login and request.session.accesslevel lt 20)){
			request.session.message = 'You are not authorized to access this area.';
			application.session.savesession(cookie.token, request.session);
			relocate('/');
		}
		</cfscript>
    </cffunction>

	<cffunction name="checkSuperAdmin" interceptionPoint="true" output="false" >
    	<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
    	<cfscript>
		if(request.session.login eq 0 or (request.session.login and request.session.accesslevel lt 100)){
			request.session.message = 'You are not authorized to access this area.';
			application.session.savesession(cookie.token, request.session);
			relocate('/');
		}
		</cfscript>
    </cffunction>


	<cffunction name="checkProfileType" interceptionPoint="true" output="false" >
    	<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>

		<cfscript>
			profileType = application.cms.settings.check('canViewProfileType');
			if (profileType neq 'Anyone'){
				if (request.session.accesslevel lt 20 and ( not isdefined('rc.memberID') or (isdefined('rc.memberID') and rc.memberID neq request.session.memberID))){ 
					if(profileType eq 'Consumer' and request.session.profileType neq 1){
						request.session.message = 'You are not authorized to access this area.';
						application.session.savesession(cookie.token, request.session);
						relocate('/');
					}
			
					if(profileType eq 'Business' and request.session.profileType neq 2){
						request.session.message = 'You are not authorized to access this area.';
						application.session.savesession(cookie.token, request.session);
						relocate('/');
					}
				}
			}
		</cfscript>
    </cffunction>


	<cffunction name="checkPrivate" interceptionPoint="true" output="false" >
    	<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
    	<cfscript>
		if(request.session.login eq 0 and request.community.private eq 1){
			setNextEvent('app.info.private');
		}
		</cfscript>
	</cffunction>
</cfcomponent>