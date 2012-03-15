<cfset communityList = event.getValue('communityList')>
<cfset community = event.getValue('community')>
<cfsetting showdebugoutput="no"> 
<cfoutput><div class="mod">
	<div class="hd">
		<form action="#event.buildLink('member.admin.index')#" method="post">
		<select name="communityID">
			<cfloop query="communityList">
			<option value="#communityID#" <cfif community.communityID eq communityID>selected</cfif>>#site#</option>
			</cfloop>
		</select>
		<input type="submit" value="Manage Site" class="button">
		<input type="button" value="View Site" onclick="location.href='#community.baseURL#';">

	</form>
	</div>
	<div class="bd">	
	
	<div id="manageTabs">
		<ul>
	    	<li><a href="#event.buildLink(linkTo='member.admin.index',queryString='communityID=#community.communityID#')#" title="tabs-1"><img src="#application.cdn.fam#group.png"> Members</a></li>
			<li><A href="#event.buildLink(linkTo='app.forms.index',queryString='communityID=#community.communityID#')#" title="tabs-6"><img src="#application.cdn.fam#application_edit.png">  Forms</A></li> 
	    </ul>
	</div>
	</div>
	<div class="ft"></div>
</div>
	<script type="text/javascript">
			$("##manageTabs").tabs({
	    load: function(event, ui) {
	        $('.intab', ui.panel).click(function() {
	            $(ui.panel).load(this.href);
	            return false;
	        });
	    }
	});
	</script>
</cfoutput>