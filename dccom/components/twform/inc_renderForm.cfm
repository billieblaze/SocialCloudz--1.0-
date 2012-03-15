<cfquery name="getFormInfo" datasource="#attributes.datasource#">
SELECT	formTitle, formCreationDate, formCreatedByUserId, formLastUpdatedDate, formLastUpdatedByUserId, formDesignWDDX
FROM	dccom_twform_forms
WHERE	instanceId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#getInstanceId.instanceId#">
</cfquery>
<!--- Extract the form info from WDDX --->
<cfif getFormInfo.formDesignWDDX IS "">
	<cfset REQUEST.formInfo = StructNew()>
	<cfset REQUEST.formInfo.name = "Untitled Form">
	<cfset REQUEST.formInfo.desc = "">
	<cfset REQUEST.formInfo.fieldorder = ArrayNew(1)>
	<cfset REQUEST.formInfo.submitbuttontext = "">
	<cfset REQUEST.formItems = StructNew()>
<cfelse>
	<cftry>
		<cfwddx action="WDDX2CFML" input="#getFormInfo.formDesignWDDX#" output="REQUEST.formData">
		<cfcatch type="Any">
			<cfoutput><div class="formWizFormMessage">Error decoding form from WDDX.</div></cfoutput>
			<cfexit method="EXITTEMPLATE">
		</cfcatch>
	</cftry>
	<cfset REQUEST.formInfo = REQUEST.formData.formInfo>
	<cfset REQUEST.formItems = REQUEST.formData.formItems>
</cfif>

<!--- Check if the form uses conditional logic --->
<cfset REQUEST.conditionalLogicFieldList = "">
<cfloop from="1" to="#ArrayLen( REQUEST.formInfo.fieldorder )#" index="i">
	<cfset id = REQUEST.formInfo.fieldorder[i]>
	<cfif StructKeyExists( REQUEST.formItems[id], "conditionallogic" )
	AND IsStruct( REQUEST.formItems[id].conditionallogic ) AND StructKeyExists( REQUEST.formItems[id].conditionallogic, "checks" ) AND ArrayLen( REQUEST.formItems[id].conditionallogic.checks ) GT 0>
		<cfset REQUEST.conditionalLogicFieldList = ListAppend( REQUEST.conditionalLogicFieldList, i )>
	</cfif>
</cfloop>


<!--- Include the stylesheet --->
<cfinclude template="inc_stylesheet.cfm">


<cfif StructKeyExists( URL, "twformShowMsg#REQUEST.instanceId#" )>
	<cfif NOT StructKeyExists( REQUEST.formInfo, "confirmMsg" ) AND Len( REQUEST.formInfo.confirmMsg ) IS 0>
		<cfset REQUEST.formInfo.confirmMsg = "Thank you. Your entry has been successfully submitted.">
	</cfif>
	<cfoutput><div class="formWizFormMessage">#replace( REQUEST.formInfo.confirmMsg, "#chr(13)##chr(10)#", "<br/>", "ALL" )#</div></cfoutput>
	<cfif isdefined("URL.test") OR StructKeyExists( REQUEST, "twFormTestMode" )>
		<div id="footer"><input type="button" value="&laquo; Back" onclick="history.back(-1);"></div>
	</cfif>
	<cfexit method="EXITTEMPLATE">
</cfif>

<cfinclude template="inc_renderField.cfm">

