<cfset commentFormTarget = ''>
<Cfif event.getValue('parentid','') neq '' and  event.getValue('parentid',0) neq 0>
	<cfset commentFormTarget = rc.parentID>
</cfif>
<cfoutput>
	<form action="/index.cfm/comments/main/add" class="commentForm" id="commentForm#commentFormTarget#" name="commentForm" method="post">
		<input type="hidden" name="fkID" value="#event.getvalue('fkid')#" />
	    <input type="hidden" name="fkType" value="#event.getvalue('fktype')#" />
	    <input type="hidden" name="commentMemberID" value="#event.getvalue('commentMemberID')#"  />
	    <input type="hidden" name="commentReturnURL" value="#event.getvalue('commentReturnURL','')#"  />
	    <input type="hidden" name="parentID" value="#event.getvalue('parentID','')#"  />
	    
	    <table>
			<cfif request.session.memberid eq 0>
			    <TR>
		        	<TD class="small">Username:</TD>
		            <TD>
		            	<input type="text" name="guestUsername" style="width:98%" class="small" />
					</TD>
		        </TR>
		    	<TR>
		        	<TD class="small">Email:</TD>
		            <TD>
		            	<input type="text" name="guestEmail" style="width:98%" class="small" />
		            </TD>
		        </TR>
		    </cfif>
		    <TR>
			    <TD class="small" valign="top"></TD>
			    <TD>
					<textarea id="comment" name="comment" cols="95" style="width:98%" class="small comment"></textarea> 
			    </TD>
		    </TR>
			<TR>
				<TD></TD>
				<TD class="xsmall">
					<cfif event.getCurrentEvent() eq 'member.profile.index'>
						<div style="float:left;">
							<span class="commentAttachText">Attach:</span> 
							<a href="##" onclick="attachMedia('commentAttach', '/index.cfm/comments/attach/link', 'a Link');" class="blackText">Link</a> | 
							<a href="##" onclick="attachMedia('commentAttach', '/index.cfm/comments/attach/image?memberID=#request.session.memberID#', 'an Image');" class="blackText">Image</a> | 
							<a href="##" onclick="attachMedia('commentAttach', '/index.cfm/comments/attach/video?memberID=#request.session.memberID#', 'a Video');" class="blackText">Video</a>  
						</div>
					</cfif>
					<div align="right">
						<input type="submit" value="Add" class="small"/>
						<Cfif event.getValue('parentID','') neq 0 and event.getValue('parentID',0) neq 0>
							<input type="submit" value="Cancel" class="small" onclick="hideReplyForm(event.get)"/>						
						</cfif>
						&nbsp;&nbsp;
					</div>
				</TD>
			</TR>
	    </table>
		<div id="commentAttach" style="display:none; border: 1px solid gray;" class="pad5">
			<div style="float:left" id="commentAttach_title"></div>
			<div align="right"><a href="##" onclick="closeAttach('commentAttach')"><img src="/images/closelabel.gif"></a></div>
			<div id="commentAttach_content" class="pad5">
			</div>
		</div>
	</form>
	<br style="clear:both" />
</cfoutput>