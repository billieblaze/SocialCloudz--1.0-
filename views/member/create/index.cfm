<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
<cfoutput>
	<div class="cfUniForm-form-container">
		<uform:form 
			action="#event.buildLink('member.create.submit')#" 
			id="addUserForm" 
			errors="#rc.errors#" 
			errorMessagePlacement="top" 
			loadValidation="true"
			submitValue="Invite User"
			class="ajaxform">
			<uform:fieldset legend="">
				<uform:field label="User Name" name="member.username" isRequired="yes" type="text" value="#event.getvalue('member.username','')#" hint="" />
				<uform:field label="Email" name="member.email" isRequired="yes" type="text" value="#event.getvalue('member.email','')#" hint="" />
			</uform:fieldset>
		</uform:form>
	</div>
</cfoutput>	