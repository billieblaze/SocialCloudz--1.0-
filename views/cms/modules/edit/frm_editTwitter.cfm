<cfsetting showdebugoutput="no">
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
				<label for="title" class="first">Title: 
					<input type="text" name="title" value="#getModule.title#" />
				</label>
				<label for="display">Display: 
					<select name="displayRows">
					<cfloop from="1" to="20" index="i">			
					<option value="#i#" <cfif getmodule.displayrows eq #i#>selected</cfif>>#i#</option>
					</cfloop>
					</select>
				</label>
				
				<label for="displaylayout">Display Module Layout: 
					<select name="displayLayout">
					<option value="1" <cfif getModule.displayLayout eq 1>selected</cfif>>Yes</option>
					<option value="0" <cfif getModule.displayLayout eq 0>selected</cfif>>No</option>
					</select>
				</label>
				<label for="user" class="first">Twitter Username: 
					<input type="text" name="displayTemplate" value="#getModule.displayTemplate#" />
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
		</div>
	
	</div>

		<style type="text/css">
		##cke_html {width: 655px !important;}
	</style>
 
<div align="center">
<input type="submit" value="Update" class="submit"/>
    <input type="hidden" name="ID" value="#rc.id#"/>   
</div> 
</form>
</div>
</cfoutput>
