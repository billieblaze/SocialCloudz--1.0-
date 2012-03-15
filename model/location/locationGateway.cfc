<cfcomponent extends="../baseGateway">  

	<cffunction name="getCountryList">
		<cfset var getCountries = ''>
	   <cfquery datasource="#this.datasource#" name="getCountries">
            select distinct countryname as country, countrycode from ips
            order by countryname
            </cfquery>
		<cfreturn getCountries>
	</cffunction>	

	<cffunction name="getStateList">
		<cfset var getStates = ''>
	   <cfquery datasource="#this.datasource#" name="getStates">
            select state, abbr from state
            order by state
            </cfquery>
		<cfreturn getStates>
	</cffunction>	
    
	

</cfcomponent>