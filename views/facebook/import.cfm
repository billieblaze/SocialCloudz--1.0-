<cfdump var='#rc.data#'><cfabort>
			<cfif arrayLen(rc.data) eq 0>
				You have not created any events on facebook
			<cfelse>
			<cfoutput>
				<cfloop from="1" to="#arrayLen(rc.data)#" index='i'>
					<a href="/index.cfm/content/form/event/0?import=#rc.data[i].id#">Import</a>	#rc.data[i].name# - 		#rc.data[i].location# - 		#rc.data[i].rsvp_status# - #rc.data[i].start_time#<br><br>
				</cfloop>
			</cfoutput>
			</cfif>