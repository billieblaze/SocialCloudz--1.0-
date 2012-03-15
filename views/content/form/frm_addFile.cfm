<cfoutput>
	
<cfparam name="rc.file" default="">
<div class="ui-widget">

	<div class="ui-widget-header">File</div>
	<div class="ui-widget-content" align="center">
<cfif rc.file neq ''>
	#rc.file#
<cfelse>
	<cfmodule template="/customTags/singleUploader.cfm" 
				fkType = "file"
				mediaType = "any"
				autoSubmit = 0
				contentID = "#rc.contentID#"
	/>
</cfif>

</div>
</div>

</cfoutput>