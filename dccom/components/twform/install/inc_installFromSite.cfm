	<cfset REQUEST.bFlagIsNewInstance = 0>
	<cfquery name="getInstanceId" datasource="#ATTRIBUTES.datasource#">
	SELECT instanceId
	FROM dcCom_Instances
	WHERE dcComComponent = '#ATTRIBUTES.component#'
	AND instance = '#ATTRIBUTES.instanceName#'
	</cfquery>

<cfif getInstanceId.recordCount IS 0>
	<cfset REQUEST.bFlagIsNewInstance = 1>

	<cfquery name="insertInstance" datasource="#ATTRIBUTES.datasource#">
	INSERT INTO dcCom_Instances( dcComComponent, instance )
	VALUES( '#ATTRIBUTES.component#', '#ATTRIBUTES.instanceName#' )
	</cfquery>

	<cfquery name="getInstanceId" datasource="#ATTRIBUTES.datasource#">
	SELECT instanceId
	FROM dcCom_Instances
	WHERE dcComComponent = '#ATTRIBUTES.component#'
	AND instance = '#ATTRIBUTES.instanceName#'
	</cfquery>
</cfif>

<cfset REQUEST.instanceId = getInstanceId.instanceId>