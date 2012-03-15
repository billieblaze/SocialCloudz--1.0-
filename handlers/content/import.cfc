<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 import content
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>
	<cffunction name="event">
	  <cfargument name="event" />
	  <cfset var rc = event.getCollection()>
		<!--- TODO: ticket ##934 - finish google integration --->
	  <cfif isdefined('rc.googleFeed') and rc.googleFeed neq ''>
		<cfdump var='#rc.googlefeed#'>
		<cfhttp method="get" url="#rc.googleFeed#"/>
		<Cfdump var='#xmlParse(cfhttp.fileContent)#'>
		<cfabort>	  
	  </cfif>
	  
	  
	  <cfif isdefined('rc.icsURL') and rc.icsURL neq ''>
		<Cftry>
			<cfhttp url="#rc.icsURL#" method="get"></cfhttp>
			<Cfset data = cfhttp.filecontent>
			
			<cfset ical = createObject("component","/udf/ical").init(data)>
			<cfset results = ical.getEvents()>
			<cfdump var='#results#'>
			<cfloop index="x" from="1" to="#arraylen(results)#">
			
				<cfset eventData = results[x]>
				<cfif not structKeyExists(eventData,"summary")>
					<cfset title = 'Unnamed Event'>
				<cfelse>
					<cfset title = eventData.summary.data>
				</cfif>
				
				<cfset startDate = ical.icalParseDateTime(eventData.dtstart.data)>
				<cfif structKeyExists(eventData,"dtend")>
					<cfset endDate = ical.icalParseDateTime(eventData.dtend.data)>
				<cfelseif structKeyExists(eventData,"duration") and eventData.duration.data is not "P1D">
					<cfset endDate = ical.icalParseDuration(eventData.duration.data,startdate)>
				<cfelse>
					<cfset enddate = startdate>
				</cfif>
			
				<cfif structKeyExists(eventData,"description")>
					<cfset description=eventData.description.data>
				</cfif>
				
				<cfscript>
					checkEvent = application.content.get(attribute='uid', attributeValue=eventData.UID.data, trackstats=0);
					
					if (checkEvent.recordCount){
						writeoutput('Skipped - #eventData.UID.data#<BR>');
					} else {
						if (not isdefined('eventData.partstat') or (isdefined('eventdata.partstat') and eventdata.partstat.data eq 'Accepted')){
							data = structNew();
							data.uid = eventData.uid.data;
							data.title = eventData.summary.data;
							data.desc = description;
							data.endDate = endDate;
							data.startDate = startDate;
							data.publishDate = eventData.created.data; //todo: timezone on imports
							
							if (structKeyExists(eventData, 'location')){
								data.venue = eventData.location.data;
							}
													
							if (structKeyExists(eventData, 'organizer')){
								data.creator = eventData.organizer.data;
							}
							
							if (structKeyExists(eventData, 'url')){
								data.website = eventData.URL.data;
							}
							
							data.communityID = request.community.communityID;
							data.memberID = request.session.memberID;
							data.contentType = 'Event';
							
							application.content.save(data);
						}
					}
				</cfscript>
			</cfloop>
			<Cfcatch>
				<cfset request.session.message = 'An error occurred processing your import. Please check the URL and try again.'>
			</Cfcatch>	
		</Cftry>
		<cfset relocate('/index.cfm/content/event')>
		</cfif>
	</cffunction>
	
	<cffunction name="recurEvent">
	  <cfargument name="event" />

	  <cfscript>
		var rc = event.getCollection();
		if (isdefined('rc.repeat') and rc.repeat eq 'on'){
	                // begin recurrences on next event per
	                // repeat_enddate and repeat_interval form parameters
	                if(isdefined('rc.repeatEnddate') and rc.repeatEnddate neq '' and rc.repeat eq 'on'){
	                    rc.repeatEnddate = createODBCDateTime(rc.repeatEnddate);
	
	                    // peform date arithmetic to determine the number of events to create
	                    //
	                    // eligible time frame goes from the end of the initial event to the repeat_enddate
	                    dateDiff = dateDiff(rc.repeatInterval, rc.startdate, rc.repeatEnddate);
	                    rc.dateDiff = dateDiff;
	                    for (i = 0; i lt dateDiff; i = i + 1){ 
	                        rc.startdate = dateAdd(rc.repeatInterval, 1, rc.startdate);
							if (trim(rc.endDate) neq ''){
							  rc.enddate = dateAdd(rc.repeatInterval, 1, rc.enddate);
							}
	                    
	                          rc.contentID = 0;
	                          application.content.save(rc);
	                    }
	                }
	          }
	</cfscript>
	</cffunction>
	<cffunction name="heywatch">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
		  	data = {	memberID = request.session.memberID,
				  		communityID = request.community.communityID,
				  		contentType = "Video",
		  				converted = 0,
				  		image = '/images/converting_icon.png',
						container = 'user_#request.session.memberID#'};
		</cfscript>

		<cfif isdefined('rc.upload_result') and rc.upload_result neq ''>      
		    <cfset data.uploadedVideo = application.xml2struct.ConvertXmlToStruct(rc.upload_result,structNew())>
			<cfset data.videoID = uploadedVideo.id>
	    	<cfset data.title = uploadedVideo.title>
	        <cfset data.contentID = application.content.save(data)>
			<cfhttp method="post" url="http://heywatch.com/job.xml" redirect="no" username="bblaze" password="bblaze" result="jobResult">
				<cfhttpparam name="video_id" value="#data.uploadedVideo.id#" type="formfield" />
				<cfhttpparam name="default_format" value="true" type="formfield" />
				<cfhttpparam name="ping_url_after_encode" value="http://#cgi.http_host#/index.cfm/content/import/heywatchEncode/contentID/#data.contentID#/memberID/#data.memberID#/communityID/#data.communityID#" type="formfield">
				<cfhttpparam name="ping_url_if_error" value="http://#cgi.http_host#/index.cfm/content/import/heywatchError/contentID/#data.contentID#/memberID/#data.memberID#" type="formfield">
			</cfhttp>
			<cfset log.debug('sending heywatch job request',  data: data)>
	    <cfelseif isdefined('rc.url') and rc.url neq ''>
			<cfset data.videoURL = rc.url>
   	    	<cfset data.contentID = application.content.save(data)>
		
 	      	<cfhttp method="post" url="http://heywatch.com/download.xml" redirect="no" username="bblaze" password="bblaze" result="downloadResult">
        		<cfhttpparam name="url" value="#data.videourl#" type="formfield" />
		        <cfhttpparam name="default_format" value="true" type="formfield" />
		        <cfhttpparam name="ping_url_after_transfer" value="http://#cgi.http_host#/index.cfm/content/import/heywatchTransfer/contentID/#data.contentID#/memberID/#data.memberID#/communityID/#data.communityID#" type="formfield">
				<cfhttpparam name="ping_url_if_error" value="http://#cgi.http_host#/index.cfm/content/import/heywatchError/contentID/#data.contentID#/memberID/#data.memberID#" type="formfield">
				<cfhttpparam name="http_upload_directive" value="http://#cgi.http_host#/upload" type="formfield" />
			</cfhttp>
			<Cfset data.http = downloadResult>
			<cfset log.debug('sending heywatch download request', data)>
			
		<cfelseif isdefined('rc.putID') and rc.putID neq ''>
			<cfif rc.putTypeUStream eq 'user'>
				<cfhttp url="http://api.ustream.tv/xml/#rc.putTypeUStream#/#rc.putID#/listAllVideos?key=9C5943BB89D12F2DB12311B81BB4E57A&limit=100" method="get"/>
			<cfelseif rc.putTypeUStream eq 'channel'>
				<cfhttp url="http://api.ustream.tv/xml/#rc.putTypeUStream#/#rc.putID#/listAllVideos?key=9C5943BB89D12F2DB12311B81BB4E57A&limit=100" method="get"/>
			<cfelseif rc.putTypeUStream eq 'video'>
				<cfhttp url="http://api.ustream.tv/xml/#rc.putTypeUStream#/#rc.putID#/getInfo?key=9C5943BB89D12F2DB12311B81BB4E57A&limit=100" method="get"/>
			</cfif>
			
			<cfscript>
			xmlDoc = xmlParse(cfhttp.filecontent);

			myRoot = xmlDoc.xmlRoot.xmlChildren[1].xmlChildren;
			
			arrID = xmlSearch(xmlDoc, '/xml/results/array/id');
			arrTitle = xmlSearch(xmlDoc, '/xml/results/array/title');
			arrDesc = xmlSearch(xmlDoc, '/xml/results/array/description');
			arrCreated = xmlSearch(xmlDoc, '/xml/results/array/createdAt');
			arrEmbed = xmlSearch(xmlDoc, '/xml/results/array/embedTag');
			arrImage = xmlSearch(xmlDoc, '/xml/results/array/imageUrl/medium');
			
			for(i=1;i lte arrayLen(arrID); i++){
				newData = {	ustreamID = arrID[i].xmlText,
							title = arrTitle[i].xmlText,
							desc = arrDesc[i].xmlText,
							dateCreated = arrCreated[i].xmlText,
							publishDate = arrCreated[i].xmlText,
							embed = arrEmbed[i].xmlText,
							converted = 1,
							private = 0,
							rating = 1,
							comments = 1,
							explicit = 0,
							flagged = 0,
							approved = 1,
							isDeleted = 0,
							image = application.image.downloadImage(arrImage[i].xmlText, request.session.memberID)};
				structAppend(data,newData, true);
				
				data.embed = replace(data.embed, '320','580','all');
				data.embed = replace(data.embed, '260','320','all');
				data.embed = replace(data.embed, '<param value="true" name="allowfullscreen">','<param value="transparent" name="wmode">','all');
				data.embed = replace(data.embed, '<embed ','<embed wmode="transparent" ','all');
				
				checkContent = application.content.get(attribute='ustreamID', attributeValue=data.ustreamID);

				if (checkContent.recordcount eq 0){
					data.contentID = application.content.save(data);
				}
			}
			</cfscript>
			
   	    <cfelseif isdefined('rc.embed') and  rc.embed neq ''>
			<cfset data = {	converted = 1,image = '/images/nothumbnail_icon.png'}>
			<cfset data.contentID = application.content.save(data)>
	    </cfif>
		<Cfset rc.contentID = data.contentID>
	</cffunction> 
	
	<cffunction name="heywatchTransfer" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			log.debug('start transfer', rc);
		</cfscript>
		<!--- run the video conversion job --->
		<cfhttp method="post" url="http://heywatch.com/job.xml" redirect="no" username="bblaze" password="bblaze" result="jobResult">
	    	<cfhttpparam name="video_id" value="#rc.video_id#" type="formfield" />
		    <cfhttpparam name="default_format" value="true" type="formfield" />
	        <cfhttpparam name="ping_url_after_encode" value="http://#cgi.http_host#/index.cfm/content/import/heywatchEncode/contentID/#rc.contentID#/memberID/#rc.memberID#/communityID/#rc.communityID#" type="formfield">
		    <cfhttpparam name="ping_url_after_error" value="http://#cgi.http_host#/index.cfm/content/import/heywatchError/contentID/#rc.contentID#/memberID/#rc.memberID#" type="formfield">
		</cfhttp>
		<cfset log.debug('conversion started', jobresult)>
		<cfset event.renderData('plain','ok')>
	</cffunction>
	
	<cffunction name="heywatchEncode" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		</cfscript>
		<cfset log.debug('starting video encoding', rc)>

			<cftry>
			<cfif structKeyExists(rc, "job_id")>
			  <!--- if the job conversion has completed --->
				<Cfhttp method="get" url="http://heywatch.com/encoded_video/#form.encoded_video_id#.json" username="bblaze" password="bblaze">
				<cfset jobDetails = deserializeJSON(cfhttp.fileContent)>
				<cfset log.debug('job details', jobdetails )>
				
				<cfhttp method="get" url="#jobDetails.specs.thumb#" path="/tmp/getUpload" file="#replace(rc.filename, '.mp4','')#.jpg" getAsBinary="yes" result="thumbDetail">
				<cfhttp method="get" url="#jobDetails.link#" path="/tmp/getUpload/" username="bblaze" password="bblaze" file="#rc.fileName#" getAsBinary="yes" result="videoDetail">

			  	<cfscript>
			    //update the contentstore, content.converted=1
				  	content = {	contentType = 'Video',
						  		contentID = rc.contentID,
							  	converted = 1,
				  			  	container = 'user_#rc.memberID#',
								length = jobdetails.specs.video.length,
								width = jobdetails.specs.video.width,
								height = jobDetails.specs.video.height};
					
					session.mosso = CreateObject("component", "model.cloudfiles").init(application.MOSSO_USER, application.MOSSO_KEY);
					if ( session.mosso.createContainer(content.container)){	uri = session.mosso.enableCDN(content.container);	}
					containerDetails = session.mosso.getContainer(content.container);

					session.mosso.putObject( content.container, rc.fileName, '#application.tempUpload#/#rc.filename#', jobDetails.specs.mime_type);
					session.mosso.putObject( content.container, '#replace(rc.filename, '.mp4','')#.jpg', '#application.tempUpload#/#replace(rc.filename, '.mp4','')#.jpg', thumbDetail.responseHeader['content-type']);					
					fileDelete('#application.tempUpload#/#rc.filename#');
					fileDelete('#application.tempUpload#/#replace(rc.filename, '.mp4','')#.jpg');					

					// STORE VIDEO IN FILE TABLE 
					rc.data = {
						cdnurl = containerDetails.cdn.uri,
						container = content.container,
						file = rc.filename,
						filesize = videoDetail.responseheader['content-length'],
						originalName = rc.filename,
						contentID = rc.contentID
						
					};
					rc.data.fileID = application.server.storage.save(rc.data,0);
					
					content.file = "#rc.data.cdnurl#/#rc.filename#";

					// STORE THUMBNAIL IN FILE TABLE 
					rc.data = {
						cdnurl = containerDetails.cdn.uri,
						container = content.container,
						file = '#replace(rc.filename, '.mp4','')#.jpg',
						filesize = thumbDetail.responseheader['content-length'],
						originalName = '#rc.filename#.jpg',
						contentID = rc.contentID
					};
					rc.data.fileID = application.server.storage.save(rc.data,0)

				  	content.image = "#rc.data.cdnurl#/#replace(rc.filename, '.mp4','')#.jpg";
				  	rc.contentID = application.content.save(content,0);
		
			  </cfscript>
			  <cfset log.debug('encoding successful', content)>
			</cfif>
			
				<cfcatch>
					<Cfscript>
						content = { contentID = rc.contentID, image = "/images/error_icon.png"};
					  	contentID = application.content.save(content,0);
						log.debug('encoding failure', {catch: cfcatch, content: content});
					</Cfscript>
				</cfcatch>
		</cftry>
		<cfset event.renderData('plain','ok')>
	</cffunction>
	
	<cffunction name="heywatchError" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			log.debug('heywatch error', rc);
		</cfscript>
		<cfscript>
			content = {	contentType = 'Video',
					  	contentID = rc.contentID,
		  				converted = 0,
		  				image = "/images/error_icon.png"};
		  	contentID = application.content.save(content,0);
		</cfscript>
		<cfset event.renderData('plain','ok')>
	</cffunction>
	
	<cffunction name="fileTypeIcon">
		<cfargument name="event" />
	    <cfscript>	
			var rc = event.getCollection();
		if( isdefined('rc.file') and rc.file neq ''){
			rc.extension = listlast(trim(rc.file), '.');
			rc.Size = fileinfo('#application.filestore#/../#trim(rc.file)#').size;
			rc.image = '#application.cdn.fam#help.png';
			rc.filetype = 'unknown';
			switch ('#rc.extension#'){
			case "jpg": 
				rc.image = '#application.cdn.fam#image.png';
				rc.filetype='Image - JPG';
				break;
				
			case "gif": 
				rc.image = '#application.cdn.fam#image.png';
				rc.filetype='Image - GIF';
				break;
				
			case "bmp": 
				rc.image = '#application.cdn.fam#image.png';
				rc.filetype='Image - BMP';
				break;
				
			case "tif":
				rc.image = '#application.cdn.fam#image.png';
				rc.filetype='Image - TIF';
				break;
				
			case "png": 
				rc.image = '#application.cdn.fam#image.png';
				rc.filetype='Image - PNG';
				break;
				
			case "psd": 
				rc.image = '#application.cdn.fam#image.png';
				rc.filetype='Photoshop';
				break;
				
			case "pdf": 
				rc.image = '#application.cdn.fam#book.png';
				rc.filetype='Adobe Acrobat';
				break;
				
			case "doc": 
				rc.image = '#application.cdn.fam#book.png';
				rc.filetype='Microsoft Word';
				break;
	
			case "docx": 
				rc.image = '#application.cdn.fam#book.png';
				rc.filetype='Microsoft Word';
				break;
			
			case "log": 
				rc.image = '#application.cdn.fam#application_form_edit.png';
				rc.filetype='Log File';
				break;
				
			case "msg": 
				rc.image = '#application.cdn.fam#email.png';
				rc.filetype='Mail Message';
				break;
				
			case "rtf": 
				rc.image = '#application.cdn.fam#book.png';
				rc.filetype='Rich Text Format';
				break;
	
			case "wpd": 
				rc.image = '#application.cdn.fam#book.png';
				rc.filetype='Word Perfect';
				break;
				
			case "wps": 
				rc.image = '#application.cdn.fam#book.png';
				rc.filetype='Microsoft Works';
				break;
	
			case "csv": 
				rc.image = '#application.cdn.fam#database.png';
				rc.filetype='Comma Seperated Values';
				break;
				
			case "mdb": 
				rc.image = '#application.cdn.fam#database.png';
				rc.filetype='Microsoft Access';
				break;
				
			case "ppt": 
				rc.image = '#application.cdn.fam#television.png';
				rc.filetype='Microsoft Powerpoint';
				break;
				
			case "sql": 
				rc.image = '#application.cdn.fam#database.png';
				rc.filetype='SQL';
				break;
				
			case "xls": 
				rc.image = '#application.cdn.fam#database.png';
				rc.filetype='Microsoft Excel';
				break;
				
			case "xlsx": 
				rc.image = '#application.cdn.fam#database.png';
				rc.filetype='Microsoft Excel';
				break;
				
			case "xml": 
				rc.image = '#application.cdn.fam#tag.png.png';
				rc.filetype='XML';
				break;
				
			case "wav": 
				rc.image = '#application.cdn.fam#music.png';
				rc.filetype='WAVE Audio';
				break;
				
			case "mp3": 
				rc.image = '#application.cdn.fam#music.png';
				rc.filetype='MP3 Audio';
				break;
				
			case "WMA": 
				rc.image = '#application.cdn.fam#music.png';
				rc.filetype='Windows Media Audio';
				break;
				
			case "aif": 
				rc.image = '#application.cdn.fam#music.png';
				rc.filetype='Audio Interchange File';
				break;
	
			case "avi": 
				rc.image = '#application.cdn.fam#television.png';
				rc.filetype='Audio Video Interleave';
				break;
				
			case "flv": 
				rc.image = '#application.cdn.fam#television.png';
				rc.filetype='Flash Video';
				break;
				
			case "mov": 
				rc.image = '#application.cdn.fam#television.png';
				rc.filetype='Quicktime Movie';
				break;
				
			case "mp4": 
				rc.image = '#application.cdn.fam#television.png';
				rc.filetype='MPEG-4 Video';
				break;
				
			case "mpg": 
				rc.image = '#application.cdn.fam#television.png';
				rc.filetype='MPEG Video';
				break;
				
			case "swf": 
				rc.image = '#application.cdn.fam#television.png';
				rc.filetype='Flash Movie';
				break;
	
			case "zip": 
				rc.image = '#application.cdn.fam#package.png';
				rc.filetype='Zip File';
				break;
	
			case "rar": 
				rc.image = '#application.cdn.fam#package.png';
				rc.filetype='WinRAR file';
				break;
			}
		}
		</cfscript>
	</cffunction>

	
</cfcomponent>

