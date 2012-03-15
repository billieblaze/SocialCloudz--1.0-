<cfcomponent name="configInterceptor"
	hint="This interceptor will handle config to the app."
	output="false"
	extends="coldbox.system.interceptor" >

	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptor" output="false" >
	</cffunction>

	<cffunction name="afterConfigurationLoad" output="false" access="public" returntype="void" hint="ENVIRONMENT control the settings">
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfinclude template="/config/settings.cfm">
		<cfinclude template="/config/initModel.cfm">
		<cfinclude template="/config/scheduledTasks.cfm">
		<cfset application.init = 1>
	</cffunction>
	
	<cffunction name="preProcess"output="false" access="public" returntype="void" hint="ENVIRONMENT control the settings">
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		
		<cfset var rc = event.getCollection()>
 
		<!--- if it's secure, load the site from url.c (passed in commerce areas) - isSSL is set in nginx during ssl proxy--->
		<cfif cgi.isSSL eq 1>
	    	<cfset request.community = application.community.setupCommunity(communityID = rc.c)>
			<cfset event.setSESBaseURL('https://' & cgi.http_host & '/index.cfm/')>
		<cfelse>
		     <cfscript>
			  if ( getColdboxOCM().lookup(cgi.http_host) ){
			     request.community  = getColdboxOCM().get(cgi.http_host);
			  } else{
			   //Create md from Transfer
			   request.community = application.community.setupCommunity(cgi.http_host)
			   //set back in cache
			   getColdboxOCM().set(cgi.http_host, request.community, 10);
			  }
		  </cfscript>

			<cfset event.setSESBaseURL('http://' & cgi.http_host & '/index.cfm/')>		
		</cfif>
		

	</cffunction>
</cfcomponent>
