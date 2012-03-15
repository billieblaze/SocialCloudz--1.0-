<Cfsetting showdebugoutput="false">
<Cfset community = event.getValue('community')>
<cfoutput>
<div id="subscriberAdmin">
	<div style="float:left">
		<a href="/index.cfm/emailMarketing/admin/index/communityID/#community.communityID#" class="ajaxTabLink">Back to Email Marketing</a>
	</div>
	<div align="right">
		<a href="##" id="addSubscriber">Add Subscriber</a> | 
		<a href="/index.cfm/emailMarketing/mailinglist/export/communityID/#community.communityID#" target="_blank">Export Subscribers</a>
	</div>
</div>
<!---email | type |  date joined | last sent  | bounce alert | unsubscribe--->
<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
						gridName = 'emailMarketingSubscribers' 
						objectName = 'Subscriber'	 
						width="100%" 
						rows="10"
						
						method = 'application.mailinglist.get' 
						arguments = 'communityID=#rc.community.communityID#' 
						defaultSort = 'ID' 							
	
						pid='#request.session.memberID#'
						datasource="community"
						isAdmin='1' 
						showdelete = 1 
						deleteURL = '/index.cfm/emailMarketing/mailinglist/delete/communityID/#community.communityID#/id/'
> 
<script>
	$('##addSubscriber').modalAjax({
		title: 'Add a Subscriber',
		url: '/index.cfm/emailMarketing/mailinglist/index/communityID/#community.communityID#',
		initAjaxForm: true, 
		initValidate: true,
		ajaxFormSuccess: function(){
			jQuery("##emailMarketingSubscribers").trigger("reloadGrid");
		},
		ajaxFormClose: true
	});
</script>
</cfoutput>
