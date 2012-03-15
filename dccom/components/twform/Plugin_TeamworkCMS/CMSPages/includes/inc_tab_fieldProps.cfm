<div class="message" id="nofieldSel" onclick="showFields(true)">
<h3>No field selected</h3>
<p>Please click on a field in the form preview on the right to change its properties.</p>
</div>

<form id="fieldProps" class="hide" action="#" onsubmit="return false;">
<div class="num" id="fieldPos" >1.</div>
<ul id="allProps">
	<li>
	<label class="desc" for="fieldTitle">Field Title <a href="#" class="help" onclick="return false;" rel="A field's title is the most direct way of telling your user what kind of data should be entered into a particular field. Field titles are usually just one or two words, but can also be a question. Field Titles are always placed directly above the field.">(?)</a></label>
	<input id="fieldTitle" class="text full" type="text" name="text" value="" tabindex="11" onkeyup="updateProps(this.value, 'title')" onblur="updateProps(this.value, 'title')" />
	</li>

	<li class="left half" id="listType">
		<label class="desc" for="fieldtype">
			Field Type <a href="#" class="help" onclick="return false;" rel="This property detemines what kind of data can be collected by your field. In addition to your standard fields, we provide premade structures of the most common data types like addresses and dates. This property can only be changed on newly added fields. After you save an added field to a form, the field type cannot be changed.">(?)</a>
		</label>
		<select class="select full" id="fieldtype" autocomplete="off" tabindex="12" onchange="updateProps($F(this), 'fieldtype')"></select>
	</li>

<li class="right half" id="listFieldSize">
<label class="desc" for="fieldSize">
Field Size
<a href="#" class="help" onclick="return false;" rel="This property only affects the visual appearance of the field in your form. It does not limit nor increase the amount of data that can be collected by the field. On most fields, this property affects the field's width. On Paragraph Text fields, the Field Size determines the height of the field.">(?)</a>
</label>

<select class="select full" id="fieldSize" autocomplete="off" tabindex="13"
 onchange="updateProps($F(this), 'size')" >
<option value="small">Small</option>
<option value="medium">Medium</option>
<option value="large">Large</option>
</select>
</li>

<li class="left half clear" id="listOptions">
<fieldset class="fieldset">
	<legend>Validation</legend>
	
	<input id="fieldRequired" class="checkbox" type="checkbox" value="" tabindex="14" onchange="(this.checked) ? checkVal = '1' : checkVal = '0';updateProps(checkVal, 'isrequired')" />
	<label class="choice" for="fieldRequired">Required</label><a href="#" class="help" onclick="return false;" rel="If you want to make sure that a user fills out a particular field, use the Required validation to have us check if the field is empty before submitting the entry. A message will be displayed to the user if they have not filled out the field. A red asterisk will appear to the right of the Field Title if the field is required.">(?)</a><br />
	<div id="fieldUniqueOpt">
	<input id="fieldUnique" class="checkbox fieldUniqueToggle" type="checkbox" value="" tabindex="15" onchange="(this.checked) ? checkVal = '1' : checkVal = '0';updateProps(checkVal, 'isunique')" /> 
	<label class="choice fieldUniqueToggle" for="fieldUnique">No Duplicates</label> <a href="#" class="tooltip fieldUniqueToggle" title="About No Duplicates" rel="Checking this validation will have us verify that the information entered into this field is unique and has not been submitted previously. Useful for mailing lists and registration forms, where preventing the users from entering the same information more than once is often needed."></a><br />
	</div>
</fieldset>
</li>

<li class="right half" id="listSecurity">

<fieldset class="fieldset">
<legend>Permissions</legend>
<input id="fieldPublic" name="security" class="radio" type="radio" value="" checked="checked" tabindex="16"
    onclick="updateProps('0', 'isprivate')" />
<label class="choice" for="fieldPublic">Public Access</label>
<a href="#" class="help" onclick="return false;"
rel="Set the field to 'Public Access' if you would like the field to be accessible by anyone when the form is made public.">(?)</a><br />

<input id="fieldPrivate" name="security" class="radio" type="radio" value="" tabindex="17"
 onclick="updateProps('1', 'isprivate')" />
<label class="choice" for="fieldPrivate">Admin Only</label>
<a href="#" class="help" onclick="return false;"
rel="Set the field to 'Admin Only' if you would like the field to ONLY be accessible via the Admin inteface. Fields that are set to 'Admin Only' will not be shown to users when the form is made public. Useful for forms that need to collect public submissions but then need to be ranked or added to privately in the Admin interface.">(?)</a><br />
</fieldset>
</li>

<li class="clear" id="listTextDefault">
<label class="desc" for="fieldDefault">
Default Value
<a href="#" class="help" onclick="return false;" rel="By setting this value, the field will be prepopulated with the text you enter when a user comes to visit your form. You can also set this to something like #FORM.userId# to load the data from existing variables.">(?)</a>
</label>
<input id="fieldDefault" class="text large" type="text" name="text" value="" tabindex="11" maxlength="255" onkeyup="updateProps($F(this), 'defaultval')" onblur="updateProps($F(this), 'defaultval')" />
</li>

<li class="clear" id="listInstructions">
<label class="desc" for="fieldInstructions">
Instructions for User 
<a href="#" class="help" onclick="return false;"
rel="This is an optional property that displays the text specified to your users while they're filling out that particular field. While the instructions do now show here in the Live Preview, they do appear off to the right side of the field when the form is published.">(?)</a>
</label>

<textarea class="textarea full" rows="10" cols="50" id="fieldInstructions" tabindex="18"
 onkeyup="updateProps(this.value, 'instructions')"
 onblur="updateProps(this.value, 'instructions')"></textarea>
</li>

<li class="clear" style="clear:both;">
<fieldset class="fieldset">
<legend>Conditional Logic
<a href="#" class="help" onclick="return false;" rel="Conditional Logic allows you to specify that this field will be hidden or visible depending on the values set in other fields.<br/><br/>Note: You need to have at least one drop-down or multiple choice field to use conditional logic.">(?)</a>
</legend>

	<input type="button" value="Use Conditional Logic" onclick="addConditionalLogic()" id="conditionalLogicBut">
	<div id="conditionalLogicDiv" style="display:none;overflow:hidden;">
		<table cellpadding="0" cellspacing="5"><tr>
		<td><select id="conditionalLogicShowOrHide" onchange="onChangeConditionLogic('action',this.value)" onblur="onChangeConditionLogic('action',this.value)" onkeyup="onChangeConditionLogic('action',this.value)"><option value="Show">Show<option value="Hide">Hide</select></td>
		<td>this field if</td>
		<td><select id="conditionalLogicAllOrAny" onchange="onChangeConditionLogic('bool',this.value)" onblur="onChangeConditionLogic('bool',this.value)" onkeyup="onChangeConditionLogic('bool',this.value)"><option value="AND">all<option value="OR">any</select></td>
		<td>of the following match:</td>
		</tr>
		</table>
		<div id="conditionalLogicTableDiv">
		</div>
	</div>
</fieldset>
</li>

</ul>

</form>