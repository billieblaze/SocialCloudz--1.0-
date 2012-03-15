<cfscript>
q_childContent = event.getvalue('q_childcontent');
	q_content = event.getvalue('q_content');
</cfscript>
<cfparam name="rc.address" default="">
<cfparam name="rc.price" default="">
<cfparam name="rc.built" default="">
<cfparam name="rc.city" default="">
<cfparam name="rc.state" default="">
<cfparam name="rc.country" default="">
<cfparam name="rc.longitude" default="">
<cfparam name="rc.latitude" default="">

<cfoutput>
		#renderView('content/form/frm_top')#
	 <div class="ui-widget">
	<div class="ui-widget-header">Add a property</div>
    <div class="ui-widget-content" align="Center">
	<div id="tabs">
    	<ul>
        	<li><a href="##tabs-1" class="blackText">Details</a></li>
			<cfif q_content.contentID neq 0 and q_content.contentID neq ''>
				 <li><a href="##tabs-2" class="blackText">Add Photos</a></li>
			 </cfif>
	       <cfif q_childContent.recordcount gt 0>
		        <li><a href="##tabs-3" class="blackText">Edit Photos</a></li>
	       </cfif>
	    </ul>            

        <div id="tabs-1" class="ui-tabs-hide">
		  	Title<BR> <input  name="title" value="#rc.title#" type="text"  maxlength="255" style="width:100%">
          	<br /><BR />
			Tagline<BR> <input  name="subtitle" value="#rc.subtitle#" type="text"  maxlength="255" style="width:100%">
            <br /><BR />
			Price<BR> <input  name="price" value="#rc.price#" type="text"  maxlength="255" style="width:100%">
            <br /><BR />
			Year Built<BR> <input  name="built" value="#rc.built#" type="text"  maxlength="255" style="width:100%">
            <br /><BR />
            Description<br />
			#application.form.textEditor('desc', rc.desc)#
			<br /><br />
			By submitting this post, you agree to the 
			<a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions" class="blackText">Terms & Conditions</a>.<br />
			<br />

			<div align="center">
				<input  type="submit" class="button" value="Save">
				<input type="button" value="Cancel" onclick="history.back();" class="button" />
			</div>
        </div>
       
	    <cfif q_content.contentID neq 0 and q_content.contentID neq ''>
			 <div id="tabs-2" class="ui-tabs-hide">   
				<cfmodule template="/customTags/multiUploader.cfm" mediatype='#event.getvalue('contentType')#' directory='/users/#memberID#/#event.getvalue('contentType')#/#q_content.contentID#' actionfile='#rc.content.submitChildPostURL#' contentID='#rc.contentID#'  oncomplete='/#event.getvalue('contentType')#/form/#q_content.contentID#?r=#createuuid()###tabs-3'/>
			</div>
		</cfif>
		
		<cfif q_childContent.recordcount gt 0>
        	<div id="tabs-3" class="ui-tabs-hide">   
		    	<cfset frameHeight = q_childContent.recordcount * 200 + 100>
			    <iframe src="	/index.cfm/content/form/child/#event.getvalue('contentType')#/#q_content.contentID#" scrolling="no" height="#frameheight#" width="100%" frameborder="0"></iframe>
				<br style="clear:left" />
            </div>
       	</cfif>
	</div>
	</div>
	</div>
	</div>
</cfoutput>

<script>
	$(document).ready(function($) {
			$("#tabs").tabs();
	});
</script>