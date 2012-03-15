<cfscript>
	getModule = qGetModules;
	posts=application.forum.getTopics(sticky=0, limit=getmodule.displayrows);
</cfscript>
<table width="100%" cellpadding=0 cellspacing=0>
	<cfoutput query="posts">
		<TR class="<cfif posts.currentrow mod 2>even<cfelse>odd</cfif>">
			<TD class="pad3">
				<A href="/index.cfm/forum/display/thread/id/#ID#"><cfif replyCount gt 0>Re: </cfif> #title#</a><BR />
			    <div class="small">#dateformat(maxdate, request.community.dateformat)# by #application.members.getusername(postmember,1)#</div>
			</td>
		</tr>
	</cfoutput>
</table>
