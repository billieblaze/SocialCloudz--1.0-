<cfscript>
members = event.getvalue('members');
membercount = event.getvalue('membercount').count;
title = application.cms.settings.check('Title');
</cfscript>
<div class="mod">  
<cfoutput>
<div class="hd">
<cfif isdefined('rc.search')>

Search #title# - #rc.search# - #membercount# results

<cfelseif isdefined('rc.online') and rc.online eq 1>
Online #title# (#membercount#)
<cfelse>
#title# (#membercount#)
</cfif>
</div>  </cfoutput>
<div class="bd"> 
<form action="/index.cfm/member/util/list">
Sort By: 
	<select name="sort">
		<option value="m.memberID asc" <cfif event.getValue('sort','') eq 'm.memberID asc'>selected</cfif>>MemberID</option>
		<option value="username asc" <cfif event.getValue('sort','') eq 'username asc'>selected</cfif>>Username</option>
		<option value="city asc, state asc" <cfif event.getValue('sort','') eq 'city asc, state asc'>selected</cfif>>State</option>
	</select>
	<input type="submit" value="Go" class="button">
</form>
				
<cfoutput query="members">     
<div style="width:98%; height: 105px; border:1px solid gray; float:left" class="pad5">


		 #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
	    		image=application.members.userpic( members.memberID ), 
	    		size=100,
	    		link='/index.cfm/member/profile/index/memberID/#members.memberID#' )#
	<div>
	<B>#application.members.getUsername(members.memberID,1)#</b> - 
	<Cfif  application.community.settings.getValue('friends') eq 1>
		<cfif members.birthdate neq '' >#application.util.agesincedob(members.birthdate)# /</cfif> 

		<cfif members.gender eq 1>Male<cfelseif members.gender eq 2>Female</cfif><BR>
	</cfif>
	
	<cfif city neq '' and state neq ''>#city#, #state# </cfif>
	<cfif country neq 'US'>#country#</cfif><BR>
	<span class="small">Last Seen: #dateformat(members.lastclick, request.community.dateformat)#</span>
	<BR><BR>
</div>
<div>
	
<cfif request.session.memberID neq members.memberID and application.community.settings.getValue('friends') eq 1>
	<cfscript>
	isfriend = application.members.isfriend(request.session.memberid, members.memberID);
	</cfscript>
       <cfif isfriend EQ 1>
        	<a href="#event.buildLink(linkTo='member.friends.remove',queryString='memberID=#members.memberID#')#">Remove Friend</a>
	<cfelseif isfriend eq 2>
		Pending Friend
    	<cfelse>
	        <a href="#event.buildLink(linkTo='member.friends.add',queryString='memberID=#members.memberID#')#">Add Friend</a>
        </cfif> <BR>

	 
		<a href="#event.buildLink(linkTo='mail.compose.index',queryString='memberID=#members.memberID#')#">Send Message</a>
	</cfif>
	
</div>
</div>       

</cfoutput>
 <br style="clear:both">  
<cfoutput>#application.util.queryPaging('/index.cfm/member/util/list', membercount, 10)#</cfoutput>
</div>  
<div class="ft"></div></div>
