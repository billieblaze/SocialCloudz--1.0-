<cfsetting showdebugoutput="no">
<cfscript>
	application.form.ajaxFormSubmit('generalInfoForm');
	community = event.getvalue('community');
	categories = event.getvalue('categories');
	menuFeatures = event.getvalue('menuFeatures');
	startpage = application.community.settings.getValue('startPage',community.settings);
	firstPage = application.community.settings.getValue('firstPage',community.settings);
</cfscript>

<cfoutput>
This section allows you to control the basic settings for your community.  <BR><BR>

<form action="#event.buildLink('community.settings.submit')#" method="post" class="blackText" id="generalInfoForm">
<input type="hidden" name="communityID" value="#community.communityID#" />
<table width="100%" cellpadding="5" cellspacing="10">
<TR>
	<TD><div align="right">Site Name&nbsp;</div></td><TD><input type="text" name="site" id="site" value="#community.site#" size="70" style="width:85%;"/></td><TD width="1%"><a href="##"  class="tTip" title="#application.help.getHelp('adminSiteName')#" id="adminSiteName"><img src="#application.cdn.fam#help.png"></a></td>
</tr>

<TR>
	<TD><div align="right">Site Tagline&nbsp;</div></td><TD><input type="text" name="tagline" id="tagline" value="#community.tagline#" size="70" style="width:85%;"/></td><TD><a href="##" class="tTip" title="#application.help.getHelp('adminSiteTagline')#" id="adminsiteTagline"><img src="#application.cdn.fam#help.png"></a></td>
</tr>
<TR>
	<TD class="padTop10"><div align="right">Site Category&nbsp;</div></td><TD class="padTop10">
<select name="categoryID" id="category">
<cfloop query="categories">
	<option value="#ID#" <cfif community.categoryID eq ID>selected</cfif>>#category#</option>
</cfloop>
</select> </td><TD class="padTop10"><a href="##" class="tTip" title="#application.help.getHelp('adminSiteCategory')#" id="adminsiteCategory"><img src="#application.cdn.fam#help.png"></a></td>
</tr>
<TR>
	<TD><div align="right">Keywords&nbsp;</div></td><TD><input type="text" name="keywords"  id="keywords" value="#community.keywords#" size="70" style="width:85%;"/></td><TD> <a href="##" alt="help" id="adminsiteKeywords"><img src="#application.cdn.fam#help.png"></a></td>
</tr>
<TR>
	<TD valign="top"><div align="right">Description&nbsp;</div></td><TD><textarea name="description" id="description" cols="67" style="width:85%;">#community.description#</textarea></td><TD valign="top"><a href="##" class="tTip" title="#application.help.getHelp('adminSiteDescription')#" id="adminsiteDescription"><img src="#application.cdn.fam#help.png"></a></td>
</tr>
 
</table>
 
<BR><BR>
<input type="submit"  value="Save"/>

</form>

</cfoutput>

<script>$('.tTip').betterTooltip({speed: 150, delay: 100});</script>