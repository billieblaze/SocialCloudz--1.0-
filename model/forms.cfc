<cfcomponent>
	<cffunction name="init" returnType ='forms'>
		<cfargument name="datasource">
		<cfset variables.datasource = arguments.datasource>
		<cfreturn this>
	</cffunction>

	<cffunction name="getForms">
		<cfargument name="communityID" default='#request.community.communityID#'>
		<cfset var q_GetForms = ''>
		<cfquery name="q_getForms" datasource="#variables.datasource#">
			select *, '' as moduleID, '' as ModuleData, '' as modulePages, 0 as submissions
			from dcCom_Instances d
			inner join dccom_twform_forms f on f.instanceID = d.instanceID
			where instance like 'customform_#arguments.communityID#_%'
		</cfquery>
		<cfoutput query="q_getForms">
			<cfset q_getForms.moduleID[currentRow] = #listlast(q_getForms.instance[currentRow], '_')#>
			<cfset q_getForms.moduleData[currentRow] = #application.cms.modules.getExisting(q_getForms.moduleID[currentRow])#>
			<cfset q_getForms.modulePages[currentRow] = #application.cms.modules.getContext(q_getForms.moduleID[currentRow])#>
			<cfset q_getForms.submissions[currentRow] = #application.forms.submissionCount(q_getForms.instanceID[currentRow])#>
			<cfif q_getForms.moduleData[currentRow].title eq ''>
				<cfset q_getForms.formtitle[currentRow]='Untitled'>
			<cfelse>
				<cfset q_getForms.formtitle[currentRow]=q_getForms.moduleData[currentRow].title>
			</cfif>
			
		</cfoutput>
		<cfreturn q_getForms>
	</cffunction>
	
	<cffunction name="submissionCount">
		<cfargument name="instanceID">
		<cfset var q_getCount = ''>
		<cfquery name="q_getCount" datasource="#variables.datasource#">
			select count(submissionid) as count 
			from dccom_twform_formsubmissions
			where instanceID = #arguments.instanceID#
		</cfquery>
		<cfreturn q_getCount.count>
	</cffunction>
	
</cfcomponent>