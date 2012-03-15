<cfscript>
	q_content = event.getvalue('q_content');
	q_childContent = event.getvalue('q_childContent');
	relocateURL = '/index.cfm/content/form/child/#q_content.contentType#/#q_content.contentID#';
</cfscript>
<cfoutput>
   <form action="#event.buildLink('content.form.saveChild')#" method="post">
   	   	<input type="hidden" name="contentID" value="#valuelist(q_childContent.contentID)#" />
	   	<input type="hidden" name="contentType" value="#q_Childcontent.contentType#">	
		<input type="hidden" name="parentcontentType" value="#q_content.contentType#" />
		<input type="hidden" name="parentID" value="#q_content.contentID#"/>
       	<cfloop query="q_childContent">
			<div style="width:95%;  border-bottom:1px solid gray;  margin:3px" class="pad5" id="photo#contentID#">
			<table border="0" cellpadding="4" width="100%">
		  	  <tr>
		       <td width="230" align="center" valign="top">
		       	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
					image= '#application.content.getAttribute(q_childContent.attribs,'cdnurl')#/#application.content.getAttribute(q_childContent.attribs,'file')#', 
					size=180, 
					showTools = 1 )#

		       <br /><br />
		           </td>
		       <TD valign="top">
					Caption: <textarea NAME="title_#q_childContent.contentID#" rows="4" style="width:90%">#q_childContent.title#</textarea><BR><BR>
						<span class="small"> <input type="radio" name="default" value="#q_childContent.contentID#"  <cfif application.content.getAttribute(q_childContent.attribs, 'default') eq 1>checked</cfif>/> Default Image</span><BR>
				      <span class="small">   <input type="checkbox" value="#q_childContent.contentID#" name="delete_#q_childContent.contentID#" class="button"> Delete This Photo</span>
		          </td>
		           </tr>
		    </table>
		<div align="center" style="font-family: arial; font-size: 11px;">
		File URL: #application.content.getAttribute(q_childContent.attribs,'cdnurl')#/#application.content.getAttribute(q_childContent.attribs,'file')# 
		</div>
	</div>
    </cfloop>  	
	<div align="center"><INPUT TYPE="SUBMIT" VALUE="Save Changes"  class="button"></div> 
</form>
</cfoutput>