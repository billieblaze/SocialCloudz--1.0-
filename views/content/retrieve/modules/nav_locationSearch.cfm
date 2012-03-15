<cfscript>
categories = application.content.category.list(contentType=rc.contentType, hasEntries= 0);
</cfscript>

<cfparam name="rc.search" default="">
<cfparam name="rc.categoryID" default="">
<cfparam name="rc.location" default="City / State">
<cfparam name="rc.city" default="">
<cfparam name="rc.state" default="">
<cfparam name="rc.zipcode" default="">
<cfparam name="rc.latitude" default="">
<cfparam name="rc.longitude" default="">
<cfparam name="rc.country" default="">
<cfparam name="rc.radius" default="">
<cfparam name="rc.subtitle" default="">

<cfif isdefined('rc.search')>
	<cfset rc.search = rc.search>
</cfif>

<cfif isdefined('rc.location')>
	<cfset rc.location = rc.location>
</cfif>

<cfif isdefined('rc.city')>
	<cfset rc.city = rc.city>
</cfif>

<cfif isdefined('rc.state')>
	<cfset rc.state = rc.state>
</cfif>

<cfif isdefined('rc.zipcode')>
	<cfset rc.zipcode = rc.zipcode>
</cfif>

<cfif isdefined('rc.latitude')>
	<cfset rc.latitude = rc.latitude>
</cfif>

<cfif isdefined('rc.longitude')>
	<cfset rc.longitude = rc.longitude>
</cfif>

<cfif isdefined('rc.country')>
	<cfset rc.country = rc.country>
</cfif>

<cfif isdefined('rc.radius')>
	<cfset rc.radius = rc.radius>
</cfif>
<cfif isdefined('rc.categoryID')>
	<cfset rc.categoryID = rc.categoryID>
