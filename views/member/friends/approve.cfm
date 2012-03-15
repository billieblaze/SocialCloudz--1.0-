<cfscript>
	friends = event.getvalue('friends');
</cfscript>
<div class="mod">
	<div class="hd">Friend Requests</div>
	<div class="bd">
		<table width="100%">
		<cfoutput query="friends">
			<TR>
				<TD align="center">
			    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( memberID ), 
		    		size=150 )#
				<BR><a href="#event.buildLink(linkTo='member.profile.index',queryString='memberID=#memberID#')#">#username#</a></td>
				<TD valign="middle"><form action="#event.buildLink('member.friends.doApprove')#" method="POST"><input type="hidden" name="memberID" value="#memberID#"><input type="submit" name="submit" value="Approve"> <input type="submit" name="submit" value="Deny"></form></TD>
			</TR>
		</cfoutput>
		</table>
	</div>
	<div class="ft"></div>
</div>