<cfcomponent name="authInterceptor"	output="false">
	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptor" output="false" >
	</cffunction>

	<cffunction name="preProcess" access="public" returntype="void" hint="Executes after the framework and application configuration loads, but before the aspects get configured. " output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		
		<cfif isdefined('rc.i')>
			<cfcookie name="token" value="#rc.i#" expires="never">
		</cfif>
    	
		<cfif not IsDefined("cookie.token")>
			<cfcookie name="token" value="#createUUID()#" expires="never">
		</cfif>

		<cfif not isdefined('cookie.remember')>
			<cfcookie name="remember" expires="never" value="0">
	    </cfif>
    
	    <cfif not isdefined('cookie.email')>
			<cfcookie name="email" expires="never" value="">
	    </cfif>
	    
	    <cfif isdefined('rc.remember')>
        	<cfcookie name="remember" expires="never" value="1">
           	<cfcookie name="email" expires="never" value="#rc.email#">
        <cfelse>
        	<cfcookie name="remember" expires="never" value="0">
        </cfif>

	</cffunction>
</cfcomponent>