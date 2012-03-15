<cfsetting showdebugoutput="no">
<cfoutput>
	<div class="tabs">
	<ul>
		<li><a href="#event.buildLink(linkTo='cms.modules.list',queryString='type=community&page=#rc.page#')#">Community</a></li>
		<li><a href="#event.buildLink(linkTo='cms.modules.list',queryString='type=media&page=#rc.page#')#">Media</a></li>
		
		<Cfif rc.type neq ''>
			<li><a href="#event.buildLink(linkTo='cms.modules.list',queryString='type=content&page=#rc.page#')#">Media Nav</a></li>
		</cfif>
		
		<li><a href="#event.buildLink(linkTo='cms.modules.list',queryString='type=widget&page=#rc.page#')#">Widgets</a></li>
   		<li><a href="#event.buildLink(linkTo='cms.modules.list',queryString='type=promote&page=#rc.page#')#">Promote</a></li>        
     	
		<cfif application.community.settings.getValue('Ads') eq 1 and request.session.accesslevel gte 10>
       		<li><a href="#event.buildLink(linkTo='cms.modules.list',queryString='type=advertising&page=#rc.page#')#">Advertising</a></li>
        </cfif>
       	
		<cfif request.session.accesslevel gte 10> 
			<li><a href="#event.buildLink(linkTo='cms.modules.listMyModules',queryString='page=#rc.page#')#">My Modules</a></li>
		</cfif>
	</ul>
	</div>
</cfoutput>