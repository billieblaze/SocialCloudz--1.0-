<cfparam name="rc.timespan" default="1">
<cfparam name="rc.timepart" default="h">

<cfset whoSOnData ="#application.statistics.visitor.get(argumentcollection = form)#">
<cfset whosonData = application.community.joincommunitydata(whosondata)>
<cfset whosonData = application.members.joinmemberdata(whosondata)>

<cfset totalmembercnt = 0>
<cfset totalguestcnt = 0>
<cfset totalbotcnt = 0>

<cfoutput>
	<form action="#event.buildLink('app.admin.sessions')#" method="post" id="sessionForm">
	Past 
			<select name="timespan">
			
				<cfloop from="1" to="24" index="i">
					<option value="#i#" <cfif rc.timespan eq i>selected</cfif>>#i#</option>
				</cfloop>
	
			</select>
			<select name="timepart">
				<option value="h" <cfif rc.timepart eq 'h'>selected</cfif>>hour</option>
				<option value="d" <cfif rc.timepart eq 'd'>selected</cfif>>day</option>
				<option value="m" <cfif rc.timepart eq 'm'>selected</cfif>>months</option>
				<option value="y" <cfif rc.timepart eq 'y'>selected</cfif>>years</option>
			</select>
				
		<input type="submit" value="update">
	</form>
</cfoutput>
<cfsavecontent variable="lastTwentyFourHours">


		<cfoutput query="whosonData" group="site">
		
			<cfset membercnt = 0>
			<cfset guestcnt = 0>
			<cfset botcnt = 0>
			<table width="100%" border="1">
				<TR>
					<TD>Active</TD>
			        <TD>Page Count</TD>
			        <TD>Session Details</TD> 
					<TD>Browser Details</TD>
				
				</TR>		
			<cfsaveContent variable="siteData">
				
			<cfoutput>
					<TR>
				    	<TD valign="top" class="small">
							<!--- is active on site? --->
				        	<cfif isNumeric(memberID) and memberID neq 0>
				            	<cfset membercnt = membercnt + 1>
				            	Member: #whosondata.username#
				            	<cfif memberid neq ''>
					            	<BR />MemberID: #memberID#<BR>
								</cfif>
				            <cfelseif whosondata.isbot eq 1>
						    	<cfset botcnt = botcnt + 1> 
						    	BOT
				            <cfelse>
				            	<cfset guestcnt = guestcnt + 1>            
				            	Guest<BR>
				            </cfif>

							<cfif whosondata.dateUpdated lt dateadd('h',-1, now())>
					        	Online
							</cfif>
							
				        </TD>
				        <TD valign="top" class="small">#pageCount#</TD> 
				    	<TD valign="top" class="small">
					    	Entered: #dateformat(dateEntered, request.community.dateformat)# -- <a href="http://#subdomain#.socialcloudz.com/?#firstpage#" class="small" target="_blank">#firstpage#</a><BR />
				        	Last Page: #dateformat(dateUpdated, request.community.dateformat)# -- <a href="http://#subdomain#.socialcloudz.com/?#lastpage#" class="small" target="_blank">#lastpage#</a><BR>
				        </TD>
						<TD valign="top" class="small">
							IP Address: #ipaddress#  ---
							Location: #city# - #region# - #countrycode#<BR>
							#browser#<BR />
							
						</TD>
				
					</TR> 
			
		
		
			</cfoutput>
			</table>
			</cfsavecontent>
			<cfsaveContent variable="siteheader">
			<div>
				<a href="http://#subdomain#.socialcloudz.com">#site#</a> (ID = #communityID# )  -- Members:  #memberCnt# -- Guests: #guestCnt#  -- Bots: #botCnt#<BR>
			</div>
			</cfsavecontent>
			#siteHeader#
			#siteData#	
			<BR><BR>	
				    <cfset totalmembercnt = totalmembercnt + membercnt>
				<cfset totalguestcnt = totalguestcnt + guestcnt>
				<cfset totalbotcnt = totalbotcnt + botcnt>
		</cfoutput>
</cfsavecontent>

<cfoutput>
	
	Sessions: #whosondata.recordcount#<BR />
	Bots: #totalbotcnt#<BR />
	Guests: #totalguestcnt#<BR />
	Members: #totalmembercnt#<BR />
	<BR><BR>
	Current Time: #dateformat(now(), request.community.dateformat)#
	#lastTwentyFourHours#
</cfoutput>
<script>
        // bind 'myForm' and provide a simple callback function 
        $('#sessionForm').ajaxForm(function(responseText) { 
			$('#sessionForm').parent().html(responseText);            	        	
	     }); 
</script>