</cfif>
<cfoutput>

    <form action="/index.cfm/content/#rc.contentType#" method="get">

		Keyword: <input type="text" name="search" value="#rc.search#"><BR /><BR />
		<CFIF request.community.communityid EQ '251'>
		Position: <select name="subtitle"  class="normalHelp">
			<option value="">All</option>
			<option value="Accounting" <cfif rc.subtitle eq 'Accounting'>selected</cfif>>Accounting</option>
		    <option value="Administrative Assistant" <cfif rc.subtitle eq 'Administrative Assistant'>selected</cfif>>Administrative Assistant</option>
		    <option value="Branch Manager" <cfif rc.subtitle eq 'Branch Manager'>selected</cfif>>Branch Manager</option>
		    <option value="Business Manager" <cfif rc.subtitle eq 'Business Manager'>selected</cfif>>Business Manager</option>
		    <option value="Closer" <cfif rc.subtitle eq 'Closer'>selected</cfif>>Closer</option>
		    <option value="Compliance Officer" <cfif rc.subtitle eq 'Compliance Officer'>selected</cfif>>Compliance Officer</option>
		    <option value="Corporate and Credit Union Partnering" <cfif rc.subtitle eq 'Corporate and Credit Union Partnering'>selected</cfif>>Corporate and Credit Union Partnering</option>
		    <option value="Correspondent Operations" <cfif rc.subtitle eq 'Correspondent Operations'>selected</cfif>>Correspondent Operations</option>		   
		    <option value="Escrow Specialist" <cfif rc.subtitle eq 'Escrow Specialist'>selected</cfif>>Escrow Specialist</option>
		    <option value="Executive Assistant" <cfif rc.subtitle eq 'Executive Assistant'>selected</cfif>>Executive Assistant</option>
		    <option value="Human Resources" <cfif rc.subtitle eq 'Human Resources'>selected</cfif>>Human Resources</option>
		    <option value="Information Security Officer" <cfif rc.subtitle eq 'Information Security Officer'>selected</cfif>>Information Security Officer</option>
		    <option value="Inside sales/telemarketing" <cfif rc.subtitle eq 'Inside sales/telemarketing'>selected</cfif>>Inside sales/telemarketing</option>
		   	<option value="Loan Officer Assistant" <cfif rc.subtitle eq 'Loan Officer Assistant'>selected</cfif>>Loan Officer Assistant</option>
		    <option value="Marketing" <cfif rc.subtitle eq 'Marketing'>selected</cfif>>Marketing</option>
		    <option value="Mortgage Banker" <cfif rc.subtitle eq 'Mortgage Banker'>selected</cfif>>Mortgage Banker</option>
		    <option value="Mortgage Broker" <cfif rc.subtitle eq 'Mortgage Broker'>selected</cfif>>Mortgage Broker</option>
		    <option value="Mortgage Loan Officer [MLO]" <cfif rc.subtitle eq 'Mortgage Loan Officer [MLO]'>selected</cfif>>Mortgage Loan Officer [MLO]</option>
		    <option value="Open a Net Branch" <cfif rc.subtitle eq 'Open a Net Branch'>selected</cfif>>Open a Net Branch</option>
		    <option value="Operations Manager" <cfif rc.subtitle eq 'Operations Manager'>selected</cfif>>Operations Manager</option>
		    <option value="Post Closing Auditor" <cfif rc.subtitle eq 'Post Closing Auditor'>selected</cfif>>Post Closing Auditor</option>
		    <option value="Processor" <cfif rc.subtitle eq 'Processor'>selected</cfif>>Processor</option>
		    <option value="Quality Control Manager" <cfif rc.subtitle eq 'Quality Control Manager'>selected</cfif>>Quality Control Manager</option>
		    <option value="Receptionist" <cfif rc.subtitle eq 'Receptionist'>selected</cfif>>Receptionist</option>
		    <option value="Regional Manager" <cfif rc.subtitle eq 'Regional Manager'>selected</cfif>>Regional Manager</option>
  		    <option value="Retail Operations" <cfif rc.subtitle eq 'Retail Operations'>selected</cfif>>Retail Operations</option>
		    <option value="Retail Sales" <cfif rc.subtitle eq 'Retail Sales'>selected</cfif>>Retail Sales</option>
		    <option value="Sales Manager" <cfif rc.subtitle eq 'Sales Manager'>selected</cfif>>Sales Manager</option>
		    <option value="Technology" <cfif rc.subtitle eq 'Technology'>selected</cfif>>Technology</option>
		    <option value="Underwriter" <cfif rc.subtitle eq 'Underwriter'>selected</cfif>>Underwriter</option>
		    <option value="VA Underwriter" <cfif rc.subtitle eq 'VA Underwriter'>selected</cfif>>VA Underwriter</option>
		    <option value="Web Design" <cfif rc.subtitle eq 'Web Design'>selected</cfif>>Web Design</option>
		    <option value="Wholesale Acct Exec" <cfif rc.subtitle eq 'Wholesale Acct Exec'>selected</cfif>>Wholesale Acct Exec</option>
		    <option value="Wholesale Management" <cfif rc.subtitle eq 'Wholesale Management'>selected</cfif>>Wholesale Management</option>
		    <option value="Wholesale Operations" <cfif rc.subtitle eq 'Wholesale Operations'>selected</cfif>>Wholesale Operations</option>
		    <option value="Wholesale Sales" <cfif rc.subtitle eq 'Wholesale Salesgy'>selected</cfif>>Wholesale Sales</option>
		</select>
		<BR /><BR />
		</cfif>
        <cfif categories.recordcount gt 0>
		Category: <select name="categoryID">
        	<option value="" <cfif rc.categoryID eq ''>selected</cfif>>Any</option>
            <cfloop query="categories">
            	<option value="#categories.ID#" <cfif rc.categoryID eq categories.ID>selected</cfif>>#categories.category#</option>
            </cfloop>
        </select>
        <BR /><BR />
        </cfif>
        Within <select name="radius">
        <option value="" <cfif rc.radius eq ''>selected</cfif>>Any</option>
        <option value="25" <cfif rc.radius eq 25>selected</cfif>>25</option> 
        <option value="50" <cfif rc.radius eq 50>selected</cfif>>50</option> 
        <option value="100" <cfif rc.radius eq 100>selected</cfif>>100</option> 
        <option value="500" <cfif rc.radius eq 500>selected</cfif>>500</option>
        <option value="1000" <cfif rc.radius eq 1000>selected</cfif>>1000</option>
        <option value="2500" <cfif rc.radius eq 2500>selected</cfif>>2500</option> 
        </select> Miles  <BR />
        of 
      <cfmodule template="/customTags/location.cfm" city='#rc.city#' state='#rc.state#' country='#rc.country#' latitude='#rc.latitude#' longitude='#rc.longitude#'>
        
        <BR />
	<input type="submit" value="Search" class="button">
</form>



<cfif rc.contentType neq 'restaurant'>
	<CFIF request.community.communityid NEQ '251'>
	<br><br>
    <form action="/#rc.contentType#/main" method="get">
	
		State: 
		<cfmodule template="/customTags/state.cfm" selectName="state" value=""/>
	
		<input type="submit" value="Search">
		</form>
		<BR>
	</cfif>
</cfif>
</cfoutput>