<!---
Serialize and deserialize JSON data into native ColdFusion objects
http://www.epiphantastic.com/cfjson/

Authors: Jehiah Czebotar (jehiah@gmail.com)
         Thomas Messier  (thomas@epiphantastic.com)

Version: 1.7 March 1st, 2007
--->

<cfcomponent displayname="JSON" output="No">
	<cffunction name="decode" hint="Converts data frm JSON to CF format" access="remote" returntype="any" output="no">
		<cfargument name="data" type="string" required="Yes" />
		
		<!--- DECLARE VARIABLES --->
		<cfset var ar = ArrayNew(1) />
		<cfset var st = StructNew() />
		<cfset var dataType = "" />
		<cfset var inQuotes = false />
		<cfset var startPos = 1 />
		<cfset var nestingLevel = 0 />
		<cfset var dataSize = 0 />
		<cfset var i = 1 />
		<cfset var skipIncrement = false />
		<cfset var j = 0 />
		<cfset var char = "" />
		<cfset var dataStr = "" />
		<cfset var structVal = "" />
		<cfset var structKey = "" />
		<cfset var colonPos = "" />
		<cfset var qRows = 0 />
		<cfset var qCol = "" />
		<cfset var qData = "" />
		<cfset var unescapeVals = "\"",\',\\,\b,\t,\n,\f,\r" />
		<cfset var unescapeToVals = """,',\,#Chr(8)#,#Chr(9)#,#Chr(10)#,#Chr(12)#,#Chr(13)#" />
		
		<cfset var _data = Trim(arguments.data) />

		<!--- NULL --->
		<cfif NOT IsNumeric(_data) AND _data EQ "null">
			<cfreturn "" />
		
		<!--- BOOLEAN TRUE --->
		<cfelseif NOT IsNumeric(_data) AND _data EQ "true">
			<cfreturn true />
		
		<!--- BOOLEAN FALSE --->
		<cfelseif NOT IsNumeric(_data) AND _data EQ "false">
			<cfreturn false />
		
		<!--- NUMBER --->
		<cfelseif IsNumeric(_data)>
			<cfreturn _data />
		
		<!--- EMPTY STRING --->
		<cfelseif _data EQ "''" OR _data EQ '""'>
			<cfreturn "" />
		
		<!--- STRING --->
		<cfelseif ReFind('^".+"$', _data) EQ 1 OR ReFind("^'.+'$", _data) EQ 1>
			<cfreturn ReplaceList( mid(_data, 2, Len(_data)-2), unescapeVals, unescapeToVals) />
		
		<!--- ARRAY, STRUCT, OR QUERY --->
		<cfelseif ReFind("^\[.*\]$", _data) EQ 1
			OR ReFind("^\{.*\}$", _data) EQ 1
			OR ReFindNoCase('^\{"recordcount":[0-9]+,"columnlist":"[^"]+","data":\{("[^"]+":\[[^]]*\],?)+\}\}$', _data, 0) EQ 1>
			
			<!--- Store the data type we're dealing with --->
			<cfif ReFind("^\[.*\]$", _data) EQ 1>
				<cfset dataType = "array" />
			<cfelseif ReFindNoCase('^\{"recordcount":[0-9]+,"columnlist":"[^"]+","data":\{("[^"]+":\[[^]]*\],?)+\}\}$', _data, 0) EQ 1>
				<cfset dataType = "query" />
			<cfelse>
				<cfset dataType = "struct" />
			</cfif>
			
			<!--- Remove the brackets --->
			<cfset _data = Trim( Mid(_data, 2, Len(_data)-2) ) />
			
			<!--- Deal with empty array/struct --->
			<cfif Len(_data) EQ 0>
				<cfif dataType EQ "array">
					<cfreturn ar />
				<cfelse>
					<cfreturn st />
				</cfif>
			</cfif>
			
			<!--- Loop through the string characters --->
			<cfset dataSize = Len(_data) + 1 />
			<cfloop condition="#i# LTE #dataSize#">
				<cfset skipIncrement = false />
				<!--- Save current character --->
				<cfset char = Mid(_data, i, 1) />
				
				<!--- If char is a quote, switch the quote status --->
				<cfif char EQ '"'>
					<cfset inQuotes = NOT inQuotes />
				<!--- If char is escape character, skip the next character --->
				<cfelseif char EQ "\" AND inQuotes>
					<cfset i = i + 2 />
					<cfset skipIncrement = true />
				<!--- If char is a comma and is not in quotes, or if end of string, deal with data --->
				<cfelseif (char EQ "," AND NOT inQuotes AND nestingLevel EQ 0) OR i EQ Len(_data)+1>
					<cfset dataStr = Mid(_data, startPos, i-startPos) />
					
					<!--- If data type is array, append data to the array --->
					<cfif dataType EQ "array">
						<cfset arrayappend( ar, decode(dataStr) ) />
					<!--- If data type is struct or query... --->
					<cfelseif dataType EQ "struct" OR dataType EQ "query">
						<cfset dataStr = Mid(_data, startPos, i-startPos) />
						<cfset colonPos = Find(":", dataStr) />
						<cfset structKey = Trim( Mid(dataStr, 1, colonPos-1) ) />
						
						<!--- If needed, remove quotes from keys --->
						<cfif Left(structKey, 1) EQ "'" OR Left(structKey, 1) EQ '"'>
							<cfset structKey = Mid( structKey, 2, Len(structKey)-2 ) />
						</cfif>
						
						<cfset structVal = Mid( dataStr, colonPos+1, Len(dataStr)-colonPos ) />
						
						<!--- If struct, add to the structure --->
						<cfif dataType EQ "struct">
							<cfset StructInsert( st, structKey, decode(structVal) ) />
						
						<!--- If query, build the query --->
						<cfelse>
							<cfif structKey EQ "recordcount">
								<cfset qRows = decode(structVal) />
							<cfelseif structKey EQ "columnlist">
								<cfset st = QueryNew( decode(structVal) ) />
								<cfif qRows>
									<cfset QueryAddRow(st, qRows) />
								</cfif>
							<cfelseif structKey EQ "data">
								<cfset qData = decode(structVal) />
								<cfset ar = StructKeyArray(qData) />
								<cfloop from="1" to="#ArrayLen(ar)#" index="j">
									<cfloop from="1" to="#st.recordcount#" index="qRows">
										<cfset qCol = ar[j] />
										<cfset QuerySetCell(st, qCol, qData[qCol][qRows], qRows) />
									</cfloop>
								</cfloop>
							</cfif>
						</cfif>
					</cfif>
					
					<cfset startPos = i + 1 />
				<!--- If starting a new array or struct, add to nesting level --->
				<cfelseif "{[" CONTAINS char AND NOT inQuotes>
					<cfset nestingLevel = nestingLevel + 1 />
				<!--- If ending an array or struct, subtract from nesting level --->
				<cfelseif "]}" CONTAINS char AND NOT inQuotes>
					<cfset nestingLevel = nestingLevel - 1 />
				</cfif>
				
				<cfif NOT skipIncrement>
					<cfset i = i + 1 />
				</cfif>
			</cfloop>
			
			<!--- Return appropriate value based on data type --->
			<cfif dataType EQ "array">
				<cfreturn ar />
			<cfelse>
				<cfreturn st />
			</cfif>
		
		<!--- INVALID JSON --->
		<cfelse>
			<cfreturn "Invalid argument: either your JSON is wrong or there's a bug in the JSON function" />
		</cfif>
	</cffunction>
	
	
	<!--- CONVERTS DATA FROM CF TO JSON FORMAT --->
	<cffunction name="encode" hint="Converts data from CF to JSON format" access="remote" returntype="string" output="No">
		<cfargument name="data" type="any" required="Yes" />
		<!---
			The following argument allows for formatting queries in query or struct format
			If set to query, query will be a structure of colums filled with arrays of data
			If set to array, query will be an array of records filled with a structure of columns
		--->
		<cfargument name="queryFormat" type="string" required="No" default="query" />
		<cfargument name="queryKeyCase" type="string" required="No" default="lower" />
		
		<!--- VARIABLE DECLARATION --->
		<cfset var jsonString = "" />
		<cfset var tempVal = "" />
		<cfset var arKeys = "" />
		<cfset var colPos = 1 />
		<cfset var i = 1 />
		
		<cfset var _data = arguments.data />

		<!--- BOOLEAN --->
		<cfif IsBoolean(_data) AND NOT IsNumeric(_data) AND NOT ListFindNoCase("Yes,No", _data)>
			<cfreturn ToString(_data) />
			
		<!--- NUMBER --->
		<cfelseif IsNumeric(_data) AND NOT REFind("^0+[^\.]",_data)>
			<cfreturn ToString(_data) />
		
		<!--- STRING --->
		<cfelseif IsSimpleValue(_data)>
			<cfreturn '"' & JSStringFormat(_data) & '"' />
		
		<!--- ARRAY --->
		<cfelseif IsArray(_data)>
			<cfset jsonString = "" />
			<cfloop from="1" to="#ArrayLen(_data)#" index="i">
				<cfset tempVal = encode( _data[i], arguments.queryFormat, arguments.queryKeyCase ) />
				<cfset jsonString = ListAppend(jsonString, tempVal, ",") />
			</cfloop>
			
			<cfreturn "[" & jsonString & "]" />
		
		<!--- STRUCT --->
		<cfelseif IsStruct(_data)>
			<cfset jsonString = "" />
			<cfset arKeys = StructKeyArray(_data) />
			<cfloop from="1" to="#ArrayLen(arKeys)#" index="i">
				<cfset tempVal = encode( _data[ arKeys[i] ], arguments.queryFormat, arguments.queryKeyCase ) />
				<cfset jsonString = ListAppend(jsonString, '"' & arKeys[i] & '":' & tempVal, ",") />
			</cfloop>
			
			<cfreturn "{" & jsonString & "}" />
		
		<!--- QUERY --->
		<cfelseif IsQuery(_data)>
			<!--- Add query meta data --->
			<cfif arguments.queryKeyCase EQ "lower">
				<cfset recordcountKey = "recordcount" />
				<cfset columnlistKey = "columnlist" />
				<cfset columnlist = LCase(_data.columnlist) />
				<cfset dataKey = "data" />
			<cfelse>
				<cfset recordcountKey = "RECORDCOUNT" />
				<cfset columnlistKey = "COLUMNLIST" />
				<cfset columnlist = _data.columnlist />
				<cfset dataKey = "data" />
			</cfif>
			<cfset jsonString = '"#recordcountKey#":' & _data.recordcount />
			<cfset jsonString = jsonString & ',"#columnlistKey#":"' & columnlist & '"' />
			<cfset jsonString = jsonString & ',"#dataKey#":' />
			
			<!--- Make query a structure of arrays --->
			<cfif arguments.queryFormat EQ "query">
				<cfset jsonString = jsonString & "{" />
				<cfset colPos = 1 />
				
				<cfloop list="#_data.columnlist#" delimiters="," index="column">
					<cfif colPos GT 1>
						<cfset jsonString = jsonString & "," />
					</cfif>
					<cfif arguments.queryKeyCase EQ "lower">
						<cfset column = LCase(column) />
					</cfif>
					<cfset jsonString = jsonString & '"' & column & '":[' />
					
					<cfloop from="1" to="#_data.recordcount#" index="i">
						<!--- Get cell value; recurse to get proper format depending on string/number/boolean data type --->
						<cfset tempVal = encode( _data[column][i], arguments.queryFormat, arguments.queryKeyCase ) />
						
						<cfif i GT 1>
							<cfset jsonString = jsonString & "," />
						</cfif>
						<cfset jsonString = jsonString & tempVal />
					</cfloop>
					
					<cfset jsonString = jsonString & "]" />
					
					<cfset colPos = colPos + 1 />
				</cfloop>
				<cfset jsonString = jsonString & "}" />
			<!--- Make query an array of structures --->
			<cfelse>
				<cfset jsonString = jsonString & "[" />
				<cfloop query="_data">
					<cfif CurrentRow GT 1>
						<cfset jsonString = jsonString & "," />
					</cfif>
					<cfset jsonString = jsonString & "{" />
					<cfset colPos = 1 />
					<cfloop list="#columnlist#" delimiters="," index="column">
						<cfset tempVal = encode( _data[column][CurrentRow], arguments.queryFormat, arguments.queryKeyCase ) />
						
						<cfif colPos GT 1>
							<cfset jsonString = jsonString & "," />
						</cfif>
						
						<cfif arguments.queryKeyCase EQ "lower">
							<cfset column = LCase(column) />
						</cfif>
						<cfset jsonString = jsonString & '"' & column & '":' & tempVal />
						
						<cfset colPos = colPos + 1 />
					</cfloop>
					<cfset jsonString = jsonString & "}" />
				</cfloop>
				<cfset jsonString = jsonString & "]" />
			</cfif>
			
			<!--- Wrap all query data into an object --->
			<cfreturn "{" & jsonString & "}" />
		
		<!--- UNKNOWN OBJECT TYPE --->
		<cfelse>
			<cfreturn '"' & "unknown-obj" & '"' />
		</cfif>
	</cffunction>
</cfcomponent>