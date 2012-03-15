<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
<cfscript>
	types = event.getvalue('types');
	sections = event.getvalue('sections');
</cfscript>
<cfoutput>
	<div class="cfUniForm-form-container" style="width:400px">
	 	<uform:form action="#event.buildLink('member.profileAdmin.sectionSubmit')#" id="sectionForm" errors="#rc.errors#" errorMessagePlacement="top" submitValue="Save" loadValidation="false" class="ajaxform">
			<uform:fieldset legend="">
				<input type="hidden" name="CommunityID" value="#rc.communityID#">
				<input type="hidden" name="ID" value="#rc.ID#" />
				<uform:field label="Profile Type" name="typeID" type="select" isRequired="true">
					<cfloop query="types">
						<uform:option display="#types.name[currentRow]#" value="#types.typeID[currentRow]#" isSelected="#sections.typeID EQ types.typeID[currentRow]#" />
					</cfloop>
				</uform:field>

				<uform:field label="Name" name="name" isRequired="yes" type="text" value="#sections.name#" hint="" />
			</uform:fieldset>
		</uform:form>
	</div>

</cfoutput>