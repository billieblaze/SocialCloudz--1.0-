<script>
function tranferHeywatchResults(response){
	$('#upload_result').val(response);
}
</script>

<cfoutput>
	 
		#renderView('content/form/frm_top')#
		<div class="ui-widget">
	<div class="ui-widget-header">Add a Video</div>
    <div class="ui-widget-content" align="Center">
Title<br />
<input class="normalHelp" name="title" value="#rc.title#" type="text"  maxlength="255"  style="width:100%">
<br /><BR />
Description<br />
<textarea cols="75" name="desc" style="width:100%">#rc.desc#</textarea>
<BR /><BR />
<cfif rc.contentID eq '' or rc.contentID eq 0>
	There are a number of ways to add a video to our site. Choose one of the options below.<br><br>
	<div id="tabs" style="height:150px">
		<ul>
	        <li><a href="##tabs-1" class="blackText">PC</a></li>
	        <li><a href="##tabs-2" class="blackText">URL</a></li>
	        <li><a href="##tabs-3" class="blackText">UStream</a></li>
			<li><a href="##tabs-4" class="blackText">Embed</a></li>
      	</ul>

        <div id="tabs-1">
	    <span class="small">Click "Browse" and locate the file you wish to upload from your computer.</span>
		<div align="center">
        	<input name="putType" type="hidden" value="upload">
 			<input type="hidden" name="upload_result" id="upload_result">

			<cfmodule template="/customTags/singleUploader.cfm" 
				fkType = "file"
				mediaType = "video"
				autoSubmit = 0
				uploadURL = 'http://heywatch.com/upload.xml?key=#application.heyWatchKey#&memberID=#request.session.memberID#&secret=#hash('{upload}{#request.session.memberID#}{#application.privateKey#}','MD5')#'
				contentID = "#rc.contentID#"
				onComplete = 'tranferHeywatchResults'
				previewType = 'none'
			/>

			<br style="clear:both;"/><br />

		</div>
		</div>
        <div id="tabs-2">
       	<span class="small">Upload any video via URL. Paste the full video URL in the box below:</span> 
		<br /><br />
        <div align="center">
  	  	<b>URL:</b>&nbsp;
        <input name="putType" type="hidden" value="service">
        <input type="text" id="url" name="url" size="50" class="normalHelp"/><span id="urlError" style="color: red; display: none;">« Please enter a valid URL</span>
        </div>
        </div>

        <div id="tabs-3">
       	<span class="small">Upload from a UStream user, channel or videoID</span> 
		<br /><br />
	        <div align="center">
		  	  	<b>Type:</b>&nbsp;
		        <select name="putTypeUStream">
		        	<option value="user">User</option>
		        	<option value="channel">Channel</option>
		        	<option value="video">Video</option>		        	
		        </select>
		  	  	<b>ID:</b>&nbsp;
		        <input name="putID" type="text" value="">
	        </div>
        </div>
       	<div id="tabs-4">
       	<span class="small">Add a video using the embed code, simply paste the embed code in the box below<br/><br/></span>
		<div align="center">
          <input name="putType" type="hidden" value="embed">
          <textarea name="embed" style="width:75%" ></textarea>
        </div>
	    </div>
	</div>
</cfif>
<BR />
<div align="center">
	<input type="submit"  value="Save" />  <input type="button" onclick="history.back()" value="Cancel" />
</div>
</div>
</div>
</cfoutput>
		
