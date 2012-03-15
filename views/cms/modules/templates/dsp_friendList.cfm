<cfscript>
members = application.members.friend.list(rc.memberID);
</cfscript>

<cfoutput query="members">      
    	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		id="imagePreview",
		    		link='/index.cfm/member/profile/index/memberID/#members.memberID#'
		    		image=application.members.userpic( members.memberID ), 
		    		title = application.members.getusername(members.memberid,1),
		    		size=100 )#
</cfoutput> 
<br style="clear:both"> 
