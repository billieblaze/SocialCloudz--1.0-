<cfsetting showdebugoutput="no">
<cfscript>
	templates = event.getvalue('templates');
</cfscript>
<cfoutput>
<div id="tabs" style="width:575px">
	<ul>
		<li><a href="##tabs-1">Basic</a></li>
		<li><a href="##tabs-2">Advanced</a></li>
	</ul>
	<div id="tabs-1">
<cfloop query="templates">
<cfif templates.type eq 'basic'>
<div style="width:120px; height:100px; float: left; margin:5px;text-align:center;">
<a href="##" onclick="confirmDelete('Are you sure you want to change templates?  You will lose your current design!','#event.buildLink(linkTo='cms.template.change',queryString='templateID=#ID#')#');" class="aNone small"><img src="/images/templates/#thumbnail#" /><BR />#name#</a></div>
</cfif>
</cfloop>
<div style="clear:both; height:1px;"/>
	</div>
	<div id="tabs-2">

<cfloop query="templates">
<cfif templates.type eq 'advanced'>
<div style="width:120px; height:100px; float: left; margin:5px;text-align:center;">
<a href="##" onclick="confirmDelete('Are you sure you want to change templates?  You will lose your current design!','#event.buildLink(linkTo='cms.template.change',queryString='templateID=#ID#')#');" class="aNone small"><img src="/images/templates/#thumbnail#" /><BR />#name#</a></div>
</cfif>
</cfloop>
<div style="clear:both; height:1px;"/>
	</div>

</div>

</cfoutput>
