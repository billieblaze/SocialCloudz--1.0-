<cfscript>
	if ( isdefined('rc.q_childContent')){	q_childContent = event.getvalue('q_childcontent');}
	q_content = event.getvalue('q_content');
</cfscript>

<cfoutput>
		#renderView('content/form/frm_top')#
			 <div class="ui-widget">
	<div class="ui-widget-header">Add a Gallery</div>
    <div class="ui-widget-content" align="Center">
	<div id="tabs">
    	<ul>
        	<li ><a href="##tabs-1" class="blackText">Details</a></li>
			<cfif q_content.contentID neq 0 and q_content.contentID neq ''>
				 <li><a href="##tabs-2" class="blackText">Add Photos</a></li>
		 	</cfif>
	       	<cfif isDefined('q_childContent') and q_childContent.recordcount gt 0>
	        	<li><a href="##tabs-3" class="blackText">Edit Photos</a></li>
	            <li><a href="##tabs-4" class="blackText">Change Order</a></li>
	       </cfif>
	    </ul>            

        <div id="tabs-1" class="ui-tabs-hide">
			Title<BR> <input class="normalHelp" name="title" value="#rc.title#" type="text"  maxlength="255" style="width:100%">
            <br /><BR />
            Description<br /> #application.form.textEditor('desc', rc.desc)#
			<BR>
			<input name="explicit" type="checkbox" value="1" <cfif rc.explicit eq 1>checked</cfif>> 
			Gallery contains explicit content.<br /><br />
			By submitting this gallery, you agree to the 
			<a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions" class="blackText">Terms & Conditions</a>.<br />
			<br />
			<div align="center">
				<input  type="submit" class="button" value="Save">
				<input type="button" value="Cancel" onclick="history.back();" class="button" />
			</div>
      	</div>
            
        <cfif q_content.contentID neq 0 and q_content.contentID neq ''>
			<div id="tabs-2" class="ui-tabs-hide">   
				<cfmodule template="/customTags/multiUploader.cfm" 
						mediatype='#event.getvalue('contentType')#' 
						actionfile='#rc.content.submitChildPostURL#' 
						contentID='#rc.contentID#'  
						oncomplete='/index.cfm/content/form/#event.getvalue('contentType')#/#q_content.contentID#?r=#createuuid()###tabs-3'/>
			</div>
		</cfif>
		
		<cfif isDefined('q_childContent') and q_childContent.recordcount gt 0>
        	<div id="tabs-3" class="ui-tabs-hide">   
		    	<iframe src="/index.cfm/content/form/child/#event.getvalue('contentType')#/#q_content.contentID#" scrolling="yes" height="600" width="100%" frameborder="0"></iframe>
				<br style="clear:left" />
            </div>
            <div id="tabs-4" class="ui-tabs-hide">
				Drag and drop your images to change the order in which they display.  Click "Save" when finished.<BR><BR>         

   				<iframe src="/index.cfm/content/form/sort/#event.getvalue('contentType')#/#q_content.contentID#" scrolling="yes" height="600" width="100%" frameborder="0"></iframe>
			</div>
       </cfif>
	</div>
</div>
</div>
</cfoutput>

<style type="text/css">
	#sortable { list-style-type: none; margin: 0; padding: 0; }
	#sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 125px; height: 125px; font-size: 4em; text-align: center; }
</style>

<script type="text/javascript">
	 $(document).ready(function($) {
 		$("#tabs").tabs();
		$("#sortable").sortable({ stop: function(){ 
        	 var out = '';
              $("#sortable li").each(function(){
                out += $(this).attr('id').split("_")[1] + " ";
    
		 });
            	$('#myOrder').val(out);
        }});
		$("#sortable").disableSelection();

 });
</script>
