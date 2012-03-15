<style type="text/css">
table{ font-family:Arial, Helvetica, sans-serif;} 
</style>

<cfscript>
	q_content = event.getvalue('q_content');
	q_childContent = event.getvalue('q_childContent');
</cfscript>

<cfoutput>	
	<form method="post" action="#event.buildLink('content.form.saveChild')#">
		<input type="hidden" name="contentID" value="#valuelist(q_childContent.contentID)#" />
   		<input type="hidden" name="contentType" value="#q_Childcontent.contentType#">	
		<input type="hidden" name="parentcontentType" value="#q_content.contentType#" />
		<input type="hidden" name="parentID" value="#q_content.contentID#"/>
		<cfloop  query="q_childcontent">
		<div style="width:95%;  border-bottom:1px solid gray;  margin:3px" class="pad5" id="photo#contentID#">
			<table border="0" cellpadding="4" width="100%">
		        <TR valign="top" id="song#contentID#">
	            <TD>
					Filename: #application.content.getAttribute(q_childContent.attribs,'file')#<BR />
		            Artist:<BR /><input type="text" name="creator_#contentID#" value="#q_childContent.creator#" size="50" maxlength="70"><br />
		            Title:<BR /><INPUT TYPE="TEXT" NAME="title_#contentID#" SIZE="50" MAXLENGTH="255" value="#q_childContent.title#" ><BR>
					<input type="checkbox" name="delete_#contentID#" value="#q_childContent.contentID#"> Delete
					<BR /><BR />
				</TD>
				<TD valign="top" class="small">
			        Allow Download:<br />
		            <input type="radio" name="download_#contentID#" value="1" <cfif q_childContent.download eq 1>checked</cfif>> Yes <br />
		            <input type="radio" name="download_#contentID#" value="0" <cfif q_childContent.download eq 0 or q_childContent.download eq ''>checked</cfif>> No
		        </TD>
		        <TD></TD>
	        </TR>
		</table>
	</div>
	</cfloop>
	<div align="center"><INPUT TYPE="SUBMIT" VALUE="Update" class="button" ></Div>	
	</form>      
</cfoutput>