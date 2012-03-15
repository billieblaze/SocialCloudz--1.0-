<cfscript>
	usertopics = event.getvalue('usertopics');
	admintopics = event.getvalue('admintopics');
</cfscript>
<cfoutput>
<div class="mod">
<div class="hd">Help</div>
<div class="bd">
Get help here!   Don't find what you're looking for?  Email us @ <a href="mailto:support@#request.community.parent.domain.domain#">support@#request.community.parent.domain.domain#</a>
</div>
<div class="ft"></div>
</div>
<div class="mod">
<div class="hd">Most Viewed</div>
<div class="bd">
<cfif userTopics.recordcount gt 0>
<B>Users</B>
<ul>
<cfloop query="userTopics">
	<li><a href="#event.buildLink(linkTo='app.help.detail',queryString='ID=#id#')#">#title#</a></li>
</cfloop>
</ul>
<BR />
<BR />
</cfif>
<cfif adminTopics.recordcount gt 0>
<B>Owners</B>
<ul>
<cfloop query="adminTopics">
	<li><a href="#event.buildLink(linkTo='app.help.detail',queryString='ID=#id#')#">#title#</a></li>
</cfloop>
</ul>
<BR><BR>
</cfif>
</div>
<div class="ft"></div>
</div>
</cfoutput>