<cfscript>
	sizes = application.advertising.getAdSizes();
	getModule = application.cms.modules.get(rc.id);
</cfscript>
<cfoutput>
	<form action="/index.cfm/cms/modules/update" method="post" class="form ajaxform">
<input type="hidden" name="id" value="#rc.id#">
Title: <input type="text" name="title" value="#getModule.title#" /><BR />

Size: <select name="thumbsize">
<cfloop query="sizes">
	<option value="#sizes.width#x#sizes.height#" <cfif getModule.thumbsize eq '#sizes.width#x#sizes.height#'>selected</cfif>>#sizes.width#x#sizes.height#</option>
</cfloop>
</select>
<BR />

Display: <select name="displayRows">
	<cfloop from="1" to="5" index="i">
    <option value="#i#" <cfif getModule.displayRows eq i>selected</cfif>>#i#</option>
    </cfloop>
    </select><BR />
Template: <select name="displayTemplate">
		<option value="Vertical" <cfif getmodule.displayTemplate eq 'Vertical'>selected</cfif>>Vertical</option>
        <option value="Horizontal" <cfif getmodule.displayTemplate eq 'Horizontal'>selected</cfif>>Horizontal</option>
        </select><BR />
Display Module Layout: <select name="displayLayout"><option value="1" <cfif getModule.displayLayout eq 1>selected</cfif>>Yes</option>
<option value="0" <cfif getModule.displayLayout eq 0>selected</cfif>>No</option>
</select>
<BR>
<input type="submit" value="Save" />
</form>
</cfoutput>