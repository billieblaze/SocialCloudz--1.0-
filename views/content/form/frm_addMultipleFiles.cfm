<cfscript>
	q_content = event.getvalue('q_content');
</cfscript>
<cfoutput>
<div class="ui-widget">
	<div class="ui-widget-header">Files</div>
    <div class="ui-widget-content">
		<cfif event.getvalue('contentID') eq 0> 
			Enter details and save your post, then you will be able to upload files to it.
		<cfelse>
			<div style="width:99%">
				<cfmodule template="/customTags/multiUploader.cfm" mediatype='#event.getvalue('contentType')#' directory='/users/#memberID#/#event.getvalue('contentType')#/#q_content.contentID#' actionfile='#rc.content.submitChildPostURL#' contentID='#rc.contentID#'  oncomplete='/#event.getvalue('contentType')#/form/#q_content.contentID#?r=#createuuid()###tabs-2'/>
			</div>
		</cfif>
    </div>
</div> 
</cfoutput>