<cffunction name='constructModules'>
	<cfargument name='list'>
	<cfargument name='moduleSettingID'>
	<Cfset var mContent = ''>
	<Cfif isdefined('arguments.list')>
		<cfquery dbtype = 'query' name="qGetModules">
			select * from request.layout.modules 
			where list = #arguments.list#
		</cfquery>
	<Cfelse>
		<cfset qGetModules = application.cms.modules.get(arguments.moduleSettingID)>
	</cfif>

	<cfset rc.Modules = application.util.queryToArrayOfStructures(qGetModules)>
	<!--- TODO: caching of modules makes imageManager not inject scripts 
	<cfset	cachekey = '#cgi.http_host#|#request.page.id#|content module|#arguments.list#_#arguments.moduleSettingID#'>
	<cfif  getColdboxOCM().lookup(cacheKey)>
		<cfset mContent  = getColdboxOCM().get(cacheKey)>
	<cfelse>							
	--->
		<Cfsavecontent variable = 'mContent'>
	
		<cfoutput query='qGetModules'>
			<cfif ((qGetModules.accesslevel eq ''  and (request.session.profiletype eq qGetModules.displayProfileType or qGetModules.displayProfileType eq 0))  or request.session.accesslevel gt 10) 
				or (qGetModules.accesslevel eq 0 and request.session.accesslevel eq 0  and (request.session.profiletype eq qGetModules.displayProfileType or qGetModules.displayProfileType eq 0)) 
				or (qGetModules.accesslevel gt 0 and request.session.accesslevel gte qGetModules.accesslevel and (request.session.profiletype eq qGetModules.displayProfileType or qGetModules.displayProfileType eq 0))
				>
				
				<cfscript>
					self = '/';
					attributes.id = qGetModules.msID;
					module_html = application.cms.modules.getHTML(attributes.id);
					style="";

					if (qGetModules.displayLayout eq 0){   style="noLayout";	}

					if (qGetModules.file eq 'content') { 
						rc.contentFilter = rc.modules[qGetModules.currentRow];
						rc.contentFilter.tag = qGetModules.displayTag;
						rc.contentFilter.categoryID = qGetModules.displayCategoryID;
						rc.contentFilter.memberID = qGetModules.displayMember;
						rc.contentFilter.contentID = qGetModules.displayContentID;
						rc.contentFilter.template = qGetModules.displayTemplate;
						rc.contentFilter.limit = qGetModules.displayRows;
						

						if ( rc.contentFilter.isContent eq 1 and not isdefined('arguments.moduleSettingID')){ 
							rc.contentModuleData = rc.content;
							
						} else { 
							rc.contentFilter.page = 1;
							if (isDefined('rc.memberID')){	rc.contentFilter.memberID = rc.memberID;}
							
							
							rc.contentModuleData = application.content.getForInterceptor(rc.contentFilter);
							
							rc.contentFilter.Template = rc.contentFilter.displayTemplate;							
							if (rc.contentFilter.displayTemplate eq ''){ rc.contentFilter.Template = rc.contentModuleData.uiSettings.mainTemplate;	}
						}
					}
					
				</cfscript>
	       		<li  id="module#msID#" 
	       			<cfif request.session.accesslevel gt 10 and qGetModules.accesslevel eq 0>
		       			class="hiddenModule"
					</cfif>
				>
				<div class="mod draggable #style#">
					<div class="hd #style# #file# #contentType#" <Cfif isDefined('qGetModules.moduleType') and qGetModules.moduleType  eq 'content'>onclick="$('##inner-#msID#').slideToggle();"</cfif>>
						<div style="float: left">
							#title# 
							<cfif request.session.accesslevel gt 10 and qGetModules.accesslevel eq 0>
								<span class="xsmall">Visible to guests only</span>
							</cfif> 
							<cfif qGetModules.file eq 'content'>
								  <cfif isdefined('rc.categoryID') and rc.categoryID neq ''>
							        - Category: #application.content.category.get(rc.categoryID).category#
							      </cfif>
							      <cfif isdefined('rc.attributeValue')>
							        - #rc.attribute#: #rc.attributeValue#
							      </cfif>
							      <cfif isdefined('rc.state')>
							        - State: #rc.state#
							      </cfif>
								  <cfif event.getValue('contentID','') eq '' and rc.contentFilter.displayRecordCount eq 1>
							    	 (#rc.contentModuleData.count#) 
							    	 <a href="http://#request.community.domain.subdomain[1]#.#request.community.domain.domain[1]#/index.cfm/content/rss/#contentType#"  target="_blank" class="aNone small"><img src="#application.cdn.fam#feed.png"></a>
							     </cfif>
							     
							</cfif>
						</div>
						<cfif request.session.accesslevel gte 10>
							<div style="float:left;" class="ui-state-default toolbar">
								<a  href="javascript: void(0);" class="close ui-icon ui-icon-close" style=" float: right; padding:0px;"  alt="#msID#"></a>							
								<a  href="javascript: void(0);" class="edit ui-icon ui-icon-wrench" style=" float: right; padding:0px;" alt="#msID#" rel="#editFile#"></a>
								<a  href="javascript: void(0);" class="move ui-icon ui-icon-arrow-4-diag" style=" float: right; padding:0px;" alt="#msID#"></a>
							</div>
						</cfif>
						<cfif qGetModules.isContent eq 1 and  file eq 'content'>
							#renderView('content/retrieve/menu')#
						</cfif>
					</div>
					<div class="bd #style#" id="inner-#msID#">
						#module_html#
						<cfif file contains 'dsp_'>
							<cfinclude template='/views/cms/modules/templates/#file#.cfm'>
						<cfelseif file contains 'nav_'>
							<cfinclude template='/views/content/retrieve/modules/#file#.cfm'>
						<Cfelseif file eq 'content'>
							<cfif rc.contentModuleData.count eq 0>
								No #replace(rc.contentfilter.contenttype, '_detail', '')#s have been posted yet. 
							<cfelse>					
								#renderView( 'content/retrieve/templates/#rc.contentFilter.Template#')#
							</cfif>
								
							
						 	<BR style="clear:both" />						
							 <cfif rc.contentFilter.isContent eq 1 and  event.getValue('contentType','') neq '' and event.getValue('contentID',0) eq 0 and rc.contentModuleData.count gt 0 and qGetModules.displayRows neq 0>
								 #application.util.queryPaging('/index.cfm/content/#rc.contentType#', rc.contentModuleData.count, rc.contentFilter.displayRows)#
							 <cfelseif rc.contentFilter.isContent eq 1 and  event.getValue('contentType','') neq '' and event.getValue('contentID',0) neq 0>
								 #renderview('content/retrieve/layout/foot_share')#
							<Cfelseif rc.contentFilter.isContent eq 0 and rc.contentFilter.ContentType neq ''>
								<div align="right" style="pad10 small"><a href="/index.cfm/content/#replace(rc.contentFilter.contentType, '_detail', '')#">View All</a></div>
							</cfif>
						</cfif>
					</div>
					<div class="ft #style#"></div>
				</div>
						<Cfif file eq 'content' and application.community.settings.getValue('friends') eq 1>
							<cfparam name="rc.comments" default="0">
							<cfif event.getValue('contentId',0) neq 0 and rc.comments eq 1>#renderView('comments/main/index')#</cfif>
						</cfif>
				</li>
			</cfif>
		</cfoutput>
		</cfsavecontent>
		<!--->
		<cfset    getColdboxOCM().set(cacheKey, mContent, 10)>
	</cfif>--->

		<cfreturn mContent>
	</cffunction>
	