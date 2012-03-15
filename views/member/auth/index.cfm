<cfparam name="cookie.remember" default="0">
<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
<cfoutput>
	<cfif request.session.showLogin eq 1>
		<cfparam name="request.session.loginMessage" default="You must be logged in.">
		<div id="warning"><p class="red">#request.session.loginMessage#</p></div>  
		<cfset request.session.showLogin = 0>
		<cfset request.session.loginMessage = ''>
	</cfif>
	<div class="cfUniForm-form-container" data-ajax="false">
		<uform:form 
			action="#event.buildLink('member.auth.login')#" 
			id="loginDetail" 
			errors="#rc.errors#" 
			errorMessagePlacement="top"
			submitValue="Login"
			class="ajaxform">
			<div id="loginError" class="red"></div>  

			<uform:fieldset legend="">
				<uform:field label="Email" name="email" isRequired="yes" type="text" value="#event.getvalue('email','')#" hint="" />
				<uform:field label="Password" name="password" isRequired="yes" type="password" value="#event.getvalue('password','')#" hint="" />
			</uform:fieldset>
			<uform:fieldset>
				<table style="padding:0 0 3px 35%">
					 	<tr>
					      	<td class="small" nowrap>
								<div style="float:left;" class="small">  
						       		<a href="##" class="forgotPassword">Forgot Password</a> 
									<cfif application.community.settings.getValue('Signup')>| <a href="#event.buildLink('member.signup.details')#">Signup</a></cfif>
								</div>
							</td>
							<td class="small" nowrap>
								<input type="checkbox" name="remember" <cfif cookie.remember eq 1>checked</cfif>/> Remember Me 					      	
					      	</td>
					 	</tr>
				     </table>
			</uform:fieldset>
		</uform:form>
	</div>
	
	<cfset facebookLogin = application.community.settings.getValue('facebookLogin',request.community.settings)>
	<cfset linkedinLogin = application.community.settings.getValue('linkedinLogin',request.community.settings)>
	<cfif facebookLogin neq 0 or linkedinLogin neq 0>
		<h3>Login with:</h3>
	
			<div align="center">
			<cfif facebookLogin neq '' and facebookLogin neq 0>
				<a href='/index.cfm/member/auth/facebook' class="fblogin"><img src="/images/connect2.gif"></a><br>
			</cfif>
			
			<cfif linkedInLogin neq '' and linkedinLogin neq 0>
				<a href='/index.cfm/member/auth/linkedin' class="linkedInLogin"><img src="/images/log-in-linkedin-large.png"></a><BR>
			</cfif>
		</div>
		<Br>
	</cfif>
	
	<br>
</cfoutput>
