<cfparam name="cookie.remember" default="1">
<cfparam name="cookie.email" default="">
<cfoutput>
	
	
<cfif request.session.login eq 0>
<script>
	$('##loginForm').ajaxForm(function(){alert('foo');});
</script>  	
  <form id="form1" name="form1" id="loginForm" method="post" action="/index.cfm/member/auth/login">
		<table  border="0" width="90%" >
                <tr>
                  <td  class="small">Email</td>
				 <td><input name="email" type="text" id="email" size="20" class="small" <cfif cookie.remember eq 1>value='#cookie.email#'</cfif>/>
            
                  </td>
                </tr>
                <tr>
                  <td class="small">Password</td>
				<Td><input name="password" type="password" id="password" size="20" class="small" />
              </td>
                </tr>
				<tr><td></td><td class="small">
				<input type="checkbox" name="remember" <cfif cookie.remember eq 1>checked</cfif>/>
                  Remember Me <BR><BR>
				</td></tr>
                <tr>
              
                  
                	<td class="small" colspan="2">
					<div style="float:left;" class="small">  
                   		<a href="##" class="forgotPassword">Forgot PW</a> <cfif application.community.settings.getValue('Signup')>| <a href="/index.cfm/member/signup/details">Signup</a></cfif>
					</div>
					<div align="right">
						<input name="signIn " type="submit" class="button" value="Login" />					
					</div>
					</td>
                </tr>

     </table>
     </form>

     <br>
	<cfelse>
		<cfscript>
			member = application.members.gateway.get(request.session.memberID);
		</cfscript>

		    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		id="imagePreview",
		    		image=application.members.userpic( request.session.memberID ), 
		    		size=50 )#
		<B><A href='/index.cfm/member/profile/index/memberID/#member.memberID#'>#member.username#</a></b><BR>
		#application.util.agesincedob(request.session.birthdate)# / 
		<cfif request.session.gender eq 1>Male<cfelseif request.session.gender eq 2>Female</cfif><BR>
		#request.session.city# #request.session.state#<BR>
		#request.session.country#<BR><BR>
			
		<a href="/index.cfm/member/profile/index/memberID/#member.memberID#">View Profile</a><BR>
		<a href="/index.cfm/member/account/index/memberID/#member.memberID#">Edit Profile</a><BR>
		<a href="/?logout">Logout</a>
  </cfif>
</cfoutput>