<cfset REQUEST.twFormUsedfieldNames = "">
<cfset REQUEST.twFormJSValidation = "">
<cfparam name="REQUEST.edit" default="#ATTRIBUTES.edit#">
<cfif getFormInfo.formDesignWDDX IS NOT "">

	<cfoutput><form name="TWForm#REQUEST.instanceId#" id="TWForm#REQUEST.instanceId#" action="about:blank" class="formWizForm" method="post" onsubmit="return TWFormValidate(#REQUEST.instanceId#)" enctype="multipart/form-data"></cfoutput>
	<cfoutput><input type="hidden" name="instanceId" value="#REQUEST.instanceId#"></cfoutput>
	<cfoutput><input type="hidden" name="thisPageURL" value="#ATTRIBUTES.thisPageURL#"></cfoutput>
	
	<cfif REQUEST.formInfo.desc IS NOT ""><cfoutput><div class="desc">#replace( REQUEST.formInfo.desc, "#chr(13)##chr(10)#", "<br/>", "ALL" )#</div></cfoutput></cfif>
	<cfoutput><ul id="formFields"></cfoutput>
	
	<cfset bShowPrivateFields = false>
	
	<!--- Display each field according to the fieldorder array --->
	<cfloop from="1" to="#ArrayLen( REQUEST.formInfo.fieldorder )#" index="i">
		<cfset id = REQUEST.formInfo.fieldorder[i]>
		<cfif NOT StructKeyExists( REQUEST.formItems[id], "isprivate" ) OR REQUEST.formItems[id].isprivate IS 0>
			<cfif REQUEST.formItems[id].fieldType NEQ "hiddenField">
				<cfoutput><li id="TWFormLI#id#"<cfif ListFind( REQUEST.conditionalLogicFieldList, i )> style="display:none;"</cfif>></cfoutput>
			</cfif>
			<cfoutput>#renderField( i, id, REQUEST.formItems[ id ] )#</cfoutput>
			<cfif REQUEST.formItems[id].fieldType NEQ "hiddenField">
				<cfoutput></li></cfoutput>
			</cfif>
		</cfif>
	</cfloop>
	
	<cfoutput></ul></cfoutput>
	<cfif request.session.memberID eq 0>
		<BR><BR>
		<cfset key = application.util.randString(5)>
		<cfimage action="captcha" thickness='2' width='250' height='50' text='#key#' overwrite='true'>
		<input type="hidden" name="key_hidden" value="#key#" />
		Security: <input type="text" class="text" name="key" value="" size="36" />
		<BR>
	</cfif>
	<cfoutput><div class="twFormFooter"></cfoutput>
	<cfoutput><input type="hidden" name="_fieldNames" value="#REQUEST.twFormUsedfieldNames#"></cfoutput>
	<cfif REQUEST.formInfo.submitbuttontext IS NOT ""><cfoutput><input type="submit" class="submitBut" value="#REQUEST.formInfo.submitbuttontext#"></cfoutput><cfelse><input type="submit" class="submitBut" value="Submit"></cfif>
	<cfif isdefined("URL.twFormTest") OR StructKeyExists( REQUEST, "twFormTestMode" )>
		<cfoutput><input type="button" value="Test Form" onclick="alert( TWForm#REQUEST.instanceId#Validate() )"></cfoutput>
		<cfoutput><input type="button" value="Reload Form" onclick="document.location = document.location"></cfoutput>
	</cfif>
	<cfoutput></div></cfoutput>
	<cfoutput></form></cfoutput>
	
	<cfif ListLen( REQUEST.conditionalLogicFieldList )>
		<cfoutput><script language="JavaScript1.2" src="#RelSharedPath#js/prototype.js"></script></cfoutput>
		<cfoutput><script language="JavaScript1.2" src="#RelSharedPath#js/twformLogic.js"></script></cfoutput>
	</cfif>
	<cfoutput><script language="JavaScript1.2">
	function TWForm#REQUEST.instanceId#Validate()
	{
	
		var errMsg = "";
		var f = document.TWForm#REQUEST.instanceId#;
		#REQUEST.twFormJSValidation#
		if( errMsg != "" )
		{
			alert( "Sorry there are some problems:\n" + errMsg );
			return false;
		}
		f.action = "/dccom/components/#ATTRIBUTES.component#/actions/postForm/index.cfm";
		return true;
	}
	</cfoutput>
	<cfif ListLen( REQUEST.conditionalLogicFieldList )>
		<cfoutput>if( window.twformList == null ) window.twformList = [#REQUEST.instanceId#];else window.twformList.push(#REQUEST.instanceId#);</cfoutput>
		<cfoutput>#chr(13)##chr(10)#var twFormChecks#REQUEST.instanceId# = [];</cfoutput>
		<cfloop list="#REQUEST.conditionalLogicFieldList#" index="i">
			<cfset id = REQUEST.formInfo.fieldorder[i]>
			<cfset checks = REQUEST.formItems[id].conditionallogic.checks>
			<cfoutput>twFormChecks#REQUEST.instanceId#.push({</cfoutput>
				<cfoutput>target:'#id#'</cfoutput>
				<cfoutput>,action:'#REQUEST.formItems[id].conditionallogic.action#'</cfoutput>
				<cfoutput>,bool:'#REQUEST.formItems[id].conditionallogic.bool#'</cfoutput>
				<cfoutput>,checks: [</cfoutput>
					<cfloop from="1" to="#ArrayLen( checks )#" index="checkNo">
						<cfif checkNo GT 1><cfoutput>,</cfoutput></cfif>
						<cfoutput>{field: '#checks[checkNo].field#', fieldtype:'#REQUEST.formItems[ checks[checkNo].field ].fieldtype#', condition: '#checks[checkNo].condition#', option: '#checks[checkNo].option#'}</cfoutput>
					</cfloop>
				<cfoutput>]</cfoutput>
			<cfoutput>});</cfoutput>
		</cfloop>
	</cfif>
	<cfoutput></script></cfoutput>
</cfif>

<cfif (REQUEST.edit) >
	<form class="formWizForm" style="margin:10px;padding:10px;font:12px sans-serif;">
		<cfif getFormInfo.formDesignWDDX IS "" AND NOT REQUEST.edit>
			<cfoutput><div style="padding:5px 0 0 0;">The form hasn't been designed yet.<!--- To design this form, set edit="yes".---></div></cfoutput>
		</cfif>
		<cfinclude template="inc_launchFormWiz.cfm">
	</form>
</cfif>