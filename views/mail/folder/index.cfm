<cfoutput>
<div style="width:300px; height:80px" class="pad10">
	<form action="#event.buildLink('mail.folder.submit')#" method="post" id="addFolder">
		<input type="hidden" name="folderID" value="#event.getValue('folderID',0)#">
		<div align="center">Name: <input type="text" name="folderName" id="folderName">
		<BR><BR>
		<input type="submit" value="Save"></div>
	</form>
</div>
</cfoutput>
