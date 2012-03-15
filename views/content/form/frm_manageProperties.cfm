<style type="text/css">
table{ font-family:Arial, Helvetica, sans-serif;} 
</style>

<cfscript>
q_content = event.getvalue('q_content');
q_childContent = event.getvalue('q_childContent');
</cfscript>
<cfoutput>
   <form action="#event.buildLink('content.form.saveChild')#" method="post">
   	<input type="hidden" name="contentID" value="#valuelist(q_childContent.contentID)#" />
   	<input type="hidden" name="contentType" value="#q_Childcontent.contentType#">	
	<input type="hidden" name="parentcontentType" value="#q_content.contentType#" />
	<input type="hidden" name="parentID" value="#q_content.contentID#"/>
   	<cfloop query="q_childContent">
		<div style="width:95%;  border-bottom:1px solid gray;  margin:3px" class="pad5" id="photo#contentID#">
		    <table width="100%">
		    <TR><TD>
		       
		       	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
			image=q_childcontent.image, 
			size=200
			)#
				<br /><br />
		    </TD><TD>
		     		 <span class="small"> <input type="radio" name="default" value="#q_childContent.contentID#"  <cfif application.content.getAttribute(q_childContent.attribs, 'default') eq 1>checked</cfif>/> Default Image</span><BR>
				<span class="small">   <input type="checkbox" value="#q_childContent.contentID#" name="delete_#q_childContent.contentID#" class="button"> Delete This Photo</span>
		     </TD></TR></table>
		</div>
    </cfloop>  	
	<div align="center"><INPUT TYPE="SUBMIT" VALUE="Save Changes"  class="button"></div> 
	</form>
</cfoutput>