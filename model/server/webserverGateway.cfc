<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="id">
		<cfscript>
			return super.get('log', arguments);
		</cfscript>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="dataStruct">
		<cfquery datasource="#this.datasource#">
			insert into log
			(browser, dateEntered, file,host,ip,referrer,size)
			values
			('#arguments.dataStruct.browser#',#createodbcdatetime(arguments.dataStruct.dateEntered)#,'#left(arguments.dataStruct.file,1024)#','#arguments.dataStruct.host#','#arguments.dataStruct.ip#','#left(arguments.dataStruct.referrer,1024)#','#arguments.dataStruct.size#')
		</cfquery>

	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="id">
		<cfscript>
			return super.delete('log', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>