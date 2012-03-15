<cfscript>
friends = event.getvalue('friends');
myUserName=application.members.getusername(rc.memberID);
</cfscript>
<cfoutput>
<Cfif friends.recordcount>
<div class="mod">  
	<div class="hd">#friends.recordCount# Friends</div>  
	<div class="bd"> 
		<cfloop query="friends" endrow="12">     
			<cfset username = application.members.getusername(memberid)> 
				 #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
	    		image=application.members.userpic( memberID ), 
	    		size=45,
	    		link='/index.cfm/member/profile/index/memberID/#memberID#' )#
		</cfloop> 
		<br style="clear:both">  
		<div align="right">
			<a href="javascript://" class="Friends" alt="#myUsername#'s Friends" rel='#rc.memberID#'>View All</a>
		</div>
	</div>  
	<div class="ft"></div>
</div>
</cfif>
</cfoutput>