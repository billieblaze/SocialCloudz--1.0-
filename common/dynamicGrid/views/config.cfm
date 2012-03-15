<cfsetting showdebugoutput="false">
<cfparam name="url.grid" default="">

<cfset getViews = application.dynamicGrid.getViewList(url.grid, url.pid)>

<cfoutput>
    <form action="">
	    <input type="hidden" name="grid" value="#url.grid#" />
	    <input type="hidden" name="cmJSON" value="" />
		<table width="100%" align="center" border="0" cellspacing="0" cellpadding="0" style="padding:10px 0px 7px 0px;">
		    <tr align="center">
		        <td width="1%" nowrap="nowrap" class="copy">Select a View to Update or Delete: 
		            <select name="view" id="view">
		                <option value="">Select a view...</option>
		                <cfloop list="#getViews#" index="view_name">
		                    <option value="#view_name#">#view_name#</option>
		                </cfloop>
		            </select>
		        </td>
		    </tr>
		    <tr align="center">
		    	<td>&nbsp;</td>
		    </tr>
		    <tr align="center">
		    	<td width="1%" nowrap="nowrap" class="copy">Or enter a new view name: 
		    		<input type="text" name="new_view" id="new_view" />
		        </td>
		    </tr>
		    <tr align="center">
		    	<td>&nbsp;</td>
		    </tr>
		    <tr align="center">
		    	<td width="1%" nowrap="nowrap" class="copy">
					<cfif url.isAdmin eq 1>
	
		            	<input type="button" name="btnSave" value="Save Grid Default" class="button" onclick="saveView('#url.grid#','default','','', '#url.datasource#','#url.isAdmin#')"/>
			            &nbsp;&nbsp;
	
					</cfif>

		            <input type="button" name="btnSave" value="Save/Update" class="button" onclick="saveView('#url.grid#',$('##view').val(),$('##new_view').val(),'#url.pid#', '#url.datasource#','#url.isAdmin#')"/>
		            &nbsp;&nbsp;
		            <input type="button" name="btnClose" value="Cancel" class="button" onClick="modalClose();" />
		  			&nbsp;&nbsp;
		    		<input type="button" name="btnDelete" value="Delete" class="button" onClick="deleteView('#url.grid#',$('##view').val(),'#url.pid#', '#url.datasource#');" />
		        </td>
		    </tr>
		</table>
    </form>
   </cfoutput>