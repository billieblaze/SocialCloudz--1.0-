<cfcomponent name="layoutInterceptor"
	hint="This interceptor will handle config to the app."
	output="false"
	extends="coldbox.system.interceptor">

	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptor" output="false" >
	</cffunction>
	
	<cffunction name="preProcess" output="false" access="public" returntype="void" hint="ENVIRONMENT control the settings">
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		<cfset event.setValue('sideBar','')>
		<cfparam name="request.addressArray" default = '#arrayNew(2)#'>
		<cfparam name="request.layout.columns" default = 2>
		<cfparam name="request.layout.template" default = 3>
		<cfparam name="request.layout.right" default = ''>
		<cfparam name="request.layout.skinFile" default = '/index.cfm/?event=cms.style.skin&version=#application.revisionNumber#'>
		<cfparam name="request.layout.headerFile" default = ''>
		<cfparam name="request.layout.menuFile" default = ''>
		<cfparam name="request.layout.edit" default="0">
		<cfparam name="request.layout.menu_position" default="below">
		<cfparam name="request.message" default="">
		
		<cfscript>
			  request.layout.modules = application.cms.modules.getByList(request.page.id);
		</cfscript>
		</cffunction>
			
	<cffunction name="preLayout" output="false" access="public" returntype="void" hint="ENVIRONMENT control the settings">
			<cfargument name="event" required="true"  hint="The event object.">
			<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
			<cfset var rc = event.getCollection()>
			<cfscript>
			var cachekey = cgi.http_host & '|' & request.page.id & '|Layout';
			 if ( getColdboxOCM().lookup(cachekey) ){
			     request.layout = getColdboxOCM().get(cachekey);
			  } else{
				request.layout.menu =  application.cms.menu.get();
				
				if(not isdefined('request.layout.width')){
					request.layout.width = application.community.settings.getValue('page_width');
					request.layout.widthCustom = application.community.settings.getValue('page_widthCustom');
				}
		
				if (isdefined('request.layout.edit') eq 0 or (isdefined('request.layout.edit') and request.layout.edit eq 1)){
					structappend(request.layout,application.cms.layout.get(request.page.id),true);
				}
					
					
				if (event.getValue('contentType','') neq '' and event.getCurrentEvent() eq 'cms.page.index' and request.layout.modules.recordcount eq 0){
					// GO INSERT CONTENTSTORE DEFAULT MODULES
						rc.moduleID = application.cms.modules.list(contentType = request.page.id).moduleID;
						rc.mpid = application.cms.addModule(list=1, moduleID=rc.moduleID, page=request.page.id, isContent = 1);
		
						if (event.getValue('contentID', '') eq ''){ 
							// list 
							for (i=1; i lte listLen(rc.content.uiSettings.mainRightNav); i=i+1){
								thisModule = listGetAt(rc.content.uiSettings.mainRightNav, i);
								rc.mpid = application.cms.addModule(list=2, moduleID=thisModule, page=request.page.id, isContent = 1);
							}
						}  else { 
							// detail
							for (i=1; i lte listLen(rc.content.uiSettings.detailRightNav); i=i+1){
								thisModule = listGetAt(rc.content.uiSettings.detailRightNav, i);
								rc.mpid = application.cms.addModule(list=2, moduleID=thisModule, page=request.page.id, isContent = 1);
							}
						}
						request.layout.modules = application.cms.modules.getByList(request.page.id);
				}
				 //set back in cache
				   getColdboxOCM().set(cacheKey, request.layout, 10);
			  }
			
		</cfscript>
	</cffunction>
</cfcomponent>
