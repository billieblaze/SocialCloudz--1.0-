<cfcomponent extends="/model/baseGateway" output="false">
 	<cffunction name="get">
		<cfargument name="gridName">
		<cfreturn super.get('dynamicGrid', arguments)>				
	</cffunction>
	
	<cffunction name="save">
		<cfargument name="datastruct">
		<Cfscript>
			return super.save('dynamicGrid', arguments.datastruct);
		</Cfscript>
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="gridName">
		<cfargument name="applicationName">
		<Cfscript>
			return super.delete('dynamicGrid', arguments);
		</Cfscript>			
	</cffunction>

</cfcomponent>