<cfif thisTag.ExecutionMode EQ "start">
    	<cfparam name="attributes.selectname" default="">   
        <cfparam name="attributes.value" default="">
         
       	<cfscript> 
       		getStates = application.location.gateway.getstateList();
		</cfscript>
           <cfoutput> 
			<select id="#attributes.selectname#" name="#attributes.selectName#">
	        	<option value="0">..</option>
				<cfloop query="getStates">
		            <option value="#getStates.abbr#" <cfif getStates.abbr eq attributes.value>selected</cfif>>#abbr#</option>
	            </cfloop>
    	    </select>
        </cfoutput>
</cfif>