<cfscript>
		q_content = rc.contentModuleData.query;
</cfscript>
<cfoutput>
<table width="100%">
<TR><TD><B>Title</b></td><TD><B>Size</b></td><TD><B>Type</b></td><TD><B>Uploaded</b></td>
<cfloop query='q_content'>
<TR>
<TD><a href="/index.cfm/content/#q_content.contentType#/#evaluate('q_content.#q_content.linkID#')#">#title#</a></TD> 
<TD>#application.content.getAttribute(q_content.attribs, 'size')#</td>
<TD>
#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
	    		image=q_content.image, 
	    		size=getmodule.thumbSize,
	    		align=getmodule.thumbalign )#
	    		
#application.content.getAttribute(q_content.attribs, 'filetype')#</td>

<TD>
#dateformat(application.timezone.castFromServer(q_content.publishDate, application.community.settings.getValue('timezone')), request.community.dateformat)#<BR><span class="small"> by #application.members.getusername(q_content.memberid,1)#</span>
</td>
</tr>
</cfloop>
</table>
</cfoutput>