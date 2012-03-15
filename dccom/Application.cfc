<cfcomponent displayname="Application" output="true" hint="Handle the application.">
  	
	<cfscript>
		this.sessionmanagement = 'yes';
		this.name = "socialcloudz";

	</cfscript>
	<cffunction name="onRequestStart">
	<cfargument name="TargetPage" type="string" required="true" />
	<!--- Init model layer --->
		<cfinclude template="../config/settings.cfm">
		<cfset application.directory ="">

		<cfscript>
			application.db_datasource='community';
			request.session = application.session.getSession(cookie.token);
			structappend(session, request.session);
			
			if (isdefined('cgi["X-Real-IP"]') and cgi["X-Real-IP"] neq ''){
            	request.session.ipaddress = cgi["X-Real-IP"];
        	} else { 
            	request.session.ipaddress = cgi.REMOTE_ADDR;
        	}	
		</cfscript>
        <cfset request.community = application.community.setupCommunity(cgi.http_host)>
	</cffunction>

	<cffunction name="onRequestEnd">
	 	<cfscript>
			structappend(request.session, session);		
			application.session.savesession(cookie.token, request.session);
			structclear(session);
		</cfscript>
	</cffunction>

</cfcomponent> 