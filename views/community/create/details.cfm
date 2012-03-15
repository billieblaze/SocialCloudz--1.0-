<cfsetting showdebugoutput="no">
<cfparam name="rc.ismember" default="0">

<Cfif request.session.memberID neq 0>
	<Cfset rc.isMember = 1>
</cfif>

<cfparam name="rc.username" default="">
<cfparam name="rc.password" default="">
<cfparam name="rc.repassword" default="">
<cfparam name="rc.email" default="">
<cfparam name="rc.existemail" default="">
<cfparam name="rc.existpassword" default="">

<cfparam name="request.session.community.url" default="">
<cfparam name="request.session.community.name" default="">
<cfparam name="rc.url" default="#request.session.community.url#">
<cfparam name="rc.categoryid" default="">
<cfparam name="rc.site" default="#request.session.community.name#">
<cfparam name="rc.tagline" default="">
<cfparam name="rc.keywords" default="">
<cfparam name="rc.description" default="">
<cfparam name="rc.private" default="0">
<cfparam name="rc.directory" default="1">

<cfscript>
	getCategories = event.getvalue('category');
</cfscript>

<script>
 $(document).ready(function() {
   	$('#urlLoading').hide();
	$('#url').keyup(function(){
	  $('#urlLoading').show();
      $.post("/index.cfm/community/create/checkavailable", {
       url: $('#url').val()
      }, function(response){
        $('#urlResult').fadeOut();
        setTimeout("finishAjax('url', '"+escape(response)+"')", 400);
      });
    	return false;
	});


	$('#usernameLoading').hide();
	$('#emailLoading').hide();
	$('#passwordLoading').hide();
	$('#repasswordLoading').hide();

   $('#login').click(function(){
	     $('#newuser').toggle('slow');
	     $('#existinguser').toggle('slow');
		 $('#createLogin').toggle('slow');
		 $('#createSignup').toggle('slow');
		 $('#ismember').val('1');
   });

   $('#signup').click(function(){
     $('#newuser').toggle('slow');
     $('#existinguser').toggle('slow');
	 $('#createLogin').toggle('slow');
	 $('#createSignup').toggle('slow');
	 $('#ismember').val('0');
   });
 

	$('#username').keyup(function(){
	  $('#usernameLoading').show();
      $.post("/index.cfm/member/signup/checkUsername", {
        username: $('#username').val()
      }, function(response){
        $('#usernameResult').fadeOut();
        setTimeout("finishAjax('username', '"+escape(response)+"')", 400);
      });
    	return false;
	});

$('#email').keyup(function(){
	  $('#emailLoading').show();
      $.post("/index.cfm/member/signup/checkEmail", {
        email: $('#email').val()
      }, function(response){
        $('#emailResult').fadeOut();
        setTimeout("finishAjax('email', '"+escape(response)+"')", 400);
      });
    	return false;
	});

	$('#password').keyup(function(){
	  $('#passwordLoading').show();
      $.post("/index.cfm/member/signup/checkPassword", {
        password: $('#password').val()
      }, function(response){
        $('#passwordResult').fadeOut();
        setTimeout("finishAjax('password', '"+escape(response)+"')", 400);
      });
    	return false;
	});

	$('#repassword').keyup(function(){
	  $('#repasswordLoading').show();
      $.post("/index.cfm/member/signup/checkPassword2", {
        password: $('#password').val(),
		repassword: $('#repassword').val()
      }, function(response){
        $('#repasswordResult').fadeOut();
        setTimeout("finishAjax('repassword', '"+escape(response)+"')", 400);
      });
    	return false;
	});

});

function finishAjax(id, response) {
  $('#'+id+'Loading').hide();
  $('#'+id+'Result').html(unescape(response));
  $('#'+id+'Result').fadeIn();
} //finishAjax

</script>

