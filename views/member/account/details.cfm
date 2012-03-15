<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
<Cfscript>
	types = event.getValue('types');
	if (rc.member.email contains '@linkedin.com'){
		rc.member.email = '';
	}
</Cfscript>
<cfoutput>
	<div class="cfUniForm-form-container">
		<uform:form 
			action="#event.buildLink('member.account.submit')#" 
			id="profileDetail" 
			errors="#rc.errors#" 
			errorMessagePlacement="inline" 
			loadValidation="true"
			submitValue="Update">
			<input type="hidden" name="member.memberID" value="#rc.memberID#" />
			<input type="hidden" name="member.usernameOriginal" value="#rc.member.username#" />
			<uform:fieldset legend="Account">
				<uform:field label="User Name" name="member.username" isRequired="yes" type="text" value="#rc.member.username#" hint="" />
				<cfif rc.member.signupcomplete eq 0 and rc.member.email eq rc.member.identity&'@linkedin.com'>
				<uform:field label="Email" name="member.email" isRequired="yes" type="text" value="" hint="" />
				<cfelse>
				<uform:field label="Email" name="member.email" isRequired="yes" type="text" value="#rc.member.email#" hint="" />
				</cfif>
				<uform:field label="Password" name="member.password" isRequired="false" type="password" value="#rc.member.password#"  />
				<cfif  request.session.accesslevel gte 20>
					<uform:field type="custom">
						<p class="label">Profile Type</p>
						<select name="member.profileType">
							<cfloop query='types'>
								<option value='#types.typeid#' <cfif rc.member.profileType eq types.typeid >selected</cfif>>#types.name#</option>
							</cfloop>
						</select>
					</uform:field>
				<cfelse>
					<uform:field type="custom">
						<input type="hidden" name="member.profileType" value='#rc.member.profileType#'>
					</uform:field>
				</cfif>
			</uform:fieldset>
			<uform:fieldset  legend="Details">
				<uform:field label="First Name" name="member.firstname" isRequired="no" type="text" value="#rc.member.firstName#" hint="" />
				<uform:field label="Last Name" name="member.lastname" isRequired="no" type="text" value="#rc.member.lastName#" hint="" />
				<cfif (application.community.settings.getValue('friends') eq 1)>
					<uform:field type="custom">
					<p class="label">
						Date of Birth
					</p>
					<ul class="alternate">
						<li><label for="birthMonth" class="blockLabel">
							Month 
							<select id="birthMonth" name="member.birthMonth">
								<cfset cnt = 1>														
								<cfloop list="#application.monthlist#"  index="i">
								<option value="#cnt#" <cfif isValid('date', rc.member.birthdate) and cnt eq month(rc.member.birthdate)>selected</cfif>>#i#</option>	
								<cfset cnt = cnt + 1>	
								</cfloop>	
							</select>
						</label></li>
						<li><label for="birthDay" class="blockLabel">
							Day 
							<select name="member.birthDay" class="blockLabel">
								<cfloop from="1" to="31" index="i">
								<option value="#i#" <cfif isValid('date', rc.member.birthdate) and  I eq day(rc.member.birthdate)>selected</cfif>>#i#</option>		
								</cfloop>														
							</select>
						</label></li>
						<li><label for="birthYear" class="blockLabel">
							Year 
							<select id="birthYear" name="member.birthYear">
								<cfloop from="1907" to="#year(now())#" index="i">
								<option value="#i#" <cfif isValid('date', rc.member.birthdate) and  I eq year(rc.member.birthdate)>selected</cfif>>#i#</option>		
								</cfloop>	
							</select>
						</label></li>
					</ul>
					</uform:field>	
					<uform:field label="Gender" name="member.gender" type="radio" isRequired="true">
							<uform:radio label="Male" value="1" isChecked="#rc.member.gender EQ 1#" />
							<uform:radio label="Female" value="2" isChecked="#rc.member.gender EQ 2#" />
					</uform:field>
				</cfif>
			
			</uform:fieldset>
			<uform:fieldset>
			<uform:field type="custom">
			<p class="label">
					Location (type city name and select)
				</p>
				<ul class="alternate">
					<li>
						<cfmodule template="/customTags/location.cfm" city='#rc.member.city#' state='#rc.member.state#' country='#rc.member.country#' latitude='#rc.member.latitude#' longitude='#rc.member.longitude#'>
					</li>
				</ul>
			</uform:field>
				<uform:field label="Profile Visible?" name="member.invisible" type="radio" isRequired="true">
							<uform:radio label="Yes" value="0" isChecked="#rc.member.invisible EQ 0#" />
							<uform:radio label="No" value="1" isChecked="#rc.member.invisible EQ 1#" />
					</uform:field>
			</uform:fieldset>	
		</uform:form>
	</div>
</cfoutput>	