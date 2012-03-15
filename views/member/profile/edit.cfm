<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
<script>
	deleteMultiQuestionGroup = function(questionID, answerSet){
		$.get('/index.cfm/member/profile/deleteMultiQuestionAnswers?answerSet='+answerSet+'&questionID='+questionID+'&memberID='+<cfoutput>#rc.memberID#</cfoutput>, function(){
			$('#profileTabs').tabs('load', <cfoutput>#rc.tab#</cfoutput>);
		});
	};	

	multiInit = function(){
 		  $("form#multiQuestionForm .anyTimePicker").AnyTime_picker( { 
		  		format: "%m/%d/%Z",
		  		askSecond: false
		  } );
	};

	multiFormSuccess = function(){
			$('#profileTabs').tabs('load', <cfoutput>#rc.tab#</cfoutput>);
	}

	
	// AJAX enable the profile form 
	$('#profileForm_<cfoutput>#rc.sectionid#</cfoutput>').ajaxForm(function(responseText) { 
	   $.jGrowl('Save Complete!'); 
	   return false;
	 });	
		
</script>

<cfoutput>
	<div class="cfUniForm-form-container">
		<uform:form 
		action="#event.buildLink('member.profile.submit')#" 
		id="profileForm_#rc.sectionid#" 
		submitValue=" Save "
		loadjQuery="true" 
		loadDateUI='true'
		loadTimeUI='true'
		configValidation='true'>
			<input type='hidden' name='memberid' value='#rc.memberID#'>
			<cfscript>
					questions = application.members.profile.getQuestions(sectionID=rc.sectionid);
				</cfscript>
			<table>
				<cfloop query="questions">
					<tr>
						<td><uform:fieldset>
							<cfset answer = application.members.profile.get(memberid=rc.memberID, questionID=questions.id)>
							<cfif questions.multiple eq 1>
								<cfif questions.type eq 'fieldset'>
									<strong>#questions.question#</strong>
									<hr>
									<cfset fieldset = application.members.profile.getQuestions(groupID=questions.id, memberID=rc.memberID)>
									<cfset tmpLastFieldSet = fieldSet.answerset[1]>
									<cfloop query="fieldset">
										<cfif (tmpLastFieldSet neq fieldSet.answerSet)>
											<cfif tmpLastFieldSet neq ''>
												&nbsp;&nbsp;&nbsp; <a href="javascript: void(0);" class="profileMultiEdit" alt='#questions.id#' rel="#tmpLastFieldSet#"  title='Edit a #questions.question#'>[+] Edit</a> <a href="javascript: void(0);" onClick="deleteMultiQuestionGroup('#questions.id#','#tmpLastFieldSet#')">Delete</a> <br>
											</cfif>
											<cfset tmpLastFieldSet = fieldSet.answerSet>
										</cfif>
										<cfif fieldset.value neq ''>
											&nbsp;&nbsp;&nbsp;#fieldset.question#:
											&nbsp;#fieldset.value#<BR>
										</cfif>
									</cfloop>
									<cfif tmpLastFieldSet neq ''>
										&nbsp;&nbsp;&nbsp; <a href="javascript: void(0);" class="profileMultiEdit" alt='#questions.id#' rel="#tmpLastFieldSet#"  title='Edit a #questions.question#')">[+] Edit</a> <a href="javascript: void(0);" onClick="deleteMultiQuestionGroup('#questions.id#','#tmpLastFieldSet#')">Delete</a> <br>
										<cfelse>
										<cfset tmpLastFieldSet = 0>
									</cfif>
									&nbsp;&nbsp;&nbsp;<a href="javascript: void(0);" class="profileMultiAdd" alt='#questions.id#' rel='#tmpLastFieldSet+1# title="Add a #questions.question#" >[+] Add #questions.question#</a><br>
								</cfif>
								<cfelse>
								<cfif questions.type eq 'fieldset'>
									<uform:fieldset legend="#questions.question#">
										<cfset fieldset = application.members.profile.getQuestions(sectionID=rc.sectionID, groupID=questions.id)>
										<cfloop query="fieldset">
											<cfset answer = trim(application.members.profile.get(memberid=rc.memberID, questionID=fieldset.id))>
											<cfif fieldset.type eq 'text'>
												<uform:field label="#fieldset.question#" 
											   name="question_#fieldset.id#" 
											   type="text" 
											   value="#answer.value#"/>
												<cfelseif fieldset.type eq 'textarea'>
												&nbsp;&nbsp;#fieldset.question#<br>
												<br>
												&nbsp;&nbsp;
												<cfif fieldset.description neq ''>
													<uform:field type="custom" id="tooltip"> <a href="##"  class="tTip" title="#fieldset.description#" id="tooltip_#fieldset.id#"><img src="#application.cdn.fam#help.png"></a> </uform:field>
												</cfif>
												#application.form.textEditor('question_#fieldset.id#',answer.value)#
												<cfelseif fieldset.type eq 'select'>
												<uform:field label="#fieldset.question#" name="question_#fieldset.id#" type="select">
													<cfloop index = "valueListValue" list = "#fieldset.ValueList#" delimiters = ",">
														<uform:option display="#valueListValue#" value="#valueListValue#" isSelected="#fieldset.ValueList eq valueListValue#" />
													</cfloop>
												</uform:field>
												<cfelseif fieldset.type eq 'radio'>
												<uform:field label="#fieldset.question#" name="question_#fieldset.id#" type="radio">
													<cfloop index = "valueListValue" list = "#fieldset.ValueList#" delimiters = ",">
														<uform:radio label="#valueListValue#" 
												value="#valueListValue#" 
												isChecked="#answer.value EQ valueListValue#" />
													</cfloop>
												</uform:field>
												<cfelseif fieldset.type eq 'checkbox'>
												<uform:field label="#fieldset.question#" name="question_#fieldset.id#" type="checkboxgroup">
													<cfloop index = "valueListValue" list = "#fieldset.ValueList#" delimiters = ",">
														<uform:checkbox  label="#valueListValue#" 
														value="#valueListValue#" 
														isChecked="#answer.value EQ valueListValue#" />
													</cfloop>
												</uform:field>
												<cfelseif fieldset.type eq 'date'>
												<uform:field type="custom">
													<cfset dateName = 'question_'&fieldset.id>
													<cfset dateTime = answer.value>
													<p class="label">#fieldset.question#</p>
													#application.form.calendar(dateName, dateTime, '40%','0')# </uform:field>
											</cfif>
											<cfif fieldset.type neq 'textarea'>
												<cfif fieldset.description neq ''>
													<uform:field type="custom" id="tooltip"> <a href="##"  class="tTip" title="#fieldset.description#" id="tooltip_#fieldset.id#"><img src="#application.cdn.fam#help.png"></a> </uform:field>
												</cfif>
											</cfif>
										</cfloop>
									</uform:fieldset>
									<cfelseif questions.type eq 'text'>
									<uform:field label="#questions.question#" 
								   name="question_#questions.id#" 
								   type="text" 
								   value="#answer.value#"/>
									<cfelseif questions.type eq 'textarea'>
									&nbsp;&nbsp;#questions.question#<br>
									<br>
									&nbsp;&nbsp;
									<cfif questions.description neq ''>
										<a href="##"  class="tTip" title="#questions.description#" id="tooltip_#questions.id#"><img src="#application.cdn.fam#help.png"></a>
									</cfif>
									#application.form.textEditor('question_#questions.id#',answer.value)#
									<cfelseif questions.type eq 'select'>
									<uform:field label="#questions.question#" name="question_#questions.id#" type="select">
										<cfloop index = "valueListValue" list = "#questions.ValueList#" delimiters = ",">
											<uform:option display="#valueListValue#" value="#valueListValue#" isSelected="#questions.ValueList eq valueListValue#" />
										</cfloop>
									</uform:field>
									<cfelseif questions.type eq 'radio'>
									<uform:field label="#questions.question#" name="question_#questions.id#" type="radio">
										<cfloop index = "valueListValue" list = "#questions.ValueList#" delimiters = ",">
											<uform:radio label="#valueListValue#" 
											value="#valueListValue#" 
											isChecked="#answer.value EQ valueListValue#" />
										</cfloop>
									</uform:field>
									<cfelseif questions.type eq 'checkbox'>
									<uform:field label="#questions.question#" name="question_#questions.id#" type="checkboxgroup">
										<cfloop index = "valueListValue" list = "#questions.ValueList#" delimiters = ",">
											#valueListValue#
											<uform:checkbox label="#valueListValue#" 
											value="#valueListValue#" 
											isChecked="#answer.value contains valueListValue#" />
										</cfloop>
									</uform:field>
									<cfelseif questions.type eq 'date'>
									<uform:field type="custom">
										<cfset dateName = 'question_'&questions.id>
										<cfset dateTime = answer.value>
										<p class="label">#questions.question#</p>
										#application.form.calendar(dateName, dateTime, '40%','0')# </uform:field>
								</cfif>
							</cfif>
						</td>
						<td><cfif questions.type neq 'textarea'>
								<cfif questions.description neq ''>
									<uform:field type="custom" id="tooltip"> <a href="##"  class="tTip" title="#questions.description#" id="tooltip_#questions.id#"> <img src="#application.cdn.fam#help.png"> </a> </uform:field>
								</cfif>
							</cfif>
						</td>
					</tr>
					</uform:fieldset>
					
				</cfloop>
			</table>
			<br>
			<br>
		</uform:form>
	</div>
</cfoutput>
<!--- todo: remove qTip --->
<script>$('.tTip').qtip({show: 'mouseover', hide: 'mouseout'});</script>
<script>
$('.profileMultiAdd').modalAjax({
		title: '!title!',
		url: '/index.cfm/member/profile/MultiEdit/groupID/!alt!/answerset/!rel!',
		width:450,
		initFunction: multiInit,
		ajaxFormSuccess: multiFormSuccess,
		initAjaxForm: true,
		initValidate: true,
		ajaxFormClose: true
	});

	$('.profileMultiEdit').modalAjax({
		title: '!title!',
		url: '/index.cfm/member/profile/MultiEdit/groupID/!alt!/answerset/!rel!',
		width:450,
		initFunction: multiInit,
		ajaxFormSuccess: multiFormSuccess,
		initAjaxForm: true,
		initValidate: true,
		ajaxFormClose: true
	});
		
</script>