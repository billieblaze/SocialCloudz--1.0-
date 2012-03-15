<cfscript>
thissection = event.getvalue('thissection');
topics = event.getvalue('topics');
</cfscript>
<cfoutput>
<div class="mod">
<div class="hd">
<div style="float:left">
#thissection.title#
</div>
<div align="right">
<cfif request.session.accesslevel eq 100>
	<a href="#event.buildLink(linkTo='app.help.form',queryString='ID=0')#">Add</a>
<cfelse>
	&nbsp;
</cfif>
</div>
</div>
<div class="bd">
<div align="right"><a href="#event.buildLink('app.help.index')#"><< Back to Help Center</a></div>
<cfloop query="topics">
<B><a href="#event.buildLink(linkTo='app.help.detail',queryString='id=#id#')#">#title#</a></B><BR />
<span class="xsmall">Posted on #dateformat(dateCreated)#</span>
<BR><BR>
</cfloop>

</div>
<div class="ft"></div>
</div>
</cfoutput>