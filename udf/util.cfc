<cfcomponent><cffunction name="init" returntype="util">
<cfreturn this>
</cffunction>
	<cffunction name="queryPaging">
		<Cfargument name="url" default="#cgi.script_name#">
    	<cfargument name="count" default="0">
		<cfargument name="recordsperpage" default="10">
		
		<cfset var TotalPages = '' />
		<cfset var StartRow = '' />
		<cfset var EndRow = '' />
		<cfset var NextPage = '' />
		<cfset var PreviousPage = '' />
		<cfset var querystring = '' />
		<cfset var pages = '' />
	    <cfparam name="url.page" default="1">
  <cfif listlen(url.page) gt 1>
    <cfset url.page = listgetat(url.page, listlen(url.page))>
  </cfif>

    <cfset TotalPages = Ceiling(arguments.count/arguments.RecordsPerPage)>
    <cfset StartRow = (url.page*RecordsPerPage)+1>
    <cfset EndRow = (url.page*RecordsPerPage)+recordsperpage>
    <cfset NextPage = url.page+1>
    <cfset PreviousPage = url.page-1>
    
    <cfset querystring = rereplace(cgi.QUERY_STRING,  'page=[0-9][0-9][0-9]+[&]*', '')>
    <cfset querystring = rereplace(querystring, 'page=[0-9][0-9]+[&]*', '')>
    <cfset querystring = rereplace(querystring, 'page=[0-9]+[&]*', '')>
    <cfset querystring = rereplace(querystring, 'page=[0-9]*', '')>
	

	<cfoutput>
	    <cfif arguments.count gt 0  and totalpages gt 1>
			<ul id="pagination">
				<li class="previous<cfif url.page eq 1>-off</cfif>">
				<cfif url.page eq 1>Previous<cfelse><a href="#arguments.url#?#querystring#&page=#url.page-1#">Previous</a></cfif>
			    </li>
			    <cfloop index="pages" from="1" to="#totalpages#">
			   <cfif (pages lte url.page + 5 and pages gte url.page - 5) or (url.page lt 9 and pages lte 9)  or (url.page gt totalpages - 10 and pages gte totalpages - 10) >
			          <cfif url.page eq pages>
						<li class="active">#pages#</li>            
			          <cfelse>
			            <li><a href="#arguments.url#?#querystring#&page=#pages#" title="Page #pages#">#pages#</a></li>
			          </cfif>
			    </cfif>
			    </cfloop>
				<li class="next<cfif url.page eq totalPages>-off</cfif>">
					<cfif url.page eq totalPages>Next<cfelse><a href="#arguments.url#?#querystring#&page=#url.page+1#">Next</a></cfif>
			    </li>
			</ul> 
	    </cfif>
	  </cfoutput>
</cffunction>

	
<cfscript>
/**
 * Makes a struct for all values in a given column(s) of a query.
 * v2 by James Moberg
 * 
 * @param query 	 The query to operate on (Required)
 * @param keyColumn 	 The name of the column to use for the key in the struct (Required)
 * @param valueColumn 	 The name of the column in the query to use for the values in the struct (defaults to whatever the keyColumn is) (Optional)
 * @param reverse 	 Boolean value for whether to go through the query in reverse (default is false) (Optional)
 * @param retainSort 	 If true, a Java LinkedHashMap will be used to create the result. This will create a struct with ordered keys. Defaults to false. (Optional)
 * @return struct 
 * @author Nathan Dintenfass (&#110;&#97;&#116;&#104;&#97;&#110;&#64;&#99;&#104;&#97;&#110;&#103;&#101;&#109;&#101;&#100;&#105;&#97;&#46;&#99;&#111;&#109;) 
 * @version 2, January 24, 2011 
 */
