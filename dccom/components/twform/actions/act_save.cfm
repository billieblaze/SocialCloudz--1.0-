<cftry>

	<cfparam name="FORM.instanceId">
	<cfparam name="FORM.wddxPacket">


	<cffunction name="createSafeName" output="false" returntype="string">
	<cfargument name="filename">
	<cfset OKFilename = ARGUMENTS.filename>
	<cfscript>
	OKFilename = reReplace(OKFilename, "[^A-Za-z0-9\-\.]", "_", "ALL");
	OKFilename = reReplace(OKFilename, "_{2,}", "_", "ALL");
	OKFilename = reReplace(OKFilename, "([^_]+)_+$", "\1", "ALL");
	OKFilename = reReplace(OKFilename, "$_([^_]+)$", "\1", "ALL");
	</cfscript>
	<cfreturn OKFilename>
	</cffunction>

	
	<!--- Debugging 
	<cfsavecontent variable="x"><cfdump var="#FORM#"></cfsavecontent>
	<cffile action="write" file="c:\in\temp\FORM.html" output="#x#">
	--->
	
	<cfwddx action="WDDX2CFML" input="#FORM.WDDXPacket#" output="formInfo">
	<cfwddx action="CFML2WDDX" input="#formInfo#" output="formDesignWDDX">
	
<!--->
	<cfsavecontent variable="x"><cfdump var="#formInfo#"></cfsavecontent>
	<cffile action="write" file="c:\in\temp\formInfo.html" output="#x#">
	<cfsavecontent variable="x">#formDesignWDDX#</cfsavecontent>
	<cffile action="write" file="c:\in\temp\formDesignWDDX.html" output="#x#">
	--->

	
	<cfset result = StructNew()>
	<!--- Default Response --->

		<cfset result.success = true>
		<cfset result.msgTitle = "Form Saved">
		<cfset result.message = "Your form has been saved.">

	<!--- Validation - Ensure Required Fields Exists 
	
	

	<!--- Validation - Data Values 	--->	
	<cfloop collection="#formData.formitems#" item="formItem">
		<cfset formitem = formData.formitems[ formitem ]>
		<cfif Left( formitem.title, Len("Untitled") ) EQ "Untitled">
			<cfthrow type="custom" message="<p>Before we save this form for you, please change the title of any fields from 'Untitled'.</p>">
		</cfif>
	</cfloop>
--->
	<!--- Save interface to database --->
	<cfinclude template="../install/includes/inc_getDBType.cfm">
	<cfinclude template="../install/custom/inc_getDefaultDateString.cfm">
		
	<cfquery name="saveForm" datasource="#attributes.datasource#">
	UPDATE dccom_twform_forms
	SET
		formLastUpdatedDate = #REQUEST.defaultDateString#,
		formLastUpdatedByUserId = #request.SESSION.memberId#,
		formDesignWDDX = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#formDesignWDDX#">
	WHERE instanceId = #listFirst(FORM.instanceId)#
	</cfquery>

	<cfinvoke component="JSON" method="encode" data="#result#" returnvariable="resultJSON" />
	<cfheader name="X-JSON" value = "#resultJSON#">
	
	<cfcatch type="custom">
		<cfset result.success = false>
		<cfset result.msgTitle = "Not Saved">
		<cfset result.message = cfcatch.message>
		<cfinvoke component="JSON" method="encode" data="#result#" returnvariable="resultJSON" />
		<cfheader name="X-JSON" value = "#resultJSON#">
	</cfcatch>
	<cfcatch type="Any">
		<cfsavecontent variable="x"><cfdump var="#cfcatch#"></cfsavecontent>
		<cffile action="write" file="#expandPath('/logs')#/formSaveError.html" output="#x#">

		<cfset result.success = false>
		<cfset result.msgTitle = "Not Saved">
		<cfset result.message = cfcatch.message>
		<cfif StructKeyExists( cfcatch, "Rootcause" )>
			<cfset result.message = cfcatch.Rootcause>
		</cfif>
		<cfif isdefined("URL.test")><cfrethrow></cfif>
		<cfinvoke component="JSON" method="encode" data="#result#" returnvariable="resultJSON" />
		<cfheader name="X-JSON" value = "#resultJSON#">
	</cfcatch>

</cftry>