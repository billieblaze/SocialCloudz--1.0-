<cfoutput>
	<cfimport taglib="/customTags/forms/cfUniForm/" prefix="uform" />
	<div class="cfUniForm-form-container" style="width:300px">
		<uform:form action="#event.buildLink('member.admin.accessSubmit')#" id="memberAccess" errors="#rc.errors#" errorMessagePlacement="top" submitValue="Save" loadValidation="true" class="ajaxform">
			<input type="hidden" name="memberId" value='#rc.memberId#'>
			<input type="hidden" name="communityId" value='#rc.communityId#'>
			<uform:fieldset legend="">
				<uform:field label="Access Level" name="accesslevel" type="select" isRequired="true">
					<uform:option display="Member" value="1" isSelected="#rc.member.accesslevel eq 1#" />
					<uform:option display="Editor" value="10" isSelected="#rc.member.accesslevel eq 10#" />
					<uform:option display="Owner" value="20" isSelected="#rc.member.accesslevel eq 20#" />
					<cfif request.session.accesslevel eq 100>
						<uform:option display="Support" value="100" isSelected="#rc.member.accesslevel eq 100#" />
					</cfif>
				</uform:field>
				<uform:field label="Approved" name="approved" type="checkbox" value="1" hint="" isChecked="#rc.member.approved eq 1#" />
				<uform:field label="Banned" name="banned"  type="checkbox" value="1" hint="" isChecked="#rc.member.banned eq 1#" />
				<uform:field label="Flagged" name="flagged"  type="checkbox" value="1" hint="" isChecked="#rc.member.flagged eq 1#" />

			</uform:fieldset>
		</uform:form>
	</div>
</cfoutput>