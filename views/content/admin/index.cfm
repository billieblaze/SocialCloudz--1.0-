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

<cfscript>
	communityList = event.getValue('communityList');
	community = event.getValue('community');
	contentTypes = application.content.type.get();
</cfscript>

<script language="javascript">
	imageFmatter = function(cellvalue, options, rowdata){
	  image = ('<a href="http://<cfoutput>#community.baseURL#</cfoutput>/index.cfm/content/'+ rowdata['CONTENTTYPE'] + '/'+ rowdata['CONTENTID']+'"><img src="' + rowdata['IMAGE'] + '">"</a>');
	  return image;
	}

	titleFmatter = function(cellvalue, options, rowdata){
	  user = ('<a href="http://<cfoutput>#community.baseURL#</cfoutput>/index.cfm/content/'+ rowdata['CONTENTTYPE'] + '/'+ rowdata['CONTENTID']+'">' + cellvalue + '</a>');
	  return user;
	}
	
	userFmatter = function(cellvalue, options, rowdata){
	  user = ('<a href="http://<cfoutput>#community.baseURL#</cfoutput>/index.cfm/member/profile/index/memberID/'+ rowdata['MEMBERID'] + '">' + cellvalue + '</a>');
	  return user;
	}
	approvalFormat = function(cellvalue, options, rowdata){ 
	  if (cellvalue == '0'){ 
	  	result = '<A href="/index.cfm/content/admin/approve/communityID/<cfoutput>#community.communityID#</cfoutput>/approved/1/contentID/'+rowdata['CONTENTID']+'">No</A>';
	  } else { 
	  	result = '<A href="/index.cfm/content/admin/approve/communityID/<cfoutput>#community.communityID#</cfoutput>/approved/0/contentID/'+rowdata['CONTENTID']+'">Yes</A>';
	 }
	  return result; 	
	}
	
	flagFormat = function(cellvalue, options, rowdata){ 
	  	if (cellvalue == '0'){ 
	  		result = '<A href="/index.cfm/content/util/flag/communityID/<cfoutput>#community.communityID#</cfoutput>/newstatus/1/contentID/'+rowdata['CONTENTID']+'">No</A>';
	  	} else { 
	  		result = '<A href="/index.cfm/content/util/flag/communityID/<cfoutput>#community.communityID#</cfoutput>/newstatus/0/contentID/'+rowdata['CONTENTID']+'">Yes</A>';
	 	}
	  return result; 	
	}


	 var removeNesting = new Array();
	 var cnt = 0;
	function removeNestedLink(id){
		$('#'+id+' td:first').removeClass('ui-sgcollapsed');
		$('#'+id+' td:first').removeClass('sgcollapsed');
		$('#'+id+' td:first').html('');
	}

	nestingFormat = function(cellvalue, options, rowdata){
		if(rowdata['CHILDCOUNT'] == 0){
			removeNesting[cnt] = rowdata['CONTENTID'];
			cnt = cnt+1;
		}
		return cellvalue;
	}

	function processNesting(){
		for(var i=0; i < removeNesting.length; i++) {
			var value = removeNesting[i];
			removeNestedLink(value);
		}
	}
	
	function updateGrid(ev){
		setTimeout(gridReload,500);
		return false;	
	} 
	
	function gridReload(){ 
		var search = jQuery("#search").val(); 
		var status = jQuery("#status").val(); 
		var type = jQuery("#type").val();
		
		jQuery("#contentAdmin").setGridParam({
				url:"/index.cfm/util/dynamicGrid/index?method=application.content.get&communityID=<cfoutput>#community.communityID#</cfoutput>&search="+search+"&status="+status+"&contenttype="+type,
				page:1
		}).trigger("reloadGrid"); 
	} 

	$('#addContent').live('click', function(){
		location.href='<cfoutput>#community.baseURL#</cfoutput>/content/form/'+$('#addContentType').val()+'/0';
	});
	
	
</script>

<div class="mod">
	<div class="hd">
			<form action="/index.cfm/app/dashboard/content" method="post">
				Manage Content:
				<Cfoutput>
				<select name="communityID" class="small">
					<cfloop query="communityList">
					<option value="#communityList.communityID#" <cfif communityList.communityID eq rc.communityID>selected</cfif>>#site#</option>
					</cfloop>
				</select>
				</Cfoutput>
				<input type="submit" value="Go >>" class="button small">
			</form>
	</div>
	<div class="bd">

		Here, you can manage your content.   You can approve / disapprove content, review inappropriate content flags, as well as delete content.<BR>
		<BR>
		<select name="type" id="addContentType">
		  <option value="">Select</option>
		  <cfoutput query="contentTypes">
	          
	          <option value="#contentType#" >
	          #contentType#
	          </option>
			  </cfoutput>
	      </select>
		<input type="button" value="Add" id="addContent">
			
		<div style="background-color:#c3c3c3" class="pad5 blackText">
		  <table width="100%" class="blackText">
		    <TR height="35">
		      <TD><B>Text Search:</B></TD>
		      <TD><input type="text" name="search" id="search"/>
		 </TD>
		    </TR>
		
		    <TR height="35">
		      <TD valign="top"><B>Type:</B></TD>
		      <TD>
			  <select name="type" id="type">
			  <option value="">All</option>
			  <cfoutput query="contentTypes">
		          
		          <option value="#contentType#" >
		          #contentType#
		          </option>
				  </cfoutput>
		      </select>
		      </TD>
		    </TR>
		    <TR>
		      <TD colspan="2"><input type="submit" value="Search" onclick="return updateGrid();" /></TD>
		    </TR>
		  </table>
		</div>
		<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
								gridName = 'contentAdmin' 
								objectName = 'Content'	 
								rows="10"
								loadComplete='processNesting'
								method = 'application.content.get' 
								arguments = 'parentID=-1' 
								defaultSort = 'contentID asc' 
									
								subgridName = 'contentAdmin'
								subgridMethod = 'application.content.get'
								subgridArguments = ''
								subgridKey = 'PARENTID'
								subgridValue = 'CONTENTID'
							
			
								pid='#request.session.memberID#'
								datasource="community"
								isAdmin='1' 
		> 
	</div>
</div>