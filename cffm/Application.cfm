<cfapplication name="cffm-1.16" sessionmanagement="yes">
<cfinclude template="/config/settings.cfm">
<cfscript>
    application.server = createObject('component', '/model/server/serverService').init(datasource='statistics', xmlDefinition="/model/server/server.xml");
	application.memcachedFactory = createObject("component","/model/memcached/MemcachedFactory").init("#application.memcachedServer#:11211"); 
	application.memcached = application.memcachedFactory.getmemcached();      
    	application.session = createObject('component', '/model/session').init(memcached = application.memcached);
			request.session = application.session.getSession(cookie.token);
			structappend(session, request.session);
			
			if (isdefined('cgi["X-Real-IP"]') and cgi["X-Real-IP"] neq ''){
            	request.session.ipaddress = cgi["X-Real-IP"];
        	} else { 
            	request.session.ipaddress = cgi.REMOTE_ADDR;
        	}	
		</cfscript>