function queryColumnsToStruct(query,keyColumn){
       var valueColumn = keyColumn;
       var reverse = false;
       var retainSort = false;
       var struct = structNew();
       var increment = 1;
       var ii = 1;
       var rowsGotten = 0;
       if(arrayLen(arguments) GT 2) valueColumn = arguments[3];
       if(arrayLen(arguments) GT 3) reverse = arguments[4];
       if(arrayLen(arguments) GT 4) retainSort = arguments[5];
       if(retainSort){
               struct = CreateObject("java", "java.util.LinkedHashMap").init();
       }
       if(reverse){
               ii = query.recordCount;
               increment = -1;
       }
       while(rowsGotten LT query.recordCount){
               struct[query[keyColumn][ii]] = query[valueColumn][ii];
               ii = ii + increment;
               rowsGotten = rowsGotten + 1;
       }
       return struct;
}
</cfscript>
<cfscript>
	/**
 * Converts a query object into an array of structures.
 * 
 * @param query 	 The query to be transformed 
 * @return This function returns a structure. 
 * @author Nathan Dintenfass (nathan@changemedia.com) 
 * @version 1, September 27, 2001 
 */
function QueryToArrayOfStructures(theQuery){
	var theArray = arraynew(1);
	var cols = ListtoArray(theQuery.columnlist);
	var row = 1;
	var thisRow = "";
	var col = 1;
	for(row = 1; row LTE theQuery.recordcount; row = row + 1){
		thisRow = structnew();
		for(col = 1; col LTE arraylen(cols); col = col + 1){
			thisRow[cols[col]] = theQuery[cols[col]][row];
		}
		arrayAppend(theArray,duplicate(thisRow));
	}
	return(theArray);
}
	
 
/**
* CSVFormat accepts the name of an existing query and converts it to csv format.
* Updated version of UDF orig. written by Simon Horwith
*
* @param query      The query to format. (Required)
* @param qualifer      A string to qualify the data with. (Optional)
* @param columns      The columns ot use. Defaults to all columns. (Optional)
* @return A CSV formatted string.
* @author Jeff Howden (cflib@jeffhowden.com)
* @version 2, August 26, 2008
*/
function CSVFormat(query) {
var returnValue = ArrayNew(1);
var rowValue = '';
var columns = query.columnlist;
var qualifier = '';
var i = 1;
var j = 1;
if(ArrayLen(Arguments) GTE 2) qualifier = Arguments[2];
if(ArrayLen(Arguments) GTE 3 AND Len(Arguments[3])) columns = Arguments[3];
returnValue[1] = ListQualify(columns, qualifier);
ArrayResize(returnValue, query.recordcount + 1);
columns = ListToArray(columns);
for(i = 1; i LTE query.recordcount; i = i + 1)
{
rowValue = ArrayNew(1);
ArrayResize(rowValue, ArrayLen(columns));
for(j = 1; j LTE ArrayLen(columns); j = j + 1)
rowValue[j] = qualifier & query[columns[j]][i] & qualifier;
returnValue[i + 1] = ArrayToList(rowValue);
}        
returnValue = ArrayToList(returnValue, Chr(13));
return returnValue;
}

/**
* Parses an HTML string and returns META tag information.
* Regex fix for names with spaces by Johan Steenkamp (johan@orbital.co.nz).
* Fix for self closing tags.
*
* @param str      The string to check. (Required)
* @return Returns an array.
* @author Raymond Camden (johan@orbital.co.nzray@camdenfamily.com)
* @version 4, May 2, 2007
*/
function GetMetaHeaders(str) {
    var matchStruct = structNew();
    var name = "";
    var content = "";
    var results = arrayNew(1);
    var pos = 1;
    var regex = "<meta[[:space:]]*(name|http-equiv)[[:space:]]*=[[:space:]]*(""|')([^""]*)(""|')[[:space:]]*content=(""|')([^""]*)(""|')[[:space:]]*/{0,1}>";     
    
    matchStruct = REFindNoCase(regex,str,pos,1);
    while(matchStruct.pos[1]) {
        results[arrayLen(results)+1] = structNew();
        results[arrayLen(results)][ Mid(str,matchStruct.pos[2],matchStruct.len[2])] = Mid(str,matchStruct.pos[4],matchStruct.len[4]);
        results[arrayLen(results)].content = Mid(str,matchStruct.pos[7],matchStruct.len[7]);
        pos = matchStruct.pos[6] + matchStruct.len[6] + 1;
        matchStruct = REFindNoCase(regex,str,pos,1);
    }
    return results;
}

