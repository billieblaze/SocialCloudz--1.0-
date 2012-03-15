<cfscript>
contentCount= rc.contentModuleData.count;
		q_content = rc.contentModuleData.query;
</cfscript>
<cfoutput>

		<cfparam name="rc.month" default="#month(now())#">
		<cfparam name="rc.year" default="#year(now())#">
		<cfparam name="rc.today" default="#now()#">
		
		<cfset firstOfTheMonth = createDate(rc.year, rc.month, 1)>
		<cfset dow = dayofWeek(firstOfTheMonth)>
		<cfset pad = dow - 1>
		<cfset days = daysInMonth(rc.today)>
		<cfset counter = pad + 1>
		<cfif rc.month eq 1>
			<cfset prevMonth = 12>
			<cfset prevYear = rc.year - 1>
		<cfelse>
			<cfset prevMonth = rc.month - 1>
			<cfset prevYear = rc.year>
		</cfif>
		
		<cfif rc.month eq 12>
			<cfset nextMonth = 1>
			<cfset nextYear = rc.year + 1>
		<cfelse>
			<cfset nextMonth = rc.month + 1>
			<cfset nextYear = rc.year>
		</cfif>
		
		<div align="center">
		<a href="/index.cfm/content/event?month=#prevMonth#&year=#prevYear#"><<</a>
		#monthAsString(rc.month)# #rc.year#
		<a href="/index.cfm/content/event?month=#nextMonth#&year=#nextYear#">>></a>
		</div>
		<table border="1" width="100%" height="100%">
		   <tr>
		   <cfloop index="x" from="1" to="7">
		      <th align="center" class="small">#dayOfWeekAsString(x)#</th>
		   </cfloop>
		   </tr>
		
			<tr height="65">
			<cfif pad gt 0>
				<cfset lastMonth = dateAdd("m", -1, firstOfTheMonth)>
				<cfset daysInLastMonth = daysInMonth(lastMonth)>
				<cfloop index="x" from="#daysInLastMonth-pad+1#" to="#daysInLastMonth#">
					<td class="small offMonthCell" valign="top" style="background-color: silver"></td>
				</cfloop>
			</cfif>
		
			<cfloop index="x" from="1" to="#days#">
				<cfquery dbtype="query" name="getEvents">
				select * from q_content
				where month(startDate) = #rc.month#
				and day(startDate) = #x#
				and year(startDate) = #rc.year#
				</cfquery>
			   	<td valign="top" class="small" <cfif x eq day(rc.today)> bgcolor="yellow"</cfif>>
					#x#<br>
					<a href="/index.cfm/content/event/#getEvents.contentID#">#getEvents.title#</a><br>
				</td>
			   <cfset counter = counter + 1>
			   <cfif counter is 8>
				 </tr>
			      <cfif x lt days>
			         <cfset counter = 1>
			         <tr height="65">
			      </cfif>
			   </cfif>
			</cfloop>
			
		<cfif counter is not 8>
			<cfset endPad = 8 - counter>
			<cfloop index="x" from="1" to="#endPad#">
				<td class="small offMonthCell" valign="top" style="background-color: silver"></td>
			</cfloop>
		</cfif>
		</table>
	
</cfoutput>