<cfoutput>
  	<form action="/index.cfm/community/create/detailsSubmit" method="post" id="create" name="create">
	<input type="hidden" name="ismember" id="ismember" value="0" />
	<div class="mod">
		<div class="hd">Step 1 - Create an account</div>
		<div class="bd" align="justify">
			Your SocialCloudz ID allows you to maintain a single account
			for any sites within our network.  It is the key to managing 
			your content across the SocialCloudz network.<BR /><BR />
			<div style="padding: 15px;border: 1px solid silver;-moz-border-radius: 15px;border-radius: 15px; ">
				<div id="newuser" <cfif rc.ismember neq 0>class="close"</cfif>>
    	  		<table width="100%" border="0">
	  				<TR>
		      			<td width="30%" class="formlabel" valign="top">User Name</td>
		    	      	<td colspan="2">
				        	<input id="username" name="username" style="width:85%"type="text" value="#rc.username#">
							<span id="usernameLoading"><img src="/images/progress.gif" alt="Ajax Indicator" /></span>
							<span id="usernameResult" class="small"></span>
			         	</td>
		        	</tr>
		        	<tr><td colspan="2" height="20"></td></tr>
 		           	<tr>
	            		<td  class="formlabel" valign="top">Email</td>
                		<td>
			                <input name="email" style="width:85%"type="text" value="#rc.email#" id="email">
							<span id="emailLoading"><img src="/images/progress.gif" alt="Ajax Indicator" /></span>
							<span id="emailResult" class="small"></span>
			                </td>
			           </tr>
		        	<tr><td colspan="2" height="20"></td></tr>
			           <tr>
			               <td  class="formlabel" valign="top">Password</td>
			               <td>
			                  	<input name="password" id="password" style="width:80%"type="password" value="#rc.password#">
								<span id="passwordLoading"><img src="/images/progress.gif" alt="Ajax Indicator" /></span>
								<span id="passwordResult" class="small"></span>
			              </td>
			           </tr>
			           <tr>
			             <td  class="formlabel" valign="top">Confirm Password</td>
			             <td>
			                  <input name="repassword" id="repassword" style="width:80%"type="password" value="#rc.repassword#">
			  	              <span id="repasswordLoading"><img src="/images/progress.gif" alt="Ajax Indicator" /></span>
							  <span id="repasswordResult" class="small"></span>
			             </td>
			           </tr>
			       	</table>
		       	</div>
       			<div id="existinguser" style="display:none">
            		<table width="100%" border="0">
			        	<tbody>
		                <TR>
		                  <td width="30%"  class="formlabel">Email</td>
		                  <TD>
			                  <input name="existemail" style="width:85%"type="text" value="#rc.existemail#">
		                  </td>
		                </tr>
		                <tr>
		                  <td  class="formlabel">Password</td>
		                  <td>
		                    <input name="existpassword" style="width:85%" type="password" value="#rc.existpassword#">
		                  </td>
		                </tr>
		            </table>
		        </div>
          		<div align="center">
					<div id="createLogin">
						Already signed up? 	<a href="##" id="login">Log in here</a><br />
					</div>
					<div id="createSignup" style="display:none">
						New to SocialCloudz? <a href="##" id="signup">Signup here</a><br />
					</div>
				</div>
	   		</div>
		</div>
		<BR>
		<div class="mod">
			<div class="hd">Step 2 - About your site</div>
			<div class="bd" align="justify">
				Pick a unique name and tagline for your new web site, 
				then enter a description and keywords which will be submitted to search engines. 
				Next, choose a category and specify whether you want your site to be public or private (Invite Only). 
				Finally, select whether or not you would like your site to show up in our directory of sites.
				<br /><BR>
				<div style="padding: 15px;border: 1px solid silver;-moz-border-radius: 15px;border-radius: 15px; ">
              	<table width="100%" border="0" >
                  <tr>
	                <td class="formlabel" valign="top" width="30%">Name of your site</td>
	                  <td>
	                    <input  name="site" type="text" value="#rc.site#" maxlength="50" size="43"><BR />
	                    <span class="xsmall">Example = Bay Area Techno Supporters</span>
	                    
	               	</td>
                  </tr>
                	<tr><td colspan="2" height="20"></td></tr>
				<tr>
                  <td valign="top" class="formlabel">Address of your site </td>
                  <td height="35" valign="top">
                    http:// <input type="text" name="url" id="url" value="#rc.url#" maxlength="30" size="18">.#request.community.parent.domain.domain# <BR />
             		<span id="urlLoading"><img src="/images/progress.gif" alt="Ajax Indicator" /></span>
					<span id="urlResult" class="small"></span>
	               </td>
                </tr>
                	<tr><td colspan="2" height="20"></td></tr>
                <tr>
                  <td class="formlabel">Site Tagline</td>
                  <td>
	                 <input  name="tagline" type="text" value="#rc.tagline#"  size="43">
                  </td>                  
                </tr>
				
                <tr>
                  <td  valign="top" class="formlabel">Site Description </td>
                  <td>
	                <textarea  name="description" rows="3" cols="40">#rc.description#</textarea>
                  </td>
                </tr>    
                <tr>
                  <td class="formlabel">Keywords/Tags </td>
                  <td>
	                  <input name="keywords" type="text" value="#rc.keywords#" maxlength="255" size="43">
                  </td>
                </tr>
                <tr>
                  <td class="formlabel">Category </td>
                  <td> 
						<select name="categoryID" class="normalHelp">
						  <option value="" selected>Choose One</option>
						  <cfloop query="getCategories">
							<option value="#ID#" <cfif rc.categoryID eq ID>selected</cfif>>#category#</option>
						  </cfloop>
						</select>
                  </td>
                </tr>
                <tr><td colspan="2" height="15"></td></tr>
				<tr>
                  <td class="formlabel">My site is </td>
				  <td style="font-size:12px">
                  <input type="radio" name="private" value="0"<cfif rc.private eq 0>checked</cfif>>
							Public&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  
                  	<input type="radio" name="private"  value="1"<cfif rc.private eq 1>checked</cfif>>
							Private&nbsp;
               		</td>
                </tr>   
				<tr><td colspan="2" height="15"></td></tr>
                <tr>
                  <td class="formlabel">Show in Directory </td>
				  <td style="font-size:12px">
	                  <input type="radio" name="directory" value="1"<cfif rc.directory eq 1>checked</cfif>>
							Yes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  
    	              	<input type="radio" name="directory"  value="0"<cfif rc.directory eq 0>checked</cfif>>
							No&nbsp;
        	       </td>
                </tr>
              </table>
		     <BR /><BR />
		    <div align="center">
			    <input type="checkbox" name="terms" class="small" /> 
				<span class="small">I have read and agree to the SocialCloudz Terms of Service and the SocialCloudz Privacy Policy.</span>
		  	</div>
		    <BR />
		    <input type="image" src="/socialCloudZ/img/signupbox_submit.png"/> 
	    </div>
    </div>   
	</form>
	<div class="ft"></div> 
</div>
</cfoutput>		 