
<cfoutput>

	<cfif request.page.id neq 'splash'>
		<div id="#request.layout.width#" class="yui-t#request.layout.template# bodyContent">
			<cfif application.community.settings.getValue('menu_position') eq 'above'>
				<Cfif request.layout.headerFile eq ''>
					<cfinclude template="menu.cfm">
				<cfelse>
				
				</cfif>
			</cfif>
		<A href="/" style="text-decoration:none">
		<div id="hd" <cfif application.community.settings.getValue('menu_position') eq 'above'>style="margin:0;"</cfif>>
			<Cfif request.layout.headerFile eq ''>
				<cfif fileExists(expandPath('/custom/#request.community.communityID#/dsp_header.cfm')) eq 1>
					<cfinclude template ='/custom/#request.community.communityID#/dsp_header.cfm'>
				<cfelse>
					<div id="siteLogo"></div>
					<div id="siteName">#request.community.site#</div>
				    <div id="siteTagLine">#request.community.tagline#</div>
				</cfif>
				<cfset flashHeader = application.community.settings.getValue('flashHeader')>
				<Cfif flashHeader neq ''>
					 <script type="text/javascript">
						 flashHeaderHeight =  $('##hd').height();
						 flashHeaderWidth = $('##hd').innerWidth();
						
					    swfobject.embedSWF("#flashHeader#", "hd", flashHeaderWidth, flashHeaderHeight, '9.0.0', null, null, null, {wmode:"opaque"});
				    </script>
				</cfif>
			<cfelse>
				<cfinclude template ='#request.layout.headerFile#'>	
			</cfif>
		</div>
		</A>
			<Cfif request.layout.menuFile eq ''>
				<cfif application.community.settings.getValue('menu_position') eq 'below'>
					<cfinclude template="menu.cfm">
				</cfif>
			<Cfelse>
				<cfinclude template ='#request.layout.menuFile#'>	
			</cfif>

	</cfif>
		<div id="bd">
			<div align="center">#application.advertising.showBanner(728,90,'contentBottom')#</div>
</cfoutput> 