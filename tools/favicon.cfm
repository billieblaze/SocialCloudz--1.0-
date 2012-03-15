<!--- TODO: fix this --->
<Cftry>
	<cffile action="readBinary" file="/mnt/content/community/#request.community.communityID#/favicon.ico" variable="theFile"/>
	<cfif isBinary(theFile)>
		<cfset fomattedName = "favicon.ico"/>
		<cfheader name="Content-Disposition" value="inline; filename=#fomattedName#">
		<cfscript>
			context = getPageContext();
		   	response = context.getResponse();
		   	out = response.getOutputStream();
		   	response.reset();
		   	response.setContentType("image/x-icon");
		   	response.setContentLength(arrayLen(theFile));
		   	out.write(theFile);
		   	out.close();
	 	</cfscript>
	</cfif>
	
	<cfcatch>
		<cfheader statuscode="404"> Page Not Found
	</cfcatch>
</cftry>