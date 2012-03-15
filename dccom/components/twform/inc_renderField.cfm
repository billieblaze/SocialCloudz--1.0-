<cffunction name="displayDefaultVal" output="yes">
<cfargument name="defaultVal" type="string">
<cfset var html = defaultVal>
<cfset var temp = "">

<cfif Find( "##", defaultVal )>
	<cfif Left( defaultVal, 1 ) IS "##" AND Right( defaultVal, 1 ) IS "##" AND Len( defaultVal ) GT 1>
		<cfset temp = replace( defaultVal, "##", "", "ALL" )>
		<cfif isdefined( temp )>
			<cfreturn HTMLEditFormat( Evaluate( temp ) )>
		<cfelse>
			<cfreturn "Variable #temp# was not set">
		</cfif>
	</cfif> 
</cfif>

<cfreturn html>
</cffunction> 

<cffunction name="renderField" output="no" returntype="string">
<cfargument name="fieldNo" type="string">
<cfargument name="id" type="string">
<cfargument name="fieldInfo" type="struct">
<cfset var html = "">
<cfset var temp = "">
<cfset var temp2 = "">
<cfset var fieldName = "">
<cfset var vali = "">

<!--- Automatically trim any fields --->
<cfif StructKeyExists( ARGUMENTS.fieldInfo, "defaultVal" )>
	<cfset ARGUMENTS.fieldInfo.defaultVal = Trim( ARGUMENTS.fieldInfo.defaultVal )>
</cfif>

 <!--- START: Determine a good unique name for the field --->
<cfset fieldName = REReplaceNoCase( LCASE( replace( ARGUMENTS.fieldInfo.title, " ", "_", "ALL" ) ), "[^0-9a-z .\']", "", "ALL" )>
<cfset bFieldNameOK = false>
<cfset temp = 1>
<cfset temp2 = fieldName>
<cfloop condition="NOT bFieldNameOK">
	<cfif NOT ListFindNoCase( REQUEST.twFormUsedfieldNames, fieldName )>
		<cfset bFieldNameOK = true>
	<cfelse>
		<cfset fieldName = temp2 & temp>
		<cfset temp = temp + 1>
	</cfif>
	<cfif temp GT 30><cfthrow message="Infinite loop detected"></cfif>
</cfloop>
<cfset REQUEST.twFormUsedfieldNames = ListAppend( REQUEST.twFormUsedfieldNames, ARGUMENTS.id )>
<cfset REQUEST.twFormUsedfieldNames = ListAppend( REQUEST.twFormUsedfieldNames, fieldName )>
 <!--- END: Determine a good unique name for the field --->

<cfif ARGUMENTS.fieldInfo.fieldtype EQ "sectionBreak">
	<cfset html = html & "<div class=""sectionBreak"">" & ARGUMENTS.fieldInfo.title & "</div>">
	<cfif StructKeyExists( ARGUMENTS.fieldInfo, "instructions" ) AND Len( ARGUMENTS.fieldInfo.instructions )>
		<cfset html = html & "<div class=""instructions"">" & replace( replace( ARGUMENTS.fieldInfo.instructions, chr(13), "", "ALL") , chr(10), "<br/>", "ALL" ) & "</div>">
	</cfif>
<cfelse>

	<cfparam name="ARGUMENTS.fieldInfo.isrequired" default="0">
	<cfparam name="ARGUMENTS.fieldInfo.isrequired" default="0">

	<cfif ARGUMENTS.fieldInfo.fieldType NEQ "hiddenField">
	<cfset html = html & "<label>" & ARGUMENTS.fieldInfo.title>
	<cfif ARGUMENTS.fieldInfo.isrequired IS 1>
		<cfset html = html & "<span class=""req"">*</span>">
	</cfif>
	<cfset html = html & "</label>">
	</cfif>
	
	<cfif StructKeyExists( URL, "show" )>
		<cfdump var="#ARGUMENTS.fieldInfo#">
	</cfif>
	
	<cfif StructKeyExists( ARGUMENTS.fieldInfo, "instructions" ) AND Len( ARGUMENTS.fieldInfo.instructions )>
		<cfset html = html & "<div class=""instructions"">" & replace( replace( ARGUMENTS.fieldInfo.instructions, chr(13), "", "ALL"), chr(10), "<br/>", "ALL" ) & "</div>">
	</cfif>
	<cfset html = html & "<div class=""field"">">
	
	<cfinclude template="interfaces/#ARGUMENTS.fieldInfo.fieldType#/render.cfm">
	
	<cfset html = html & "</div>">
</cfif>

<cfinclude template="interfaces/#ARGUMENTS.fieldInfo.fieldType#/validate.cfm">
<cfif Len( vali )>
	<cfif ListLen( REQUEST.conditionalLogicFieldList )>
		<cfset REQUEST.twFormJSValidation = REQUEST.twFormJSValidation & chr(13) & chr(10) & "if( $(""TWFormLI#id#"").style.display!='none' ){">
		<cfset REQUEST.twFormJSValidation = REQUEST.twFormJSValidation & chr(13) & chr(10) & vali>
		<cfset REQUEST.twFormJSValidation = REQUEST.twFormJSValidation & chr(13) & chr(10) & "}">
	<cfelse>
		<cfset REQUEST.twFormJSValidation = REQUEST.twFormJSValidation & chr(13) & chr(10) & vali>
	</cfif>
</cfif>

<cfreturn html>
</cffunction>
