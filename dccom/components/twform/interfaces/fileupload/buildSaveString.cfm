<cfif Len( FORM[ REQUEST.formField ] ) IS 0>
	<cfexit method="EXITTEMPLATE">
</cfif>
<cfset folder = "#application.filestore#/contentfiles/components/twForm/#FORM.instanceId#">

<cfif NOT DirectoryExists( folder )>
	<cfdirectory action="CREATE" directory="#folder#">
</cfif>
<cfset nameconflict = "makeUnique">

<cfif StructKeyExists( REQUEST.formItems[ id ], "uploadAccept" ) AND len( REQUEST.formItems[ id ]["uploadAccept"] )>
	<cffile action="upload" accept="#REQUEST.formItems[ id ].uploadAccept#" fileField="#REQUEST.formField#" destination="#folder#" nameConflict="#nameconflict#" />
<cfelse>
	<cffile action="upload" fileField="#REQUEST.formField#" destination="#folder#" nameConflict="#nameconflict#" />
</cfif>

<cfset FORM[ REQUEST.formField ] = File.ServerFile>