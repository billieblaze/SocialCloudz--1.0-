<!--- handle discrepencies b/w include and running in coldbox handler --->
<Cfif not isdefined('replies')>
	<cfset replies = event.getValue('qreplies')>
</cfif>
<cfoutput><li id="comment_#replies.id#">
	<table width="100%">
		<TR>
			<TD width="60" class="small pad5" valign="top">  
				    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( replies.memberID ), 
		    		size=60 )#
			</TD>
			<TD valign="top" align="left" class="small pad5">
				<B>#application.members.getusername(memberid = replies.memberID)#</B> #wrap(replies.comment, 125)#
				<BR /><BR />
				<span class="xsmall">
					#application.util.dateToEnglish(application.timezone.castFromServer(replies.dateEntered, application.community.settings.getValue('timezone')))# - 
					<cfif request.session.memberID eq replies.memberID> 
						<a href="##" onclick="ajaxConfirmDelete('Are you sure you want to delete this comment?','/index.cfm/comments/main/delete/id/#replies.id#','li##comment_#replies.id#');" class="blackText xsmall">Delete</a>
					</cfif>
				</span>
			</TD>
		</TR>
	</table>
</li>
</cfoutput>