<cfparam name="FORM._fieldNames" type="string">
<cfparam name="FORM.instanceId" type="numeric">

<cfparam name="ATTRIBUTES.datasource" default="community">

<cfif isdefined('form.key') and isdefined('form.key_hidden') and form.key neq form.key_hidden>
		<cfset request.session.message = 'The security key did not match.  Please try again.'>
		<cfscript>
			application.session.savesession(cookie.token, request.session);
		</cfscript>
		<cflocation url="#request.session.lastpage#">
</cfif>

<!--- This list of files to attached to any outgoing email - delimited by | --->
<cfset REQUEST.emailAttachmentList = "">

<!--- Lookup the form info --->
<cfquery name="getFormInfo" datasource="#ATTRIBUTES.datasource#">
SELECT	formTitle, formDesignWDDX
FROM	dccom_twform_forms
WHERE	instanceId = <cfqueryparam value = "#FORM.instanceId#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<!--- Extract the form info from WDDX --->
<cfwddx action="WDDX2CFML" input="#getFormInfo.formDesignWDDX#" output="REQUEST.formData">
<cfset REQUEST.formInfo = REQUEST.formData.formInfo>
<cfset REQUEST.formItems = REQUEST.formData.formItems>

<!--- Custom Processing --->
<cfset REQUEST.twFormIncludeMode = "beforeSaving">
<cfif StructKeyExists( REQUEST.formData.formInfo, "includeOnSubmit" ) AND Len( REQUEST.formData.formInfo.includeOnSubmit )>
	<cfinclude template="../../../../../#REQUEST.formData.formInfo.includeOnSubmit#">
</cfif>

<cfset skipList = "INSTANCEID,THISPAGEURL,FIELDNAMES,_fieldNames">
<cfset emailFormHTML = "<table cellpadding=""4"" cellspacing=""1"">">
<cfset REQUEST.dataToSave = StructNew()>
<cfloop from="1" to="#ListLen( FORM._fieldNames )#" index="i" step="2">

	<cfset id = ListGetAt( FORM._fieldNames, i )>
	<cfset REQUEST.formField = ListGetAt( FORM._fieldNames, i+1 )>
	
	<cfif REQUEST.formItems[ id ].fieldType NEQ "sectionBreak">
		<cfif FileExists( GetDirectoryFromPath( GetCurrentTemplatePath() ) & "../../interfaces/#REQUEST.formItems[ id ].fieldType#/buildSaveString.cfm" )>
			<cfinclude template="../../interfaces/#REQUEST.formItems[ id ].fieldType#/buildSaveString.cfm">
		</cfif>

		<cfparam name="#REQUEST.formField#" default="">
		<cfset REQUEST.dataToSave[ id ] = FORM[ REQUEST.formField ]>
		
		<cfset emailFormHTML = emailFormHTML & "<tr><th>#REQUEST.formItems[ id ].title#</th><td>">
			<cfif Len( FORM[ REQUEST.formField ] ) IS 0>
				<cfset emailFormHTML = emailFormHTML & "<small style=""color:##777;"">[empty]</small>">
			<cfelse>
				<cfset emailFormHTML = emailFormHTML & replace( HTMLEditFormat( FORM[ REQUEST.formField ] ), chr(10), "<br/>", "ALL" )>
			</cfif>
		<cfset emailFormHTML = emailFormHTML & "</td></tr>">

	</cfif>
</cfloop>
<cfset emailFormHTML = emailFormHTML & "</table>">

<!--- Convert this post to WDDX --->
<cfwddx action="CFML2WDDX" input="#REQUEST.dataToSave#" output="REQUEST.FORMAsWddxString">
<cfinclude template="../../install/includes/inc_getDBType.cfm">
<cfinclude template="../../install/custom/inc_getDefaultDateString.cfm">
<cfquery name="saveForm" datasource="#ATTRIBUTES.datasource#">
INSERT INTO dccom_twform_formsubmissions(
	instanceId,
	submissionDate,
	submissionUserIP,
	submissionPostWDDX
)
VALUES(
	<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#FORM.instanceId#">,
	#REQUEST.defaultDateString#,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#request.session.ipaddress#">,
	<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#REQUEST.FORMAsWddxString#">
)
</cfquery>

