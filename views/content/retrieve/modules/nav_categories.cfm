<cfscript>	
	category = application.content.category.list(contentType=rc.contenttype);
</cfscript>
<cfoutput>
	<table  align="center" width="90%">
	<cfloop query="category">
		<tr>
			<TD ><B><a href="/index.cfm/content/#rc.contentType#?categoryID=#id#" >#category#</a>&nbsp;&nbsp;(#count#)</B></td>
			<TD valign="top"> <a href="/index.cfm/content/rss/#rc.contentType#?categoryID=#id#"><img src='#application.cdn.fam#rss.png'></a></td>
		</tr>
	</cfloop>
	</table>
</cfoutput>