<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
<cfscript>
	type = event.getvalue('type');
</cfscript>
<cfoutput>
	<div class="cfUniForm-form-container" style="width:400px">
		<uform:form action="#event.buildLink('member.profileAdmin.typeSubmit')#" id="typeForm" errors="#rc.errors#" errorMessagePlacement="top" submitValue="Save" class="ajaxform">
			<input type="hidden" name="communityID" value="#rc.communityID#">
			<input type="hidden" name="typeID" value="#rc.typeID#" />
			<uform:fieldset legend="">
				<uform:field label="Name" name="name" type="text" isRequired="true" value="#type.name#"/>
			</uform:fieldset>
		</uform:form>
	</div>
</cfoutput>
