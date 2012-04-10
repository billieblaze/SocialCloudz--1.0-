<cfcomponent hint="freshbooks" output="false" extends="coldbox.system.Plugin" cache="true">

	<cffunction name="init" access="public" returnType="freshbooks" output="false" hint="Constructor">
		<cfscript>
			// Setup Plugin
			setPluginName("Freshbooks API Wrapper");
			setPluginVersion("1.0");
			setPluginDescription("A XML wrapper to the Freshbooks API service");
			setPluginAuthor("Jeremy R DeYoung");
			setPluginAuthorURL("http://www.lunarfly.com");

			return this;
		</cfscript>
	</cffunction>

	<!--- Expenses --->
    <cffunction name="clientList" output="false" access="public" returntype="any">
		<cfscript>
			arguments.httpMethod = "post";
			arguments.requestMethod = "client.list";
			results = sendAndReceive(argumentCollection=arguments);
			return results;
		</cfscript>
    </cffunction>


	<!--- Freshbooks API URL --->
    <cffunction name="setAPIURL" output="false" access="public" returntype="void" hint="Set the Freshbooks API URL">
    	<cfargument name="apiURL" type="string" required="true" default="" hint="The Freshbooks API URL"/>
		<cfscript>
			instance.apiURL = arguments.apiURL;
		</cfscript>
    </cffunction>
    <cffunction name="getAPIURL" output="false" access="public" returntype="string" hint="Set the Freshbooks API URL">

		<cfreturn instance.apiURL />
    </cffunction>


	<!--- Freshbooks API Token --->
    <cffunction name="setAPIToken" output="false" access="public" returntype="void" hint="Set the Freshbooks API Token">
    	<cfargument name="token" type="string" required="true" default="" hint="The Freshbooks API Token"/>
		<cfscript>
			instance.token = arguments.token;
		</cfscript>
    </cffunction>
    <cffunction name="getAPIToken" output="false" access="public" returntype="string" hint="Set the Freshbooks API Token">

		<cfreturn instance.token />
    </cffunction>


	<!--- Private Functions --->
    <cffunction name="sendAndReceive" output="false" access="private" returntype="any">
		<cfscript>
			var httpService = new http();
			var argumentsList = StructKeyList(arguments);
			var httpURL = this.getAPIURL();
			var httpMethod = arguments.httpMethod;
			var requestMethod = arguments.requestMethod;
			var returnFormat = arguments.returnFormat;
			var returnFields = arguments.returnFields;
			var xmlDoc = xmlNew(true);

			xmlDoc.xmlRoot = xmlElemNew(xmlDoc,"request");
			xmlDoc.xmlRoot.XmlAttributes['method'] = requestMethod;

			for(var i=1;i<=ListLen(argumentsList);i++)
			{
				if(!ListFindNoCase("httpMethod,requestMethod,returnFormat,returnType,returnFields",ListGetAt(argumentsList,i)))
				{
					xmlDoc.xmlRoot[ListGetAt(argumentsList,i)] = xmlElemNew(xmlDoc,ListGetAt(argumentsList,i));
					xmlDoc.xmlRoot[ListGetAt(argumentsList,i)].xmlText = arguments[ListGetAt(argumentsList,i)];
				}
			}

			httpService.setUsername(this.getAPIToken());
			httpService.setPassword("X");
			httpService.addParam(type="header",name="Content-Type",value="application/xml");
			httpService.addParam(type="body",value=toString(xmlDoc));
			httpService.setMethod(httpMethod);
		    httpService.setCharset("utf-8");
		    httpService.setUrl(httpURL);
			var result = httpService.send().getPrefix().filecontent;

			switch(returnFormat)
			{
				case 'query':
					return convertQuery(xmlParse(result),returnFields);
				default:
					return results;
			}
		</cfscript>
    </cffunction>

    <cffunction name="convertQuery" output="false" access="private" returntype="query">
    	<cfargument name="xmlDoc" type="xml" required="true" hint="XML Document">
    	<cfargument name="fields" type="string" required="true" hint="Fields to Return">

    	<cfscript>
    	var myDoc = xmlDoc.xmlRoot.xmlChildren[1];
		var pDoc = "";

		var query = queryNew(arguments.fields);
		QueryAddRow(query,arrayLen(myDoc.xmlChildren));
		for(var i=1;i<=arrayLen(myDoc.xmlChildren);i++)
		{
			pDoc = myDoc.xmlChildren[i];
			for(var f=1;f<=ListLen(arguments.fields);f++)
			{
				QuerySetCell(query,ListGetAt(arguments.fields,f),pDoc[ListGetAt(arguments.fields,f)].xmlText,i);
			}
		}

		return query;
    	</cfscript>
    </cffunction>

</cfcomponent>