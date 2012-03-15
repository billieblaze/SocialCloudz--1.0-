<cfscript>
ref = Replace(cookie.token,"-","X","ALL");
</cfscript>
<cfmodule template="/dccom/components/twform/serializeAttributes.cfm" method="save" uid="#ref#">
<script>

	formTitleFormatter = function(cellvalue, options, rowdata){
			  rVal = '<a href="javascript:twFormWizard.LaunchFormWizard('+rowdata['INSTANCEID']+',\'dsp_editForm.cfm\',1000,600,true,null,true,\'<cfoutput>#ref#</cfoutput>\');">' + cellvalue + '</a>';
			  return rVal;
		}

		formSubmissionFormatter = function(cellvalue, options, rowdata){
			  rVal = '<a href="javascript:twFormWizard.LaunchFormWizard('+rowdata['INSTANCEID']+',\'dsp_submissions.cfm\',1000,600,true,null,true,\'<cfoutput>#ref#</cfoutput>\');">' + cellvalue + '</a>';
			  return rVal;
		}	
</script>
	<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
		<!--- Setup --->
		gridName = 'formAdmin' 
		objectName = 'form'	 
		rows="10"
		
		method = ' application.forms.getForms' 
		arguments = 'communityID=#rc.community.communityID#' 
		defaultSort = 'title' 							
		
		pid='#request.session.memberID#'
		datasource="community"
		isAdmin='1' > 