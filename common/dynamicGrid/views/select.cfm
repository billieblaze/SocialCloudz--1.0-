<cfsetting showdebugoutput="false">
<cfparam name="url.grid" default="technology">
<cfparam name="url.view" default="default">
<cfset getViews = application.dynamicGrid.getViewList(grid=url.grid, pid=url.pid)>

<cfoutput>
	<div class="pad10" align="center">
        <select name="view" id="view" onchange="SendView();">
            <cfloop list="#getViews#" index="item">
                <option value="#URLENCODEDFORMAT(item)#"<cfif item EQ url.view> selected </cfif> >#item#</option>
            </cfloop>
        </select>
	</div>
</cfoutput>