<cfsetting enablecfoutputonly="Yes">
			<cfset ATTRIBUTES.dcCom_RelPath = '/dccom/'>
		<CFIF ThisTag.ExecutionMode IS "Start">
			<cfset RelStylePath = "/dccom/components/#ATTRIBUTES.component#/styles/default/">
			<cfset FileStylePath = "/dccom/components/#ATTRIBUTES.component#/styles/default/">
			<cfset IncludeStylePath = "styles/default/">
			<cfset RelSharedPath = "/dccom/components/#ATTRIBUTES.component#/">
			<cfset FileSharedPath = "/dccom/components/#ATTRIBUTES.component#/">


		</CFIF>
	
		<cfinclude template= "/dccom/components/#ATTRIBUTES.component#/main.cfm">

	<CFIF ThisTag.ExecutionMode IS "End">
		<CFASSOCIATE BASETAG="CF_DCCOM">
		<cfset ATTRIBUTES.generatedContent = ThisTag.generatedContent>
	</cfif>
<cfsetting enablecfoutputonly="No">
