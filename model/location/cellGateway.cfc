<cfcomponent>
	<cffunction name="init" returntype="location" access="public" output="false">
		<cfargument name="datasource">
        <cfset variables.datasource = arguments.datasource>
        <cfreturn this />
	</cffunction> 
	<cffunction name="getCellularProviders">
		<cfset var providers = ''>
 		<cfquery datasource="#variables.datasource#" name="providers">
			SELECT     * from cellprovider
	    </cfquery>
		<cfreturn providers>
	</cffunction>

    <cffunction name="cellProviderList" access="public">
    	<cfargument name="value" default="">
	   	<cfscript> 
   			var providers = this.getCellularProviders();
		</cfscript>
       	<cfoutput>
			<select id="cellprovider" name="cellprovider">
	        	<option value="0">None</option>
				<cfloop query="Providers">
	    	        <option value="#providers.id#" <cfif providers.id eq arguments.value>selected</cfif>>#company#</option>
	            </cfloop>
	        </select> 
      	</cfoutput>
    </cffunction>
</cfcomponent>