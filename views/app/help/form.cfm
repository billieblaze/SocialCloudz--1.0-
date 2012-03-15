<cfscript>
structappend(rc, application.util.queryRowToStruct(event.getValue('topic')),false);
sections = event.getvalue('sections');
</cfscript>

<cfparam name="rc.title" default="">
<cfparam name="rc.description" default="">
<cfparam name="rc.sectionID" default="">
<cfoutput>
<div class="mod">
<div class="hd">Manage Help</div>
<div class="bd">
	<form action="#event.buildLink('app.help.submit')#" method="post">
	<input type="hidden" name="id" value="#rc.id#" />
    Title<BR>
    <input type="text" name="title" value="#rc.title#" style="width:100%" maxlength="255"><BR>
    <BR>
    Description<BR>
    #application.form.textEditor('description', form.description)#<BR>
    <BR>
    Category<BR>
    <select name="sectionID">
    	<cfloop query="sections">
        <option value="#id#" <cfif rc.sectionID eq id>selected</cfif>>#type# :: #title#</option>
        </cfloop>
    </select>
    <BR><BR>
    <div align="center"><input type="submit" value="Save"></div>
    
    </form>
</div>
<div class="ft"></div>
</div>
</cfoutput>