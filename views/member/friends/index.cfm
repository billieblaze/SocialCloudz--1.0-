<Cfsetting showdebugoutput="false">
<cfscript>
members = event.getvalue('members');
</cfscript>
<div style="width:450px; height:500px; overflow:scroll;">
<cfoutput query="members">      
	<div style="float:left; width:100px; height:130px; text-align:center" class="pad3">
		<div style="height:100px; width:100px; vertical-align:middle">
		    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
	    		image=application.members.userpic( memberID ), 
	    		size=100,
	    		link='/index.cfm/member/profile/index/memberID/#memberID#' )#
		</div>      
		<b>#application.members.getusername(memberid,1)#</b>       
	</div>    
</cfoutput>
<br style="clear:both">  