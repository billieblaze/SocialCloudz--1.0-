<cfsetting showdebugoutput="no">
<cfscript>
	getModule = event.getvalue('getModule');
	FEED = application.cms.modules.getRSS(rc.id);
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
					<input type="text" name="title" value="#getModule.title#"/>
				</label>
				
				<label for="template">Template: 
					<select name="displayTemplate">
					<option value="list" <cfif getmodule.displaytemplate eq 'list'>selected</cfif>>List</option>
					<option value="preview" <cfif getmodule.displaytemplate eq 'preview'>selected</cfif>>Preview</option>
					<option value="detail" <cfif getmodule.displaytemplate eq 'detail'>selected</cfif>>Detail</option>
					</select>
				</label>
				
				<label for="feed">Feed URL: 
					<input type="text" name="feed" value="#feed#"/>
				</label>
				
				<label for="display">Display: 
					<select name="displayRows">
					<option value="5" <cfif getmodule.displayrows eq 5>selected</cfif>>5</option>
					<option value="10" <cfif getmodule.displayrows eq 10>selected</cfif>>10</option>
					<option value="20" <cfif getmodule.displayrows eq 20>selected</cfif>>20</option>
					</select>
				</label>
				
				<label for="displaylayout">Display Module Layout: 
					<select name="displayLayout">
					<option value="1" <cfif getModule.displayLayout eq 1>selected</cfif>>Yes</option>
					<option value="0" <cfif getModule.displayLayout eq 0>selected</cfif>>No</option>
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
			<textarea cols="80" id="html" name="html" rows="10" class='ckeditor'>#getModule.html#</textarea>
			<style type="text/css">
				##cke_html {width: 655px !important;}
			</style>
		</div>
	</div>
	
	<div align="center">
	    <input type="hidden" name="ID" value="#rc.id#"/>
		<input type="submit"  value="Save" class="submit"/>
	</div>   
</form>  
</div>
</cfoutput>