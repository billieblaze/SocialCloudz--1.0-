<cfsetting showdebugoutput="false">
<cfscript>
	community = event.getValue('community');
</cfscript>
<script>
	linkFormat = function(cellvalue, options, rowdata){
	link_1 = '<a href="/index.cfm/emailMarketing/message/index/communityID/<cfoutput>#community.communityID#</cfoutput>/messageID/'+rowdata['MESSAGEID']+'" class="ajaxTabLink"><img src="/images/fam/application_edit.png" title="edit"></a> ';
	link_2 = '<a href="/index.cfm/emailMarketing/message/delete/communityID/<cfoutput>#community.communityID#</cfoutput>/messageID/'+rowdata['MESSAGEID']+'" class="ajaxTabLink"><img src="/images/fam/application_delete.png" title="delete"></a> ';
	link_3 = '<a href="/index.cfm/emailMarketing/message/preview/communityID/<cfoutput>#community.communityID#</cfoutput>/messageID/'+rowdata['MESSAGEID']+'" class="ajaxTabLink"><img src="/images/fam/application_form_magnify.png" title="preview"></a> ';
	link_4 = '<a href="/index.cfm/emailMarketing/send/index/communityID/<cfoutput>#community.communityID#</cfoutput>/messageID/'+rowdata['MESSAGEID']+'" class="ajaxTabLink"><img src="/images/fam/email.png" title="send"></a> ';
	link_5 = '';
	return link_1 + link_2 + link_3 + link_4 + link_5;
	}	
	<cfif request.session.message neq ''>$.jGrowl('<cfoutput>#request.session.message#</cfoutput>');<cfset request.session.message = ''></cfif> 	
</script>

<cfoutput>
	<div align="right">
	 <a href="#event.buildLink(linkTo='emailMarketing.message.index',queryString='communityID=#community.communityID#')#" class="ajaxTabLink">New Message</A> | 
	 <a href="#event.buildLink(linkTo='emailMarketing.mailingList.subscribers',queryString='communityID=#community.communityID#')#" class="ajaxTabLink">Manage Subscribers</a> 
	</div> 
</cfoutput>
<BR />
<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
						gridName = 'emailMarketing' 
						objectName = 'Message'	 
						width="100%" 
						rows="10"
						
						method = 'application.mailinglist.getMessage' 
						arguments = 'communityID=#rc.community.communityID#' 
						defaultSort = 'ID' 							
	
						pid='#request.session.memberID#'
						datasource="community"
						isAdmin='1' 
> 