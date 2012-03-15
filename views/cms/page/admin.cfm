<cfoutput>
<script>
	function confirmDelete(id){
		$.get('/index.cfm/cms/page/delete/id/'+id, function(){
			$('##cmsAdmin').trigger('reloadGrid');
		});
	}
	
	viewPage = function(cellvalue, options, rowdata){ 
		viewURL = '#rc.community.baseurl#/pages/' + rowdata['URL'] + '?i=#cookie.token#';
		 href = '<a href="'+viewURL+'" target="blank" class="small">View</a> | ';
	  href = href + '<A href="##" onclick="confirmDelete('+rowdata['ID']+')" class="small">Delete</A>';
	  return href;
	}
</script>
</cfoutput>
		
<div align="right">
	<a href='#' class='blackText' onclick="$('.addCMSPage').toggle();">Add New Page</a><BR>
</div>
<div class="addCMSPage ui-helper-hidden">
	<form action="/index.cfm/cms/page/addSubmit" method="post" class="ajaxform">
		Page Title: <input type="text" name="title" id="newpagetitle" class="required"><input type="submit" value="Create Page">
	</form>
</div>
<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
						<!--- Setup --->
						gridName = 'cmsAdmin' 
						objectName = 'CMS Page'	 
						rows="10"
						
						method = 'application.cms.page.get' 
						arguments = 'communityID=#rc.community.communityID#&cfmonly=1' 
						defaultSort = 'asc' 							
						defaultSortField = 'title'

						pid='#request.session.memberID#'
						datasource="community"
						isAdmin='1' 
						
		> 