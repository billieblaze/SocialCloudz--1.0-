<cfscript>
folders = event.getvalue('folders');
mail = event.getvalue('mail');
</cfscript>
<cfoutput query="mail">
<div class="mod">
	<div class="hd">#mail.subject#</div>
	<div class="bd">
		<div>
			<div style="float:left; width:80px;">
			    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( mail.sourceID ), 
		    		size=75 )#
			</div>
			<div>
				<B>From:</b> #application.members.getusername(mail.sourceID,1)#<BR>
				<B>Received:</b> #dateformat(mail.dateCreated, request.community.dateformat)# #timeformat(mail.dateCreated)#<BR>
			</div>
		</div>
		<BR><BR>
		#mail.message#
		<BR><BR>
		<div style="float:left">
			<input type="button" value="Reply" onclick="location.href='/index.cfm/mail/compose/parentID/#mail.ID[1]#';">
			<input type="button" value="delete" onclick="confirmDelete('Are you sure you want to delete this message?', '/index.cfm/mail/util/action/action/delete/messageID/#ID#')">  
		</div>
		<div align="right">
			<form action="/index.cfm/mail/util/action" method="post">
			 <select name="folderID">
		    	<cfloop query="folders">
		        <option value="#folderID#">#folderName#</option>
		        </cfloop>
		    </select>
		    <input type="submit" value="Move To folder" name="action" />
		    <input type="hidden" name="messageID" value="#mail.id#" />
		    </form>
		</div>	
	</div>
	<div class="ft"></div>
</div>
</cfoutput>