/**
* Returns the position of an element in an array of structures.
*
* @param array      Array to search. (Required)
* @param searchKey      Key to check in the structs. (Required)
* @param value      Value to search for. (Required)
* @return Returns the numeric index of a match.
* @author Nath Arduini (nathbot@gmail.com)
* @version 0, June 11, 2009
*/
	function arrayOfStructsFind(Array, SearchKey, Value){
	    var result = 0;
	    var i = 1;
	    var key = "";
		
	    for (i=1;i lte arrayLen(array);i=i+1){
	        for (key in array[i])
	        {
	            if ( key eq SearchKey and not isDefined('Value')){
					result = i;
	            	return result;
	            } else if (isDefined('Value')) {
		            if(array[i][key]==Value and key == SearchKey){
		                result = i;
		                return result;
		            }
				}
	        }
	    }
		return result;
		}
		
/**
* Pass in a value in bytes, and this function converts it to a human-readable format of bytes, KB, MB, or GB.
* Updated from Nat Papovich's version.
* 01/2002 - Optional Units added by Sierra Bufe (sierra@brighterfusion.com)
*
* @param size      Size to convert.
* @param unit      Unit to return results in. Valid options are bytes,KB,MB,GB.
* @return Returns a string.
* @author Paul Mone (sierra@brighterfusion.compaul@ninthlink.com)
* @version 2.1, January 7, 2002
*/
function byteConvert(num) {
    var result = 0;
    var unit = "";
    
    // Set unit variables for convenience
    var bytes = 1;
    var kb = 1024;
    var mb = 1048576;
    var gb = 1073741824;

    // Check for non-numeric or negative num argument
    if (not isNumeric(num) OR num LT 0)
        return "Invalid size argument";
    
    // Check to see if unit was passed in, and if it is valid
    if ((ArrayLen(Arguments) GT 1)
        AND ("bytes,KB,MB,GB" contains Arguments[2]))
    {
        unit = Arguments[2];
    // If not, set unit depending on the size of num
    } else {
         if (num lt kb) {    unit ="bytes";
        } else if (num lt mb) {    unit ="KB";
        } else if (num lt gb) {    unit ="MB";
        } else {    unit ="GB";
        }        
    }
    
    // Find the result by dividing num by the number represented by the unit
    result = num / Evaluate(unit);
    
    // Format the result
    if (result lt 10)
    {
        result = NumberFormat(Round(result * 100) / 100,"0.00");
    } else if (result lt 100) {
        result = NumberFormat(Round(result * 10) / 10,"90.0");
    } else {
        result = Round(result);
    }
    // Concatenate result and unit together for the return value
    return (result & " " & unit);
}

/**
* Converts seconds to nearest time unit in english.
*
* @param iSeconds      Number of seconds. (Required)
* @return Returns a string.
* @author Peter Crowley (pcrowley@webzone.ie)
* @version 1, January 21, 2005
*/
function dateToEnglish(idate) {

	
    var szPlural = "";
    var iTime = "";
    var szUpdate = "";
    var iSeconds = datediff('s', idate,now());
	
	
    if (iSeconds LTE 0) iSeconds=1;
    iTime=iSeconds \ 86400;
    if (iTime GT 0) {
        if (iTime GT 1) szPlural = 's';
        szUpdate = "#iTime# day#szPlural#"; // Days
    } else {
        iTime=iSeconds \ 3600;
        if (iTime GT 0) {
            if (iTime GT 1) szPlural = 's';
            szUpdate = "#iTime# hour#szPlural#"; // Hours
        } else {
            iTime=iSeconds \ 60;
            if (iTime GT 0) {
                if (iTime GT 1) szPlural = 's';
                szUpdate = "#iTime# minute#szPlural#"; // Minutes
            } else {
                iTime=iSeconds;
                if (iTime NEQ 1) szPlural = 's';
                szUpdate = "#iTime# second#szPlural#"; // Seconds
            }
        }
    }
    return szUpdate & ' ago';
}

