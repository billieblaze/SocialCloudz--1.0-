<cfoutput>
<form action="#event.buildLink('cms.page.submit')#" method="post" id="pageMetaForm" class="ajaxform">
	<input type="hidden" name="id" value="#rc.pageDetail.id#">
	Title: <br><input type="text" id="title" name="title" value="#rc.pageDetail.title#" class="required" style="width:100%"><br>
	Keywords: <br> <input type="text" id="keywords" name="keywords" value="#rc.pageDetail.keywords#" style="width:100%"><br>
	Description: <br>
	<textarea name="description" style="width:100%">#rc.pageDetail.description#</textarea><br><br>
	<input type="hidden" name="url" value="#rc.pageDetail.url#">
	<BR><BR>
	<div align="center"><input type="submit"></div>
</form>
</cfoutput>