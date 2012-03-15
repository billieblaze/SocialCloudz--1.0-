<cfif event.getCurrentEvent() neq 'member.signup.details'>
	<cfscript>
		menu = request.layout.menu;
	</cfscript>
	
	<cfif not (request.session.login eq 0 and request.community.private eq 1) and application.community.settings.getValue('menu_position') neq 'side'>
	<div id="menuBar" data-role="navbar">
		<ul>
	    <cfoutput query="menu">
			<cfset ulstyle = ''> 
			<cfif request.session.accesslevel gte visibleto and (visibletoprofiletype eq '' or visibletoProfileType eq 0 or request.session.profileType eq visibletoProfileType or request.session.accesslevel gte 20)>
				<cfif menu.currentrow eq 1>
					<cfset ulstyle = 'first'>
				<cfelseif menu.currentrow eq menu.recordcount>
					<cfset ulstyle = 'last'> 
				</cfif>		
				<cfif menu.type eq 0 and   menu.cms eq request.page.id>
					<cfset ulstyle = ulstyle & ' active'>
				<cfelseif menu.type eq 2 and menu.feature neq 0 and ((menu.featureURL eq '/' and request.page.id eq 'home') or (listlen(menu.featureURL,'/') gt 0 and listGetAt(menu.featureURL, 1, '/') eq request.page.id))>
					<cfset ulstyle = ulstyle & ' active'>
				<cfelseif menu.type eq 2 and menu.feature neq 0 and ((menu.featureURL eq '/' and request.page.id eq 'home') or (listlen(menu.featureURL,'/') gt 0 and listGetAt(menu.featureURL, 2, '/') eq request.page.id))>
					<cfset ulstyle = ulstyle & ' active'>
				<cfelseif menu.type eq 2 and request.page.id eq 'members' and menu.feature eq 11>
					<cfset ulstyle = ulstyle & ' active'>
				<cfelseif menu.type eq 2 and request.page.id eq 'home' and menu.featureurl eq '/index.cfm' >
					<cfset ulstyle = ulstyle & ' active'>
				</cfif>
				<li <cfif ulstyle neq ''>class="#ulstyle#"</cfif>>
					<a class="itemlabel" data-role="button" href="<cfif menu.type eq 0>/pages/#menu.cms#<cfelseif menu.type eq 1>#menu.url#<cfelseif menu.type eq 2>#application.cms.menu.getFeatures(feature).url#</cfif>" <cfif newWindow eq '1'>target="_blank"</cfif>><span>#title#</span></a>
				</li>
			</cfif>
		</cfoutput>
		</ul>
		<div style="height:0px; clear:both;"></div>
	</div>
	</cfif>	
</cfif>