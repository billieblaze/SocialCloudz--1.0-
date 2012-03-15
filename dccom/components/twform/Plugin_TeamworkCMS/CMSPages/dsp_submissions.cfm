	<cfif request.session.memberID IS 0>
		<cfoutput><pre>Session Timeout, please log in again</pre></cfoutput>
		<cfabort>
	</cfif>

<cfparam name="URL.instanceId" type="numeric">

<cfquery name="getFormInfo" datasource="#attributes.datasource#">
SELECT	formTitle, formCreationDate, formCreatedByUserId, formLastUpdatedDate, formLastUpdatedByUserId, formDesignWDDX
FROM	dccom_twform_forms
WHERE	instanceId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.instanceId#">
</cfquery>
<cfif getFormInfo.recordCount IS 0>
	<cfoutput>Form has been deleted.</cfoutput><cfabort>
</cfif>

<cfwddx action="WDDX2CFML" input="#getFormInfo.formDesignWDDX#" output="REQUEST.formData">
<cfset REQUEST.formInfo = REQUEST.formData.formInfo>
<cfset REQUEST.formItems = REQUEST.formData.formItems>
<cfset twformwizardFolder = "twform">

<cfloop from="1" to="#ArrayLen( REQUEST.formInfo.fieldorder )#" index="i">
	<cfset id = REQUEST.formInfo.fieldorder[i]>
	<cfinclude template="../../interfaces/#REQUEST.formItems[ id ].fieldType#/info.cfm">
	<cfset REQUEST.formItems[ id ].info = Interface>
</cfloop>

<cfif StructKeyExists( URL, "action" )>
	<cfswitch expression="#URL.action#">
		<cfcase value="deletesubmission">
			<cfquery name="getSubmissionInfo" datasource="#attributes.datasource#">
			DELETE FROM	dccom_twform_formsubmissions
			WHERE	submissionId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.submissionId#">
			AND		instanceId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.instanceId#">
			</cfquery>
			<cfabort>
		</cfcase>
	</cfswitch>
</cfif>

<!--- Return the full view of a subscription through ajax --->
<cfif StructKeyExists( URL, "view" )>
	<cfswitch expression="#URL.view#">
		<cfcase value="submission">
			<cfparam name="URL.submissionId" type="numeric">
			<cfquery name="getSubmissionInfo" datasource="#attributes.datasource#">
			SELECT	submissionId, submissionDate,
					submissionUserIP,
					submissionPostWDDX
			FROM	dccom_twform_formsubmissions
			WHERE	submissionId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.submissionId#">
			AND		instanceId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.instanceId#">
			</cfquery>
			<cfif getSubmissionInfo.recordCount IS 0>
				<cfoutput>Submission not found.</cfoutput>
				<cfabort>
			</cfif>
			<cfwddx action="WDDX2CFML" input="#getSubmissionInfo.submissionPostWDDX#" output="REQUEST.submissionData">
			<cfoutput><h3>Submitted on #DateFormat( getSubmissionInfo.submissionDate, "dd mmmm yyyy" )# at #TimeFormat( getSubmissionInfo.submissionDate, "HH:MMTT" )# from #getSubmissionInfo.submissionUserIP#</h3></cfoutput>
	
			<cfoutput><table cellpadding="0" cellspacing="1" border="0"></cfoutput>
			<cfloop from="1" to="#ArrayLen( REQUEST.formInfo.fieldorder )#" index="i">
				<cfset id = REQUEST.formInfo.fieldorder[i]>
				<cfif REQUEST.formItems[ id ].fieldType EQ "sectionBreak">
					<cfoutput><tr><td colspan="2"><h3>#REQUEST.formItems[ id ].title#</h3></td></tr></cfoutput>
				<cfelse>
					<cfif NOT StructKeyExists( REQUEST.submissionData, id )>
						<cfoutput><tr><th width="200">#REQUEST.formItems[ id ].title#</th><td><span class="na">n/a</span></td></tr></cfoutput>
					<cfelse>
						<cfif NOT StructKeyExists( REQUEST.formItems[ id ].info, "CustomSubmissionView" ) OR NOT REQUEST.formItems[ id ].info.CustomSubmissionView>
							<cfoutput><tr><th width="200">#REQUEST.formItems[ id ].title#</th><td>#replace( HTMLEditFormat( REQUEST.submissionData[ id ] ), "#chr(10)#", "<br>", "ALL" )#</td></tr></cfoutput>
						<cfelse>
							<cfinclude template="../../interfaces/#REQUEST.formItems[ id ].fieldtype#/custom_SubmissionView.cfm">
						</cfif>
					</cfif>
				</cfif>
			</cfloop>
			<cfoutput></table></cfoutput>
			<cfoutput><div style="margin:10px 0 0 0;"></cfoutput>
			<cfoutput><input type="button" value="&laquo; Return to List" onClick="returnToList();"></cfoutput>
			<cfoutput><input type="button" value="Delete" onClick="delSubmission(#URL.submissionId#)"></cfoutput>
			<cfoutput></div></cfoutput>
			<cfabort>
		</cfcase>
	</cfswitch>
