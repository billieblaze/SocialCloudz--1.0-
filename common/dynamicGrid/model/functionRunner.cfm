<cfsetting showdebugoutput="false">
<cfif not isdefined('url.method')>
	<Cfthrow message="method must be specified in the url">
</cfif>
<cfif structCount(form) eq 0>
	<cfset form = url>
</cfif>
<cfset structAppend(form, url, true)>

<cfparam name="form.page" default="1">
<Cfparam name="form.rows" default="20">
<cfparam name="form.sidx" default="">
<cfparam name="form.sord" default="">

<!--- sort field --->	
<cfif form.sidx neq '' and form.sord neq ''>
	<cfset form.sort = '#form.sIdx# #form.sord#'>
</cfif> 

<cfscript>
	structAppend(form, url, true);
	if (  url.method neq ''){
		request.grid.data  = evaluate('#url.method#(argumentcollection = form)');
		form.countonly = 1;
		form.page = '';
		form.rows = '';
		form.limit = '';
		request.grid.count  = evaluate('#url.method#(argumentcollection = form)').count;
	}
</cfscript>

	<Cfdump var='#form#'>
	<Cfdump var='#request.grid.data#'><Cfabort>

<cfinclude template="/common/dynamicGrid/toJSON.cfm">