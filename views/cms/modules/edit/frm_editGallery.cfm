<cfsetting showdebugoutput="no">
<cfscript>
	getModule = application.cms.modules.get(rc.id);
	if (request.session.accesslevel gte 10){
		memberid = '';
	}else{
		memberid = request.session.memberID;
	}
	getContent = application.content.get(memberid=memberID, contenttype='gallery');
		types = event.getvalue('types');
</cfscript>
<cfoutput>
<div style="width:700px;">
	<form action="/index.cfm/cms/modules/update" method="post" class="form ajaxform">
	<input type="hidden" name="event" value="cms.modules.update">


<div id="editModuleTabs" class="tabs">
	<ul>
		<li><a href="##tabs-1">Settings</a></li>
		<li><a href="##tabs-2">Access</a></li>
		<li><a href="##tabs-3">HTML</a></li>
	</ul>
	<div id="tabs-1">
<fieldset>
<legend>Display Settings</legend>

<label for="title" class="first">Title: 
	<input type="text" name="title" value="#getModule.title#" />
</label>

</label>
<label for="gallery">Gallery: 
	<select name="displayContentID">
	<cfloop query="getcontent">
	<option value="#getcontent.contentID#" <cfif getModule.displaycontentID eq getcontent.contentID>selected</cfif>>"#getcontent.title#" - Posted by #application.members.getusername(getcontent.memberID)#</option>
	</cfloop>
	</select>
</label>
	<label for="thumb">Thumbnail Width: 
				<select name="thumbSize">
					<option value="none" <cfif getModule.thumbsize eq 'none'>selected</cfif>>None</option>
			<cfloop from="25" to="200" step="5" index="i">
			<option value="#i#" <cfif getModule.thumbsize eq i>selected</cfif>>#i#px</option>
			</cfloop>
				</select>
			</label>
<label for="display">Display Module Layout: 
<select name="displayLayout"><option value="1" <cfif getModule.displayLayout eq 1>selected</cfif>>Yes</option>
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