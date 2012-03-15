<cfcomponent name="authInterceptor"	output="false">
	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptor" output="false" >
	</cffunction>

	<cffunction name="preProcess" access="public" returntype="void" hint="Executes after the framework and application configuration loads, but before the aspects get configured. " output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		
		<cfparam name="rc.errors" default="#structNew()#">		
		
		<cfscript>
			request.session = application.session.getSession(cookie.token);

			if (structKeyExists(rc, 'logout')){
				application.members.userClick( idle='false', online='false');
				application.session.deletesession(cookie.token);
				cookie.token =  createUUID();
				structClear(request.session);
			}
		</cfscript>
		<cfif not isstruct(request.session) or not structCount(request.session) >
		    	<!--- Details about the request and or member --->
		        <cfset request.session = structnew()>
		        <cfset request.session.memberID=0>
		        <cfset request.session.username="Guest">
		        <cfset request.session.firstname = 'Guest'>
			    <cfset request.session.lastname = 'User'>
			    <cfset request.session.password = ''>
		        <cfset request.session.login="0">
		        <cfset request.session.lastpage="/">
		        <cfset request.session.accesslevel="0">
		        <cfset request.session.lastlogin="">
		        <cfset request.session.email="">
		        <cfset request.session.age="">
			    <cfset request.session.gender = 1>
			    <cfset request.session.birthdate = now()>
			    <cfset request.session.numlogins = 0>
			    <cfset request.session.message="">
		        <cfset request.session.showLogin=0>
		        <cfset request.session.timezone="8">
		        <cfset request.session.supportMessage = 0>	
   			    <cfset request.session.city = ''>
		  	    <cfset request.session.state = ''>
		  	    <cfset request.session.country = 'United States'>
	      		<cfset request.session.profiletype = 0>
				<cfset request.session.splashPage="0">
		
				<cfset request.session.cart = createObject('component', 'model.commerce.cart').init()>
				<cfset request.session.one = createObject('component', 'model.one.one').init()>
		</cfif>		
	<!--- Fix Load Balancer IP's --->
		<cfif isdefined('cgi["X-Real-IP"]') and cgi['X-Real-IP'] neq ''>
			<cfset request.session.ipaddress = cgi['X-Real-IP']>
		<cfelse>
			<cfset request.session.ipaddress = cgi.REMOTE_ADDR>
		</cfif>
		
	   	<cfif isdefined('rc.i')>
			<cfset member = application.members.gateway.list(request.session.memberid)>
			<cfif member.globalAdmin eq 1>
				<cfset request.session.accesslevel = 100>
			<cfelse>
				<cfset request.session.accesslevel = member.accesslevel>
			</cfif>
		</cfif>
	
		<cfparam name="session.returnPage" default="">

	    <cfscript>
			if ( isdefined('rc.successPage')){ 
					request.session.successPage = rc.successPage;
			}
				
			request.session.location = application.location.getIp2Location(request.session.ipaddress);
			application.session.savesession(cookie.token, request.session);

			if (structKeyExists(rc, 'logout')){
				location('/');
			}
		</cfscript>	
	</cffunction>
	
	<cffunction name="postProcess" access="public" returntype="void" hint="Executes after the framework and application configuration loads, but before the aspects get configured. " output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		
		<cfscript>
			application.session.savesession(cookie.token, request.session);
		</cfscript>
	</cffunction>

	<cffunction name="postViewRender" access="public" returntype="void" hint="Executes after the framework and application configuration loads, but before the aspects get configured. " output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		<cfscript>
			    if(cgi.SCRIPT_NAME contains '.cfm' 
		    	and cgi.query_string does not contain 'favicon.ico' 
		    	and not listFindNoCase(event.getCurrentEvent(),'member.signup.details,member.auth.login')
		   		){
			    	if (event.getCurrentLayout() eq 'layout.Main.cfm'){
						request.session.lastpage = '#cgi.Script_name##cgi.path_info#?#cgi.QUERY_STRING#'; 
					}
				}
				
		</cfscript>
	</cffunction>
</cfcomponent>