<cfif (listFindNoCate(event.getCurrentEvent(), 'member.signup.details')
	or 	( request.session.login eq 0 and request.community.private eq 1)>
	<div id="menuBar"><ul></ul></div>
	<div style="height:0px; clear:both;"></div>
<cfelse>
	<cfscript>
		menu = event.getvalue('menu');
	</cfscript>
	
	<cfif application.community.settings.getValue('menu_position') neq 'side'>
	<div id="menuBar">
		<ul>
	    <cfoutput query="menu">
			<cfset ulstyle = ''> 
			<cfif request.session.accesslevel gte visibleto>
				
				<cfif menu.currentrow eq 1>
					<cfset ulstyle = 'first'>
				<cfelseif menu.currentrow eq menu.recordcount>
					<cfset ulstyle = 'last'> 
				</cfif>

				<cfif menu.type eq 0 and   menu.cms eq request.page.id>
					<cfset ulstyle = ulstyle & ' active'>
				<cfelseif menu.type eq 2 and menu.feature neq 0 and listGetAt(application.cms.menu.getFeatures(menu.feature).url, 1, '/') eq request.page.id>
					<cfset ulstyle = ulstyle & ' active'>
				<cfelseif menu.type eq 2 and request.page.id eq 'home' and application.cms.menu.getFeatures(menu.feature).url eq '/index.cfm' >
					<cfset ulstyle = ulstyle & ' active'>
				</cfif>
				
				<li <cfif ulstyle neq ''>class="#ulstyle#"</cfif>>
					<a class="itemlabel" href="<cfif menu.type eq 0>#menu.cms#<cfelseif menu.type eq 1>#menu.url#<cfelseif menu.type eq 2>#application.cms.menu.getFeatures(feature).url#</cfif>" <cfif newWindow eq '1'>target="_blank"</cfif>><span>#title#</span></a>
				</li>
			</cfif>
		</cfoutput>
		</ul>
		<div style="height:0px; clear:both;"></div>
	</div>
	</cfif>	
</cfif>