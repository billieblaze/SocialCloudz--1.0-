
<cfset community = event.getValue('community')>
<cfparam name="rc.radius" default="">
<cfparam name="rc.location" default="">
<cfparam name="rc.gender" default="">
<cfparam name="rc.age1" default="">
<cfparam name="rc.age2" default="">
<cfparam name="rc.city" default="">
<cfparam name="rc.state" default="">
<cfparam name="rc.country" default="">
<cfparam name="rc.latitude" default="">
<cfparam name="rc.longitude" default="">

<script language="javascript">
	// MEMBER SEARCH
	function updateGrid(ev){
		setTimeout(gridReload,500);
		return false;	
	} 
	
	function gridReload(){ 
		var username = jQuery("#username").val(); 
		var gender = jQuery("#gender").val(); 
		var age1 = jQuery("#age1").val();
		var age2 = jQuery("#age2").val();
		jQuery("#memberAdmin").setGridParam({
			<cfoutput>				
				url:"/index.cfm/util/dynamicGrid/index?method=application.members.gateway.list&communityID=#rc.communityID#&search="+username+"&gender="+gender+"&age1="+age1+"&age2="+age2,
			</cfoutput> 
				page:1
		}).trigger("reloadGrid"); 
	} 
	
	accessFormat = function(cellvalue, options, rowdata){ 
	  var access_result = 'Member';
	  if (cellvalue == '100'){ 
	  	access_result = 'Support';
	  } else if (cellvalue == '20'){ 
		access_result = 'Owner';
	  } else if (cellvalue == '10'){ 
		access_result = 'Editor';
	  } 
	  
 		src = '<a href="javascript: void(0);" class="editUser" rel="'+rowdata['MEMBERID']+'">'+access_result+'</a>';
	  return src;
	}

	approvalFormat = function(cellvalue, options, rowdata){
		  var yn_result = 'no';
		  if (cellvalue == '0'){ 
		  	yn_result = 'No';
		  } else { 
			yn_result = 'Yes';
		 }
  		src = '<a href="javascript: void(0);" class="editUser" rel="'+rowdata['MEMBERID']+'">'+yn_result+'</a>';
		return src;
	}

</script>

<Cfoutput>
This section allows you to manage your members.  
You may change their access level allowing or restricting them to access certain features, 
as well as review "Flagged" users and setup Bans.<BR><BR>
<div align="right">
	<a href="##"id="addUser" class="aNone blackText"><img src="#application.cdn.fam#user_add.png"> Add Member</a> | 
	<a href="/index.cfm/member/util/exportCSV/?communityID=#rc.communityID#" target="_blank" class="aNone blackText"><img src="#application.cdn.fam#page_excel.png"> Export CSV</a>
</div>
<BR /><BR />
    <form action="##" method="POST">
		<table width="100%" style="border:1px solid gray; background-color:silver ">
		<TR>
			<TD>
				Username: <input type="text" name="search" id="username">
		 	</TD>
		 	<TD></TD>
		 </TR>
		 <TR> 
			 <TD>
			  	Gender: <select name="gender" id="gender">
		        <option value="" <cfif rc.gender eq ''>selected</cfif>>Any</option>
		        <option value="1" <cfif rc.gender eq '1'>selected</cfif>>Male</option>
		        <option value="2" <cfif rc.gender eq '2'>selected</cfif>>Female</option>
		        </select>
			 </TD>
			 <TD>          
				Age: <select name="age1" id="age1">
		        <option value="" <cfif rc.age1 eq ''>selected</cfif>>Any</option>
		        <cfloop from="15" to="100" index="i">
		        	<option value="#i#" <cfif rc.age1 eq i>selected</cfif>>#i#</option>
		        </cfloop>
		        </select> to 
		        <select name="age2" id="age2">
	                <option value="" <cfif rc.age2 eq ''>selected</cfif>>Any</option>
	                <cfloop from="15" to="100" index="i">
			        	<option value="#i#" <cfif rc.age2 eq i>selected</cfif>>#i#</option>
			        </cfloop>
		        </select>
	        </tD>
       	</TR>
       	<TR>
	       <TD colspan="2" align="center">
		        <input type="submit" value="Search" onclick="return updateGrid(arguments[0]||event);">
	       </TD>
       	</TR>
		</table>
	</form>
</cfoutput>
<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
		gridName = 'memberAdmin' 
		objectName = 'Member'		
		rows="10"
		method = 'application.members.gateway.list' 
		arguments = ''
		defaultSort = 'm.memberID' 							
		pid='#request.session.memberID#'
		datasource="community"
		isAdmin='1' 
> 

<script>
$('.editUser').modalAjax({
		url: '/index.cfm/member/admin/access/communityID/<cfoutput>#rc.communityID#</cfoutput>/memberID/!rel!',
		title: 'Edit User',
		width: 500, 
		initAjaxForm: true, 
		initValidate: true,
		ajaxFormSuccess: function(){
			jQuery("#memberAdmin").trigger('reloadGrid');
		}, 
		ajaxFormClose: true
	});
	
	$('#addUser').modalAjax({
		title: 'Add a Member',
		url: '/index.cfm/member/create/index/communityID/#rc.communityID#',
		width:500, 
		initAjaxForm: true,
		ajaxFormSuccess: function(){
			jQuery("#memberAdmin").trigger('reloadGrid');
		}, 
		ajaxFormClose: true
	});
</script>