/**
* Given a date, returns the appropriate zodiac sign.
*
* @param date      Date value. (Required)
* @return Returns a string.
* @author Charlie Griefer (charlie@griefer.com)
* @version 1, February 14, 2004
*/
function getZodiacSign(date) {
    var bday_m = month(date);
    var bday_d = day(date);
    
    switch(bday_m) {
        case 1:
            if (bday_d LTE 20) { sign = "Capricorn"; } else { sign = "Aquarius"; }
            break;
        case 2:
            if (bday_d LTE 19) { sign = "Aquarius"; } else { sign = "Pisces"; }
            break;
        case 3:
            if (bday_d LTE 20) { sign = "Pisces"; } else { sign = "Aries"; }
            break;
        case 4:
            if (bday_d LTE 20) { sign = "Aries"; } else { sign = "Taurus"; }
            break;
        case 5:
            if (bday_d LTE 21) { sign = "Taurus"; } else { sign = "Gemini";    }
            break;
        case 6:
            if (bday_d LTE 22) { sign = "Gemini"; } else { sign = "Cancer";    }
            break;
        case 7:
            if (bday_d LTE 23) { sign = "Cancer"; } else { sign = "Leo"; }
            break;
        case 8:
            if (bday_d LTE 23) { sign = "Leo"; } else { sign = "Virgo"; }
            break;
        case 9:
            if (bday_d LTE 23) { sign = "Virgo"; } else { sign = "Libra"; }
            break;
        case 10:
            if (bday_d LTE 23) { sign = "Libra"; } else { sign = "Scorpio"; }
            break;
        case 11:
            if (bday_d LTE 22) { sign = "Scorpio"; } else { sign = "Sagittarius"; }
            break;
        case 12:
            if (bday_d LTE 21) { sign = "Sagittarius"; } else { sign = "Capricorn"; }
            break;
    }
    
    return sign;
}
/**
* Given the date of birth, returns age.
*
* @param dob      Date of birth. (Required)
* @return Returns a string.
* @author Alexander Sicular (as867@columbia.edu)
* @version 1, November 18, 2002
*/
function ageSinceDOB(dob) {
if(dob eq ''){ 
	return 'NA';
}
var ageYR = DateDiff('yyyy', dob, NOW());
var ageMO = DateDiff('m', dob, NOW());
var ageWK = DateDiff('ww', dob, NOW());
var ageDY = DateDiff('d', dob, NOW());
var age = "NA";

if ( isDate(dob) ){
if (now() LT dob){
age = "NA";
}else{
if (ageYR LT 2) {
age = ageMO & "m";
if (ageMO LT 1) {
         age = ageWK & "w";
         }
         if (ageWK LT 1) {
         age = ageDY & "d";
         }
     }else{
     age = ageYR;
     }
}
}else{
age = "NA";
}
return age;
}


/**
* Converts a URL query string to a structure.
*
* @param qs      Query string to parse. Defaults to cgi.query_string. (Optional)
* @return Returns a struct.
* @author Malessa Brisbane (cflib@brisnicki.com)
* @version 1, April 11, 2006
*/
function queryStringToStruct() {
    //var to hold the final structure
    var struct = StructNew();
    //vars for use in the loop, so we don't have to evaluate lists and arrays more than once
    var i = 1;
    var pairi = "";
    var keyi = "";
    var valuei = "";
    var qsarray = "";
    var qs = CGI.QUERY_STRING; // default querystring value
    
    //if there is a second argument, use that as the query string
    if (arrayLen(arguments) GT 0) qs = arguments[1];

    //put the query string into an array for easier looping
    qsarray = listToArray(qs, "&");
    //now, loop over the array and build the struct
    for (i = 1; i lte arrayLen(qsarray); i = i + 1){
        pairi = qsarray[i]; // current pair
        keyi = listFirst(pairi,"="); // current key
        valuei = urlDecode(listLast(pairi,"="));// current value
        // check if key already added to struct
        if (structKeyExists(struct,keyi)) struct[keyi] = listAppend(struct[keyi],valuei); // add value to list
        else structInsert(struct,keyi,valuei); // add new key/value pair
    }
    // return the struct
    return struct;
}

