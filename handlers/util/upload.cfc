<!-----------------------------------------------------------------------
Author 	 :	Bill Berzinskas
Date     :	11/7/2010
Description : 			
 upload handler
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">
	
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfset var rc = event.getCollection()>
		
		<cfset log.info('Receiving Upload')>
		
		<cfparam name="form.procfile" default="general">
		<cfparam name="form.contentID" default="0">
		<cfparam name="form.fkType" default="">
		<cfparam name="form.fkID" default="">

		<cfset var filename = getFileFromPath(form.filedata.name)>
		<cfset var extension = lcase(listLast(filename,"."))>
		<cfset var tempOutputFile = "#createUUID()#.#extension#"> 

		<cfset log.info('Copy Temp to File')>
		<cffile action='copy' source='#application.tempUpload#/#listlast(form.filedata.path,'/')#' destination='#application.tempUpload#/#tempOutputFile#'/>
		<cfdirectory action='list' directory="#application.tempUpload#" filter='#tempOutputFile#' name='dirlist'>
		
		<cfif form.procfile eq 'util.upload.layout'>
			<Cfset container = 'community_#form.communityid#'>
		<cfelse>
			<Cfset container = 'user_#form.memberid#'>
		</cfif>
		
		<cfset session.mosso = CreateObject("component", "model.cloudfiles").init(application.MOSSO_USER, application.MOSSO_KEY) />
		<cftry>
			<cfif session.mosso.createContainer(container)>
				<cfset uri = session.mosso.enableCDN(container) />
			</cfif>
			<cfcatch type="any"><cfset log.warn('Could Not Create Container')></cfcatch>
		</cftry>

		<cfset containerDetails = session.mosso.getContainer(container) />
		<cfset log.info('Put Object to CloudFiles')>
		<cfset session.mosso.putObject( container, tempOutputFile, '#application.tempUpload#/#tempOutputFile#', form.filedata.content_type) />
		
		<cfscript>
			catchContent = '';

			if (isdefined('form.memberID')){
				request.session.memberid = form.memberid; 
			}
			
			request.session.accesslevel = 0;
			request.community.communityID = form.communityID;
		
			rc.data = structNew();
			rc.data = form;
			rc.data.cdnurl = containerDetails.cdn.uri;
			rc.data.container = container;
			rc.data.file = tempOutputFile;
			rc.data.filesize = dirlist.size;
			rc.data.originalName = form.filedata.name; 
			
			if (not isdefined('form.contentID')){
				rc.data.contentID = 0;
			}
			log.info('Save Uploaded File to DB');	
			rc.data.fileID = application.server.storage.save(rc.data);
			
			rc.result = runEvent(form.procfile);
			
			announceinterception('logActivity', {	activityType='app', 
						 	activityAction='upload file', 
							contentType = form.fktype, 
							contentID = form.fkID, 
							memberID = request.session.memberID});
		</cfscript>

		<cfset log.info('Upload Complete')>
		<cfset event.renderData('plain',rc.data.fileID & '|' & rc.data.cdnurl & '/' & rc.data.file)>
	</cffunction>
	
	<cffunction name="albumSong">
		<cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			rc.data.parentID = rc.data.contentID;
			rc.data.contentID = 0;
			rc.data.contentType = 'Song';
			rc.data.approved = 1;
			rc.data.contentID = application.content.save(rc.data);
		</cfscript>
	</cffunction>
	
	<cffunction name="commentImage">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
	</cffunction>
	
	<cffunction name="galleryPhoto">
		<cfargument name="event">
			<cfscript>
				var rc = event.getCollection();
				var content = application.content.get(parentID=rc.data.contentID, approved=0);
				
				if (content.recordcount eq 0){
					rc.data.contentType = 'gallery';
					rc.data.image =rc.data.cdnurl & '/' & rc.data.file;
					rc.data.default=1;
					rc.data.parentID = application.content.save(rc.data);
				}
				
				rc.data.parentID = rc.data.contentID				
				rc.data.contentID = 0;	
				rc.data.contentType = 'photo';
				rc.data.image = rc.data.cdnurl & '/' & rc.data.file;
				rc.data.approved = 1; 
				application.content.save(rc.data);
				
				if ( application.community.settings.getValue('watermarkImages') eq '1' and request.community.logo neq ''){
					waterMarkImage = '#rc.data.directory#/#rc.data.file#';
					watermarkPosition = application.community.settings.getValue('watermarkPosition',community.settings);
					
					httpService = new http();
					httpService.setMethod("get"); 
				    httpService.setUrl("http://#cgi.host_name#/index.cfm/imageManager/watermark/?image=#watermarkImage#&watermark=#request.community.logo#&position=#watermarkPosition#"); 
				
				    result = httpService.send().getPrefix(); 
					
				}	
			</cfscript>
	</cffunction>
	
	<cffunction name="propertyPhoto">
		<cfargument name="event">
		<cfscript>
			var content=application.content.get(parentID=rc.data.contentID,communityID=rc.data.communityID, approved=0);
			
			if (content.recordcount eq 0){
				rc.data.contentType = 'Property';
				rc.data.image = rc.data.cdnurl & '/' & rc.data.file;
				rc.data.default=1;
				rc.data.contentID = 0;
				application.content.save(rc.data);
			}
			
			rc.data.parentID = rc.data.contentID;
			rc.data.contentType = 'PropertyThumbnail';
			rc.data.image = rc.data.cdnurl & '/' & rc.data.file;
			rc.data.approved = 1;
			application.content.save(rc.data);
			
		</cfscript>
	</cffunction>
	
	<cffunction name="general">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
	</cffunction>
	
	<cffunction name="layout">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
		<cfscript>
			rc.data.formfield = 'foo';
			rc.data.contentID = form.communityID;
		</cfscript>
	</cffunction>
	
	<cffunction name="flashHeader">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
		<cfscript>
			rc.data.formfield = 'flashHeader';
			rc.data.contentID = form.communityID;
			application.community.save({flashHeader =	'#rc.data.cdnurl#/#rc.data.file#', communityID= form.communityId });		
		</cfscript>
	</cffunction>
	
	<cffunction name="profile">
		<cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			application.members.gateway.save({ memberID = rc.contentID, image = rc.image, communityID = rc.communityID});
		</cfscript>
	</cffunction>
	
</cfcomponent>

