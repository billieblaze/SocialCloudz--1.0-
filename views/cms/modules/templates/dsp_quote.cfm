<cffeed action="read" source='http://feeds.feedburner.com/brainyquote/QUOTEBR' name='quote'/>
<cfscript>
	getModule = qGetModules;
	record = randrange(1, arraylen(quote.item))
</cfscript>
<cfoutput>
	<h3>#quote.item[record].title#</h3><hr>
	#quote.item[record].description#
</cfoutput>



