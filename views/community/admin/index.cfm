<cfparam name="rc.flagged" default="">
<cfparam name="rc.contenttype" default="">
<cfparam name="rc.do" default="">
<cfparam name="rc.contentid" default="0">
<cfparam name="rc.parentid" default="0">
<cfparam name="rc.tag" default="">
<cfparam name="rc.memberID" default="">
<cfparam name="rc.sort" default="">
<cfparam name="rc.featured" default="">
<cfparam name="rc.thispage" default="0">

<div class="mod">
	<div class="hd">My Communities</div>
	<div class="bd">
		<script language="javascript">
			communityFormatter = function(cellvalue, options, rowdata){ 
			 	var ret = '<a href="' + rowdata['BASEURL'] + '?i=<cfoutput>#cookie.token#</cfoutput>">' + rowdata["SITE"] + '</a> (ID: ' + rowdata["COMMUNITYID"] +')<BR>';
			  	return ret;
			  
			};
		
			actionFormatter = function(cellvalue, options, rowdata){ 
				if (rowdata['ACCESSLEVEL'] == 1 && <cfoutput>#request.session.accesslevel#</cfoutput> < 100){
					ret = '';
				} else { 
					ret = '<a href="/index.cfm/app/dashboard/configure/communityID/' + rowdata["COMMUNITYID"] +'">Configure</a> | <a href="/index.cfm/app/dashboard/manage/communityID/' + rowdata["COMMUNITYID"] +'">Manage</a> | <a href="/index.cfm/app/dashboard/statistics/communityID/' + rowdata["COMMUNITYID"] +'">Statistics</a> | <a href="/index.cfm/app/dashboard/premium/communityID/' + rowdata["COMMUNITYID"] +'">Premium</a> ';
				}
			  return ret;
			};
			accessFormat = function(cellvalue, options, rowdata){ 
	  var access_result = 'Member';
	  if (cellvalue == '100'){ 
	  	access_result = 'Support';
	  } else if (cellvalue == '20'){ 
		access_result = 'Owner';
	  } else if (cellvalue == '10'){ 
		access_result = 'Editor';
	  } 
	  
	  return access_result;
	}
		</script>
	
		<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
								gridName = 'communityAdmin' 
								objectName = 'Community'	 
								width="100%" 
								rows="10"
								
								method = 'application.community.getMine' 
								arguments = 'memberID=#request.session.memberID#' 
								defaultSort = 'communityID' 							
			
								pid='#request.session.memberID#'
								datasource="community"
								isAdmin='1' 
		> 
	</div>
	<div class="ft"></div>
</div>