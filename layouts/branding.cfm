<cfscript>
	hasBranding =  application.community.settings.getValue('Branding');

	if (request.layout.width eq 'custom-doc'){
		width=request.layout.widthCustom;
	} else if (request.layout.width eq 'doc'){
		width="750";
	} else if (request.layout.width eq 'doc2'){
		width="950";
	} else if (request.layout.width eq 'doc4'){
		width="974";
	} else if (request.layout.width eq 'doc3'){
		width="100%";
	}
 
/*if(request.session.login eq 1){
	if (isdefined('rc.notification')){
		application.members.notification.delete(rc.notification);
	}	
		if(request.session.login eq 1){
		notifications =application.members.notification.get();
	}
}*/
</cfscript>
<cfoutput>
<div id="topNav">
  <table height="30" width="#width#" align="center">
    <TR>  
     <TD >
  <ul id="branding_menu">

<!--->
<cfif request.session.login eq 1 and notifications.recordcount gt 0>
   	<li class="mega"  <cfif hasbranding eq 0>style="top:-7px;"</cfif> >
	    <a href="##"><img src="#application.cdn.fam#error_add.png" width="10" height="10"> Notifications</a>
	  	<div style="width:250px;" class="small pad10">
			<cfloop query="notifications">
				#notifications.type# - <a href="#notifications.linkurl#&notification=#notifications.id#">#notifications.message#</a> <b>#application.util.dateToEnglish(notifications.dateEntered)#</b>
				<hr />
			</cfloop>
	  	</div>
	</li>
</cfif>
--->
	<cfif arrayLen(request.session.cart.list())>
		<li>
			<a href="#event.buildLink('commerce.cart.index')#"><img src="#application.cdn.fam#cart.png" width="10" height="10"> View Cart</a>
		</li>
	</cfif>
	
   <cfif request.session.login neq 0>
   <li class="mega" >

    <a href="##"><img src="#application.cdn.fam#information.png" width="10" height="10"> #request.session.username#</a> 
 
  <div>
 <table width="300">
				<TR>
				<TD width="33%" valign="top" style="padding:10px;">
				<h3>Profile</h3>
					<Hr>

                        <a href="#event.buildLink('member.profile.index')#" class="aNone small blackText">
                       View Profile</a>
				<BR>
                        <a href="#event.buildLink('member.account.index')#" class="aNone small blackText">
                        Edit Profile</a>
                       
						
					
				</td>
				<cfif application.community.settings.getValue('friends') eq 1>
					<TD></TD>
					<TD width="33%" valign="top" style="padding:10px;">
						<h3>Community</h3>
						<HR>
						<A href="#event.buildLink('community.admin.index')#" class="aNone small blackText">My Sites</A><BR />
						<a href="/index.cfm/content/group/?favorite=1" class="aNone small">My Groups</a> <BR />
                   	   <a href="javascript://"  class="friends aNone small blackText">View Friends</a><br />
						<a href="#event.buildLink('member.util.list')#" class="aNone small blackText">Members</a><BR>
		                <a href="#event.buildLink(linkTo='member.util.list',queryString="online=1")#" class="aNone small blackText">Who's Online</a><BR>
						<a href="#event.buildLink('member.invite.index')#" class="aNone small blackText">Invite Friends</a><BR>
					</td>
					<TD></TD>
					
					<TD width="33%" valign="top" style="padding:10px;">
						<h3>Mail</h3>
						<HR>
						<a href="#event.buildLink('mail.message.index')#" class="aNone small blackText">Inbox</a><BR>
		                <a href="#event.buildLink(linkTo='mail.message.index',queryString='folder=2')#" class="aNone small blackText">Sent Items</a><BR>
		                <a href="#event.buildLink('mail.compose.index')#" class="aNone small blackText">Compose a Message</a>
	            	</td>
				</cfif>
			</tr>
		</table>
	</div>
</li>
</cfif>
<cfif request.session.login eq 1 and request.session.accesslevel gte 20>
	<cfif request.layout.edit eq 1>
 	<li class="mega">
    	<a href="##" id="editPage"><img src="#application.cdn.fam#book_edit.png" width="10" height="10"> Edit This Page</a>
	</li>
	<li class="mega" >
    	<a href="##"><img src="#application.cdn.fam#color_wheel.png" width="10" height="10"> Design</a>
  		<div>
		<table width="150">
			<TR>
			
				<TD  valign="top" style="padding:10px;" nowrap="nowrap">
                    <cfif application.community.settings.getValue('firstPage') eq 'splash'><a href="/?edit=1" class="aNone small blackText">Splash Page</a></cfif>     
                    <a href="##" id="siteDesigner" class="aNone small blackText"> Site Designer</a> <BR>
				    <a href="##" id="templateSelector" class="aNone small blackText"> Change Template</a> <BR>
                    <A href="##" id="menuEditor" class="aNone small blackText"> Menu</A>
				</td>
			</tr>
		</table>
	</div>
</li>
	</cfif>
   <li class="mega" >
    	<a href="##"><img src="#application.cdn.fam#briefcase.png" width="10" height="10"> Admin</a>
	  	<div>
		<table>
			<TR>
				<TD  valign="top" style="padding:10px;" width="150" nowrap>
					<h3>This Site</h3>
					<HR>
					<A href="#event.buildLink('app.dashboard.configure')#" class="aNone small blackText">Configure Site</a><BR>
					<A href="#event.buildLink('app.dashboard.manage')#" class="aNone small blackText">Manage Site</a><BR>
					<A href="#event.buildLink('content.admin.index')#" class="aNone small blackText">Manage Content</A><BR />
					<A href="#event.buildLink('app.dashboard.statistics')#" class="aNone small blackText">Statistics</a><BR>
					<A href="#event.buildLink('app.dashboard.premium')#" class="aNone small blackText">Premium Features</a><BR>
				</TD>
				<Cfif request.session.accessLevel eq 100>
				<TD nowrap valign="top" style="padding:10px;" width="150" >
					<h3>Other</h3>
					<HR>
                    <A href="#event.buildLink('app.admin.index')#" class="aNone small blackText">App Admin</A><BR />
    			</td>
				</cfif>
	        </TR>
		</table>
		</div>
	</li>	
</cfif>
</ul>
</TD>
<!--- Next TD hold the middle spacing --->
<TD align="right" style="padding:0px" nowrap> </TD>
     
<cfif request.session.login eq 0>
	<cfif application.community.settings.getValue('Signup')>
		<cfset width="110">
	<cfelse>
		<cfset width="60">
	</cfif>
    <TD width="#width#" align="right" valign="top" style="padding-top:5px;">
		<a  href="##"  style="color:lightblue;font-weight:bold;" class="showLogin aNone"> Login</a>
        <cfif application.community.settings.getValue('Signup')> | 
        	<a  style="color:lightblue;padding-right:0px;font-weight:bold;" id="SignupLink" class="aNone" href="#event.buildLink('member.signup.details')#"> Signup</a>
        </cfif>
    </TD>
<cfelse>
	<TD align="right" valign="top" style="padding-top:5px;">  
		<a href="/?logout" id="logout" class="aNone" style="color:lightblue;font-weight:bold;">Logout</a>
	</td>
</cfif>
    </TR>
  </table>
</div>
</cfoutput>
