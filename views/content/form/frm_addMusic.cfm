<cfscript>
	q_childcontent = event.getvalue('q_childcontent','');
	q_content = event.getvalue('q_content');
</cfscript>
<cfparam name="rc.genre" default="">

<cfoutput>
	#renderView('content/form/frm_top')#
	 <div class="ui-widget">
	<div class="ui-widget-header">Add Music</div>
    <div class="ui-widget-content" align="Center">
<div id="tabs">
    <ul>
        <li><a href="##tabs-1" class="blackText">Details</a></li>
	   	<cfif q_content.contentID neq 0 and q_content.contentID neq ''>
			 <li><a href="##tabs-2" class="blackText">Add Songs</a></li>
		 </cfif>
	    <cfif  q_content.contentID neq 0 and q_content.contentID neq '' and q_childContent.recordcount gt 0>
        <li><a href="##tabs-3" class="blackText">Edit Songs</a></li>
        </cfif>
    </ul>            
    <div id="tabs-1">
		Artist<BR /><input type="text" name="creator" value="#rc.creator#" maxlength="255" style="width:100%"><BR /><BR />Title<BR /><input type="text" name="title" value="#rc.title#" maxlength="255" style="width:100%"><BR /><BR />

    	Track Listing / Description
		#application.form.textEditor('desc', rc.desc)#
	
		<BR>
		<div align="center">
		By submitting this entry, you agree to the 
        <a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions" class="blackText">Terms & Conditions</a>.<br />
<br />
<input  type="submit" class="button" value="Save"><input type="button" value="Cancel" onclick="history.back();" class="button" />
</div>

        </div>
		    <cfif q_content.contentID neq 0 and q_content.contentID neq ''>
		 <div id="tabs-2" class="ui-tabs-hide">   
			<cfmodule template="/customTags/multiUploader.cfm" mediatype='#event.getvalue('contentType')#' directory='/users/#request.session.memberID#/#event.getvalue('contentType')#/#q_content.contentID#' actionfile='#rc.content.submitChildPostURL#' contentID='#rc.contentID#'  oncomplete='/index.cfm/content/form/#event.getvalue('contentType')#/#q_content.contentID#?r=#createuuid()###tabs-3'/>
		</div>
		
        <cfif isQuery(q_childContent) and q_childcontent.recordcount gt 0>
	        <div id="tabs-3">   
		    <iframe src="/index.cfm/content/form/child/#event.getvalue('contentType')#/#q_content.contentID#" scrolling="yes" height="600" width="100%" frameborder="0"></iframe>
	        </div>
		</cfif>
		</cfif>
</div>
</cfoutput>

