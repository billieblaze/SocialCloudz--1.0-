<cfoutput>
<script language="javascript" src="/scripts/form_autofocus.js"></script>
	#renderView('content/form/frm_top')#
	<div class="ui-widget">
	<div class="ui-widget-header">Add #rc.contentType#</div>
    <div class="ui-widget-content"> 
		Title<br />
		<input class="normalHelp" name="title" value="#rc.title#" type="text"  maxlength="255"  style="width:100%">
		<br /><BR />
		Body<br />
		#application.form.textEditor("desc",rc.desc)#
		<BR>
	  <div align="center">
			 By submitting this entry, you agree to the <a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions">Terms & Conditions</a>.<br />
			<br />
		<input type="submit" value="Save" class="button" /><input type="button" value="Cancel" onclick="history.back();" class="button" />
	</div>
	</div>
	</div>
</cfoutput>