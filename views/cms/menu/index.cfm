<cfsetting showdebugoutput="no">
<cfscript>
menu = event.getvalue('menu');
menuFeatures = event.getvalue('menuFeatures');
menuCMS = event.getvalue('menuCMS');
menuJson = arraynew(1);
for (i=1; i lte menu.recordcount; i=i+1){
	menuJSON[i]=structnew();
    menuJSON[i].ID=menu.id[i];
	menuJSON[i].NEWWINDOW=menu.newwindow[i];
	menuJSON[i].SORTORDER=menu.sortorder[i];
	menuJSON[i].TITLE=menu.title[i];
	menuJSON[i].URL=menu.url[i];
	
	menuJSON[i].TYPE = menu.type[i];
	menuJSON[i].FEATURE = menu.feature[i];	
	menuJSON[i].CMS = menu.cms[i];	
	menuJSON[i].VISIBLETO=menu.visibleto[i];
	menuJSON[i].VISIBLETOPROFILETYPE=menu.visibletoprofileType[i];
}
menuJSON = application.util.jsonEncode(menuJSON);

	types = event.getvalue('types'); 
</cfscript>
<cfoutput>
<script language="javascript">

<cfif menu.recordcount eq 0>
var menuData = new Array(1);
<cfelse>
var menuData = #menuJSON#;
</cfif>
var menuRecordCount = #menu.recordcount#
</script>

<div style="width:600px; height: 600px">
Here, you can configure your sites menu.   Click "Add Link" to add a menu item to the list on the left.  Select a menu item and change its settings to the right.  
You may also delete a menu item after you have selected it.  Menu items can be dragged and dropped to change the order in which they appear. When you are done, click "Save".
<BR><BR>

<form action="#event.buildLink('cms.menu.submit')#" method="post" name="menu" id="menu" class="blackText" onsubmit="saveMenu();">
	<div style="float:left;">  
	Menu Position
	<select name="menu_position">
		<option value="above" <cfif application.community.settings.getValue('menu_position') eq 'above'>selected</cfif>>Above Header</option>
	    <option value="below" <cfif application.community.settings.getValue('menu_position') eq 'below'>selected</cfif>>Below Header</option>
	    <option value="side" <cfif application.community.settings.getValue('menu_position') eq 'side'>selected</cfif>>Sidebar</option>
	</select>
	<a href="##" class="tTip" title="#application.help.getHelp('menuPosition')#" ><img src="#application.cdn.fam#help.png"></a></div>
	<div align="right"><a href="##" id="addLI" alt="help">Add  Link</a><br></div>
	<div style="clear:both; height:6px; width:100%"></div>
	<div class="workarea">
	  <ul id="ul1" class="draglist">
	    <cfloop query="menu">
	    <li class="ui-state-default pad2 bold" id="li1_#menu.currentrow#">#title#</li>
	   </cfloop>
	  </ul>
	</div>
	
	<div class="editarea">
	<table height="260">
	<TR height="30" valign="top"><TD width="70">Title:</TD><TD>
	<input name="title" id="menuTitle" type="text" onkeyup="updateJSON();document.getElementById('li1_'+(menuPosition+1)).innerHTML=this.value"> 
	<a href="##" class="tTip" title="#application.help.getHelp('adminmenuTitle')#"><img src="#application.cdn.fam#help.png"></a></TD></TR>
	<TR height="80" valign="top"><TD>Target:</TD><TD>
		<input type="radio" name="menuType" value="2" onchange="updateJSON();"> Feature: <select name="menuFeature" id="menuFeature"  onchange="updateJSON();"><option value="0">...</option><cfloop query="menuFeatures"><option value="#ID#">#name#</option></cfloop>
	</select><a href="##" class="tTip" title="#application.help.getHelp('adminmenuFeature')#"><img src="#application.cdn.fam#help.png"></a><BR>
	
		<input type="radio" name="menuType" value="0" onchange="updateJSON();">
		CMS Page:  <select name="menuCMS" id="menuCMS"  onchange="updateJSON();"><option value="0">...</option><cfloop query="menuCMS"><Cfif menuCMS.url does not contain '.' and menuCMS.url does not contain '/' and menuCMS.title does not contain '/'><option value="#menuCMS.url#">#menuCMS.url# :: #title#</option></cfif></cfloop></select>  <br>
		<input type="radio" name="menuType" value="1"> URL: <input type="text" id="menuURL" onkeyup="updateJSON();">
		<a href="##" class="tTip" title="#application.help.getHelp('adminmenuURL')#"><img src="#application.cdn.fam#help.png"></a><br />
	<br><br>
	<input type="checkbox" id="menuNewWindow" name="menuNewWindow" onchange="updateJSON();" value="1"> Opens in a new window 
	<a href="##" class="tTip" title="#application.help.getHelp('menuNewWindow')#"><img src="#application.cdn.fam#help.png"></a><br />
	<br />
	</TD></TR>
	<TR height="30" valign="top"><TD>Visible to:</TD><TD>
		
		<label for="whocanview" class="first">Which Accesslevels can view: 
			<select id="menuVisible" onchange="updateJSON();">
				<option value="0">Everyone</option>
				<option value="1">Members</option>
				<option value="10">Editors</option>
				<option value="20">Owners</option>
				<option value="100">Administrators</option>
			</select>
		</label>
		<br>
		<label for="whocanview" class="first">Which profile types can view: 
			
			<select id="menuVisibleProfileType" onchange="updateJSON();">
					<cfloop query='types'>
						<option value='#types.typeid#'>#types.name#</option>
					</cfloop>
			</select>
		</label>
		
	<a href="##" class="tTip" title="#application.help.getHelp('menuVisibility')#"><img src="#application.cdn.fam#help.png"></a></TD></TR>
	<TR><TD></TD><TD><input type="submit" value="Save" ><input type="button" value="Delete Item" id="delLI" /></TD></TR>
	</table>
	</Div>
	<input type="hidden" name="order" id="menuOrder" />
	<input type="hidden" name="json" id="menuJSON" />
	</cfoutput>
	</form>
	<div style="clear:both; height:7px; width:100%"></div>
</div>
<script>
	$.getScript('/scripts/menuEditor.js');
</script>