<cftry>
	<cffeed action="read" source='http://www.google.com/ig/api?weather=#request.session.location.cityName#,#request.session.location.regionName#' name='weather'/>
	<cfoutput>
	Weather Forecast for #request.session.location.cityName#, #request.session.location.regionName#<BR><BR>
	<table>
		<TR>
			<TD>
				<img src='http://www.google.com/ig#weather.xml_api_reply.weather.forecast_conditions[1].icon.data#'>
			</td>
			<TD>
				Condition: #weather.xml_api_reply.weather.forecast_conditions[1].condition.data#<BR>
				High: #weather.xml_api_reply.weather.forecast_conditions[1].high.data#<BR>
				Low: #weather.xml_api_reply.weather.forecast_conditions[1].low.data#<BR>
			</TD>
		</tr>
	</table>
	</cfoutput>
<cfcatch>Forecast not found</cfcatch>
</cftry>