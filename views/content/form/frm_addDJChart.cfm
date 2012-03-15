<cfoutput>
<script language="javascript" src="/scripts/form_autofocus.js"></script>
	#renderView('content/form/frm_top')#
	<div class="ui-widget">
	<div class="ui-widget-header">Add a Chart</div>
    <div class="ui-widget-content" align="Center"> 
				Title<br />
<cfif rc.title eq ''>
	<cfset rc.title="#request.session.username#'s chart for #dateformat(application.timezone.castFromServer(now(), application.community.settings.getValue('timezone')), request.community.dateformat)#">
</cfif>
<input class="normalHelp" name="title" value="#rc.title#" type="text"  maxlength="255"  style="width:100%">
				<br /><BR />

			<table width="100%" border="0">
			<TR>
				<td class="pad3">Artist</td>
				<td class="pad3">Title</td>
				<td class="pad3">Label</td>


			</tr>
			<cfloop from="1" to="10" index="i">
			<TR <cfif i mod 2> class="odd"<cfelse>class="even"</cfif>>
				<TD  class="pad3" align="center"><input type="text" name="artist_#i#" value="#application.content.getAttribute(rc.attribs, 'artist_#i#')#"></td>
				<TD  class="pad3" align="center"><input type="text" name="title_#i#" value="#application.content.getAttribute(rc.attribs, 'title_#i#')#"></td>
				<TD  class="pad3" align="center"><input type="text" name="label_#i#" value="#application.content.getAttribute(rc.attribs, 'label_#i#')#"></td>
			</tr>
			</cfloop>
			</table>


            

				  <div align="center">
 By submitting this entry, you agree to the <a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions">Terms & Conditions</a>.<br />

<br />
<input type="submit" value="Save" class="button" /><input type="button" value="Cancel" onclick="history.back();" class="button" /></div>
</div>
</div>
</div>
</cfoutput>