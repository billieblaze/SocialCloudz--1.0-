
<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
<cfscript>
	types = event.getValue('types');
</cfscript>
<cfoutput>
	<div class="mod" id="signupForm">
		<div class="hd">
			<div style="float:left">
				Sign up for #request.community.site#
			</div>
			<div align="right" class="small">
				
						Already a member?          
						<a href="##" class="showLogin small">Click here to login</a>
					
			</div>
		</div>
		
		
		<div class="bd">
			<div class="cfUniForm-form-container">
					<cfset fbLogin = application.community.settings.getValue('facebookLogin',request.community.settings)>
					<cfset linkedinLogin = application.community.settings.getValue('linkedinLogin',request.community.settings)>

					<cfif fbLogin neq 0 or linkedinLogin neq 0>
						<br><br><span class="small">Already have an existing social media profile? Skip signup and import your profile.</span><br><br>
							<cfif fbLogin neq ''>
								<a href='/index.cfm/member/signup/facebook' class="facebook"><img src="/images/connect2.gif"></a><br>
							</cfif>
							
							<cfif linkedinLogin neq 0>
									<a href='/index.cfm/member/signup/linkedIn' class="linkedIn"><img src="/images/log-in-linkedin-large.png"></a><BR>
							</cfif>
						<Br>
						<h3>OR</h3>
					</cfif>
								<cfif request.community.communityID eq '251'>(<strong>Companies:</strong> You must create an account to post jobs.)<br></cfif>
				
				<uform:form 
					action="#event.buildLink('member.signup.detailsSubmit')#" 
					id="signupDetail" 
					errors="#rc.errors#" 
					submitValue=" Sign Me Up "
					loadDateUI='true'
					loadTimeUI='true'
					configValidation='true'					
				>
						
				
					<uform:fieldset legend="Step 1: Create an Account">
						<cfif request.community.communityID eq '251'>
						<uform:field label="User/Company Name (no spaces)" name="member.username" isRequired="yes" type="text" value="#event.getvalue('member.username','')#" hint="" />
						<cfelse>
						<uform:field label="User Name (no spaces)" name="member.username" isRequired="yes" type="text" value="#event.getvalue('member.username','')#" hint="" />
						</cfif>
						<uform:field label="Email" name="member.email" isRequired="yes" type="text" value="#event.getvalue('member.email','')#" hint="" />
						<uform:field label="Password (6 or more characters)" name="member.password" isRequired="true" type="password" />
					</uform:fieldset>
					<uform:fieldset  legend="Step 2: Personal Details">
						<uform:field label="First Name" name="member.firstname" isRequired="no" type="text" value="#event.getvalue('member.firstName','')#" hint="" />
						<uform:field label="Last Name" name="member.lastname" isRequired="no" type="text" value="#event.getvalue('member.lastName','')#" hint="" />
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
									<option value="#cnt#" <cfif cnt eq month(event.getvalue('member.birthdate','01/01/1970'))>selected</cfif>>#i#</option>	
									<cfset cnt = cnt + 1>	
									</cfloop>	
								</select>
							</label></li>
							<li><label for="birthDay" class="blockLabel">
								Day 
								<select name="member.birthDay" class="blockLabel">
									<cfloop from="1" to="31" index="i">
									<option value="#i#" <cfif I eq day(event.getvalue('member.birthdate','01/01/1970'))>selected</cfif>>#i#</option>		
									</cfloop>														
								</select>
							</label></li>
							<li><label for="birthYear" class="blockLabel">
								Year 
								<select id="birthYear" name="member.birthYear">
									<cfloop from="1907" to="#year(now())#" index="i">
									<option value="#i#" <cfif I eq year(event.getvalue('member.birthdate','01/01/1970'))>selected</cfif>>#i#</option>		
									</cfloop>	
								</select>
							</label></li>
						</ul>
						</uform:field>	
						<uform:field label="Gender" name="member.gender" type="radio" isRequired="true">
								<uform:radio label="Male" value="1" isChecked="#event.getvalue('member.gender','0') EQ 1#" />
								<uform:radio label="Female" value="2" isChecked="#event.getvalue('member.gender','0') EQ 2#" />
						</uform:field>
					<cfelse>
					<input type='hidden' name='member.birthMonth' value='01'>
					<input type='hidden' name='member.birthDay' value='01'>
					<input type='hidden' name='member.birthYear' value='1899'>
					<input type='hidden' name='member.gender' value='M'>
					
					</cfif>
					</uform:fieldset>
					
					<uform:fieldset>
					<cfif types.recordcount gt 0>
						<cfif request.community.communityID eq '251'>
						<uform:field label="Profile Type (To post jobs select Company)" name="member.profileType" type="select" isRequired="true">
						<cfloop query="types">
								<cfif types.name[currentRow] neq 'Everyone'><uform:option display="#types.name[currentRow]#" value="#types.typeID[currentRow]#" isSelected="#event.getvalue('member.profileType','') EQ types.typeID[currentRow]#" /></cfif>
							</cfloop>
						</uform:field>
						<cfelse>
						<uform:field label="Profile Type" name="member.profileType" type="select" isRequired="true">
						<cfloop query="types">
								<cfif types.name[currentRow] neq 'Everyone'><uform:option display="#types.name[currentRow]#" value="#types.typeID[currentRow]#" isSelected="#event.getvalue('member.profileType','') EQ types.typeID[currentRow]#" /></cfif>
							</cfloop>
						</uform:field>
						</cfif>						
							
					</cfif>
					
					<uform:field type="custom">
						<p class="label">
							 Heard About
						</p>
						<ul class="alternate">
							<li>
								<select name="member.heardabout">
									<option value="none">None</option>
									<option value="Search">Search Engine</option>
									<option value="Facebook">Facebook</option>
									<option value="LinkedIn">LinkedIn</option>
									<option value="MySpace">MySpace</option>
									<option value="Ad">Advertisement</option>
									<Option value="friend">Friend</option>
								</select>							
							</li>
						</ul>
					</uform:field>	
					<uform:field name="key"
							label="Verify Security Image"
							type="captcha"
							captchaWidth="400"
							captchaMinChars="3"
							captchaMaxChars="5" 
							isRequired = "true"/>	
						</uform:fieldset>	
					</uform:form>
				</div>
			</div>
		<div class="ft"></div>
	</div>
</cfoutput>	


<cfif request.community.communityID eq '251'>
						<br>Need help creating a profile? Check out the "How To" videos on the <a href="http://mymortgagejob.com/about_us.cfm" target='_blank'>About Us page</a><br>
					</cfif>
					
	