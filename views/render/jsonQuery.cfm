<cfsetting showdebugoutput="false"> 
<cfset event.showdebugpanel(false)>
<cfparam name="rc.grid.count" default="#rc.grid.count#">
<cfparam name="rc.page" default="1">
<cfparam name="rc.userdata" default="">
<Cfparam name="rc.rows" default="20">
<cfscript>
	//  protect from divide by zero
	if (rc.rows eq 0){ rc.rows = 1; }
	
	//  protect from divide by zeroSlice the page out of the data array
	startRow = rc.page * rc.rows - rc.rows + 1;
	endRow = startRow+rc.rows;
	pageResults = rc.grid.Data;
	pageResults = application.util.queryToArrayOfStructures(pageResults);  

	// query metadata 
	if (rc.grid.count eq 0 or rc.grid.count eq ''){
		total = 0;
	} else { 
		total = ceiling(rc.grid.count / rc.rows);
	}
	if (structKeyExists(rc, 'gridFooter')){
		rc.str = {total=total, page=rc.page, records=rc.grid.count, rows=pageResults, userdata = rc.gridFooter};
	} else { 
		rc.str = {total=total, page=rc.page, records=rc.grid.count, rows=pageResults,userdata=rc.userdata};
	}

	// Serialize 
	rc.str = serializejson(rc.str);

	// Cleanup serialization caps problem 
	rc.str = replace(rc.str, 'USERDATA', 'userdata');
	rc.str = replace(rc.str, 'EXECUTION_DATE', 'execution_date');
	rc.str = replace(rc.str, 'AMOUNT', 'amount');
	rc.str = replace(rc.str, '"RECORDS"', '"records"');
	rc.str = replace(rc.str, '"TOTAL"', '"total"');
	rc.str = replace(rc.str, '"ROWS"', '"rows"');
	rc.str = replace(rc.str, '"PAGE"', '"page"');
	rc.str = replace(rc.str, '"{', '{', 'all');
	rc.str = replace(rc.str, '}"', '}', 'all');
	// Send IT! 
	writeoutput(rc.str);
</cfscript>