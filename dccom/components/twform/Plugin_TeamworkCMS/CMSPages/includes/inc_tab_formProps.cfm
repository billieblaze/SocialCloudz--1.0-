<cfparam name="FORM.passwordProtect" default="no" type="boolean">
<cfparam name="FORM.formpassword" default="" type="string">
<cfparam name="FORM.emailCopy" default="no" type="boolean">
<cfparam name="FORM.style" default="any" type="string">


<form id="formProperties" action="##" onsubmit="return false;">
<ul>

<li>
<label class="desc" for="formDesc">Description <a class="help" title="About Form Description" 
rel="Use this property to display a short description or any instructions, notes, or guidelines that your user should read when filling out the form. This will appear directly below the form name."></a></label>
<textarea class="textarea small" rows="10" cols="50" id="formDesc" tabindex="2"
 onkeyup="updateForm(this.value, 'description')"
 onblur="updateForm(this.value, 'description')"></textarea>
</li>
 
 <li>
<label class="desc" for="formSubmitButtonText">Submit Button Text <a class="help"
rel="At the bottom of the form is the 'Submit' button. You can change the text on this from 'Submit' to a custom message such as 'Send feedback' or 'Complete survey'."></a></label>
<input id="formSubmitButtonText" class="text medium" type="text" value="" tabindex="1" maxlength="50"
 onkeyup="updateForm(this.value, 'submitbuttontext')"
 onblur="updateForm(this.value, 'submitbuttontext')" />
</li>

<li>
<input id="formCopyEmailCheckbox" class="checkbox" type="checkbox" value="" onclick="updateForm( this.checked, 'formCopyEmailCheckbox' );"/>
<label class="choice" for="formCopyEmailCheckbox"><b>Send a Copy of New Entries via Email</b></label>
<a class="help" rel="If you would like every successfully submitted entry from this form to be emailed to you, check this option on and type in the email address where you'd like a summary of the entry to be sent to. Multiple email addresses may be entered here by separating them with a comma.'"></a><br />
<fieldset id="formCopyEmailCheckboxDiv" class="hide">
	<label class="desc" for=""><b>Send To: </b> <a class="help" rel="Email address to send the copy of each submission to."></a></label>
	<input id="formCopyEmailTo" style="width:90%" type="text" value="" size="25" tabindex="4" maxlength="255" <!--- onkeyup="updateForm(this.value, 'formCopyEmailTo')" onblur="updateForm(this.value, 'formEmailVal')" --->/>
</fieldset>
</li>
<li>
<input id="formReceiptCheckbox" class="checkbox" type="checkbox" value="" onclick="updateForm( this.checked, 'formReceiptCheckbox' );"/>
<label class="choice" for="formReceiptCheckbox"><b>Send an Email Receipt to the User</b></label>
<a class="help" rel="Check this off to send an email to the user when their entry is successfully submitted. Requires your form to have an email field."></a><br />
<fieldset id="formReceiptEmailDiv" class="hide">
	<label class="desc" for="formReceiptEmailTo"><b>Send To:</b> <a class="help" rel="Select the email field you want us send the receipt to. You must choose one of the 'email' type fields on the form. If you have no email field, we cannot send the form."></a></label>
	<select id="formReceiptEmailTo" name="" class="select" style="width:170px;"></select>
	<label class="desc" for="formReceiptEmailReplyTo"><b>Reply To:</b> <a class="help" title="About Reply To:" rel="Email address you want the users to send messages when they reply to the receipt. If you don't want them to email you, just leave it blank."></a></label>
	<input id="formReceiptEmailReplyTo" class="text" type="text" value="" size="25" tabindex="4" maxlength="255" <!--- onkeyup="updateForm(this.value, 'formReceiptEmailTo')" onblur="updateForm(this.value, 'receiptReplyTo')"---> />
	<div>
	<label class="desc" for="formReceiptEmailMsg"><b>Custom Message for Email: </b> <a class="help" title="About Reply To:" rel="This message will be displayed in the email that is sent to the user."></a></label>
	<textarea style="width:90%;height:200px;" rows="8" wrap="off" cols="50" id="formReceiptEmailMsg" tabindex="9"></textarea>
	</div>
</fieldset>
</li>

<li>
<fieldset>
<legend>Confirmation Message</legend>
<div class="left">
<input id="confirmationType_Message" name="confirmationType" class="radio" type="radio" value="Show Text" checked="checked" tabindex="8" onclick="updateForm('Show Text', 'confirmationOpt'); Element.removeClassName('confirmMsg', 'hide');Element.addClassName('formRedirectVal', 'hide')" />
<label class="choice" for="confirmationType_Message">Show Text</label>
<a class="help" rel="After your users have successfully submitted an entry, they will be sent to Confirmation Page, which will display the text you have specified here." ></a>
</div>

<div class="right">
<input id="confirmationType_redirect" name="confirmationType" class="radio" type="radio" value="redirect" tabindex="7" 
    onclick="updateForm( 'Redirect', 'confirmationOpt'); Element.addClassName('confirmMsg', 'hide');Element.removeClassName('formRedirectVal', 'hide');" />
<label class="choice" for="confirmationType_redirect">Redirect URL</label>
<a class="help" rel="After your users have successfully submitted an entry, you can redirect them to another 
website. This will bypass the default Confirmation Page, and send them directly to a URL 
of your choice."></a>
</div>

<textarea class="textarea full hide" rows="10" cols="50" id="confirmMsg" tabindex="9" 
     onkeyup="updateForm($F(this), 'confirmMsg')" onblur="updateForm($F(this), 'confirmMsg')" ></textarea>

<input id="formRedirectVal" class="text full hide" type="text" name="text" value="http://" tabindex="10" 
 onkeyup="updateForm($F(this), 'redirectURL')"
 onblur="updateForm($F(this), 'redirectURL')" />
</fieldset>
</li>

<!--- Administrator Only --->

<input id="includeOnSubmit" type="hidden" name="text" value="" tabindex="19" />

<input type="hidden" name="" id="formStyle" value="Default" />
</ul>
<div id="formButtons1" class="buttons">
	<a class="textfield_add" href="#" onclick="showFields();return false">Add Another Field</a>
	<a href="javascript:saveForm()" class="ok">Save Form</a>
</div>
<br/><br/><br/><br/>
</form>