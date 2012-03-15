<cfif thisTag.ExecutionMode EQ "start">
	<cfparam name="attributes.mediaType" default="">
	<cfparam name="attributes.directory" default="">
	<cfparam name="attributes.actionFile" default="">
	<cfparam name="attributes.contentID" default="">
	<cfparam name="attributes.onComplete" default="">
	<cfparam name="attributes.fileFieldName" default="filedata">
	<cfscript>
		switch(attributes.mediatype){
			case "video":
				filedesc = 'Video Files';
		    	fileext = '*.mov;*.avi;*.mpg;*.mpeg;*.flv;*.wmv;*.mp4;*.m4v;';
				break;
			case "music":
				filedesc = 'Audio Files';
		    	fileext = '*.mp3;*.wav;*.aif';
				break;
			case "gallery":
				filedesc = 'Image Files';
		    	fileext = '*.jpg;*.gif;*.png;*.bmp;*.tif';
				break;
			case "property":
				filedesc = 'Image Files';
		    	fileext = '*.jpg;*.gif;*.png;*.bmp;*.tif';
				break;
			case "any":
				filedesc = 'All Files';
				fileext = '*.*';
				break;
			
		}
	</cfscript>

	<cfoutput>
		<div id="fileQueue" style="width:100%;padding: 0;overflow:auto;margin-bottom: 10px;" class="blackText">&nbsp;</div>
		<input id="file" name="file" type="file" />
		
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
		var retries = 0;
			$("##file").uploadify({
					'uploader'       : '/flash/uploadify.swf',
					'script'         : '/upload',
					'cancelImg'      : '/images/cancel.png',
					'buttonImg'      : '/images/browse-files.png',
					'wmode'          : 'transparent',
					'width'          : 100,
					'simUploadLimit' : 3,
					'queueID'        : 'fileQueue',
					'auto'           : true,
					'multi'          : true,
					'fileDataName'   : '#attributes.fileFieldName#',
					'fileDesc'		 : '#fileDesc#',
					'fileExt'		 : '#fileExt#',
					'onComplete'		: function(event, queueID,fileObj,response, data){
											if (response.type === "HTTP")
													alert('error '+d.type+": "+d.status);
											},
					'onAllComplete'  	 : function(event, queueID, fileObj, response, data){
					
										    location.href = '#attributes.oncomplete#';
										    
										},
					'onError'		: function(event, queueID, fileObj, errorObj) {
											if (errorObj.type != 'File Size' || retries <= 3) {
												retries++;
												$('##file').uploadifyUpload(queueid);
											}
								},
					'scriptData'	 :	{
											procFile: "#attributes.actionfile#", 
											directory:"#attributes.directory#",
											memberID:"#request.session.memberID#",
											communityID:"#request.community.communityID#",
											contentID:"#attributes.contentID#"
										}
				});    
			
		</script>
	</cfoutput>
</cfif>