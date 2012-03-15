<cfif not isdefined('request.grid.data') or NOT isQuery(request.grid.data)>
	<cfthrow message="request.grid.data must contain a query object">
</cfif>

<cfparam name="request.grid.count" default="#request.grid.data.recordcount#">

<cfparam name="form.page" default="1">
<cfset request.grid.page = form.page>

<CFPARAM name="request.grid.page" default="1">
<CFPARAM name="request.grid.rows" default="10">
<cfscript>
	if (isdefined('form.rows')) {request.grid.rows = form.rows;}
	//  protect from divide by zero
	if (request.grid.rows eq 0){ request.grid.rows = 1; }
	
	//  protect from divide by zeroSlice the page out of the data array
	startRow = request.grid.page * request.grid.rows - request.grid.rows + 1;
	endRow = startRow+request.grid.rows;
	pageResults = application.utils.querySlice(request.grid.data, startRow ,endRow);
	pageResults = application.utils.queryToArrayOfStructures(pageResults);

	// query metadata 
	total = ceiling(request.grid.count / request.grid.rows);

	if ( structKeyExists(request.grid, 'footer') ){
		dataset = {total=total, page=request.grid.page, records=request.grid.count, rows=pageResults, userdata = request.grid.footer};
	} else { 
		dataset = {total=total, page=request.grid.page, records=request.grid.count, rows=pageResults};
	}
	
	dataset = serializejson(dataset);

	writeoutput(dataset);
</cfscript>

