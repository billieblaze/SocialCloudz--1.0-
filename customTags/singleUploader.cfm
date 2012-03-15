<cfif thisTag.ExecutionMode EQ "start">
<cfparam name="attributes.fkType" default="">
<cfparam name="attributes.contentID" default="">
<cfparam name="attributes.mediaType" default="Any">
<cfparam name="attributes.fileFieldName" default="Filedata">
<cfparam name="attributes.previewType" default="text">
<cfparam name="attributes.previewElement" default="text">
<cfparam name="attributes.showClear" default="0">
<cfparam name="Attributes.value" default="">
<cfparam name="attributes.autoSubmit" default="0">
<cfparam name="attributes.uploadURL" default="/upload">
<cfparam name="attributes.uploadProc" default="util.upload.general">
<cfparam name="attributes.oncomplete" default="">
<cfparam name="attributes.onclearcomplete" default="">
<cfscript>
	switch(attributes.mediatype){
		case "video":
			filedesc = 'Video Files';
	    	fileext = '*.mov;*.avi;*.mpg;*.mpeg;*.flv;*.wmv;*.mp4;*.m4v;';
			break;
		case "audio":
			filedesc = 'Audio Files';
	    	fileext = '*.mp3;*.wav;*.aif;';
			break;
		case "image":
			filedesc = 'Image Files';
	    	fileext = '*.jpg;*.gif;*.png;*.bmp;*.tif;';
			break;
		case "icon":
			filedesc = 'Icon Files';
	    	fileext = '*.ico;';
			break;
		case "flash":
			filedesc = 'Flash Files';
			fileext = '*.swf';
			break;			
		case "any":
			filedesc = 'All Files';
			fileext = '*.*';
			break;
		
	}
</cfscript>

	<cfoutput>

	<input id="#attributes.fkType#_file" name="#attributes.fkType#_file" type="file" />
	<input id="#attributes.fkType#" name="#attributes.fkType#" type="hidden" value="#attributes.value#" />
	<cfif attributes.showClear eq 1><br><a href="##" id="clearImage">Clear Image</a></cfif>
	
	<div id="fileQueue_#attributes.fkType#" style="width:75% !important;padding: 10px;overflow:auto;margin-bottom: 10px;" class="blackText">&nbsp;</div>
	
	<cfif isdefined('url.debug')>
		<div id="uploaderDebug"></div>
	</cfif>
	
	<script>
		
		function trim(str, chars) {
		    return ltrim(rtrim(str, chars), chars);
		}
		
		function ltrim(str, chars) {
		    chars = chars || "\\s";
		    return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
		}
		
		function rtrim(str, chars) {
		    chars = chars || "\\s";
		    return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
		}

		
	$('##clearImage').click(	function(){ 
		
			$('input###attributes.fkType#').val('/images/nothumbnail_icon.png');	
			$('##imagePreview').attr('src', '/images/nothumbnail_icon.png');
			<cfif attributes.onClearComplete neq ''>
				#attributes.onClearComplete#();
			</cfif>
			
	});
	var retries = 0;
	$("###attributes.fkType#_file").uploadify({
			'uploader'       : '/flash/uploadify.swf',
			'script'         : '#attributes.uploadURL#',
			'cancelImg'      : '/images/cancel.png',
			'buttonImg'      : '/images/browse-files.png',
			'wmode'          : 'transparent',
			'queueID'        : 'fileQueue_#attributes.fkType#',
			'auto'           : true,
			'multi'          : false,
			'width'          : 100,
			'fileDataName'   : '#attributes.fileFieldName#',
			'fileDesc'		 : '#fileDesc#',
			'fileExt'		 : '#fileExt#',
			'onComplete'  	 : function(event, queueID, fileObj, response, data){
								cleanResponse = trim(response);
								
								<cfif isdefined('url.debug')>
									$('##uploaderDebug').append(cleanResponse);								
								</cfif>
								
								fileData = cleanResponse.split('|');

								$('input###attributes.fkType#').val( fileData[1]);	
								<cfif attributes.previewType eq 'text'>
									$('##fileQueue_#attributes.fkType#').html(fileData[1]);
								<cfelseif attributes.previewtype eq 'image'>
									$('##imagePreview').attr('src', fileData[1]);
									$('##uploadContainer').hide();
								</cfif>
								$.jGrowl('File Uploaded.');
								<cfif attributes.onComplete neq ''>
									#attributes.onComplete#(cleanResponse);
								</cfif>
								
							},
			'onError'		: function(event, queueID, fileObj, errorObj) {
											if (errorObj.type != 'File Size' || retries <= 3) {
												retries++;
												$('###attributes.fkType#_file').uploadifyUpload(queueid);
											}
								},
			'scriptData'	 :	{
									contentID: '#attributes.contentID#', 
									memberID: '#request.session.memberID#', 
									communityID: '#request.community.communityID#', 
									fkType:'#attributes.fkType#', 
									procfile: '#attributes.uploadproc#'
								}
		});    
		
	</script>
	</cfoutput>
</cfif>