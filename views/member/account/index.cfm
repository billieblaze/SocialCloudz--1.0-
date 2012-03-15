<cfif isdefined('rc.signupcomplete') and rc.signupcomplete eq 0>
	<cfset  request.message = 'Please take a moment to complete your profile.'>
</cfif>

<cfset sections = event.getvalue('sections')>
			
<script type="text/javascript">
			$(function() {
		$("#profileTabs").tabs({
 		  	select: function(event, ui) {	
 		  		$('textarea').ckeditor(function(){
					this.destroy();
					});
 		  		
 		  	}
	 	});
	});


	</script>
<cfparam name="rc.tab" default="details">
<cfoutput>
	<style>
	.ui-tabs .ui-tabs-nav li a { padding: 3px 5px; } 
	</style>
<div class="ui-widget">
	<div class="ui-widget-header" style="padding:5px">
		<div style="float:left">
		Edit Profile
		</div>
		<div align="right">
			<a href="#event.buildLink(linkTo='member.profile.index',queryString='memberID=#rc.memberID#')#">View Profile</a>
			
			<cfif request.session.accesslevel gte 10>
				| 
				<cfif rc.member.featured eq 1>
				<a href='#event.buildLink(linkTo='member.util.feature',queryString='memberID=#rc.memberID#&featured=0')#' class='aNone small'>Un-Feature This User</a>
				<cfelse>
				<a href='#event.buildLink(linkTo='member.util.feature',queryString='memberID=#rc.memberID#&featured=1')#' class='aNone small'>Feature This User</a>
				</cfif>
			</cfif>
		</div>
	</div>
    <div class="ui-widget-content" style="padding: 5px 0px;">
	   <div id="profileTabs" class="blackText">
       <ul> 
	        <li><a href="#event.buildLink(linkTo='member.account.details',queryString='memberID=#rc.memberID#')#" id="tabs-1">Personal Info</a></li> 
			<cfloop query="sections">
				<li><a  href="#event.buildLink(linkTo='member.profile.edit',queryString='memberID=#rc.memberID#&sectionID=#sections.id#&tab=#sections.currentRow#')#" id="tabs-#sections.currentRow + 1#">#sections.name#</a></li>
			</cfloop>
			<li><a  href="#event.buildLink(linkTo='emailTemplates:settings.index',queryString='memberID=#rc.memberID#')#" id="tabs-#sections.recordcount + 1#">Notifications</a></li>
		</ul>             
    </div>
</div>
        

</cfoutput>