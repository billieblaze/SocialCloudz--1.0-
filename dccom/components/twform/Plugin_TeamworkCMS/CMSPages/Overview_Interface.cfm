
<cfquery name="getSubmissionCount" datasource="#ATTRIBUTES.datasource#">
SELECT	COUNT(*) AS submissionCount
FROM	dccom_twform_formsubmissions
WHERE	instanceId = 1
</cfquery>

<cfset overview = structNew()>

<cfset overviewSection = structNew()>
<cfset structInsert(overviewSection,"title","Design Form",true)>
<cfset structInsert(overviewSection,"description","Add/Edit or delete fields on your form",true)>
<cfset structInsert(overviewSection,"cmsPage","dsp_editForm.cfm",true)>
<cfset structInsert(overviewSection,"width","1000",true)>
<cfset structInsert(overviewSection,"height","600",true)>
<cfset structInsert(overviewSection,"scrolling","auto",true)>
<cfset structInsert(overviewSection,"bScrollbars","true",true)>
<cfset structInsert(overview,"edit1",overviewSection,true)>

<cfset overviewSection = structNew()>
<cfset structInsert(overviewSection,"title","Test Your Form",true)>
<cfset structInsert(overviewSection,"description","Test your forms functionality",true)>
<cfset structInsert(overviewSection,"cmsPage","dsp_testform.cfm",true)>
<cfset structInsert(overviewSection,"bScrollbars","true",true)>
<cfset structInsert(overview,"edit2",overviewSection,true)>

<cfset overviewSection = structNew()>
<cfset structInsert(overviewSection,"title","Submissions",true)>
<cfset structInsert(overviewSection,"description","View all form submissions made using this form",true)>
<cfset structInsert(overviewSection,"cmsPage","dsp_submissions.cfm",true)>
<cfset structInsert(overviewSection,"bScrollbars","true",true)>
<cfset structInsert(overview,"edit3",overviewSection,true)>
