<cfscript>
categories = event.getvalue('communityCategories');
</cfscript>

<div class="mod">
	<div  class="hd">Categories</div>
	<div class="bd">
		<div style="0px 15px">
			<cfoutput query="categories">	
				<cfset thisCategoryCount = application.community.category.getCount(parentID = request.community.communityID, categoryID = id)>
				<cfif thisCategoryCount gt 0>
					<a href='/socialcloudz/directory?categoryID=#ID#' class="blackText">#category#</a> (#thisCategoryCount#)<BR>
				</cfif>
			</cfoutput>
		</div>
	</div>
	<div class="ft"></div>
</div>