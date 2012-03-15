<cfscript>
	isfriend = application.members.isfriend(rc.memberID, request.session.memberID);
	member = event.getvalue('member');
</cfscript>
<cfoutput>

	<div class="mod">
		<div class="hd">Details</div>
	    <div class="bd" align="center">
	
						 #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
				image=application.members.userpic(rc.memberID), 
				size=100,
				align="center"
				 )#
				 
				 
				 <div>
							#application.members.getUsername(rc.memberID)#<BR>
							<cfif (application.community.settings.getValue('friends') eq 1)>
								#application.util.agesincedob(member.birthdate)# / <cfif member.gender eq 1>Male<cfelseif member.gender eq 2>Female</cfif><BR>
							</cfif>
							 #member.city#, #member.state#<BR>
				
				</div>
					
					<cfif request.community.communityID eq '251'>
					<table>
						<tr>
							<td colspan='2' class="small">
								<a href='mailto:#member.email#'>Email Company</a>
							</td>
						</tr>

						<tr>
							<td colspan='2' class="small">
								<a href='/index.cfm/content/job?memberID=#rc.memberID#'>View Jobs</a>
							</td>
						</tr>	</table>
					</cfif>
							 
			
			    <cfif request.session.login eq 1 and application.community.settings.getValue('friends') eq 1>
					<cfif request.session.memberID neq rc.memberID>
	        			<cfif isfriend EQ 1>
				        	<a href="#event.buildLink(linkTo='member.friend.remove',queryString='memberID=#rc.memberID#')#" class="small">Remove Friend</a><BR>
						<cfelseif isfriend eq 2>
							<span class="small">Pending Friend</span><BR>
				    	<cfelse>
		        			<a href="#event.buildLink(linkTo='member.friend.add',queryString='memberID=#rc.memberID#')#" class="small">Add Friend</a><BR>
				        </cfif> 
		 				<a href="#event.buildLink(linkTo='mail.compose.index',queryString='memberID=#rc.memberID#')#" class="small">Send Message</a>
					</cfif>
				</cfif>
		</div>
	    <div class="ft"></div>
	</div>


   <div class="mod">
        <div class="hd">Statistics</div>
        <div class="bd small">
		Joined: #dateformat(application.timezone.castFromServer(member.dateEntered, application.community.settings.getValue('timezone')), request.community.dateformat)#<BR>
		Visits: #member.numlogins#<BR>
		Profile Views: #member.profileviews#<BR>
		Last Seen: #dateformat(member.lastclick, request.community.dateformat)#<BR>
		</div>
		<div class="ft"></div>
   </div>
</cfoutput>