</cfif>

<!--- This is important - it ensures the user is logged in --->
<cfsetting enablecfoutputonly="No">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html><head><title>Form Submissions</title>
<cfif NOT StructKeyExists( URL, "ref" )><base href="<cfoutput>#APPLICATION.siteURL#</cfoutput>dcCom/components/<cfoutput>#twformwizardFolder#</cfoutput>/"></cfif>
<link rel="STYLESHEET" type="text/css" href="/dccom/components/twform/Plugin_TeamworkCMS/CMSPages/submissions.css">
<script src="js/prototype.js" type="text/javascript"></script>
<script src="js/submissions.js" type="text/javascript"></script>
<script>
var baseHref = "<cfif NOT StructKeyExists( URL, "ref" )><cfoutput>#JSStringFormat( APPLICATION.siteURL )#</cfoutput>dcCom/components/<cfoutput>#JSStringFormat( twformwizardFolder )#</cfoutput>/</cfif>";
var instanceId = <cfoutput>#URL.instanceId#</cfoutput>;
</script>
</head><body id="mainBody">
<cfsetting enablecfoutputonly="Yes">

<cfoutput><h1>Form Submissions</h1></cfoutput>

<cfquery name="getSubmissions" datasource="#attributes.datasource#">
SELECT	submissionId, submissionDate,
		submissionUserIP,
		submissionPostWDDX
FROM	dccom_twform_formsubmissions
WHERE	instanceId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.instanceId#">
ORDER BY	submissionId DESC
</cfquery>

<cfif getSubmissions.recordCount IS 0>
	<cfoutput>No submissions yet</cfoutput>
<cfelse>
	<cfoutput><table cellpadding="0" cellspacing="0" border="0" id="listTable"></cfoutput>
	<cfoutput><tr><th>Id</th></cfoutput>
		<cfloop from="1" to="#ArrayLen( REQUEST.formInfo.fieldorder )#" index="i">
			<cfset id = REQUEST.formInfo.fieldorder[i]>
			<cfif REQUEST.formItems[ id ].info.ShortList>
				<cfoutput><th title="#HTMLEditFormat( REQUEST.formItems[ id ].title )#"><span>#HTMLEditFormat( REQUEST.formItems[ id ].title )#</span></th></cfoutput>
			</cfif>
		</cfloop>
		<cfoutput><th><span>Date Submitted</span></th></cfoutput>
		<!--- <th>User IP Address</th>--->
	<cfoutput></tr></cfoutput>
	<cfloop query="getSubmissions">
	<cfwddx action="WDDX2CFML" input="#submissionPostWDDX#" output="REQUEST.submissionData">
	<cfoutput><tr id="s#submissionId#" onclick="viewFull(#submissionId#)" onmouseover="g(#submissionId#,1)" onmouseout="g(#submissionId#,0)"></cfoutput>
		<cfoutput><td>#submissionId#</td></cfoutput>
		<cfloop from="1" to="#ArrayLen( REQUEST.formInfo.fieldorder )#" index="i">
			<cfset id = REQUEST.formInfo.fieldorder[i]>
			<cfif REQUEST.formItems[ id ].info.ShortList>
				<cfif NOT StructKeyExists( REQUEST.submissionData, id )>
					<cfoutput><td><span class="na">n/a</span></td></cfoutput>
				<cfelse>
					<cfoutput><td><span>#HTMLEditFormat( REQUEST.submissionData[ id ] )#</span></td></cfoutput>
				</cfif>
			</cfif>
		</cfloop>
		<cfoutput><td><span>#DateFormat( submissionDate, "dd mmmm yyyy" )# at #TimeFormat( submissionDate, "HH:MMTT" )#</span></td></cfoutput>
		<!--- <td>#submissionUserIP#</td> --->
	<cfoutput></tr></cfoutput>
	</cfloop>
	<cfoutput></table></cfoutput>
	<cfoutput><div id="detailView"></div></cfoutput>
</cfif>

<cfoutput></body></html></cfoutput>
<cfsetting enablecfoutputonly="No">
