<div class="mod">
	<div class="hd">Manage Email Templates</div>
	<div class="bd">
		<script>
			templateFormatter = function(cellvalue, options, rowdata){ 
			<cfoutput>
				isNew = 0;
				
				var url = "<a class='blackText' href='/index.cfm/emailTemplates:admin/form/id/" + rowdata['ID'] + "/communityID/#rc.communityID#/?new="+isNew+"'>"+cellvalue+"</a>"; //TODO: add an instance selector 
				return url;
			</cfoutput>
			}
		</script>
		
<a href="/index.cfm/emailTemplates:admin/form/id/0/new/1" style="text-decoration:none"><img src="/common/fam/add.png"> Add Template</a>
	<cfmodule template="/common/dynamicGrid/jqGrid4.cfm" 
		gridName = 'emailTemplateListing'   
		method = 'application.emailTemplates.gateway.get'
		defaultsort = 'id'	
		arguments = 'communityID=#request.community.communityID#&editable=1'
		 rows="100"
		 showCustom = 1
		 application = 'EmailTemplatesModule'
		 datasource='community'	
		 pid='#request.session.memberid#'
		 isAdmin = 1
	 >


	</div>
	<div class="ft"></div>
</div>