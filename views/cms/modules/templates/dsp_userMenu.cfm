<cfoutput>
<div align="center">
	    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( request.session.memberID ), 
		    		size=150 )#
</div>

<table id="userMenu" align="center" width="99%">
	<TR>
		<TD id="um_Details">
			#request.session.firstname# #request.session.lastname#<BR>
			<cfif (application.community.settings.getValue('friends') eq 1)>
				#application.util.agesincedob(request.session.birthdate)# / <cfif request.session.gender eq 1>Male<cfelseif request.session.gender eq 2>Female</cfif><BR>
			</cfif>
			#request.session.city# #request.session.state#<BR>
			#request.session.country#<BR><BR>
		</td>
	</tR>	
	<TR><TD id="um_Profile" style="border-bottom: 1px solid gray;" class="pad3"><a href="/index.cfm/member/profile/index">My Profile</a></tD></tr>
	<cfif application.community.settings.getValue('friends') eq 1>
		<TR><TD id="um_Friends" style="border-bottom: 1px solid gray;" class="pad3"><a href="/index.cfm/member/friends/index">Your Friends</a></tD></tr>
		<TR><TD id="um_Groups" style="border-bottom: 1px solid gray;" class="pad3"><a href="/index.cfm/content/group/memberid/#request.session.memberid#">Your Groups</a></tD></tr>
		<TR><TD id="um_Inbox" style="border-bottom: 1px solid gray;" class="pad3"><a href="/index.cfm/mail/message/index">Inbox</a></tD></tr>
		<TR><TD id="um_Invite" style="border-bottom: 1px solid gray;" class="pad3"><a href="/index.cfm/member/invite/main">Invite Friends</a></tD></tr>
	</cfif>
    
   <cfscript>
	   mycontent = application.content.get(memberid=request.session.memberid);
   </cfscript>
   
   <cfquery dbtype="query" name="qContentTypes">
	   select distinct contenttype from mycontent
	   group by contenttype	
	   order by contentType
   </cfquery>

   <cfloop query="qContentTypes">
	<cfif qContentTypes.contentType neq 'Photo'>   	
	   <cfquery dbtype="query" name="qContentCount">
		   select count(contentID) as cnt from mycontent
           where contentType = '#qContenttypes.contentType#'
		   </cfquery>
		<cfscript>
		qcontentType = application.content.type.get(contentType=qContentTypes.contentType);
		</cfscript>
		<cfif  qContentCount.cnt gt 0>
	        <TR>
				<TD id="um_Invite" style="border-bottom: 1px solid gray;" class="pad3">
	        		<a href="/index.cfm/content/#qcontentType.contentType#/memberID/#request.session.memberid#">My #qContentType.description# (#qContentCount.cnt#)</a>
				</TD>
			</TR>
        </cfif>
	</cfif>
   </cfloop>
	<TR><TD id="um_Logout" style="border-bottom: 1px solid gray;" class="pad3"><a href="/?logout">Logout</a></tD></tr>
</table>
</cfoutput>