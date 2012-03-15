
<cfif isDefined("errorMsg")>
	<table align="center">
       	<tr>
       		<td style="font-weight:bold; color:yellow;"><cfoutput>#ErrorMsg#</cfoutput></td>
       	</tr>
      </table>
</cfif>
<form method="post" action="sitemap.cfm">
	<table align="center">
		<tr>
			<td colspan="2" align="left">
				<h2>Step 1</h2>
			</td>
		</tr>
		<tr>
			<th colspan="2" align="left">
				The root of the site usually the entire address with a slash on the end
			</th>
		</tr>
		<tr>
			<td>
				Root
			</td>
			<td>
				<input type="Text" name="txtRoot" size="50" value="http://www.example.com/">
			</td>
		</tr>
		<tr>
			<th colspan="2" align="left">
				The first page it should start indexing
			</th>
		</tr>		
		<tr>	
			<td>
				Start Page
			</td>
			<td>
				<input type="Text" name="txtStart" value="index.cfm">
			</td>
		</tr>
		<tr>
			<th colspan="2" align="left">
				The depth of links the crawler should visit
			</th>
		</tr>		
		<tr>	
			<td>
				Max Levels
			</td>
			<td>
				<input type="Text" name="txtLevels" value="3">
			</td>
		</tr>
		<tr>
			<th colspan="2" align="left">
				Physical drive location to save the file to in the server
			</th>
		</tr>		
		<tr>	
			<td>
				Physical path (.xml)
			</td>
			<td>
				<cfoutput><input type="Text" name="txtPhysicalPath" value="#ExpandPath('.')#\sitemap.xml" size="60"></cfoutput>
			</td>
		</tr>		
		<tr>
			<th colspan="2" align="left">
				If this is unchecked it will run in CF7 mode which will result in 95% slower crawl time.
			</th>
		</tr>			
		<tr>
			<td>
				CFML8 Mode
			</td>
			<td>
				<input type="Checkbox" name="chkCF8Mode" checked>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="Submit" value="Crawl">
			</td>
		</tr>
	</table>
</form>