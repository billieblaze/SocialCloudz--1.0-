<cfsetting showdebugoutput="no">
<cfscript>
	application.form.ajaxFormSubmit('integrationSettingsForm');
	community = event.getvalue('community');
	categories = event.getvalue('categories');
	menuFeatures = event.getvalue('menuFeatures');
	startpage = application.community.settings.getValue('startPage',community.settings);
	firstPage = application.community.settings.getValue('firstPage',community.settings);
</cfscript>

<cfoutput>
This section allows you to control the basic settings for your community.  <BR><BR>

<form action="#event.buildLink('community.settings.submit')#" method="post" class="blackText" id="integrationSettingsForm">
<input type="hidden" name="communityID" value="#community.communityID#" />
<table width="100%" cellpadding="5" cellspacing="10">
<TR>
	<TD valign="top" class="padTop10"><div align="right">Google Analytics ID&nbsp;</div></td>
	<TD valign="top" class="padTop10">
		<input type="text" name="google" id="google" value="#community.google#"><BR>
		Example: UA-8341242-4
	</td>
	<TD valign="top" class="padTop10"><a href="##"class="tTip" title="#application.help.getHelp('adminGoogleAnalytics')#" id="adminGoogleAnalytics"><img src="#application.cdn.fam#help.png"></a></td>
</tr>

<TR>
	<TD valign="top" class="padTop10"><div align="right">Microsoft / Bing ID&nbsp;</div></td>
	<TD valign="top" class="padTop10">
		<input type="text" name="microsoft" id="microsoft" value="#community.microsoft#"><BR>
		Example: B4E7ACD27ED94776B4123B38DC647C50
	</td>
	<TD valign="top" class="padTop10"><a href="##"class="tTip" title="#application.help.getHelp('adminGoogleAnalytics')#" id="adminGoogleAnalytics"><img src="#application.cdn.fam#help.png"></a></td>
</tr>
<cfset facebookLogin = application.community.settings.getValue('facebookLogin',request.community.settings)>
<TR>
	<TD valign="top" class="padTop10"><div align="right">Allow Facebook Login&nbsp;</div></td>
	<TD valign="top" class="padTop10">
		<select name="facebookLogin">
			<option value='0' <cfif facebookLogin eq '0'>selected</cfif>>No</option>	
			<option value='1' <cfif facebookLogin eq '1'>selected</cfif>>Yes</option>
		</select>
	</td>
	<TD valign="top" class="padTop10"><a href="##"class="tTip" title="#application.help.getHelp('adminFacebookAPI')#" id="adminFacebookAPI"><img src="#application.cdn.fam#help.png"></a></td>
</tr>
<TR>
	<TD valign="top" class="padTop10"><div align="right">Facebook API Key&nbsp;</div></td>
	<TD valign="top" class="padTop10">
		<input type="text" name="facebookAPI" id="facebookAPI" value="#application.community.settings.getValue('facebookAPI',community.settings)#"><BR>
		Example: 89e956b453700fea33096b23f87ae27d
	</td>
	<TD valign="top" class="padTop10"><a href="##"class="tTip" title="#application.help.getHelp('adminFacebookAPI')#" id="adminFacebookAPI"><img src="#application.cdn.fam#help.png"></a></td>
</tr>
<TR>
	<TD valign="top" class="padTop10"><div align="right">Facebook APP Secret&nbsp;</div></td>
	<TD valign="top" class="padTop10">
		<input type="text" name="facebookAppSecret" id="facebookAppSecret" value="#application.community.settings.getValue('facebookAppSecret',community.settings)#"><BR>
		Example: 89e956b453700fea33096b23f87ae27d
	</td>
	<TD valign="top" class="padTop10"><a href="##"class="tTip" title="#application.help.getHelp('adminFacebookAPI')#" id="adminFacebookAPI"><img src="#application.cdn.fam#help.png"></a></td>
</tr>

<cfset linkedinLogin = application.community.settings.getValue('linkedinLogin',request.community.settings)>
<TR>
	<TD valign="top" class="padTop10"><div align="right">Allow LinkedIn Login&nbsp;</div></td>
	<TD valign="top" class="padTop10">
		<select name="linkedInLogin">
			<option value='0' <cfif linkedInLogin eq '0'>selected</cfif>>No</option>	
			<option value='1' <cfif linkedInLogin eq '1'>selected</cfif>>Yes</option>
		</select>
	</td>
	<TD valign="top" class="padTop10"><a href="##"class="tTip" title="#application.help.getHelp('adminFacebookAPI')#" id="adminFacebookAPI"><img src="#application.cdn.fam#help.png"></a></td>
</tr>
<TR>
	<TD valign="top" class="padTop10"><div align="right">LinkedIn API Key&nbsp;</div></td>
	<TD valign="top" class="padTop10">
		<input type="text" name="linkedInAPI" id="linkedInAPI" value="#application.community.settings.getValue('linkedInAPI',community.settings)#"><BR>
	</td>
	<TD valign="top" class="padTop10"><a href="##"class="tTip" title="#application.help.getHelp('linkedInAPI')#" id="linkedInAPI"><img src="#application.cdn.fam#help.png"></a></td>
</tr>
<TR>
	<TD valign="top" class="padTop10"><div align="right">LinkedIn API Secret&nbsp;</div></td>
	<TD valign="top" class="padTop10">
		<input type="text" name="linkedInSecret" id="linkedInSecret" value="#application.community.settings.getValue('linkedInSecret',community.settings)#"><BR>
	</td>
	<TD valign="top" class="padTop10"><a href="##"class="tTip" title="#application.help.getHelp('linkedInSecret')#" id="linkedInSecret"><img src="#application.cdn.fam#help.png"></a></td>
</tr>
</table>
 
<BR><BR>
<input type="submit"  value="Save"/>

</form>

</cfoutput>

<script>$('.tTip').betterTooltip({speed: 150, delay: 100});</script>