<cfscript>
	q_content = rc.contentModuleData.query;
	getModule = qGetModules;
</cfscript>
	<cfoutput query="q_content"> 
		<cfif q_content.image eq ''>
 				    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
	    		image=application.members.userpic( q_content.memberID ), 
				 link='/index.cfm/content/#q_content.contentType#/#evaluate('#q_content.linkID#')#',
	   		    size=getmodule.thumbsize, 
			     title=q_content.title, 
			     subtitle='Posted By: #application.members.getUserName(memberID)#<br>Views:#q_content.views#', 
			     showMosaic = 1 )#
		<cfelse>
		    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
			    image=q_content.image, 
			    link='/index.cfm/content/#q_content.contentType#/#evaluate('#q_content.linkID#')#',
	   		    size=getmodule.thumbsize, 
		     title=q_content.title, 
		     subtitle='Posted By: #application.members.getUserName(memberID)#<br>Views:#q_content.views#', 
		     showMosaic = 1 )#
		</cfif>
	</cfoutput>
<br style="clear:both">