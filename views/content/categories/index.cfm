<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
<cfoutput>
	<div class="cfUniForm-form-container" style="width:350px">
		<uform:form action="/index.cfm/content/categories/save" id="categoryForm" errors="#rc.errors#" errorMessagePlacement="top" submitValue="Save" loadValidation="false" class="ajaxform">
			<input type="hidden" name="communityId" value="#request.community.communityID#">
			<input type="hidden" name="memberId" value="#request.session.memberID#">
			<input type="hidden" name="contentType" value="#rc.contentType#">
			<input type="hidden" name="Id" value="#event.getValue('ID',0)#">
			<uform:fieldset legend="">
				<uform:field label="Name" name="category" isRequired="yes" type="text" value="#rc.category.category#" hint="" />
			</uform:fieldset>
		</uform:form>
	</div>
</cfoutput>