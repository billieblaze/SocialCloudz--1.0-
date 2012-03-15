<cfoutput>
	<div id="menuBar">
		<ul>
			<cfif request.session.accesslevel gte 100>
			<li class="first">
				<a class="itemlabel" href="#event.buildLink('app.admin.index')#">App</a>
			</li>
			</cfif>
			<li class="first">
				<a class="itemlabel" href="#event.buildLink('community.admin.index')#">Communities</a>
			</li>
	
			<li class="">
				<a class="itemlabel" href="#event.buildLink('content.admin.index')#">Content</a>
			</li>
			<li class="">
				<a class="itemlabel" href="/">Back</a>
			</li>
		</ul>
	</div>
	<div style="height:0px; clear:both;"></div>
</cfoutput>