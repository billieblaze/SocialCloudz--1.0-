<cfscript>
bots = event.getvalue('bots');
</cfscript>
<cfoutput>
	<form action="#event.buildLink('statistics:bots.submit')#" method="post" id="botForm">
		User Agent: <input type="text" name="useragent"><BR>
		<input type="submit" value="Save">
	</form>
	<BR><BR>
	<Table width="100%" class="oddEven">
	<cfloop query="bots">
		<TR>
			<TD>#useragent#</TD>
			<td><a href="#event.buildLink(linkTo='statistics:bots.delete',queryString="id=#id#")#" class="ajaxTabLink">delete</a></td>
		</TR>
	</cfloop>
	</Table>
</cfoutput>
<script>
	// bind 'myForm' and provide a simple callback function 
    $('#botForm').ajaxForm(function(responseText) { 
		$('#botForm').parent().html(responseText);  
		$.jGrowl('Bot saved.');          	        	
   	}); 
</script>