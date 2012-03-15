<script type="text/javascript">
	$(function() {
		$("#attachImageTabs").tabs();
	});
	</script>

	<input type="hidden" id="attachmentType" name="attachmenttype" value="image">
	<div id="attachImageTabs">
	<ul>
		<!--- <li><a href="#attachImagetabs-1" class="blackText">From Disk</a></li> --->
		<li><a href="#attachImagetabs-2" class="blackText">From URL</a></li>
	</ul>

	<!--- 	<div id="attachImagetabs-1">
	<cfoutput>
		<cfmodule template="/customTags/singleUploader.cfm" 
					fkType = "commentForm"
					mediaType = "image"
					directory = '/users/#url.memberID#/comments'
					autoSubmit = 0
					uploadURL = "uploadCommentImage.cfm"
					contentID = "#url.memberID#"
		/>
	</cfoutput>
    <BR style="clear:both" />
	</div> --->
	<div id="attachImagetabs-2">
		URL: <input type="text" id="attachmentURL" name="attachmentURL" style="width:89%">
	</div>
</div>
