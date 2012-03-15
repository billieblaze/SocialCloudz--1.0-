<cfscript>
	getModule = qGetModules;
	qActivity = application.statistics.activity.getRecentActivity(limit=getModule.displayRows);
</cfscript>

<cfoutput query="qActivity">

		    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( qActivity.memberID ), 
		    		size=getmodule.thumbSize,
		    		align=getModule.thumbAlign )#
		
	<cfif activityAction eq 'Submit'>
		<a href="/#username#">#username#</a> posted <a href='/index.cfm/content/#activityType#/#contentID#'>#application.content.get(contentID).title#</a><BR>
	</cfif>
	<cfif isvalid('date', dateEntered)>
	<span class="small">
		#application.util.dateToEnglish(dateDiff('s', application.timezone.castFromServer(now(), application.community.settings.getValue('timezone')), application.timezone.castFromServer(dateEntered, application.community.settings.getValue('timezone'))))#
	</span>
	</cfif>
	<BR>
	<br style="clear:both">
</cfoutput>
