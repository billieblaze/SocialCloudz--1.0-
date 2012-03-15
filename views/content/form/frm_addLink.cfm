<cfparam name="rc.linkurl" default="">
<cfoutput>
#renderView('content/form/frm_top')#
 <div class="ui-widget">
	<div class="ui-widget-header">Add a Link</div>
    <div class="ui-widget-content" align="Center">
Title<BR />
<input name="Title" type="text" value='#rc.title#' style="width:100%"/>
<BR /><BR />
Link<BR />
<input name="linkurl" type="text"  value="#rc.linkurl#" style="width:100%"/>
<BR /><BR>
Description<BR> 
<textarea name="desc" style="width:100%" >#rc.desc#</textarea>
<br /><br />
<div align="center">
	By submitting this entry, you agree to the 
    <a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions">Terms & Conditions</a>.
	<br />
	<br />
	<input type="submit" value="Save" />
    <input type="button" value="Cancel" onclick="history.back();" class="button" />
</div>
</div>
</div>
</cfoutput> 