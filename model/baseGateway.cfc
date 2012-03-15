<cfcomponent hint="I am the abstract gateway object.  All other gateways should extend me to inherit my functionality.">
	<cffunction name='init' returnType="any" >
		<cfargument name="Datasource" required="true">
		<cfargument name="dao"  required="true">

		<cfset this.datasource = arguments.datasource>
		<cfset variables.instance = structNew()>
		<Cfset variables.instance.dao = arguments.dao>

		<cfreturn this/>
	</cffunction>
	
	<cffunction name="get" hint="I am the generic select functionality of the abstract gateway.  I allow for very simple syntax to perform database SELECT statements." output="false">
		<cfargument name="table" type="string" required="true" hint="the table to select from">
		<cfargument name="dataStruct" default="#structnew()#" type="struct" required="true" hint="a structure defining what fields to match (where clause).  empty = all records">
		<cfargument name="orderBy" default="" type="string" required="false" hint="Field to sort by, empty = primary key">	
		<cfargument name="limit" default="" required="false" hint="Limit the number of returned rows, empty = all records">
		<cfargument name="offset" default="">
		<Cfset var retVal = ''>	
		<cfif arguments.limit eq ''>
			<cfset retVal = variables.instance.DAO.getRecords(tablename=arguments.table, data=arguments.dataStruct, orderby=arguments.orderBy)>
		<cfelse>
			<cfset retVal = variables.instance.DAO.getRecords(tablename=arguments.table, data=arguments.dataStruct, orderby=arguments.orderBy, maxrows=arguments.limit, offset = arguments.offset)>
		</cfif>
		<cfreturn retVal>
	</cffunction>

	<cffunction name="save" hint="I am the generic save functionality of the abstract gateway.  I allow for very simple syntax to perform database INSERT / UPDATE statements.  If I receive a Primary Key value, I know that I must UPDATE, otherwise, I INSERT" output="false">
		<cfargument name="table" type="string" required="true" hint="the database table to insert/update to">
		<cfargument name="dataStruct" type="struct"  required="true" hint="a structure containing the data to be saved. should be formated with key / value pairs reflecting the database field names">	
		<cfargument name="onExists" default="update">
		<Cfset var retVal = ''>
		<cfif arguments.onExists eq 'update'>
			<cfset retVal = variables.instance.DAO.saveRecord(arguments.table, arguments.datastruct)>
		<cfelse>
			<cfset retVal = variables.instance.DAO.insertRecord(arguments.table, arguments.datastruct, arguments.onExists)>
		</cfif>
		
		<cfreturn retVal>
	</cffunction>
	
	<cffunction name="delete" hint="I am the generic delete functionality of the abstract gateway.  I allow for very simple syntax to perform databse DELETE statements." output="false">
		<cfargument name="table" type="string" required="true" hint="the table to DELETE from">
		<cfargument name="dataStruct" type="struct" default="#structNew()#" required="true" hint="a struct of data containing the primary keys.  all primary keys must be passed in.">
	
		<cfset var i = ''>
	
		<cfif structcount(arguments.datastruct) eq 0>
			<cfthrow message="You must provide a structure of column / values to the delete function">
		<cfelse>
			<cfquery datasource='#this.datasource#'>
				delete from #arguments.table#
				where 1=1
				<cfloop collection='#arguments.dataStruct#' item='i'>
					<cfif i neq 'event'>
					and #i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.datastruct[i]#">
					</cfif>
				</cfloop>
			</cfquery>
		
			<cfreturn 1>
		</cfif>
	</cffunction>
	
	<cffunction name="getTableData">
		<cfargument name="table">
		<cfreturn variables.instance.DAO.getTableData(arguments.table)>
	</cffunction>

	<cfscript>
		/**
		* Makes a row of a query into a structure.
		*
		* @param query      The query to work with.
		* @param row      Row number to check. Defaults to row 1.
		* @return Returns a structure.
		* @author Nathan Dintenfass (nathan@changemedia.com)
		* @version 1, December 11, 2001
		*/
		function queryRowToStruct(query){
		    //by default, do this to the first row of the query
		    var row = 1;
		    //a var for looping
		    var ii = 1;
		    //the cols to loop over
		    var cols = listToArray(query.columnList);
		    //the struct to return
		    var stReturn = structnew();
		    //if there is a second argument, use that for the row number
		    if(arrayLen(arguments) GT 1)
		        row = arguments[2];
		    //loop over the cols and build the struct from the query row    
		    for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
		        stReturn[cols[ii]] = query[cols[ii]][row];
		    }        
		    //return the struct
		    return stReturn;
		}
	</cfscript>
</cfcomponent>