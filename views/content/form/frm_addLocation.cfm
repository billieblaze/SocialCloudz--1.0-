<cfoutput>
<cfscript>
contentType = event.getvalue('contentType');
</cfscript>
<cfparam name="rc.area" default="">
<cfparam name="rc.venue" default="">
<cfparam name="rc.address" default="">
<cfparam name="rc.city" default="">
<cfparam name="rc.state" default="">
<cfparam name="rc.creator" default="">
<cfparam name="rc.latitude" default="">
<cfparam name="rc.longitude" default="">
<cfparam name="rc.country" default="">
<cfparam name="rc.website" default="">
<cfparam name="rc.phone" default="">
<cfparam name="rc.zipcode" default="">
<div class="ui-widget">
	<div class="ui-widget-header">Location</div>
    <div class="ui-widget-content" align="Center">
    <div align="left" class="small">
	   <cfif contentType neq 'property'>
	   Name<BR /><input name="venue" value="#rc.venue#"  size="33"><BR /><BR />
	   </cfif>
		<cfif (contentType eq 'Restaurant' and listfind('3,177',request.community.communityid)) >
		Neighborhood<BR>
		<cfset neighborhoodlist = 'Crabtree Valley Mall,Cameron Village,Glenwood South,Seaboard Station,Hillsborough Street,Warehouse District,Downtown,Moore Square,North Hills Mall,Brier Creek,North Raleigh,Brennan Station'>
		<select name="area">
			<cfloop list="#neighborhoodlist#" index="i">
				<option value="#i#" <cfif i eq rc.area>selected</cfif>>#i#</option>
			</cfloop>
		</select><BR><BR>
		
		</cfif>
	Address<BR><input name="address" value="#rc.address#" size="33"><BR><BR>		
City / State<br />  <cfmodule template="/customTags/location.cfm" city='#rc.city#' state='#rc.state#' country='#rc.country#' latitude='#rc.latitude#' longitude='#rc.longitude#'><BR /><BR />
Zipcode<BR><input name="zipcode" value="#rc.zipcode#" size="10"><BR><BR>
<cfif contentType neq 'property'>
       Website<BR>
	<input name="website" value="#rc.website#" size="33"><BR><BR>
	 <cfif contentType eq 'restaurant'>
      Yelp URL<BR>
	<input name="yelp" value="#application.content.getAttribute(rc.q_content.attribs, 'yelp')#" size="33"><BR><BR>
	</cfif>
       Phone<BR>
<input name="phone" value="#rc.phone#" size="33"><BR><BR>
</cfif>
    </div>
    </div>
</div>
</cfoutput>