<cfset submissionRef = "">
<cfif ATTRIBUTES.dbtype EQ "mysql">
	<cfquery name="getSubmissionId" datasource="#ATTRIBUTES.datasource#">
	SELECT last_insert_id() AS submissionId
	</cfquery>
	<cfset submissionRef = "(" & getSubmissionId.submissionId & ")">
<cfelse>
	<cfquery name="getSubmissionId" datasource="#ATTRIBUTES.datasource#">
	SELECT	MAX( submissionId ) AS submissionId
	FROM	dccom_twform_formsubmissions
	WHERE	instanceId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#FORM.instanceId#">
			AND submissionUserIP = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#request.ipaddress#">
	</cfquery>
	<cfset submissionRef = "(" & getSubmissionId.submissionId & ")">
</cfif>

<!--- Send email to notify admin --->
<cfif REQUEST.formInfo.formCopyEmailCheckbox AND Len( REQUEST.formInfo.formCopyEmailTo )>
	<cfset subject = "#request.community.site# - Form Submission #submissionRef#">
	<Cfset mailBody = "The following form submission has been received:<br/><br/>#emailFormHTML#">
	<Cfmail from='#application.smtpuser#'to="#REQUEST.formInfo.formCopyEmailTo#" subject="#subject#"  type="html">
	#mailBody#
	</cfmail>
</cfif>	

<!--- Send email to notify user --->
<cfif REQUEST.formInfo.formReceiptCheckbox AND Len( REQUEST.formInfo.formReceiptEmailTo ) AND StructKeyExists( REQUEST.dataToSave, REQUEST.formInfo.formReceiptEmailTo ) >
	<cfset emailToSendTo = REQUEST.dataToSave[ REQUEST.formInfo.formReceiptEmailTo ]>

	<cfif Len( emailToSendTo )>
		<cfif Len( REQUEST.formInfo.formReceiptEmailMsg ) IS 0>
			<cfset REQUEST.formInfo.formReceiptEmailMsg = "This email confirms that we have received your<br/>form submission. Details of your form submission are listed below.">
		<cfelse>
			<cfset REQUEST.formInfo.formReceiptEmailMsg = replace( HTMLEditFormat( REQUEST.formInfo.formReceiptEmailMsg ), chr(10), "<br/>", "ALL")>
		</cfif>
		<cfset subject = "Form Submission Confirmation">
		<cfif StructKeyExists( APPLICATION, "siteName" )>
			<cfset subject = APPLICATION.siteName & " - " & subject>
		</cfif>
		<cfif application.sendEmail eq 'true' and isvalid('email',emailToSendTo)>
			
	<Cfset mailBody = "	#REQUEST.formInfo.formReceiptEmailMsg#
					<br/><br/>
					#emailFormHTML#">
					<Cfmail from='#application.smtpuser#'to="#emailToSendTo#" subject="#subject#"  type="html">
	#mailBody#
	</cfmail>

		<cfelse>
			<cfdump var='#emailFormHTML#'>
		</cfif>		
	</cfif>
</cfif>

<!--- Custom Processing --->
<cfset REQUEST.twFormIncludeMode = "afterSaving">
<cfif StructKeyExists( REQUEST.formData.formInfo, "includeOnSubmit" ) AND Len( REQUEST.formData.formInfo.includeOnSubmit )>
	<cfinclude template="../../../../../#REQUEST.formData.formInfo.includeOnSubmit#">
</cfif>


<cfif REQUEST.formInfo.confirmationType EQ "Redirect" AND Len( REQUEST.formInfo.redirectURL ) AND REQUEST.formInfo.redirectURL NEQ "http://">
	<cflocation url="#REQUEST.formInfo.redirectURL#" addtoken="No">
<cfelse>
	<cfif NOT StructKeyExists( REQUEST.formInfo, "confirmMsg" ) AND Len( REQUEST.formInfo.confirmMsg ) IS 0>
		<cfset request.session.message = 'Thank you. Your entry has been successfully submitted.'>
	<cfelse>
		<cfset request.session.message = REQUEST.formInfo.confirmMsg>
	</cfif>
<cfscript>
		application.session.savesession(cookie.token, request.session);
</cfscript>
	<!--- Redirect back to the form page --->
	<cfset finishedURL = FORM.thisPageURL>
	

	<!--- <cfoutput>#finishedURL#</cfoutput><cfabort>--->
	<cflocation url="#finishedURL#" addtoken="No">
</cfif>

<cfoutput>FORM SAVED</cfoutput>
<cfabort>