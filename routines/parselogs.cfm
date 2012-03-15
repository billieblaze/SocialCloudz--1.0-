<cfsetting showdebugoutput="no">
<!--- Parse Weblog to DB --->

<!---
24.130.87.138 - - [13/Dec/2008:01:52:43 -0800] assets.socialcloudz.com GET /assets/css/skin.css HTTP/1.1 "200" 6225 "http://dev.socialcloudz.com/index.cfm" "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.4) Gecko/2008102920 Firefox/3.0.4" "-"
--->

<cftry>
<cffile action="read" file="/var/log/nginx/access.log.1" variable="logData">
<cfoutput>

<cfloop index="rc" list="#logData#" delimiters="#chr(13)##chr(10)#">

  <CFSET Value = 0> 
                <cfloop index="id" list="#rc#" delimiters="#chr(32)#">

                <CFSET FirstValue = "#id#">
                <CFSET Value = Value + 1>

				<CFIF Value is 1>
                    <cfset data.ip = "#FirstValue#">
                <CFELSEIF Value is 2>

                    <cfset data.dateEntered = "#replace(FirstValue,'[','')#">
			
			
					 	
					<cfset data.dateEntered = "#replace(data.dateEntered,':',' ')#">
					<cfset data.dateEntered = "#createodbcdatetime(now())#">
								
					<cfset data.dateEntered = parsedatetime(data.dateEntered)>
							
                <CFELSEIF Value is 4>
                    <cfset data.host = "#FirstValue#">
                <CFELSEIF Value is 7>
                    <cfset data.file = "#FirstValue#">
                <CFELSEIF Value is 9>
                <cfif firstvalue eq '-' or firstvalue eq '"-"'>
					<cfset data.size = 0>
				<cfelse>
                    <cfset data.size = "#FirstValue#">
				</cfif>
                <CFELSEIF Value is 10>
                	<cfset data.referrer = "#replace(FirstValue,'"','', 'all')#">
                <CFELSEIF Value is 11>
                	<cfset data.browser = "#replace(FirstValue,'"','', 'all')#">    
             <CFELSEIF Value gt 11>
                    <cfset data.browser = data.browser &' '& #replace(FirstValue,'"','', 'all')#>
	
            </cfif>
		
        </cfloop>

	<cfset	application.server.webserver.save(data)>
		
</cfloop>
</cfoutput> 

<cfcatch>
	<cfsavecontent variable="catchData">
		<cfdump var="#cfcatch#">
	</cfsavecontent>
	<cffile action="write" file="#expandPath('/logs')#/parseLogFail.htm" nameconflict="overwrite" output="#catchData#" >
</cfcatch>
</cftry>

