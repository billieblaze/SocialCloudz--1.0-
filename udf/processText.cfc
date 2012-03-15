<cfcomponent>
	<cffunction name="init" returntype="processtext">
<cfreturn this>
</cffunction>
<cffunction name="forbiddenWords" access="public" returntype="string">
  	<cfargument name="inString">
  	<cfset var passed = 'clean'>
	<cfset var listValue = ''>
  	<cfloop list="#application.forbiddenwords#" index="listValue">
    	<cfif arguments.inString contains listValue>
      		<cfset passed = 'forbidden'>
	    </cfif>
	  </cfloop>
  <cfreturn passed>
</cffunction>
<cffunction name="badLanguage" access="public" returntype="string">
  <cfargument name="inString">
  <cfset var passed = ''>
  <cfset var retVal = ''>
  <cfset var listValue = "">
  <cfloop list="#application.badLanguage#" index="listValue">
    <cfif inString contains listValue>
      <cfset retval = listValue>
      <cfset passed = 'no'>
    </cfif>
  </cfloop>
  <cfif passed eq ''>
    <cfset retVal = 'clean'>
  </cfif>
  <cfreturn retVal>
</cffunction>



<cfscript>
/**
* Abbreviates a given string to roughly the given length, stripping any tags, making sure the ending doesn't chop a word in two, and adding an ellipsis character at the end.
* Fix by Patrick McElhaney
* v3 by Ken Fricklas kenf@accessnet.net, takes care of too many spaces in text.
*
* @param string      String to use. (Required)
* @param len      Length to use. (Required)
* @return Returns a string.
* @author Gyrus (kenf@accessnet.netgyrus@norlonto.net)
* @version 3, September 6, 2005
*/
function abbreviate(string,len) {
    var newString = REReplace(string, "<[^>]*>", " ", "ALL");
    var lastSpace = 0;
    newString = REReplace(newString, " \s*", " ", "ALL");
    if (len(newString) gt len) {
        newString = left(newString, len-2);
        lastSpace = find(" ", reverse(newString));
        lastSpace = len(newString) - lastSpace;
        newString = left(newString, lastSpace) & " &##8230;";
    }    
    return newString;
}



/**
 * Function to strip HTML tags, with options to preserve certain tags.
 * 
 * @param str 	 String to manipulate. (Required)
 * @param action 	 Strip or preserve. Default is strip. (Optional)
 * @param tagList 	 Tags to strip or perserve. (Optional)
 * @return Returns a string. 
 * @author Rick Root
 * @version 1, November 24, 2007 
 */
function tagStripper(str) {
	var i = 1;
	var action = 'strip';
	var tagList = ';
	var tag = ';
	
	if (ArrayLen(arguments) gt 1 and lcase(arguments[2]) eq 'preserve') {
		action = 'preserve';
	}
	if (ArrayLen(arguments) gt 2) tagList = arguments[3];

	if (trim(lcase(action)) eq "preserve") {
		// strip only those tags in the tagList argument
		for (i=1;i lte listlen(tagList); i = i + 1) {
			tag = listGetAt(tagList,i);
			str = REReplaceNoCase(str,"</?#tag#.*?>","","ALL");
		}
	} else {
		// strip all, except those in the tagList argument
		// if there are exclusions, mark them with NOSTRIP
		if (tagList neq "") {
			for (i=1;i lte listlen(tagList); i = i + 1) {
				tag = listGetAt(tagList,i);
				str = REReplaceNoCase(str,"<(/?#tag#.*?)>","___TEMP___NOSTRIP___\1___TEMP___ENDNOSTRIP___","ALL");
			}
		}
		// strip all remaining tsgs.  This does NOT strip comments
		str = reReplaceNoCase(str,"<[A-Z].*?>","","ALL");
		// convert unstripped back to normal
		str = replace(str,"___TEMP___NOSTRIP___","<","ALL");
		str = replace(str,"___TEMP___ENDNOSTRIP___",">","ALL");
	
		// additions that aren't getting cleared -bill b
		str = replacenocase(str,"</div>","","all");
		str = replacenocase(str,"&nbsp;","","all");
		str = replacenocase(str,"</em>","","all");
		str = replacenocase(str,"</img>","","all");
		str = replacenocase(str,"</p>","","all");
		str = replacenocase(str,"</b>","","all");
		str = replacenocase(str,"</font>","","all");
		str = replacenocase(str,"</dd>","","all");
		str = replacenocase(str,"</dl>","","all");
		str = replacenocase(str,"</form>","","all");
		str = replacenocase(str,"</a>","","all");
		str = replacenocase(str,"</span>","","all");
		str = replacenocase(str,"</td>","","all");
		str = replacenocase(str,"</tr>","","all");
		str = replacenocase(str,"</th>","","all");
		str = replacenocase(str,"</tbody>","","all");
		str = replacenocase(str,"</table>","","all");
		str = replacenocase(str,"</script>","","all");
		str = replacenocase(str,"</blockquote>","","all");
		str = replacenocase(str,"</searchignore>","","all");
		str = replacenocase(str,"</iframe>","","all");
		str = replacenocase(str,"</noscript>","","all");
		str = replacenocase(str,"</strong>","","all");
		str = replacenocase(str,"</label>","","all");
		str = replacenocase(str,"</option>","","all");
		str = replacenocase(str,"</select>","","all");
		str = replacenocase(str,"</h1>","","all");
		str = replacenocase(str,"</h2>","","all");
		str = replacenocase(str,"</h3>","","all");
		str = replacenocase(str,"</h4>","","all");
		str = replacenocase(str,"</ul>","","all");
		str = replacenocase(str,"</center>","","all");
		str = replacenocase(str,"</style>","","all");
		str = replacenocase(str,"</u>","","all");
		str = replacenocase(str,"</cite>","","all");
		str = replacenocase(str,"</noembed>","","all");
		str = replacenocase(str,"</li>","","all");
		str = replacenocase(str,"<!--","","all");
		str = replacenocase(str,"-->","","all");
		str = replacenocase(str,"</st1:address>","","all");
		str = replacenocase(str,"</st1:street>","","all");
		str = replacenocase(str,"</st1:place>","","all");
		str = replacenocase(str,"</st1:city>","","all");
		str = replacenocase(str,"</st1:city>","","all");
		str = replacenocase(str,"</st1:placename>","","all");
		str = replacenocase(str,"</st1:placetype>","","all");
		str = replacenocase(str,"</o:p>","","all");
			str = replacenocase(str,">","","all");
		
		
        
		
	}
	
	return str;	
}


