<cfsetting showdebugoutput="false">

<cfscript>
	request.layout.config.columns = 2;
	request.layout.config.template = 3;
	request.layout.config.right = '';
	request.layout.config.menu = 'Top';
	request.layout.config.width = application.community.settings.getValue('page_width');
	request.layout.config.widthCustom = application.community.settings.getValue('page_widthCustom');
    structappend(request.layout.config,event.getvalue('layoutconfig'),true);
</cfscript> 

<cfoutput>
<div style="height:420px; width:275px ">
<form id="layoutForm" action="#event.buildLink('cms.layout.save')#" method="post" class="form blackText ajaxform"> 
	<input type="hidden" name="page" value="#rc.page#">
   	<fieldset style="border:1px solid gray;">
	<legend>Global Layout</legend>
	<label for="width" class="first">
	   	Page Width
        <select name="page_width" id="pagewidth" onchange="layoutCustomWidth();">
      	<option value="doc" <cfif request.layout.config.width eq 'doc'>selected</cfif>>750px</option>
      	<option value="doc2" <cfif request.layout.config.width eq 'doc2'>selected</cfif>>950px</option>
      	<option value="doc4" <cfif request.layout.config.width eq 'doc4'>selected</cfif>>974px</option>
      	<option value="doc3" <cfif request.layout.config.width eq 'doc3'>selected</cfif>>100%</option>
		<option value="custom-doc" <cfif request.layout.config.width eq 'custom-doc'>selected</cfif>>Custom</option>
	    </select>
	</label>
	<div id="page_widthCustom" <cfif request.layout.config.width neq 'custom-doc'>style="display:none;"</cfif>>
	<label >
	  	Custom Width
	    <input type="text" name="page_widthCustom" value="#request.layout.config.widthCustom#" size="4">
	</label>
	</div>
	</fieldset>
	    <fieldset style="border:1px solid gray;">
	   <legend>Layout for #request.page.id#</legend>

		<div id="oneColumn" align="center">
		<table border="1" width="210" height="100" bordercolor="silver">
			<TR>
				<TD colspan="2">Single</td>
			</tr>
		</table>
		</div>
		<div id="twoColumn" align="center">
		<table border="1" width="210" height="100" bordercolor="silver">
			<TR>
				<TD colspan="2" height="10">T</td>
			</tr>
			<TR>
				<TD class="quarter layoutPreviewLeft">L</TD>
				<TD class="threeQuarter layoutPreviewCenter">R</td>
			<TR>
				<TD colspan="2" height="10">B</td>
			</tr>
		</table>
		</div>
		<div id="threeColumn" align="center">
		<table border="1" width="210" height="100" bordercolor="silver">
			<TR>
				<TD colspan="3" height="10">T</td>
			</tr>
			<TR>
				<TD class="quarter layoutPreviewLeft">L</TD>
				<TD class="quarterHalf layoutPreviewCenter">C</tD>
				<TD class="quarterHalf layoutPreviewRight">R</td>
			<TR>
				<TD colspan="3" height="10">B</td>
			</tr>
		</table>
	</div>
    <label for="columns" class="first">
   	Columns
        <select name="columns" id="columns"  onChange="changeColumns(this.value);">
      	<option value="1" <cfif request.layout.config.columns eq 1>selected</cfif>>1</option>
      	<option value="2" <cfif request.layout.config.columns eq 2>selected</cfif>>2</option>
      	<option value="3" <cfif request.layout.config.columns eq 3>selected</cfif>>3</option>
	    </select>
     </label>
	<div id="templateContainer">
	     <label for="template">
	     	Layout
	        <select name="template" id="template" onchange="changeTemplate(this.value);">
	        <option value="1" <cfif request.layout.config.template eq 1>selected</cfif>>160px - Left</option>
	        <option value="2" <cfif request.layout.config.template eq 2>selected</cfif>>180px - Left</option>
	        <option value="3" <cfif request.layout.config.template eq 3>selected</cfif>>300px - Left</option>
	        <option value="4" <cfif request.layout.config.template eq 4>selected</cfif>>180px - Right</option>
	        <option value="5" <cfif request.layout.config.template eq 5>selected</cfif>>240px - Right</option>
	        <option value="6" <cfif request.layout.config.template eq 6>selected</cfif>>300px - Right</option>
	        </select>
	     </label>
	</div>
	<div id="rightContainer">
	     <label for="right">
	        Third Column
	        <select name="right" id="right" onchange="changeThird(this.value);">
	        <option value="" <cfif request.layout.config.right eq ''>selected</cfif>>1/2 - 1/2</option>
	        <option value="c" <cfif request.layout.config.right eq 'c'>selected</cfif>>2/3 - 1/3</option>
	        <option value="d" <cfif request.layout.config.right eq 'd'>selected</cfif>>1/3 - 2/3</option>
	        <option value="e" <cfif request.layout.config.right eq 'e'>selected</cfif>>3/4 - 1/4</option>
	        <option value="f" <cfif request.layout.config.right eq 'f'>selected</cfif>>1/4 - 3/4</option>
	        </select>
	    </label>
	</div>
    </fieldset>
	<div align="center">
	 <input class="submit" type="submit" value="Update"><input class="submit" type="button" value="Cancel" onclick="location.href='#request.session.lastpage#';"/>
	</div>
</form>

</div>
</cfoutput>
<script>
	$.getScript('/scripts/layoutEditor.js');
</script>