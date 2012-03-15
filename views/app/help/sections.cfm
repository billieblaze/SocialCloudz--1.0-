<cfscript>
adminsections = event.getvalue('adminsections');
usersections = event.getvalue('usersections');
</cfscript>
<cfoutput>
<div class="mod">
<div class="hd">Categories</div>
<div class="bd">
<h3>Users</h3>

<cfloop query="usersections">
	<a href="#event.buildLink(linkTo='app.help.topics',queryString='sectionID=#id#')#">#title#</a> (#count#)<BR>
</cfloop>
<BR /><BR />
<h3>Owners</h3>

<cfloop query="adminsections">
	<a href="#event.buildLink(linkTo='app.help.topics',queryString='sectionID=#id#')#">#title#</a> (#count#)<BR>
</cfloop>
</div>
<div class="ft"></div>
</div>
</cfoutput>