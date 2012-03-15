<div id="addFieldMsg"><span>Click</span> to Add a Field</div>

<cfsilent>

	<cfset interfacePath = replace( GetDirectoryFromPath( GetCurrentTemplatePath() ), "\", "/", "ALL" ) & "../../../interfaces/">
	<cfdirectory action="list" directory="#interfacePath#" name="getInterfaces">
	
</cfsilent>

<div id="newFieldTable" class="buttons">
	<cfloop query="getInterfaces">
		<cfif type EQ "dir" AND name IS NOT ".svn">
			<cfinclude template="../../../interfaces/#Name#/info.cfm">
			<cfoutput><a href="javascript:addField('#Name#')" style="background-image:url('interfaces/#Name#/icon.gif');">#Interface.Name#</a></cfoutput>
		</cfif>
	</cfloop>
</div>