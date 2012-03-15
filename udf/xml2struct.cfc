<cfcomponent>
<!--- 
This function converts XML variables into Coldfusion Structures. It also
returns the attributes for each XML node.
--->
<cffunction name="init" returntype="xml2struct">
<cfreturn this>
</cffunction>

<cffunction name="ConvertXmlToStruct" access="public" returntype="struct" output="true"
				hint="Parse raw XML response body into ColdFusion structs and arrays and return it.">
	<cfargument name="xmlNode" type="string" required="true" />
	<cfargument name="str" type="struct" required="true" />
	<!---Setup local variables for recurse: --->
	<cfset var i = 0 />
	<cfset var axml = arguments.xmlNode />
	<cfset var astr = arguments.str />
	<cfset var n = "" />
	<cfset var tmpContainer = "" />
	<cfset var at_list = ''>
	<cfset var attrib_list = ''>
	<cfset var atr = ''>
	<cfset var attrib = ''>
	
	<cfset axml = XmlSearch(XmlParse(arguments.xmlNode),"/node()")>
	<cfset axml = axml[1] />
	<!--- For each children of context node: --->
	<cfloop from="1" to="#arrayLen(axml.XmlChildren)#" index="i">
		<!--- Read XML node name without namespace: --->
		<cfset n = replace(axml.XmlChildren[i].XmlName, axml.XmlChildren[i].XmlNsPrefix&":", "") />
     
	

		<!--- If key with that name exists within output struct ... --->
		<cfif structKeyExists(astr, n)>
			<!--- ... and is not an array... --->
			<cfif not isArray(astr[n])>
				<!--- ... get this item into temp variable, ... --->
				<cfset tmpContainer = astr[n] />
				<!--- ... setup array for this item beacuse we have multiple items with same name, ... --->
				<cfset astr[n] = arrayNew(1) />
				<!--- ... and reassing temp item as a first element of new array: --->
				<cfset astr[n][1] = tmpContainer />
			<cfelse>
				<!--- Item is already an array: --->
				
			</cfif>
			<cfif arrayLen(axml.XmlChildren[i].XmlChildren) gt 0>
					<!--- recurse call: get complex item: --->
					<cfset astr[n][arrayLen(astr[n])+1] = ConvertXmlToStruct(axml.XmlChildren[i], structNew()) />
                  
			<cfelse>
					<!--- else: assign node value as last element of array: --->
					<cfset astr[n][arrayLen(astr[n])+1] = axml.XmlChildren[i].XmlText />
                  
			</cfif>
		<cfelse>
			<!---
				This is not a struct. This may be first tag with some name.
				This may also be one and only tag with this name.
			--->
			<!---
					If context child node has child nodes (which means it will be complex type): --->
			<cfif arrayLen(axml.XmlChildren[i].XmlChildren) gt 0>
				<!--- recurse call: get complex item: --->
				<cfset astr[n] = ConvertXmlToStruct(axml.XmlChildren[i], structNew()) />
			<cfelse>
				<cfif IsStruct(aXml.XmlAttributes) AND StructCount(aXml.XmlAttributes)>
					<cfset at_list = StructKeyList(aXml.XmlAttributes)>
					<cfloop from="1" to="#listLen(at_list)#" index="atr">
						 <cfif ListgetAt(at_list,atr) CONTAINS "xmlns:">
							 <!--- remove any namespace attributes--->
							<cfset Structdelete(axml.XmlAttributes, listgetAt(at_list,atr))>
						 </cfif>
					 </cfloop>
					 <!--- if there are any atributes left, append them to the response--->
					 <cfif StructCount(axml.XmlAttributes) GT 0>
						 <cfset astr['_attributes'] = axml.XmlAttributes />
					</cfif>
				</cfif>
				<!--- else: assign node value as last element of array: --->
				<!--- if there are any attributes on this element--->
				<cfif IsStruct(aXml.XmlChildren[i].XmlAttributes) AND StructCount(aXml.XmlChildren[i].XmlAttributes) GT 0>
					<!--- assign the text --->
					<cfset astr[n] = axml.XmlChildren[i].XmlText />
						<!--- check if there are no attributes with xmlns: , we dont want namespaces to be in the response--->
					 <cfset attrib_list = StructKeylist(axml.XmlChildren[i].XmlAttributes) />
					 <cfloop from="1" to="#listLen(attrib_list)#" index="attrib">
						 <cfif ListgetAt(attrib_list,attrib) CONTAINS "xmlns:">
							 <!--- remove any namespace attributes--->
							<cfset Structdelete(axml.XmlChildren[i].XmlAttributes, listgetAt(attrib_list,attrib))>
						 </cfif>
					 </cfloop>
					 <!--- if there are any atributes left, append them to the response--->
					 <cfif StructCount(axml.XmlChildren[i].XmlAttributes) GT 0>
						 <cfset astr[n&'_attributes'] = axml.XmlChildren[i].XmlAttributes />
					</cfif>
				<cfelse>
					 <cfset astr[n] = axml.XmlChildren[i].XmlText />
				</cfif>
			</cfif>
		</cfif>
          
	</cfloop>
	<!--- return struct: --->
	<cfreturn astr />
</cffunction>



<cffunction name="sessionToXML" returnType="string" access="public" output="false" hint="Converts a struct into XML.">
	<cfargument name="data" type="struct" required="true">
	
	<cfargument name="itemelement" type="string" required="true">
	<cfargument name="includeheader" type="boolean" required="false" default="true">
	<cfset var keys2 = ''>
	<cfset var I = 1>
	<cfset var s = createObject('java','java.lang.StringBuffer').init()>

	<cfset var keys = structKeyList(arguments.data)>
	<cfset var key = "">
	<cfset var key2	 = "">
	<cfset var myvar ="">

	<cfif arguments.includeheader>
		<cfset s.append("<?xml version=""1.0"" encoding=""UTF-8""?>")>
	</cfif>

	<cfset s.append("<#itemElement#>")>	
	
	<cfloop index="key" list="#keys#">
  	<cfset s.append("<#key#>")>	
		
      <cfif key eq 'shoppingcart'>
      <cfloop from="1" to="#arraylen(request.shoppingcart)#" index="I">
      	<cfset s.append("<Item>")>	
       	<cfset keys2 = structKeyList(request.shoppingcart[i])>
  	
        <cfloop index="key2" list="#keys2#">
			
           <cfset myvar = evaluate('request.#key#[i].#key2#')>
            <cfset s.append("<#key2#>#htmleditformat(myvar)#</#key2#>")>
		</cfloop>
       
        <cfset s.append("</Item>")>	
      </cfloop>
	 
	  <cfelse>
		<cfset keys2 = structKeyList(data[key])>
  	
        <cfloop index="key2" list="#keys2#">
			
           <cfset myvar = evaluate('request.#key#.#key2#')>
            <cfset s.append("<#key2#>#htmleditformat(myvar)#</#key2#>")>
		</cfloop></cfif>
	<cfset s.append("</#key#>")>	
	</cfloop>
    	
	<cfset s.append("</#itemElement#>")>
	
	<cfreturn s.toString()>		
</cffunction>


<cffunction name="safeText" returnType="string" access="private" output="false">
	<cfargument name="txt" type="string" required="true">
	<!---<cfset arguments.txt = unicodeWin1252(arguments.txt)>--->
	<cfreturn xmlFormat(arguments.txt)>
</cffunction>


</cfcomponent>