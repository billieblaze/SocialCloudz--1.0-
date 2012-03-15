<cfcomponent name="contentstoreInterceptor"
	hint="This interceptor will handle config to the app."
	output="false"
	extends="coldbox.system.interceptor">

	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptor" output="false" >
	</cffunction>
	
		<cffunction name="preProcess" access="public" returntype="void" hint="Executes after the framework and application configuration loads, but before the aspects get configured. " output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		
		<Cfif isdefined('rc.contentType') and application.content.type.get(rc.contenttype).recordcount eq 0>
			<cfset request.session.message = 'Invalid ContentType'>
			<cfset relocate('/')>
		</cfif>
	</Cffunction>
	<cffunction name="preLayout" output="false" access="public" returntype="void" hint="ENVIRONMENT control the settings">
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		<Cfset var qGetModules = ''>
		
		<cfif event.getCurrentEvent() eq 'cms.page.index' and event.getValue('contentType','') neq ''>
			<cfquery dbtype = 'query' name="qGetModules">
				select * from request.layout.modules 
				where contentType = '#rc.contentType#'
				and isContent = 1
			</cfquery>	
			<cfscript>
				rc.limit = qGetModules.displayRows;
				if ( isdefined('rc.dateRangeStart') and rc.dateRangestart neq ''){
					rc.operator = '';
				} else { 
					rc.operator = qGetModules.operator;
				}
				
					// content object and ui settings
					rc.content = application.content.getForInterceptor(rc);
				
				 	announceInterception('checkContentAccess', rc.content);
				
					// page meta
					request.page.title = rc.contentType;
					request.page.description = application.processtext.tagstripper(rc.content.query.desc);
					request.page.keywords = application.processtext.tagstripper(valuelist(rc.content.query.tags));
					
					if (event.getValue('contentID', '') neq ''){
						request.page.title = request.page.title & ' - ' & rc.content.query.title;
						if ( rc.content.query.comments neq 0 and 
								(( rc.content.query.parentID eq 0 or  rc.content.query.parentID eq '') and (application.community.settings.getValue('#rc.content.query.contentType#_Comment') neq 'Noone' )
								
									)
								)
							{
								rc.qcomments = application.content.comments.get(fkID=rc.contentID,fkType=rc.contentType, sort='dateEntered', sortOrder='desc', parentID=0);
								rc.displayLayout=1;
								rc.fktype = rc.contentType;
								rc.fkID = rc.contentID; 
								rc.commentReturnURL='/#rc.contentType#/detail/#rc.contentID#?';
								rc.commentMemberID= rc.content.query.memberID;
								rc.comments = 1;
							}
					}
			</cfscript>
		</cfif>
	</cffunction>

	<cffunction name="checkContentAccess" output="false" access="public" returntype="void" hint="ENVIRONMENT control the settings" interceptionPoint="true">
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">

	  	<cfscript>
			 var rc = event.getCollection();
			 var content = interceptdata.query;
		  		
			if (isdefined('content.recordcount') and content.recordcount eq 1 and content.private eq 1 and content.memberID neq request.session.memberID and request.session.accesslevel lt 10 and application.members.isfriend(content.memberid, request.session.memberID) eq 0){
				request.session.message = 'You are not authorized to access this content.';
				application.session.savesession(cookie.token, request.session);
				relocate('#request.session.lastpage#');
			}
			
			if (content.isdeleted eq 1){ 
				request.session.message = 'The content you are trying to access has been deleted by its owner or the site admins.';
				application.session.savesession(cookie.token, request.session);
				relocate('#request.session.lastpage#');
			}
			
			if ( isdefined('rc.contentID')){ 
				dump(content);

				if (content.recordcount eq 0){
					writeDump('wtf');abort;
					request.session.message = 'Invalid ContentID';
					if (content.parentContentType eq ''){
						relocate('/index.cfm/content/#content.contentType#');
					} else { 
						relocate('/index.cfm/content/#content.parentContentType#/');
					}
				}
			}
		</cfscript>
	</cffunction>
</cfcomponent>
