<cfset column = application.dynamicGrid.column.get(grid = url.grid, pid = url.pid, field = url.field, view = url.view)>
<cfif column.recordcount eq 0>
	<cfset column = application.dynamicGrid.column.get(grid = url.grid, field = url.field, view = url.view)>
</cfif>
<cfsetting showdebugoutput="false">
<cfoutput>
<form action="/common/dynamicGrid/model/saveField.cfm" method="post" id="fieldForm">
	<input type="hidden" name="id" value="#column.id#">
	<input type="hidden" name="datasource" value="#url.datasource#">
	<input type="hidden" name="gridName" value="#url.grid#">
<!--- 	<input type="hidden" name="pid" value="#url.pid#"> --->
	<input type="hidden" name="name" value="#url.field#">
	<input type="hidden" name="viewName" value="#url.view#">
	<input type="hidden" name="hidden" value="#column.hidden#">
	<input type="hidden" name="colOrder" value="#column.colOrder#">
	<table>
		<tr>
			<td class="label">Label: </td><td><input type="text" name="label" value="#column.label#"></td>
		</tr>
		<tr>
			<td class="label">Width: </td><td><input type="text" name="width" id="width" value="#column.width#"></td>
		</tr>
		<tr>
			<td class="label">Classes: </td><td><input type="text" name="classes" value="#column.classes#"></td>
		</tr>
		<tr>
			<td class="label">Align: </td>
			<td>
				<select name='align'>
					<option value="left" <cfif column.align eq 'left'>selected</cfif>>Left</option>
					<option value="right" <cfif column.align eq 'right'>selected</cfif>>Right</option>
					<option value="center" <cfif column.align eq 'center'>selected</cfif>>Center</option>				
				</select>
			</td>
		</tr>
	
	<tr>
			<td class="label">Formatter: </td>
			<td>
				<input type="text" name="formatter" value="#column.formatter#">
				<!--- <select></select> --->
			</td>
		</tr>
		<tr>
			<td class="label">Index: </td><td><input type="checkbox" name="key" value="true" <cfif column.key eq 1>checked</cfif>></td>
		</tr>
		<tr>
			<td class="label">Hide From Dialog: </td><td><input type="checkbox" name="hidedlg" <cfif column.hidedlg eq 1>checked</cfif>></td>
		</tr>
		<tr>
				<td class="label">Searchable: </td><td><input type="checkbox" name="search" <cfif column.search eq 1>checked</cfif> value=1></td>
		</tr>
		<tr>
		<tr>
			<td class="label">Grouping - Summary Type: </td><td><input type="text" name="summaryType" id="summaryType" value="#column.summaryType#"></td>
		</tr>
		<tr>
			<td class="label">Grouping - Summary Template: </td><td><input type="text" name="summaryTpl" id="summaryTpl" value="#column.summaryTpl#"></td>
		</tr>

			<td class="label">Editable: </td><td><input type="checkbox" name="editable" value="true" <cfif column.editableBit eq 'true'>checked="true"</cfif> value=1></td>
		</tr>
		<tr>
			<td class="label">Edit Type: </td>
			<td>
				<select name="editType" >
					<option value="text" <cfif column.editType eq 'text'>selected</cfif>>Text</option>
					<option value="textarea" <cfif column.editType eq 'textarea'>selected</cfif>>Text Area</option>
					<option value="checkbox" <cfif column.editType eq 'checkbox'>selected</cfif>>Checkbox</option>
					<option value="select" <cfif column.editType eq 'select'>selected</cfif>>Select</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="label">Edit Options: </td><td><input type="text" name="editOptions"  value='#column.editOptions#'></td>
		</tr>
		
		<tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="Update"></td>
		</tr>
	</table>
</form>
<script type="text/javascript"> 
	 // bind 'myForm' and provide a simple callback function 
	 $('##fieldForm').ajaxForm(function(responseText) { 
		unloadGrid();
		loadGrid(grid, '#url.grid#', '#url.view#', dataURL, '', "##pager_"+grid, true);
		modalClose();		

		return false;
	 }); 
</script> 

</cfoutput>