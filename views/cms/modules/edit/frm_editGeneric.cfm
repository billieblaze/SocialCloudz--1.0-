<cfsetting showdebugoutput="no">
<cfscript>
	getModule = event.getValue('getModule');
	getMembers = application.members.gateway.list();
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
				<label for="display">Display: 
					<select name="displayRows">
					<cfloop from="1" to="30" index="i">			
					<option value="#i#" <cfif getmodule.displayrows eq #i#>selected</cfif>>#i#</option>
					</cfloop>			
					</select>
				</label>
	<!--- All but forum module --->
	<cfif getmodule.moduleid neq 17>
		<label for="thumbnail">
			Thumbnail Width: 	
			<select name="thumbSize">
				<option value="none" <cfif getModule.thumbsize eq 'none'>selected</cfif>>None</option>
				<cfloop from="25" to="200" step="5" index="i">
				<option value="#i#" <cfif getModule.thumbsize eq i>selected</cfif>>#i#px</option>
				</cfloop>
			</select>
		</label>
	</cfif>

	<cfif getmodule.moduleID eq 8>
		<label>Featured Only: <input type="checkbox" name="featured"  value="1" <cfif getmodule.featured eq 1>checked</cfif>></label>
		<label>Online Only: <input type="checkbox" name="active"  value="1" <cfif getmodule.active eq 1>checked</cfif>></label>
		<label>Profile Type: <select name="displayTag">
								<option value="0" <cfif getModule.displayTag eq 0>selected</cfif>>Everyone<option>
								<option value="1" <cfif getModule.displayTag eq 1>selected</cfif>>Personal<option>
								<option value="2" <cfif getModule.displayTag eq 2>selected</cfif>>Business<option>
							</select>
		
	</cfif>
	
	</fieldset>
				
	</div>
	<div id="tabs-2">
	<fieldset>
	
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
	<input type="submit" value="Update"  class="submit"/>
    <input type="hidden" name="ID" value="#rc.id#"/>   
</div>
</form>
</div>
</cfoutput>