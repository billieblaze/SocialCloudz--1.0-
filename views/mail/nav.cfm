<cfscript>
folders = event.getvalue('folders');
</cfscript>
<cfoutput>	

<div class="mod">
	<div class="hd">Navigation</div>
	<div class="bd">
    
    
	<a href="#event.buildLink('mail.message.index')#" class="aNone">Inbox</a><BR />
    -	<a href="##" id="addMailFolder">Add a Folder</a><BR />
    <cfloop query="folders">
    - <a href="#event.buildLink(linkTo='mail.message.index',queryString='folder=#folderID#')#">#folderName#</a> (<a href="#event.buildLink(linkTo='mail.folder.delete',queryString='folderID=#folderID#')#">X</a>)<BR /> 
    </cfloop>
	<a href="#event.buildLink(linkTo='mail.message.index',queryString='folder=2')#" class="aNone">Sent Items</a><Br /><BR />
     <a href="#event.buildLink('mail.compose.index')#" class="aNone">Compose a Message</a>

	</div>
	<div class="ft"></div>
</div>
</cfoutput>

<script>
 $('##addMailFolder').modalAjax({
		url: '/index.cfm/mail/folder/index/memberID/#request.session.memberID#?r='+Math.random(),
		title: 'Add a Folder',
		width: 300,
		initAjaxForm: true,
		ajaxFormClose: true
	});
</script>