<cfoutput>

		<!--- DISPLAY THE SORTING DROPDOWNS --->
		<cfif rc.contentFilter.displaySorting eq 1>
   		<cfscript>
			sort = event.getvalue('sort','dateCreated');
			sortDirection = event.getvalue('sortDirection','desc');
		</cfscript>
		<hr>
	      <form action="/index.cfm/content/#contentType#" method="get">
	        <span class="small">Sort By:</span><br />
	        <select name="sort" class="xsmall">
	       	   <cfif event.getvalue('contentType') eq 'event'>
				<option value="startDate" <cfif sort eq 'startDate'>selecteD</cfif>>Start Date</option>		
				<cfelse>
				<option value="publishDate" <cfif sort eq 'publishDate'>selecteD</cfif>>Date</option>
				</cfif>
	          <option value="title" <cfif sort eq 'title'>selecteD</cfif>>Alphabetical</option>
	          <option value="c.memberid" <cfif sort eq 'c.memberid'>selecteD</cfif>>Member</option>
	          <!--- If comments or rating allowed --->
	          <option value="commentCount" <cfif sort eq 'commentcount'>selecteD</cfif>>Comments</option>
	          <option value="ratingAverage" <cfif sort eq 'ratingaverage'>selecteD</cfif>>Rating</option>
	          <option value="state" <cfif sort eq 'state'>selecteD</cfif>>State</option>
	          <option value="city" <cfif sort eq 'city'>selecteD</cfif>>City</option>
	        </select><br>
	        <select name="sortDirection" class="xsmall">
	          <option value="asc" <cfif sortDirection eq 'asc'>selected</cfif>>asc</option>
	          <option value="desc"  <cfif sortDirection eq 'desc'>selected</cfif>>des</option>
	        </select><br>
	        <input type="submit" value="Sort" class="xsmall button" />
	      </form>
	</cfif>
	<br style="clear:both">
	<br>
</cfoutput>