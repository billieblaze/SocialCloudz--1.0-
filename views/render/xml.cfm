<cfsetting showdebugoutput="false">
<cfset event.showdebugpanel(false)>
<!--- Setup --->
<cfparam name="rc.page" default="1">
<Cfparam name="rc.rows" default="20">

<!--- Slice the page out of the data array --->
<cfset startRow = rc.page * rc.rows - rc.rows + 1>
<Cfset endRow = startRow+rc.rows>
<Cfset pageResults = application.utils.arraySlice(rc.gridData, startRow ,endRow)>
		
<!--- query metadata --->
<cfset total = ceiling(arrayLen(rc.gridData) / rc.rows)>
<cfif structKeyExists(rc, 'gridFooter')>
	<cfset rc.str = {total=total, page=rc.page, records=arrayLen(rc.gridData), rows=pageResults, userdata = rc.gridFooter}>
<Cfelse>
	<cfset rc.str = {total=total, page=rc.page, records=arrayLen(rc.gridData), rows=pageResults}>
</cfif>
<!--- Serialize --->		
<Cfset rc.str = serializejson(rc.str)>

<!--- Cleanup serialization caps problem --->
<cfset rc.str = replace(rc.str, 'USERDATA', 'userdata')>
<cfset rc.str = replace(rc.str, 'EXECUTION_DATE', 'execution_date')>
<cfset rc.str = replace(rc.str, 'AMOUNT', 'amount')>
<cfset rc.str = replace(rc.str, 'RECORDS', 'records')>
<cfset rc.str = replace(rc.str, 'TOTAL', 'total')>
<cfset rc.str = replacenocase(rc.str, 'ROWS', 'rows')>
<cfset rc.str = replacenocase(rc.str, 'PAGE', 'page')>

<!--- Send IT! --->
<cfset writeoutput(rc.str)>