<cfquery dbtype='query' name="getParents">
select * from rc.myCommunities where parentID = 0 order by communityId asc
</cfquery>
<cfoutput>
<form action="#event.buildlink('content.admin.communitySubmit')#" method="post" id="contentCommunity">
	<input type="hidden" name='contentID' value='#rc.contentID#'>

	<div id="contentCommunityTabs">
		<ul>
			<cfloop query='getParents'>
				<li><a href="##tabs-#getparents.currentRow#">#getParents.site#</a></li>
			</cfloop>
		</ul>
		<cfloop query='getParents'>
			<cfquery dbtype='query' name="getChildren">
			select * from rc.myCommunities where parentID = #getParents.communityID#
			</cfquery>
				<cfquery dbtype="query" name="check">
					select communityId
					from rc.contentcommunity
					where communityId = #getParents.communityID#
				</cfquery>

		<div id="tabs-#getParents.currentRow#" style = "width:400px;height: 250px; overflow: scroll">
		
			<table class="table oddeven">
				<tr>
					<td>
						<input type="checkbox" name="contentCommunityList" value='#getParents.communityID#' <cfif check.recordcount eq 1>checked</cfif>>
					</td>
					<td>#getParents.site#</td>
				</tr>
			<cfloop query="getChildren">
				<cfquery dbtype="query" name="check">
					select communityId
					from rc.contentcommunity
					where communityId = #getChildren.communityID#
				</cfquery>
				<tr>
					<td>
						<input type="checkbox" name="contentCommunityList" value='#getChildren.communityID#' <cfif check.recordcount eq 1>checked</cfif>>
					</td>
					<td>#getChildren.site#</td>
				</tr>
			</cfloop>
			</table>
		</div>
		</cfloop>
	</div>
	<div align="center"><input type="submit" value="Update"></div>
</form>
</cfoutput>