/**
* Recursive functions to compare structures and arrays.
* Fix by Jose Alfonso.
*
* @param LeftStruct      The first struct. (Required)
* @param RightStruct      The second structure. (Required)
* @return Returns a boolean.
* @author Ja Carter (ja@nuorbit.com)
* @version 2, October 14, 2005
*/
function structCompare(LeftStruct,RightStruct) {
    var result = true;
    var LeftStructKeys = "";
    var RightStructKeys = "";
    var key = "";
    
    //Make sure both params are structures
    if (NOT (isStruct(LeftStruct) AND isStruct(RightStruct))) return false;

    //Make sure both structures have the same keys
    LeftStructKeys = ListSort(StructKeyList(LeftStruct),"TextNoCase","ASC");
    RightStructKeys = ListSort(StructKeyList(RightStruct),"TextNoCase","ASC");
    if(LeftStructKeys neq RightStructKeys) return false;    
    
    // Loop through the keys and compare them one at a time
    for (key in LeftStruct) {
        //Key is a structure, call structCompare()
        if (isStruct(LeftStruct[key])){
            result = structCompare(LeftStruct[key],RightStruct[key]);
            if (NOT result) return false;
        //Key is an array, call arrayCompare()
        } else if (isArray(LeftStruct[key])){
            result = arrayCompare(LeftStruct[key],RightStruct[key]);
            if (NOT result) return false;
        // A simple type comparison here
        } else {
            if(LeftStruct[key] IS NOT RightStruct[key]) return false;
        }
    }
    return true;
}
</cfscript>


<!---
Display rss feed.
Changes by Raymond Camden and Steven (v2 support amount)

@param feedURL      RSS URL. (Required)
@param amount      Restricts the amount of items returned. Defaults to number of items in the feed. (Optional)
@return Returns a query.
@author Jose Diaz-Salcedo (bleachedbug@gmail.com)
@version 2, November 20, 2008
--->
<cffunction name="cfRssFeed" access="public" returntype="query" output=false>
    <cfargument name="feedUrl" type="string" required="true"/>
    <cfset var news_file = arguments.feedurl>
    <cfset var rss = "">
    <cfset var items = "">
    <cfset var rssItems = "">
    <cfset var i = "">
    <cfset var row = "">
    <cfset var title = "">
    <cfset var link = "">
    <cfset var description = "">
	
    <cfhttp url="#news_file#" method="get" />
    
    <cfset rss = xmlParse(cfhttp.filecontent)>

    <cfset items = xmlSearch(rss, "/rss/channel/item")>
    <cfset rssItems = queryNew("title,description,link")>

    <cfloop from="1" to="#ArrayLen(items)#" index="i">
        <cfset row = queryAddRow(rssItems)>
        <cfset title = xmlSearch(rss, "/rss/channel/item[#i#]/title")>

        <cfif arrayLen(title)>
            <cfset title = title[1].xmlText>
        <cfelse>
            <cfset title="">
        </cfif>

        <cfset description = XMLSearch(items[i], "/rss/channel/item[#i#]/description")>

        <cfif ArrayLen(description)>
            <cfset description = description[1].xmlText>
        <cfelse>
            <cfset description="">
        </cfif>

        <cfset link = xmlSearch(items[i], "/rss/channel/item[#i#]/link")>

        <cfif arrayLen(link)>
            <cfset link = link[1].xmlText>
        <cfelse>
            <cfset link="">
        </cfif>

        <cfset querySetCell(rssItems, "title", title, row)>
        <cfset querySetCell(rssItems, "description", description, row)>
        <cfset querySetCell(rssItems, "link", link, row)>

    </cfloop>

    <cfreturn rssItems />

