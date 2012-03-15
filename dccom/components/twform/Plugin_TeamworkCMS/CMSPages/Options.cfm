
<cfquery name="getSubmissionCount" datasource="#ATTRIBUTES.datasource#">
SELECT	COUNT(*) AS submissionCount
FROM	dccom_twform_formsubmissions
WHERE	instanceId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ATTRIBUTES.instanceId#">
</cfquery>

<cfoutput>

		<table cellpadding="5" cellspacing="1" border="0">
		<tr><td><a href="javascript:TWPagePlugin.openCMSPopup(#ATTRIBUTES.instanceId#,'dsp_editForm.cfm',1000,600,true,null,true)"><img src="/dccom/components/#ATTRIBUTES.component#/images/icons/application_form_edit.png" width="16" height="16" alt="" border="0" hspace="5" align="absmiddle">Design Form</a></td></tr>
		<tr><td><a href="javascript:TWPagePlugin.openCMSPopup(#ATTRIBUTES.instanceId#,'dsp_testform.cfm',800,600,true,null,true)"><img src="/dccom/components/#ATTRIBUTES.component#/images/icons/star.gif" width="16" height="16" alt="" border="0" hspace="5" align="absmiddle">Test Your Form</a></td></tr>
		<tr><td><a href="javascript:TWPagePlugin.openCMSPopup(#ATTRIBUTES.instanceId#,'dsp_submissions.cfm',800,600,true,null,true)"><img src="/dccom/components/#ATTRIBUTES.component#/images/icons/application_view_list.png" width="16" height="16" alt="" border="0" hspace="5" align="absmiddle">Submissions (#getSubmissionCount.submissionCount#)</a></td></tr>
		</table>
</cfoutput>