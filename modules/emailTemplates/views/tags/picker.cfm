<cfparam name="rc.elementType" default="text"> <!--- text or ckeditor --->
<cfoutput>	
	<h2>System-wide Tags</h2>
	<table class="table oddEven" width="100%">	
		<thead>
			<th>Tag</th>
			<th>Current Value</th>
		</thead>
		<cfloop collection="#rc.globalTags#" item="tag">
			<tr>
				<td><a href="##" onclick="insertTag('#rc.elementID#','#tag#','#rc.elementType#');">#tag#</td>
				<td>#rc.globalTags[tag]#</td>
			</tr>
		</cfloop>
	</table>
	<br>
	<h2>Developer Specified Tags</h2>
		<table class="table oddEven" width="100%">	
			<thead>
				<th>Tag</th>
				<th>Description</th>
			</thead>
			<cfloop query="rc.tags">
				<tr>
					<td><a href="##" onclick="insertTag('#rc.elementID#','#tag#','#rc.elementType#');">#tag#</a></td>
					<td>#description#</td>
				</tr>
			</cfloop>
		</table>
</cfoutput>