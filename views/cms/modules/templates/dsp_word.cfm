<cfscript>
	getModule = qGetModules;
</cfscript>
<cffeed action="read" source='http://wordsmith.org/awad/rss1.xml' name='word'/>
<cfoutput>
<h3>#word.item[1].title#</h3><hr>
#word.item[1].description.value#
</cfoutput>



