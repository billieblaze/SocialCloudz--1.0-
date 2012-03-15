<cfoutput> 
</div>
	
<cfif request.page.id neq 'splash'>
	    <div id="ft">
		   	<div id="ft_left"> Copyright &copy; #year(now())# #request.community.site#. All Rights Reserved. <cfif application.community.settings.getValue('Branding') eq 0><BR /> Social CMS Platform by <a href="http://#request.community.parent.baseurl#">#request.community.parent.detail.name#</a></cfif></div>
		   	<div id="ft_right">
				<a href="mailto:#request.community.owner.email#">Contact</a> |  <a href="/?ismobile=1">View Mobile Version</a> | <a href="#event.buildLink('app.help.index')#">Help</a> | <a href="#event.buildLink('app.info.terms')#">Terms of Service</a> | <a href="#event.buildLink('app.info.privacy')#">Privacy Policy</a> <!--- | <a href="/sitemap.xml">Sitemap</a> --->
		    </div>
	    </div>
	</div>
</cfif>
<div align="center">#application.advertising.showBanner(728,90,'footer')#</div>


</cfoutput>