/**
* This function takes URLs in a text string and turns them into links.
* Version 2 by Lucas Sherwood, lucas@thebitbucket.net.
* Version 3 Updated to allow for ;
*
* @param string      Text to parse. (Required)
* @param target      Optional target for links. Defaults to "". (Optional)
* @param paragraph      Optionally add paragraphFormat to returned string. (Optional)
* @return Returns a string.
* @author Joel Mueller (lucas@thebitbucket.netjmueller@swiftk.com)
* @version 3, August 11, 2004
*/
function ActivateURL(string) {
    var nextMatch = 1;
    var objMatch = "";
    var outstring = "";
    var thisURL = "";
    var thisLink = "";
    var    target = IIf(arrayLen(arguments) gte 2, "arguments[2]", DE(""));
    var paragraph = IIf(arrayLen(arguments) gte 3, "arguments[3]", DE("false"));
    
    do {
        objMatch = REFindNoCase("(((https?:|ftp:|gopher:)\/\/)|(www\.|ftp\.))[-[:alnum:]\?%,\.\/&##!;@:=\+~_]+[A-Za-z0-9\/]", string, nextMatch, true);
        if (objMatch.pos[1] GT nextMatch OR objMatch.pos[1] EQ nextMatch) {
            outString = outString & Mid(String, nextMatch, objMatch.pos[1] - nextMatch);
        } else {
            outString = outString & Mid(String, nextMatch, Len(string));
        }
        nextMatch = objMatch.pos[1] + objMatch.len[1];
        if (ArrayLen(objMatch.pos) GT 1) {
            // If the preceding character is an @, assume this is an e-mail address
            // (for addresses like admin@ftp.cdrom.com)
            if (Compare(Mid(String, Max(objMatch.pos[1] - 1, 1), 1), "@") NEQ 0) {
                thisURL = Mid(String, objMatch.pos[1], objMatch.len[1]);
                thisLink = "<A HREF=""";
                switch (LCase(Mid(String, objMatch.pos[2], objMatch.len[2]))) {
                    case "www.": {
                        thisLink = thisLink & "http://";
                        break;
                    }
                    case "ftp.": {
                        thisLink = thisLink & "ftp://";
                        break;
                    }
                }
                thisLink = thisLink & thisURL & """";
                if (Len(Target) GT 0) {
                    thisLink = thisLink & " TARGET=""" & Target & """";
                }
                thisLink = thisLink & ">" & thisURL & "</A>";
                outString = outString & thisLink;
                // String = Replace(String, thisURL, thisLink);
                // nextMatch = nextMatch + Len(thisURL);
            } else {
                outString = outString & Mid(String, objMatch.pos[1], objMatch.len[1]);
            }
        }
    } while (nextMatch GT 0);
        
    // Now turn e-mail addresses into mailto: links.
    outString = REReplace(outString, "([[:alnum:]_\.\-]+@([[:alnum:]_\.\-]+\.)+[[:alpha:]]{2,4})", "<A HREF=""mailto:\1"">\1</A>", "ALL");
        
    if (paragraph) {
        outString = ParagraphFormat(outString);
    }
    return outString;
}


</cfscript>


	<cffunction name="parseTag">
		<cfargument name="tag">
		<cfargument name="contentType">
		
		<cfset var tagData = ''>
		<cfset var data = ''>
		<cfset var link = ''>
		
		<cfif arguments.tag contains '@'>
			<cfset arguments.tag = replace(arguments.tag,'@','')>
			<cfset tagData = listToArray(arguments.tag,'_')>
			
			<cfif tagData[1] eq 'content'>
				<cfset data = application.content.get(mode=simple, contentID = tagData[2])>
				<cfset link = '<a href="/index.cfm/content/#data.contentType#/#tagData[2]#" class="small">#data.title#</a>'>
				<cfreturn link>
<!--->			<cfelseif tagData[1] eq 'community'>
				<cfset data = application.community.gateway.get(communityId = tagData[2])>
				<cfset link = '<a href="">#data.site#</a>'>
				<cfreturn link>			--->
			<cfelseif tagData[1] eq 'member'>
				<cfset data = application.members.gateway.get(memberID = tagData[2])>
				<cfset link = '<a href="/index.cfm/member/profile/index/#data.memberID#"> class="small"#data.username#</a>'>
				<cfreturn link>				
			</cfif>
		<cfelse>
			<cfset link = '<a href="/index.cfm/content/#arguments.contentType#?tag=#arguments.tag#" class="small">#arguments.tag#</a>'>
			<cfreturn link>
		</cfif>
	</cffunction>
</cfcomponent>