</cffunction> 
<cfscript>
/**
* Remove duplicates from a list.
*
* @param lst      List to parse. (Required)
* @param delim      List delimiter. Defaults to a comma. (Optional)
* @return Returns a string.
* @author Keith Gaughan (keith@digital-crew.com)
* @version 1, August 22, 2005
*/
function listRemoveDuplicates(lst) {
var i = 0;
var delim = ",";
var asArray = "";
var set = StructNew();

if (ArrayLen(arguments) gt 1) delim = arguments[2];

asArray = ListToArray(lst, delim);
for (i = 1; i LTE ArrayLen(asArray); i = i + 1) set[asArray[i]] = "";

return structKeyList(set, delim);
}
</cfscript>

<!---
Serialize native ColdFusion objects into a JSON formated string.

@param arg      The data to encode. (Required)
@return Returns a string. 
@author Jehiah Czebotar (jehiah@gmail.com) 
@version 2, June 27, 2008 
--->
<cffunction name="jsonencode" access="remote" returntype="string" output="No"
        hint="Converts data from CF to JSON format">
    <cfargument name="data" type="any" required="Yes" />
    <cfargument name="queryFormat" type="string" required="No" default="query" /> <!-- query or array -->
    <cfargument name="queryKeyCase" type="string" required="No" default="lower" /> <!-- lower or upper -->
    <cfargument name="stringNumbers" type="boolean" required="No" default=false >
    <cfargument name="formatDates" type="boolean" required="No" default=false >
    <cfargument name="columnListFormat" type="string" required="No" default="string" > <!-- string or array -->
    
    <!--- VARIABLE DECLARATION --->
    <cfset var jsonString = "" />
    <cfset var tempVal = "" />
    <cfset var arKeys = "" />
    <cfset var colPos = 1 />
    <cfset var i = 1 />
    <cfset var column = ""/>
    <cfset var datakey = ""/>
    <cfset var recordcountkey = ""/>
    <cfset var columnlist = ""/>
    <cfset var columnlistkey = ""/>
    <cfset var dJSONString = "" />
    <cfset var escapeToVals = "\\,\"",\/,\b,\t,\n,\f,\r" />
    <cfset var escapeVals = "\,"",/,#Chr(8)#,#Chr(9)#,#Chr(10)#,#Chr(12)#,#Chr(13)#" />
    
    <cfset var _data = arguments.data />

    <!--- BOOLEAN --->
    <cfif IsBoolean(_data) AND NOT IsNumeric(_data) AND NOT ListFindNoCase("Yes,No", _data)>
        <cfreturn LCase(ToString(_data)) />
        
    <!--- NUMBER --->
    <cfelseif NOT stringNumbers AND IsNumeric(_data) AND NOT REFind("^0+[^\.]",_data)>
        <cfreturn ToString(_data) />
    
    <!--- DATE --->
    <cfelseif IsDate(_data) AND arguments.formatDates>
        <cfreturn '"#DateFormat(_data, "medium")# #TimeFormat(_data, "medium")#"' />
    
    <!--- STRING --->
    <cfelseif IsSimpleValue(_data)>
        <cfreturn '"' & ReplaceList(_data, escapeVals, escapeToVals) & '"' />
    
    <!--- ARRAY --->
    <cfelseif IsArray(_data)>
        <cfset dJSONString = createObject('java','java.lang.StringBuffer').init("") />
        <cfloop from="1" to="#ArrayLen(_data)#" index="i">
            <cfset tempVal = jsonencode( _data[i], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
            <cfif dJSONString.toString() EQ "">
                <cfset dJSONString.append(tempVal) />
            <cfelse>
                <cfset dJSONString.append("," & tempVal) />
            </cfif>
        </cfloop>
        
        <cfreturn "[" & dJSONString.toString() & "]" />
    
    <!--- STRUCT --->
    <cfelseif IsStruct(_data)>
        <cfset dJSONString = createObject('java','java.lang.StringBuffer').init("") />
        <cfset arKeys = StructKeyArray(_data) />
        <cfloop from="1" to="#ArrayLen(arKeys)#" index="i">
            <cfset tempVal = jsonencode( _data[ arKeys[i] ], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
            <cfif dJSONString.toString() EQ "">
                <cfset dJSONString.append('"' & lcase(arKeys[i]) & '":' & tempVal) />
            <cfelse>
                <cfset dJSONString.append("," & '"' & lcase(arKeys[i]) & '":' & tempVal) />
            </cfif>
        </cfloop>
        
        <cfreturn "{" & dJSONString.toString() & "}" />
    
    <!--- QUERY --->
    <cfelseif IsQuery(_data)>
        <cfset dJSONString = createObject('java','java.lang.StringBuffer').init("") />
        
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
        
        <cfset dJSONString.append('"#recordcountKey#":' & _data.recordcount) />
        <cfif arguments.columnListFormat EQ "array">
            <cfset columnlist = "[" & ListQualify(columnlist, '"') & "]" />
            <cfset dJSONString.append(',"#lcase(columnlistKey)#":' & columnlist) />
        <cfelse>
            <cfset dJSONString.append(',"#lcase(columnlistKey)#":"' & columnlist & '"') />
        </cfif>
        <cfset dJSONString.append(',"#dataKey#":') />
        
        <!--- Make query a structure of arrays --->
        <cfif arguments.queryFormat EQ "query">
            <cfset dJSONString.append("{") />
            <cfset colPos = 1 />
            
            <cfloop list="#_data.columnlist#" delimiters="," index="column">
                <cfif colPos GT 1>
                    <cfset dJSONString.append(",") />
                </cfif>
                <cfif arguments.queryKeyCase EQ "lower">
                    <cfset column = LCase(column) />
                </cfif>
                <cfset dJSONString.append('"' & column & '":[') />
                
                <cfloop from="1" to="#_data.recordcount#" index="i">
                    <!--- Get cell value; recurse to get proper format depending on string/number/boolean data type --->
                    <cfset tempVal = jsonencode( _data[column][i], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
                    
                    <cfif i GT 1>
                        <cfset dJSONString.append(",") />
                    </cfif>
                    <cfset dJSONString.append(tempVal) />
                </cfloop>
                
                <cfset dJSONString.append("]") />
                
                <cfset colPos = colPos + 1 />
            </cfloop>
            <cfset dJSONString.append("}") />
        <!--- Make query an array of structures --->
        <cfelse>
            <cfset dJSONString.append("[") />
            <cfloop query="_data">
                <cfif CurrentRow GT 1>
                    <cfset dJSONString.append(",") />
                </cfif>
                <cfset dJSONString.append("{") />
                <cfset colPos = 1 />
                <cfloop list="#columnlist#" delimiters="," index="column">
                    <cfset tempVal = jsonencode( _data[column][CurrentRow], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
                    
                    <cfif colPos GT 1>
                        <cfset dJSONString.append(",") />
                    </cfif>
                    
                    <cfif arguments.queryKeyCase EQ "lower">
                        <cfset column = LCase(column) />
                    </cfif>
                    <cfset dJSONString.append('"' & lcase(column) & '":' & tempVal) />
                    
                    <cfset colPos = colPos + 1 />
                </cfloop>
                <cfset dJSONString.append("}") />
            </cfloop>
            <cfset dJSONString.append("]") />
        </cfif>
        
        <!--- Wrap all query data into an object --->
        <cfreturn "{" & dJSONString.toString() & "}" />
    
    <!--- UNKNOWN OBJECT TYPE --->
    <cfelse>
        <cfreturn '"' & "unknown-obj" & '"' />
    </cfif>
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
<cffunction name="RandString" output="no" returntype="string">
   <cfargument name="length" type="numeric" required="yes">

   <!--- Local vars --->
   <cfset var result="">
   <cfset var i=0>

   <!--- Create string --->
   <cfloop index="i" from="1" to="#ARGUMENTS.length#">
      <!--- Random character in range A-Z --->
      <cfset result=result&Chr(RandRange(65, 90))>
   </cfloop>
   <cfreturn result>
</cffunction>
</cfcomponent>