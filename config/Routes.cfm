<cfscript>
	// General Properties
	setEnabled(true);
	setUniqueURLS(false);
	//setAutoReload(false);
	
	// Base URL
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("http://#cgi.HTTP_HOST#/index.cfm/");
	}
	else{
		setBaseURL("http://#cgi.HTTP_HOST#/#getSetting('AppMapping')#/index.cfm/");
	}
	
	// Module Routing Added
	addModuleRoutes(pattern='/imageManager', module="imageManager");
	addModuleRoutes(pattern='/forums', module="forums");
	
	// Your Application Routes
	addRoute(pattern="/pages/:cmsPage", handler="cms.page", action="index");

	addRoute(pattern='/hoth/:action?',handler= 'HothReportEventHandler');
	addRoute(pattern="/content/admin/index", handler="content.admin", action="index");		
	addRoute(pattern="/content/admin/manage", handler="content.admin", action="manage");		
	addRoute(pattern="/content/admin/community/:contentID", handler="content.admin", action="community");		
	addRoute(pattern="/content/admin/communitySubmit", handler="content.admin", action="communitySubmit");		
	addRoute(pattern="/content/admin/approve", handler="content.admin", action="approve");			
	addRoute(pattern="/content/admin/manage", handler="content.admin", action="manage");		
	addRoute(pattern="/content/admin/community", handler="content.admin", action="community");		
	addRoute(pattern="/content/admin/communitySubmit", handler="content.admin", action="communitySubmit");			
	addRoute(pattern="/content/admin/delete/:contentType/:parentID/:contentID", handler="content.admin", action="delete");			
	addRoute(pattern="/content/admin/delete/:contentType/:contentID", handler="content.admin", action="delete");			
	addRoute(pattern="/content/favorite/index", handler="content.favorite", action="index");		
	addRoute(pattern="/content/favorite/add", handler="content.favorite", action="add");		
	addRoute(pattern="/content/favorite/remove", handler="content.favorite", action="remove");			

	addRoute(pattern="/content/form/child/:contenttype/:contentID?", handler="content.form", action="child");	
	addRoute(pattern="/content/form/sort/:contenttype/:contentID?", handler="content.form", action="sort");	
	addRoute(pattern="/content/form/saveChild", handler="content.form", action="saveChild");	
	addRoute(pattern="/content/form/saveorder", handler="content.form", action="saveorder");	
	addRoute(pattern="/content/form/:contenttype/:contentID", handler="content.form", action="index");		
	addRoute(pattern="/content/nestedSet", handler="content.nestedSet");		
	addRoute(pattern="/content/nestedSet/submit", handler="content.nestedSet", action="submit");
	addRoute(pattern="/content/form/save", handler="content.form", action="save");		
	addRoute(pattern="/content/categories/index", handler="content.categories", action="index");		
	addRoute(pattern="/content/categories/save", handler="content.categories", action="save");
	addRoute(pattern="/content/categories/delete", handler="content.categories", action="delete");
	
	addRoute(pattern="/content/sort/:contenttype/:contentID?", handler="content.form", action="sortOrder");	
	addRoute(pattern="/content/sort/:contenttype/:contentID?", handler="content.form", action="sortOrder");	
	addRoute(pattern="/content/util/rotatePhoto", handler="content.util", action="rotatePhoto");	
	addRoute(pattern="/content/util/incrementView/:contentID?", handler="content.util", action="incrementView");	
	addRoute(pattern="/content/util/search", handler="content.util", action="search");			
	addRoute(pattern="/content/util/flag", handler="content.util", action="flag");	
	addRoute(pattern="/content/util/printrsvplist", handler="content.util", action="printrsvplist");			
	addRoute(pattern="/content/import/facebookSubscriber", handler="content.import", action="facebookSubscriber");
	addRoute(pattern="/content/import/heywatchTransfer", handler="content.import", action="heywatchTransfer");
	addRoute(pattern="/content/import/heywatchEncode", handler="content.import", action="heywatchEncode");
	addRoute(pattern="/content/import/heywatchError", handler="content.import", action="heywatchError");	
	addRoute(pattern="/content/import/facebookEvent", handler="content.import", action="facebookEvent");	

	addRoute(pattern="/content/rss/:contentType", handler="content.util", action="rss");		
	addRoute(pattern="/content/json", handler="content.util", action="json");		

	addRoute(pattern="/content/:contentType/:contentID", handler="cms.page", action="index");	
	addRoute(pattern="/content/:contenttype", handler="cms.page", action="index");	

	addRoute(pattern="/members/:username", handler="member.profile", action="index");

	
	addRoute(pattern=":handler/:action?");

</cfscript>