<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
<cfscript>
	structappend(rc, application.util.queryRowToStruct(event.getvalue('qquestion')),false);
	sections = event.getvalue('sections');
	fieldSet = event.getValue('qfieldsets');
</cfscript>
<script>
	addValue = function()
	{	
		appendToLocation = $('#valueList').parent().parent();
		$('#valueList').parent().clone().appendTo(appendToLocation);
	}
</script>
<cfoutput>
	<div class="cfUniForm-form-container">
		<uform:form action="#event.buildLink('member.profileAdmin.questionSubmit')#" id="questionForm" errors="#rc.errors#" errorMessagePlacement="top" submitValue="Save" CLASS="ajaxform">
			<input type="hidden" name="communityID" value="#rc.communityID#">
			<input type="hidden" name="ID" value="#rc.ID#" />
			<uform:fieldset legend="">
				<uform:field label="Question" name="question" isRequired="yes" type="text" value="#rc.question#" hint="" />
				<uform:field label="Description/Tooltip" name="description" isRequired="no" type="text" value='#rc.description#'  />
				<uform:field label="Type" name="type" type="select" isRequired="true" id="questionType" >
					<uform:option display="Text Box" value="text" isSelected="#rc.type eq 'text'#" />
					<uform:option display="Rich Text" value="textarea" isSelected="#rc.type eq 'textarea'#" />
					<uform:option display="Select Box" value="select" isSelected="#rc.type eq 'select'#" />
					<uform:option display="Radio Buttons" value="radio" isSelected="#rc.type eq 'radio'#" />
					<uform:option display="Check Boxes" value="checkbox" isSelected="#rc.type eq 'checkbox'#" />
					<uform:option display="Date" value="date" isSelected="#rc.type eq 'date'#" />
					<uform:option display="Field Set" value="fieldset" isSelected="#rc.type eq 'fieldset'#" />
				</uform:field>
				<uform:field label="Section" name="sectionID" type="select" isRequired="true">
					<cfloop query="sections">
						<uform:option display="#sections.name[currentRow]#" value="#sections.id[currentRow]#" isSelected="#rc.sectionID EQ sections.id[currentRow]#" />
					</cfloop>
				</uform:field>
				<cfif fieldset.recordcount gt 0>
					<uform:field label="Add to Field Set" name="groupID" type="select" isRequired="true">
						<uform:option display="None" value="0" isSelected="#rc.sectionID eq 0#" />
						<cfloop query="fieldset">
							<uform:option display="#fieldset.question[currentRow]#" value="#fieldSet.id[currentRow]#" isSelected="#rc.groupID EQ fieldSet.id[currentRow]#" />
						</cfloop>
					</uform:field>
				</cfif>	
				<uform:field label="Allow Multiple Answers" name="multiple" isRequired="no" type="checkbox" value="1" isChecked='#rc.multiple eq 1#' />
				</uform:fieldset>	
				<uform:fieldset legend="" id='valueListFieldset'>
					<uform:field type="custom" id="valueListControl">
						<span id="valueListLabel">Below are options values for input.</span> <a href="javascript:void(0)" onclick='addValue();' id='valueListLink'>Click here to add a value.</a> 
					</uform:field>
					<cfif rc.ValueList neq ''>
						<cfloop list="#rc.ValueList#" index='value'>
							<uform:field label="" name="valueList" type="text" isRequired="no" value="#value#" id="valueList"/> 
						</cfloop>
					<cfelse>
					<uform:field label="" name="valueList" type="text" isRequired="no" value="#rc.ValueList#" id="valueList"/>
					</cfif>
			</uform:fieldset>
		</uform:form>
	</div>
</cfoutput>