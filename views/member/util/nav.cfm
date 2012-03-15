<cfset title = application.cms.settings.check('Title')> 
<cfparam name="rc.location" default="City / State">
<cfparam name="rc.city" default="">
<cfparam name="rc.state" default="">
<cfparam name="rc.zipcode" default="">
<cfparam name="rc.latitude" default="">
<cfparam name="rc.longitude" default="">
<cfparam name="rc.country" default="US">
<cfparam name="rc.radius" default="">
<cfparam name="rc.gender" default="">
<cfparam name="rc.age1" default="">
<cfparam name="rc.age2" default="">
<cfparam name="rc.location" default="">

<cfoutput>
  <div  class="mod">
    <div class="hd">Search #title#</div>
    <div class="bd">
      <form action="/" method="get">
		<input type="hidden" name="profileType" value="#event.getValue('profileType','')#">   
	 	<input type="hidden" name="event" value="member.util.list">
        Username:
        <input type="text" name="search">
        <BR />
        <BR />
		State: <cfmodule template="/customTags/state.cfm" selectname="stateSearch" value="#event.getValue('stateSearch','')#"/>
		<br />
		<br />
        Within
        <select name="radius">
          <option value="" <cfif rc.radius eq ''>selected</cfif>>Any</option>
          <option value="25" <cfif rc.radius eq 25>selected</cfif>>25</option>
          <option value="50" <cfif rc.radius eq 50>selected</cfif>>50</option>
          <option value="100" <cfif rc.radius eq 100>selected</cfif>>100</option>
          <option value="500" <cfif rc.radius eq 500>selected</cfif>>500</option>
          <option value="1000" <cfif rc.radius eq 1000>selected</cfif>>1000</option>
          <option value="2500" <cfif rc.radius eq 2500>selected</cfif>>2500</option>
        </select>
        Miles <BR />
        of 
		<cfmodule template="/customTags/location.cfm" city='#rc.city#' state='#rc.state#' country='#rc.country#' latitude='#rc.latitude#' longitude='#rc.longitude#'>
		<BR />
        <BR />
		
		<!--- TODO: make setting to turn on and off certain search options for members --->
		<cfif request.community.communityID neq '251'>
        Gender:
        <select name="gender">
          <option value="" <cfif rc.gender eq ''>selected</cfif>>Any</option>
          <option value="1" <cfif rc.gender eq '1'>selected</cfif>>Male</option>
          <option value="2" <cfif rc.gender eq '2'>selected</cfif>>Female</option>
        </select>
        <BR />
        <BR />
        Age:
        <select name="age1">
          <option value="" <cfif rc.age1 eq ''>selected</cfif>>Any</option>
          <cfloop from="15" to="100" index="i">
            <option value="#i#" <cfif rc.age1 eq i>selected</cfif>>#i#</option>
          </cfloop>
        </select>
        to
        <select name="age2">
          <option value="" <cfif rc.age2 eq ''>selected</cfif>>Any</option>
          <cfloop from="15" to="100" index="i">
            <option value="#i#" <cfif rc.age2 eq i>selected</cfif>>#i#</option>
          </cfloop>
        </select>
		<Cfelse>
			<!--- MMJ ONLY - PERSONAL USERS --->

			<cfif event.getValue('profileType','') eq 1>
				Qualifications:<br>
				<input type="hidden" name="QuestionID" value="168">
				<select name="questionValue">
					<option value="">Select One</option>
					<option value="Branch Manager" <Cfif event.getValue('questionValue','') eq 'Branch Manager'>selected</cfif>>Branch Manager</option>
				<select>
				<br /><br />
			</cfif>
		
		</cfif>
        <input type="submit" value="Search">
      </form>
    </div>
    <div class="ft"></div>
  </div>
</cfoutput>