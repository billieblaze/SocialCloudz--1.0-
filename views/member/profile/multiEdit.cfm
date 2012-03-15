<cfscript>
	questions = application.members.profile.getQuestions(groupID=rc.groupID);
</cfscript>	
<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
<cfoutput>
<div class="cfUniForm-form-container">
	
	<uform:form 
		action="#event.buildLink('member.profile.submit')#" 
		id="multiQuestionForm" 
		submitValue=" Save "
		class="ajaxform"
	>
		
		<input type='hidden' name='memberid' value='#rc.memberID#'>
		<input type='hidden' name='answerSet' value='#rc.answerSet#'>
		 <uform:fieldset>
			<cfloop query="questions">
			<cfset answer = application.members.profile.getQuestions(memberid=rc.memberID, questionID=questions.id, answerSet=rc.answerSet)>
				<cfif questions.type eq 'text'>
					<uform:field label="#questions.question#" 
					   name="question_#questions.id#" 
					   type="text" 
					   value="#answer.value#"/>										   
				<cfelseif questions.type eq 'textarea'>
					#questions.question#
					#application.form.textEditor('question_#questions.id#',answer.value)#
				<cfelseif questions.type eq 'select'>
					<uform:field label="#questions.question#" name="question_#questions.id#" type="select">
						<cfloop index = "valueListValue" list = "#questions.ValueList#" delimiters = ","> 
							<uform:option display="#valueListValue#" value="#valueListValue#" isSelected="#answer.value eq valueListValue#" />
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
						 <uform:checkbox label="#valueListValue#" 
							value="#valueListValue#" 
							isChecked="#answer.value EQ valueListValue#" />
						</cfloop>
					</uform:field>
				<cfelseif questions.type eq 'date'>					
					<uform:field type="custom">
					<cfset dateName = 'question_'&questions.id>
					<cfset dateTime = answer.value>
					<p class="label">#questions.question#</p>  #application.form.calendar(dateName, dateTime, '40%','0')#
					</uform:field>
				</cfif>
			</cfloop>
		</uform:fieldset>	
	</uform:form>
</div>
</cfoutput>
