<cfset modulelist = event.getValue('moduleList')>
<cfoutput query="modulelist">
	<cfif modulelist.moduletype eq rc.type>
         <div class="module">
	         <img src="#application.cdn.fam##icon#" /> <A href="##" onclick="doAddModule(#moduleID#,'#rc.page#');" class="moduleLink">#title#</A><br />
	         #desc#
 		</div>
    </cfif>
</cfoutput>        
<br style="clear:both" />