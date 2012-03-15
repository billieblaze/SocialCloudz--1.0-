<cfscript>
	if (isdefined('rc.reload')){
		writeoutput('Taking Sites Down...<BR>');
    	application.sitedown=1;

		// clear trusted cache
		pagePoolClear();
		
        writeoutput('Reloading CFCs...<BR>');
	}  

	// TOOLS
	application.util = createobject('component','/udf/util').init();
	application.xml2struct = createObject('component', '/udf/xml2struct').init();		
	application.processtext = createobject('component', '/udf/processtext').init();
	application.form = createobject('component', '/udf/form').init();
	application.timezone  = createobject('component', '/udf/timezone').init();

	application.dynamicGrid = createobject('component','common.dynamicGrid.model.gridService').init(datasource=getDatasource('community').getName())
		
	application.memcachedFactory = createObject("component","/model/memcached/MemcachedFactory").init("#application.memcachedServer#:11211"); 
	application.memcached = application.memcachedFactory.getmemcached();      
	application.session = createObject('component', '/model/session').init(memcached = application.memcached);
	
    application.server = createObject('component', '/model/server/serverService').init(datasource=getDatasource('statistics').getName(), xmlDefinition="/model/server/server.xml");
	application.forms = createobject('component', '/model/forms').init(getDatasource('community').getName());
	application.location = createobject('component', '/model/location/locationService').init(datasource=getDatasource('community').getName());
    application.help = createObject('component', '/model/help').init(getDatasource('community').getName());

	application.one = createobject('component','/model/one/oneService').init(datasource=getDatasource('members').getName());

	// SC Model
	application.community = createobject('component','/model/community/communityService').init(datasource=getDatasource('community').getName(),xmlDefinition="/model/community/community.xml");
	application.cms = createobject('component','/model/cms/CMSService').init(datasource=getDatasource('community').getName(), xmlDefinition="/model/cms/cms.xml");
	application.content = createobject('component', '/model/content/contentService').init(datasource=getDatasource('contentstore').getName(), xmlDefinition="/model/content/contentstore.xml");	
	application.members = createobject('component', '/model/members/memberService').init(datasource=getDatasource('members').getName(), xmlDefinition="/model/members/members_schema.xml");	
	application.search = createobject('component', '/model/searchService').init();

	application.mail = createobject('component', '/model/mail').init(getDatasource('members').getName());
	application.poll = createobject('component', '/model/poll').init(getDatasource('community').getName());	

	application.commerce = createObject('component', '/model/commerce/commerceService').init(datasource=getDatasource('community').getName(), xmlDefinition="/model/commerce/commerce.xml");
    application.advertising = createobject('component', '/model/advertising').init(getDatasource('community').getName());
	application.mailinglist = createobject('component', '/model/mailinglist').init(getDatasource('community').getName());

	if (isdefined('rc.reload')){	writeoutput('Returning sites to live status...'); }
	application.sitedown=0;
			application.HothTracker =
				new Hoth.HothTracker( new Hoth.config.HothConfig() );

</cfscript>