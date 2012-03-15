    	<cfparam name="attributes.selectname" default="">
        <cfparam name="attributes.value" default="United States">
        
       	<cfscript> 
       		getcountries = application.location.gateway.getCountryList();
		</cfscript>
        
		<cfoutput> 
			<select id="#attributes.selectname#" name="#attributes.selectName#">
        		<option value="0">Select a Country</option>
				<cfloop query="getCountries">
		            <option value="#getCountries.countryCode#" <cfif getCountries.country eq attributes.value>selected</cfif>>#country#</option>
	            </cfloop>
	        </select>
        </cfoutput>

	
