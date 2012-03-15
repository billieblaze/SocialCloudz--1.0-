<cfset mymodules = event.getValue('myModules')>
<cfoutput>
	<div style="height:400px;  overflow:scroll">
   		<cfloop query="mymodules">
		<cfset variables.usedon = #application.cms.modules.getContext(mymodules.modulesettingID)#>
        <cfif variables.usedon contains 'profile_'>
	 	<cfelse>
        	<div class="module" style='height:100px;' id="module#mymodules.moduleSettingID#">
        		<img src="#application.cdn.fam##icon#" /> 
				<A onclick="doAddMyModule(#moduleSettingID#,'#rc.page#');" class="moduleLink"><cfif title eq ' '>Untitled<cfelse>#title#</cfif></A> 
		      ( <A href="##" onclick="editModuleSetting(#moduleSettingID#, '#editFile#');">Edit</A> |    
				<a href='##' onclick="ajaxConfirmDelete('Are you sure you want to delete this module?  It will be deleted from all pages it appears on!','/index.cfm/cms/modules/deleteMyModule/modulesettingid/#modulesettingID#/page/#rc.page#','##module#mymodules.moduleSettingID#')">Delete</a>)
				<br />
				 Sort: #sort# | Rows: #displayrows#<BR />
		         Used on: #variables.usedon#
	 		</div>
		</cfif>
        </cfloop>  
	</div>
</cfoutput>