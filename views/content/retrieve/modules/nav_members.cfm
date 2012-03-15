<cfscript>
q_content = rc.content.query;
getModule = qGetModules;
members = application.members.group.getMembers(contentID=q_content.contentID);
</cfscript>
<cfoutput>

	<cfif request.session.login eq 1>
		<cfif application.members.isgroupmember(contentID=q_content.contentID, memberid = request.session.memberid)>
			<div align="right"> <a href="#event.buildLink(linkTo='member.groups.unjoin',queryString='contentID=#q_content.contentID#')#">Unjoin This Group</a></div>
		<cfelse>
			<div align="right"> <a href="#event.buildLink(linkTo='member.groups.join',queryString='contentID=#q_content.contentID#')#">Join This Group</a></div>
		</cfif>
	</cfif>

	<cfloop query="members">
		    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
			    		image=application.members.userpic( memberID ), 
			    		link='/index.cfm/members/members.username'
			    		size=getmodule.thumbSize )#
	</cfloop>

	<br style="clear:both" />
</cfoutput>