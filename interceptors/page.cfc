<cfcomponent name="pageInterceptor"
	hint="This interceptor will handle config to the app."
	output="false"
	extends="coldbox.system.interceptor">

	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptor" output="false" >
	</cffunction>
	
	<cffunction name="preProcess" output="false" access="public" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		<cfparam name="request.page.title" default="">
		<cfparam name="request.page.keywords" default="">
		<cfparam name="request.page.description" default="">
		<Cfparam name="request.page.id" default="#event.getValue('contentType', '')#">

		<cfscript>
		// prevent meaningless requests to the cms
			if (listfind ('png,jpg,gif,ico,bmp', cgi.script_name)){   writeoutput('Invalid Request');abort;	}

		// SKIN - Stop Interceptors
			if ( event.getCurrentEvent() eq 'cms.style.skin'){ return true;} 
			
		// content page
			if (event.getValue('contentType','') neq ''  and event.getCurrentEvent() contains 'content.form'){	request.page.id = 'editContent'; }
			if (event.getValue('contentType','') neq ''  and event.getCurrentEvent() does not contain 'content.form'){	request.page.id = rc.contentType; }
			if (event.getValue('contentID', '') neq ''){	request.page.id = request.page.id & '_detail';	}
		
		// load CMS Page
				if ( not isDefined('request.page.id')){	request.page.id = replace(cgi.script_name, '/', '');	}
			 	if ( isDefined('rc.cmsPage')){	request.page.id = rc.cmsPage;	}
		
		// Homepage
			if (event.getCurrentEvent() eq 'cms.page.index' and (request.page.id eq '' or request.page.id eq 'index.cfm')){ 
				// no page, assume homepage - check for splash page
				firstpage = application.community.settings.getValue('firstpage');
				if ( firstpage eq 'home' or (firstpage neq 'home' and request.session.splashpage eq 1)){ 
					request.page.id = 'home';
				} else {
					request.page.id = 'splash';
					event.setLayout('layout.Splash');
					request.session.splashPage = 1;		
				}			
			}
			
			// old cms page - page.cfm rather then /pages/pageName
			if ( cgi.script_name neq '/index.cfm' and cgi.script_name neq ''){
				request.page.id = cgi.script_name;
				request.page.id = replace(request.page.id, '/', '');
			}
			
			request.page.id = replace(request.page.id, '.cfm', '');
			if (request.page.id eq '' ){ 	request.page.id = event.getCurrentEvent(); }				
		

		// Settings

		var cachekey = cgi.http_host & '|' & request.page.id & '|page';
			 if ( getColdboxOCM().lookup(cachekey) ){
			     request.page = getColdboxOCM().get(cachekey);
			  } else{				
			request.page.settings = application.cms.settings.get(page = request.page.id, contentType = event.getValue('contentType',''));
			
			
			// Meta
				request.page.meta =  application.cms.page.get(url=request.page.id);
				if (request.page.meta.recordcount eq 1){
					request.page.title = '#request.page.meta.title#';
					request.page.keywords = '#request.page.meta.keywords#';
					request.page.description = '#request.page.meta.description#';
				} else { 
					data = structNew();
					data.url = request.page.id;
					data.communityID = request.community.communityID;
					data.dateCreated = now();
					application.cms.page.save(data);
					request.page.meta =  application.cms.page.get(url=request.page.id);
				}
								
				// Meta Data 
				if (request.page.keywords neq ''){
					request.page.keywords = replace(request.page.keywords, '"','','all');
					request.page.keywords = replace(request.page.keywords,"'","","all");
					
				} else { 
					request.page.keywords = replace(request.community.keywords,'"','','all');
					request.page.keywords = replace(request.page.keywords,"'","","all");
				}
			
				if (request.page.description neq ''){
					request.page.description= replace(request.page.description,'"','','all');
					request.page.description= replace(request.page.description,"'","","all");
				} else { 
					request.page.description= replace(request.community.description,'"','','all');
					request.page.description= replace(request.page.description,"'","","all");
				}
		    getColdboxOCM().set(cacheKey, request.page, 10);
		  }

			// check access 
			if (application.cms.settings.check('canView') eq 'Members'){
				announceInterception('checkLogin');
			} else if (application.cms.settings.check('canView') eq 'Editor'){
				announceInterception('checkEditor');
			} else if (application.cms.settings.check('canView') eq 'Admin'){
				announceInterception('checkAdmin');
			}
			
			announceInterception('checkProfileType');

		</cfscript>

	</cffunction>
	
</cfcomponent>
