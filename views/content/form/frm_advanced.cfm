<cfparam name="rc.rate" default="1">
<cfparam name="rc.download" default="1">
<cfparam name="rc.private" default="1">
<cfparam name="rc.download" default="1"> 
<cfparam name="rc.publishdate" default="#now()#"> 
<cfparam name="rc.approved" default="1">
<cfif rc.publishdate eq ''>
	<cfset rc.publishdate = now()>
</cfif>
<cfset getMembers = application.members.gateway.list()>
<script type="text/javascript">
 $(document).ready(function($) {
		$("#accordion").accordion({active: false, collapsible: true});
	});
</script>

<cfoutput>

<div class="ui-widget">
	<div class="ui-widget-header">Advanced Options</div>
	<div class="ui-widget-content">
		<div id="accordion" style="background-color:transparent;">
		<h3 class="blackText"><a href="##">Publishing / Approval</a></h3>
		<div>
            <cfif request.session.accesslevel gte 10>
		   	Post as another Member<BR>
	       	<select name="displayMember">
				<cfloop query="getmembers">
				<option value="#getmembers.memberID#" <cfif rc.memberID eq getmembers.memberID>selected</cfif>>#getmembers.username#</option>
				</cfloop>
			</select>
			<BR><BR>
			</cfif>
            Publish Date<BR>
			#application.form.calendar('publishDate', rc.publishdate, '100%')#<BR>
            <cfif request.session.accesslevel gte 10>
	            Approved <BR>
    	        <select name="approved"><option value="1" <cfif rc.approved eq 1>selected</cfif>>Yes</option><option value="0" <cfif rc.approved eq 0>selected</cfif>>No</option></select>
            <cfelse>
            	<input type="hidden" name="approved" value="#rc.approved#" />
            </cfif>
	</div>
		<h3 class="blackText"><a href="##">Communities</a></h3>
		<div style="padding:0px">


			<cfquery dbtype='query' name="getParents">
		select * from rc.myCommunities where parentID = 0 order by communityId asc
		</cfquery>
		<cfoutput>
		
			<div id="contentCommunityTabs">
				<ul>
					<cfloop query='getParents'>
						<li><a href="##communitytabs-#getparents.currentRow#">#getParents.site#</a></li>
					</cfloop>
				</ul>
				<cfloop query='getParents'>
					<cfquery dbtype='query' name="getChildren">
					select * from rc.myCommunities where parentID = #getParents.communityID#
					</cfquery>
					
				<div id="communitytabs-#getParents.currentRow#" style = "height: 150px; overflow: scroll">
				
					<table class="table oddeven">
						<tr>
							<td>
								<input type="checkbox" name="communityID" value='#getParents.communityID#' <Cfif listFind(rc.communityID,getParents.communityId) >checked</Cfif> >
							</td>
							<td>#getParents.site#</td>
						</tr>
					<cfloop query="getChildren">
						<tr>
							<td>
								<input type="checkbox" name="communityID" value='#getChildren.communityID#' <Cfif listFind(rc.communityID,getChildren.communityId) >checked</Cfif> >
							</td>
							<td>#getChildren.site#</td>
						</tr>
					</cfloop>
					</table>
				</div>
				</cfloop>
			</div>
		</cfoutput>
		<script>
			$( "##contentCommunityTabs" ).tabs();
		</script>
		</div>
	<h3 class="blackText"><a href="##">Access Settings</a></h3>
		<div style="padding:3px">
		<table class="small" width="100% ">
			<TR>
				<TD>View</TD>
		        <TD><select name="private">
					<option value="0" <cfif rc.private eq 0>selected</cfif>>Anyone</option>
					<cfif application.community.settings.getValue('friends') eq 1>
						<option value="1" <cfif rc.private eq 1>selected</cfif>>Friends</option>
					</cfif>
				</select></TD>
		    </TR>
		    <TR>
		        <TD>Comment</TD>
		        <TD>
		        <select name="comments">
					<option value="1" <cfif rc.comments eq 1>selected</cfif>>Yes</option>
					<option value="0" <cfif rc.comments eq 0>selected</cfif>>No</option>
				</select>
		        </TD>
			</TR>
		    <TR>
			    <TD>Rate</TD>
		        <TD><select name="rating">
					<option value="1" <cfif rc.rating eq 1>selected</cfif>>Yes</option>
					<option value="0" <cfif rc.rating eq 0>selected</cfif>>No</option>
				</select></TD>
		    </TR>
			<TR>
			   	<TD>Download</TD>
		        <TD>
		        <select name="download">
					<option value="1" <cfif rc.download eq 1>selected</cfif>>Yes</option>
					<option value="0" <cfif rc.download eq 0>selected</cfif>>No</option>
				</select>
		        </TD>
		    </TR>
		</table>  
		</div>
	</div>
</div>
</cfoutput>