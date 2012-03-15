<cfsetting showdebugoutput="false">
<cfscript>
	getModule = event.getvalue('getModule');
		types = event.getvalue('types');
</cfscript>

<cfoutput>
<div style="width:700px;">
<form action="/index.cfm/cms/modules/update" method="post" class="form ajaxform">
	<div id="editModuleTabs" class="tabs">
		<ul>
			<li><a href="##tabs-1">Settings</a></li>
			<li><a href="##tabs-2">Access</a></li>
			<li><a href="##tabs-3">HTML</a></li>
		</ul>
		<div id="tabs-1">
			<fieldset>
				<legend>General Settings</legend>
				
				<label for="title" class="first">Title: 
					<input type="text" name="title" value="#getModule.title#" />
				</label>
				
				<label for="displayTag" >
					Address:   <input type="text" name="displayTag" value="#getModule.displayTag#">
				</label>
				<label for="thumbnail">
					Map Height: 	
					<select name="thumbSize">
						<cfloop from="100" to="500" step="25" index="i">
							<option value="#i#" <cfif getModule.thumbsize eq i>selected</cfif>>#i#px</option>
						</cfloop>
					</select>
				</label>
			</fieldset>
				</div>
		<div id="tabs-2">
<fieldset>
			<label for="whocanview" class="first">Which Accesslevels can View: 
				
				<select name="Accesslevel">
				<option value="" <cfif getmodule.accesslevel eq ''>selected</cfif>>Anyone</option>
				<option value="0" <cfif getmodule.accesslevel eq 0>selected</cfif>>Guests Only</option>
				<option value="1" <cfif getmodule.accesslevel eq 1>selected</cfif>>Members Only</option>
				<option value="10" <cfif getmodule.accesslevel eq 10>selected</cfif>>Editors Only</option>
				<option value="20" <cfif getmodule.accesslevel eq 20>selected</cfif>>Admins Only</option>
				</select>
			</label>
			
			<label for="whocanview" class="first">Which profile types can view: 
				
				<select name="displayProfileType">
						<cfloop query='types'>
							<option value='#types.typeid#' <cfif getmodule.displayProfileType eq types.typeid >selected</cfif>>#types.name#</option>
						</cfloop>
				</select>
			</label>
		</fieldset>
		</div>
		<div id="tabs-3">
			<textarea cols="80" id="html" name="html" rows="10" class="ckeditor">#getModule.html#</textarea>
			<style type="text/css">
				##cke_html {width: 655px !important;}
			</style>
		</div>
	</div>


	<div align="center">
		<input type="submit" value="Update"  class="submit"/>
	    <input type="hidden" name="ID" value="#rc.id#"/>   
    </div>
</form>
</div>
</cfoutput>