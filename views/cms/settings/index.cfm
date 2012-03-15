<cfoutput>
	<form action="#event.buildLink('cms.settings.submit')#" method="post" class="form ajaxform" id="pageSettingsForm">
			<input type="hidden" name="page" value="#rc.page#">	
			<input type="hidden" name="contentType" value="#rc.contentType#">	
			<input type="hidden" name="communityID" value="#request.community.communityid#">
			<cfset cnt = 1>
			<cfloop query="request.page.settings">
					<label <cfif cnt eq 1>class="first"</cfif>>
					#request.page.settings.description#: 
					<cfif request.page.settings.settingtype eq 'text'>
						<input type="text" name="#request.page.settings.name#" value="#request.page.settings.value#">
					<cfelseif request.page.settings.settingtype eq 'bit'>
						<Select name="#request.page.settings.name#">
							<option value="1" <cfif request.page.settings.value eq 1>selected</cfif>>Yes</option>
							<option value="0" <cfif request.page.settings.value eq 0>selected</cfif>>No</option>
						</select>
					<cfelseif request.page.settings.settingtype eq 'select'>
						<select name="#request.page.settings.name#">
							<cfloop list="#request.page.settings.valueList#" index='i'>
							<option value="#i#" <cfif request.page.settings.value eq i>selected</cfif>>#i#</option>
							</cfloop>
						</select>
					</cfif>
					</label><br>
					<cfset cnt = cnt + 1>
			</cfloop>
			<div align="center"><input type="submit" value="Save"></div>
		</div>
</cfoutput>