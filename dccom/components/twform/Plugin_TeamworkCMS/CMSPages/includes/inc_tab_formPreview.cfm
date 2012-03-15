<form id="formPreview" action="#" class="formWizForm">

<div id="formIntro" class="editItem" onclick="onClickFormIntro()">

	
	<div id="formDescription" class="desc"></div>

</div>

<ul id="formFields">
</ul>

<div id="formButtons" class="buttons" style="display:none">
	<a class="textfield_add" href="#" onclick="showFields();return false">Add Another Field</a>
	<a href="javascript:saveForm()" class="ok">Save Form</a>
</div>

<div class="message" style="display:none" id="nofieldsMsg" onclick="showFields(true)">
<h3>This form has no fields!</h3>
<p>Use the buttons under the "Add Field" tab on the left to add inputs to your form. Click on the fields to change their properties.</p>
</div>

</form>