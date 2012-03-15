<cfscript>
		q_content = rc.contentModuleData.query;
		getModule = qGetModules;
</cfscript>
	<cfoutput query='q_content'>
		<cfset myURL = '/index.cfm/content/#q_content.contentType#/#evaluate('q_content.#q_content.linkID#')#'>
		<cfif getmodule.thumbsize neq 0>
			<div style="float:left">
			#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image, myURL, getmodule.thumbsize, q_content.title )#
			</div>
		</cfif>
		<div>
		<a href="#myURL#">#q_content.title#</a><BR />
		<span class="small">#application.members.getusername(q_content.memberid,1)# on #dateformat(application.timezone.castFromServer(q_content.publishDate, application.community.settings.getValue('timezone')), request.community.dateformat)#</span>
		</div>
		<br style="clear:both">
	</cfoutput>
