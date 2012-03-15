<cfcomponent extends="coldbox.system.Coldbox" output="false">
	<cfsetting enablecfoutputonly="no">
	<cfscript>
		this.name = "socialcloudz";
		this.sessionmanagement = true;
		this.setDomainCookies = true;
		COLDBOX_APP_ROOT_PATH = getDirectoryFromPath(getCurrentTemplatePath());
		COLDBOX_APP_MAPPING   = "/";
		COLDBOX_CONFIG_FILE   = "";
		COLDBOX_APP_KEY       = "";
	</cfscript>
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
			<cfscript>
			//Load ColdBox
			loadColdBox();
			return true;
		</cfscript>
	
	</cffunction>
	<cffunction name="onRequestStart" returntype="boolean" output='true' >
		<cfargument name="targetPage" />
		<cfif cgi.script_name contains 'index.cfm'>
		<cfset reloadChecks()>
		<cfset processColdBoxRequest()>
		</cfif>
		<cfreturn true>
	</cffunction>


</cfcomponent>