<cfsetting showdebugoutput="no">
<cfscript>
	application.form.ajaxFormSubmit('imageSettingsForm');
	community = event.getvalue('community');
	categories = event.getvalue('categories');
	menuFeatures = event.getvalue('menuFeatures');
	startpage = application.community.settings.getValue('startPage',community.settings);
	firstPage = application.community.settings.getValue('firstPage',community.settings);
</cfscript>

<cfoutput>
This section allows you to control the basic settings for your community.  <BR><BR>

<form action="#event.buildLink('community.settings.submit')#" method="post" class="blackText" id="imageSettingsForm">
<input type="hidden" name="communityID" value="#community.communityID#" />
<table width="100%" cellpadding="5" cellspacing="10">
<TR>
	<TD><div align="right">Favorites Icon&nbsp;</div></td><td class="padTop10">
		
 			<cfmodule template="/customTags/singleUploader.cfm" 
				fkType = "communityIcon"
				mediaType = "icon"
				autoSubmit = 0
				contentID = "#community.communityID#"
				previewType = 'none'
	/>
	</td>
</tr>
<TR>
	<TD><div align="right">Logo&nbsp;</div></td><td class="padTop10">
		 #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
				image=community.logo, 
				size=200
				 )#
		<BR />
			<cfmodule template="/customTags/singleUploader.cfm" 
				fkType = "communityLogo"
				mediaType = "image"
				autoSubmit = 0
				contentID = "#community.communityID#"
				previewType = 'image'
				previewElement = 'imagePreview'
				showClear = 1
	/>
	</td>
</tr>

<TR>
	<TD><div align="right">Watermark Images?&nbsp;</div></td><td class="padTop10">
		<input type="checkbox" name="watermarkImages" value="1" <cfif application.community.settings.getValue('watermarkImages',community.settings) eq '1'>checked</cfif>>
	</td>
</tr>
<TR>
	<TD><div align="right">Watermark Position&nbsp;</div></td><td class="padTop10">
		<cfset watermarkPosition = application.community.settings.getValue('watermarkPosition',community.settings)>		
		<select name="watermarkPosition">
			<option value="topLeft" <cfif watermarkPosition eq 'topLeft'>selected</cfif>>Top Left</option>
			<option value="topRight" <cfif watermarkPosition eq 'topRight'>selected</cfif>>Top Right</option>
			<option value="bottomLeft" <cfif watermarkPosition eq 'bottomLeft'>selected</cfif>>Bottom Left</option>
			<option value="bottomRight" <cfif watermarkPosition eq 'bottomRight'>selected</cfif>>Bottom Right</option>						
		</select>
	</td>
</tr>
  
</table>
 
<BR><BR>
<input type="submit"  value="Save"/>

</form>

</cfoutput>

<script>$('.tTip').betterTooltip({speed: 150, delay: 100});</script>