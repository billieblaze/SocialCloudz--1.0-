<cfscript>
	getModule = qGetModules;   
	members = application.members.gateway.list(limit=getmodule.displayrows, featured=getModule.featured, online = getModule.active, profileType = getModule.displayTag);
</cfscript>
<cfoutput query="members">
	    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
   		image=application.members.userpic( members.memberID ), 
		 link='/index.cfm/members/#members.username#',
	    size=getmodule.thumbsize, 
	     title=members.username,
	     showMosaic = 1 )#
</cfoutput>
<br style="clear:both" />
<div align="right" class="moduleViewAll"><a href="/index.cfm/member/util/list">View All</a></div>