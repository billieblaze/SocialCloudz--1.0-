<!--- handle discrepencies b/w include and running in coldbox handler --->
<Cfif not isdefined('comments')>
	<cfset comments = event.getValue('qcomments')>
</cfif>
<cfoutput><li id="comment_#comments.id#">
	<table width="100%">
		<TR>
			<TD width="60" class="small pad5" valign="top">  
					    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( comments.memberID ), 
		    		size=60 )#

			</TD>
			<TD valign="top" align="left" class="small pad5">
				<B>#application.members.getusername(memberid = comments.memberID)#</B> #wrap(comments.comment, 125)#
				<cfif comments.attachmentType eq 'Link'>
					<BR /><BR />
					<h3><A href="#comments.attachmentURL#" target="_blank" class="blackText">#comments.attachmentTitle#</A></h3>
					#comments.attachmentDescription# 
				<cfelseif comments.attachmentType eq 'Image'>
					<BR /><BR />
					<cfif comments.attachmentURL neq ''>
						<a href="#comments.attachmentURL#" target="_blank"><img src="#comments.attachmentURL#" style="max-width:400px !important; max-height:400px !important" /></a>    
				    <cfelse>
						Type: #comments.attachmentType#<BR />
				    	URL: #comments.attachmentURL#<BR />
					</cfif>
				<cfelseif comments.attachmentType eq 'Video'>
					<BR /><BR />
					<cfif attachmentCode neq ''>
				        #attachmentCode#
				    <cfelse>
				       	<cfif comments.converted eq 0 and comments.convertError eq 0>
				        	<img src="/images/converting_icon.png" />
				        <cfelseif comments.converted eq 0 and comments.convertError eq 1>
				        	<img src="/images/error_icon.png" />
				        <cfelse>
				            Converted: #comments.converted#<BR />
				            Type: #comments.attachmentType#<BR />
				            Title: #comments.attachmentTitle#<BR />
				            Desc: #comments.attachmentDescription#<BR />
				            Code: #comments.attachmentCode#<BR />
				            URL: #comments.attachmentURL#<BR />
						</cfif>        
				    </cfif>
				</cfif>
				
				
				<BR /><BR />
				<span class="xsmall">
					#application.util.dateToEnglish(application.timezone.castFromServer(comments.dateEntered, application.community.settings.getValue('timezone')))# - 
					<a href="##" onclick="showReplyForm('ol##update_#comments.id#', '#comments.id#');" class="blackText xsmall">Reply</a> 
					<cfif request.session.memberID eq comments.memberID> 
						| <a href="##" onclick="ajaxConfirmDelete('Are you sure you want to delete this comment?','/index.cfm/comments/main/delete/id/#comments.id#','li##comment_#comments.id#');" class="blackText xsmall">Delete</a>
					</cfif>
				</span>
			</TD>
		</TR>
	</table>
</li>
</cfoutput>