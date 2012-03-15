<cfset ATTRIBUTES.instanceId = REQUEST.instanceId>

<!--- START: SAVE ALL ATTRIBUTE DATA FOR RE-LOAD IN IFRAME PAGES --->
<cfset ref = Replace(cookie.token,"-","X","ALL")>
<cfmodule template="serializeAttributes.cfm" method="save" uid="#ref#">
<!--- END: SAVE ALL ATTRIBUTE DATA --->

<cfoutput>
<script>
var twFormWizard = {
	LaunchFormWizard:function( instanceId, cmsfile, w, h, bResize, sHandle, bScrollbars, ref )
	{
		if( w == null ) w = 800;
		if( h == null ) h = 600;
		if( bResize == null ) bResize = false;
		if( bScrollbars == null ) bScrollbars = 0;
		if( sHandle == null ) sHandle = "CMSPg" + cmsfile.replace(/(.cfm)/gi,"") + instanceId;
		
		var sLeft=(screen.width-w)/2, sTop=(screen.height-h)/2;
		var params = "height=" + h + ", width=" + w + ", top=" + sTop + ", left=" + sLeft + ", scrollbars=" + (bScrollbars?"yes":"no")+ ", resizable=" + (bResize?"yes":"no");
		var url = "#JSStringFormat( RelSharedPath )#pageLoader.cfm?instanceId="+instanceId+"&ref="+ref+"&cmsfile="+cmsfile;
		cmsfile = cmsfile.replace(/\./, "_" );
		var z = window.open( url, cmsfile, params );
		z.focus();		
	}
};
</script>
</cfoutput>

<cfquery name="getSubmissionCount" datasource="#ATTRIBUTES.datasource#">
SELECT	COUNT(*) AS submissionCount
FROM	dccom_twform_formsubmissions
WHERE	instanceId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ATTRIBUTES.instanceId#">
</cfquery>

<cfoutput>
<div align="right">
	<a class="aNone" href="javascript:twFormWizard.LaunchFormWizard(#ATTRIBUTES.instanceId#,'dsp_editForm.cfm',1000,600,true,null,true,'#ref#')" style="font-size:10px;"><img src="/dccom/components/#ATTRIBUTES.component#/images/icons/application_form_edit.png" width="16" height="16" alt="" border="0" hspace="5" align="absmiddle">Design Form</a>
	<a class="aNone" href="javascript:twFormWizard.LaunchFormWizard(#ATTRIBUTES.instanceId#,'dsp_submissions.cfm',800,600,true,null,true,'#ref#')" style="font-size:10px;"><img src="/dccom/components/#ATTRIBUTES.component#/images/icons/application_view_list.png" width="16" height="16" alt="" border="0" hspace="5" align="absmiddle">Submissions (#getSubmissionCount.submissionCount#)</a>
</div>
</cfoutput>
