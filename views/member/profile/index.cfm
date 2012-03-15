<cfscript>
sections = event.getvalue('sections');
member = event.getvalue('member');
</cfscript>
<cfoutput>
		<style>
	.ui-tabs .ui-tabs-nav li a { padding: 3px 5px; } 
	</style>
	<div class="mod">
        <div class="hd">
			<div style="float:left;">About Me</div>
			<div align="right">
				<cfif rc.memberID eq request.session.memberID or request.session.accesslevel gte 10>
					<a href='#event.buildLink(linkTo='member.account.index',queryString='memberID=#rc.memberID#')#' class='aNone small'>Edit Profile</a>
				<cfelse>
					&nbsp;
				</cfif>
				
				<cfif request.session.accesslevel gte 10>
				| 
					<cfif member.featured eq 1>
					<a href='#event.buildLink(linkTo='member.util.feature',queryString='memberID=#rc.memberID#&featured=0')#' class='aNone small'>Un-Feature This User</a>
					<cfelse>
					<a href='#event.buildLink(linkTo='member.util.feature',queryString='memberID=#rc.memberID#&featured=1')#' class='aNone small'>Feature This User</a>
					</cfif>
				</cfif>
			</div>
		</div>
        <div class="bd" style="padding: 5px 0px;">
				<div id="profiletabs">
				<ul>
					
			    	<cfloop query="sections">
						<li><a href="##tabs-#sections.currentRow + 1#" class="blackText">#sections.name#</a></li>
					</cfloop>
					
					<Cfif application.community.settings.getValue('friends') eq 1>
						<li><a href="##tabs-1" class="blackText">Wall</a></li>
					</cfif>
				</ul>
        	
				<cfloop query="sections">
					<div id="tabs-#sections.currentRow + 1#" class="ui-tabs-hide blacktext">
						<!--- <h3>#sections.name#</h3><hr> --->
						<!--- <cfdump var="#sections#"> --->
						<!--- <cfdump var="#member#"> --->
						<cfset questions = application.members.profile.getQuestions(memberid=rc.memberID,sectionID=sections.id)>
						<!--- <cfdump var="#questions#"> --->
						<cfloop query="questions"> 
							<cfif questions.multiple eq 1>
								<h3>#questions.question#(s)</h3><br>								
								<cfset fieldset = application.members.profile.getQuestions(memberid=rc.memberID,groupID=questions.id)>								
								<!--- <cfdump var="#fieldset#"> --->
								<cfset lastAnswerSet = 0>
								<cfloop query="fieldset">
									<cfif fieldset.answerSet neq lastAnswerSet>
										<hr>
									</cfif>
									&nbsp;&nbsp;&nbsp;<strong>#fieldset.question#:</strong>
									&nbsp;#fieldset.value#<BR>
									<cfset lastAnswerSet = fieldset.answerSet>
								</cfloop>
							<cfelse>
							<hr>
							<!--- <cfset answer = trim(application.members.profile.get(memberid=rc.memberID, questionID=questions.id))> --->
								<strong>#questions.question#:</strong>
								&nbsp;#questions.value#<BR>
							</cfif> 
						</cfloop>
						<BR><BR>
					</div>
				</cfloop>
					<Cfif application.community.settings.getValue('friends') eq 1>
		        	<div id="tabs-1" class="ui-tabs-hide blacktext">
						#renderView('comments/main/index')#
					</div>
				</cfif>
				</div>
			</div>
	    <div class="ft"></div>
	</div>
</cfoutput>
<script type="text/javascript">
	$(function() {
		$("#profiletabs").tabs();
	});
</script>


	
