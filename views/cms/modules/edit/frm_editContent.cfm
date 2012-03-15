<cfsetting showdebugoutput="no">
<cfscript>
	getModule = application.cms.modules.get(rc.id);
	getMembers = application.members.gateway.list();
	getCategories =  application.content.category.list(contentType=getModule.contentType);	
	getContent = application.content.get( contenttype=getModule.contentType);
	types = event.getvalue('types');
</cfscript>
<cfoutput>
<div style="width:700px;">
	<form action="/index.cfm/cms/modules/update" method="post" class="form ajaxform">
	<input type="hidden" name="event" value="cms.modules.update">
	<input type="hidden" name="displayContentType" value="#getModule.contentType#">
<div id="editModuleTabs" class="tabs">
	<ul>
		<li><a href="##tabs-1">Settings</a></li>
		<li><a href="##tabs-2">Access</a></li>
		<li><a href="##tabs-3">Advanced</a></li>
		<li><a href="##tabs-4">HTML</a></li>
	</ul>

	<div id="tabs-1">
		<fieldset>
			<label for="title" class="first">Title: 
				<input type="text" name="title" value="#getModule.title#" />
			</label>
			
			<label for="template">Template: 
				<select name="displayTemplate">
					<!--- todo: default templates / contenttype specific templates --->
					<option value="template_eventList" <Cfif getModule.displayTemplate eq 'template_eventList'>selected</cfif>>Event List</option>
					<option value="template_eventCalendar" <Cfif getModule.displayTemplate eq 'template_eventCalendar'>selected</cfif>>Event Calendar</option>
					<option value="template_eventDetail" <Cfif getModule.displayTemplate eq 'template_eventDetail'>selected</cfif>>Event Detail</option>
					<option value="template_fileList" <Cfif getModule.displayTemplate eq 'template_fileList'>selected</cfif>>File List</option>
					
					<Cfif getModule.contentType eq 'gallery_detail'>
						<option value="template_gallery" <Cfif getModule.displayTemplate eq 'template_gallery'>selected</cfif>>Gallery</option>
					</cfif>
					
					<option value="template_photo" <Cfif getModule.displayTemplate eq 'template_photo'>selected</cfif>>Photo</option>
					<option value="template_locationList" <Cfif getModule.displayTemplate eq 'template_locationList'>selected</cfif>>Location List</option>

					<option value="template_jobList" <Cfif getModule.displayTemplate eq 'template_jobList'>selected</cfif>>Job List</option>
					<option value="template_links" <Cfif getModule.displayTemplate eq 'template_links'>selected</cfif>>Links</option>
					<option value="template_list" <Cfif getModule.displayTemplate eq 'template_list'>selected</cfif>>List</option>
					<option value="template_musicList" <Cfif getModule.displayTemplate eq 'template_musicList'>selected</cfif>>Music List</option>
					<option value="template_preview" <Cfif getModule.displayTemplate eq 'template_preview'>selected</cfif>>Preview</option>																
					<option value="template_preview2UP" <Cfif getModule.displayTemplate eq 'template_preview2UP'>selected</cfif>>Preview 2UP</option>
					<option value="template_previewLocation" <Cfif getModule.displayTemplate eq 'template_previewLocation'>selected</cfif>>Preview Location</option>
					<option value="template_previewProperty" <Cfif getModule.displayTemplate eq 'template_previewProperty'>selected</cfif>>Preview Property</option>
					<option value="template_previewRestaurant" <Cfif getModule.displayTemplate eq 'template_previewRestaurant'>selected</cfif>>Preview Restaurant</option>												
					<option value="template_detail" <Cfif getModule.displayTemplate eq 'template_fetail'>selected</cfif>>Text Detail</option>
					<option value="template_thumbnail" <Cfif getModule.displayTemplate eq 'template_thumbnail'>selected</cfif>>Thumbnail</option>				
				</select>
			</label>
			
			<label for="display">Display: 
				<select name="displayRows">
				<option value="0" <cfif getModule.displayRows eq '0'>selected</cfif>>All</option>
				<cfloop from="1" to="20" index="i">			
				<option value="#i#" <cfif getmodule.displayrows eq #i#>selected</cfif>>#i#</option>
				</cfloop>
				</select>
			</label>
			<label for="display">Display Recordcount in Header: 
				<input type="checkbox" name="displayRecordCount" <cfif getModule.displayRecordCount eq 1>checked</cfif> value="1">
			</label>
			<Cfif getModule.contentType eq 'Event'>
				<label for="past">Past / Upcoming: 
					<select name="operator">
						<option value=">" <cfif getModule.operator eq '>'>selected</cfif>>Upcoming</option>
						<option value="<"  <cfif getModule.operator eq '<'>selected</cfif>>Past</option>
					</select>
				</label>
				
				<label for="sort">Sort: 
					<select name="sort">
						<option value="startDate" <cfif getmodule.sort eq 'startDate'>selected</cfif>>Event Date</option>
						<option value="dateCreated" <cfif getmodule.sort eq 'dateCreated'>selected</cfif>>Most Recent</option>
					    <option value="views" <cfif getmodule.sort eq 'views'>selected</cfif>>Most Viewed</option>
				    </select>
				</label>
			<cfelse>
			<label for="sort">Sort:
				<select name="sort">
				<option value="publishdate" <cfif getmodule.sort eq 'publishdate'>selected</cfif>>Most Recent</option>
			    <option value="views" <cfif getmodule.sort eq 'views'>selected</cfif>>Most Viewed</option>
			    </select>
			</label>
			</cfif>
			<label for="thumb">Thumbnail Width: 
				<select name="thumbSize">
					<option value="none" <cfif getModule.thumbsize eq 'none'>selected</cfif>>None</option>
			<cfloop from="25" to="500" step="5" index="i">
			<option value="#i#" <cfif getModule.thumbsize eq i>selected</cfif>>#i#px</option>
			</cfloop>
				</select>
			</label>
			<label for="thumb">Thumbnail Alignment: 
				<select name="thumbAlign">
					<option value="left" <cfif getModule.thumbalign eq 'left'>selected</cfif>>Left</option>
					<option value="right" <cfif getModule.thumbalign eq 'right'>selected</cfif>>Right</option>
				</select>
			</label>
			<label for="layout">Display Layout: 
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
		<fieldset>
			<label for="members" class="first">Members: 
				<select name="displayMember">
				<option value="">All</option>
				<cfloop query="getmembers">
				<option value="#getmembers.memberID#" <cfif getModule.displaymember eq getmembers.memberID>selected</cfif>>#getmembers.username#</option>
				</cfloop>
				</select>
			</label>
			<label for="entry">Specific Entry: 
				<select name="displayContentID">
				<option value="">Display All</option>
				<cfloop query="getcontent">
				<option value="#getcontent.contentID#" <cfif getModule.displaycontentID eq getcontent.contentID>selected</cfif>>"#application.processtext.abbreviate(getcontent.title, 35)#" - by #application.members.getusername(getcontent.memberID)#</option>
				</cfloop>
				</select>
			</label>
			
			<label for="tag">Tag: 
				<input type="text" name="displayTag" value='#getModule.displayTag#'>
			</label>
				
			<label for="category">Category: 
				<select name='displaycategoryID'>
				<option value=''>Any</option>
				<cfloop query='getCategories'><option value='#id#' <cfif getCategories.id eq getModule.displayCategoryID>selected</cfif>>#category#</option>
				</cfloop>
				</select>
			</label>
		</fieldset>
	</div>
	<div id="tabs-4">
		<textarea cols="80" id="html" name="html" class="ckeditor" rows="10">#getModule.html#</textarea>
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