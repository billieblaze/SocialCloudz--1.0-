<cfscript>
	q_content = rc.contentModuleData.query;
	getModule = qGetModules;
</cfscript>
<cfoutput>
	<h2>#q_content.title#</h2>
	#q_content.desc#<br />
	<cfif isDefined('rc.contentModuleData.child')>
		<cfset q_childcontent = rc.contentModuleData.child>
		<cfloop query="q_childcontent"> 
			<cfset myimage = q_childcontent.image>
			<cfif myimage eq ''>
				<cfset myimage = application.members.userpic(q_childcontent.memberid)>
			</cfif>
			
		    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
				image=myImage, 
				link='/index.cfm/content/#q_childcontent.contentType#/#evaluate('#q_childcontent.linkID#')#', 
				size=getmodule.thumbsize, 
				align=getmodule.thumbalign,
				title=q_childcontent.title, 
				subtitle='Posted By: #application.members.getUsername(q_childcontent.memberID)#<br>Views: #q_childcontent.views#', 
				showMosaic = 1 )#
		</cfloop>	
	</cfif>
	<br style="clear:both">
</cfoutput>