<cfscript>
	getModule = qGetModules;

	if (getmodule.displaymember neq ''){
		variables.birthdate = application.members.gateway.get(memberID = getModule.displayMember).birthdate;
	} else{
		if (request.session.login eq 0)
		{ 	variables.birthdate = application.timezone.castFromServer(now(), application.community.settings.getValue('timezone'));} 
		else
		{ 	variables.birthdate = request.session.birthdate;}
	}

	sign = application.util.getZodiacSign(	variables.birthdate);

	switch (sign){
		case 'Aries':
			signNumber = 1;
			break;
		case 'Taurus':
			signNumber = 2;
			break;
		case 'Gemini':
			signNumber = 3;
			break;
		case 'Cancer':
			signNumber = 4;
			break;
		case 'Leo':
			signNumber = 5;
			break;
		case 'Virgo':
			signNumber = 6;
			break;
		case 'Libra':
			signNumber = 7;
			break;
		case 'Scorpio':
			signNumber = 8;
			break;
		case 'Sagittarius':
			signNumber = 9;
			break;
		case 'Capricorn':
			signNumber = 10;
			break;
		case 'Aquarius':
			signNumber = 11;
			break;
		case 'Pisces':
			signNumber = 12;
			break;
	}
</cfscript>

<cftry>
	<cffeed action="read" source='http://www.astrosage.com/rssfeeds/sign-rss.asp?sign=#signNumber#' name='Horoscope'/>
	
	<cfoutput>
		<table>
			<TR>
				<TD><img src='/images/#sign#.png'></td>
				<TD>
					#horoscope.item[1].title#<hr>
					#horoscope.item[1].description.value#
				</td>
			</tr>
		</table>
	</cfoutput>
	<cfcatch>Feed Error</cfcatch>
</cftry>