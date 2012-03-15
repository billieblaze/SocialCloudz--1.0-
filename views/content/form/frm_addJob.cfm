<cfoutput>
<script>
	duplicatePost = function(){
		$('##contentID').val('0');
		$('##content').submit();
	}
</script>
	<script language="javascript" src="/scripts/form_autofocus.js"></script>
	#renderView('content/form/frm_top')#
	 <div class="ui-widget">
	<div class="ui-widget-header">
	Add a Job Posting
	</div>
    <div class="ui-widget-content" style="padding-right : 2em;">
		Job Post Title<br />
		<input class="normalHelp" name="title" value="#rc.title#" type="text"  maxlength="255"  style="width:95%">
		<br /><BR />
		Position<br />
		<select name="subtitle"  class="normalHelp">
			<option value="Accounting" <cfif rc.subtitle eq 'Accounting'>selected</cfif>>Accounting</option>
		    <option value="Administrative Assistant" <cfif rc.subtitle eq 'Administrative Assistant'>selected</cfif>>Administrative Assistant</option>
		    <option value="Branch Manager" <cfif rc.subtitle eq 'Branch Manager'>selected</cfif>>Branch Manager</option>
		    <option value="Business Manager" <cfif rc.subtitle eq 'Business Manager'>selected</cfif>>Business Manager</option>
		    <option value="Closer" <cfif rc.subtitle eq 'Closer'>selected</cfif>>Closer</option>
		    <option value="Compliance Officer" <cfif rc.subtitle eq 'Compliance Officer'>selected</cfif>>Compliance Officer</option>
		    <option value="Corporate and Credit Union Partnering" <cfif rc.subtitle eq 'Corporate and Credit Union Partnering'>selected</cfif>>Corporate and Credit Union Partnering</option>
		    <option value="Correspondent Operations" <cfif rc.subtitle eq 'Correspondent Operations'>selected</cfif>>Correspondent Operations</option>		   
		    <option value="Escrow Specialist" <cfif rc.subtitle eq 'Escrow Specialist'>selected</cfif>>Escrow Specialist</option>
		    <option value="Executive Assistant" <cfif rc.subtitle eq 'Executive Assistant'>selected</cfif>>Executive Assistant</option>
		    <option value="Human Resources" <cfif rc.subtitle eq 'Human Resources'>selected</cfif>>Human Resources</option>
		    <option value="Information Security Officer" <cfif rc.subtitle eq 'Information Security Officer'>selected</cfif>>Information Security Officer</option>
		    <option value="Inside sales/telemarketing" <cfif rc.subtitle eq 'Inside sales/telemarketing'>selected</cfif>>Inside sales/telemarketing</option>
		   	<option value="Loan Officer Assistant" <cfif rc.subtitle eq 'Loan Officer Assistant'>selected</cfif>>Loan Officer Assistant</option>
		    <option value="Marketing" <cfif rc.subtitle eq 'Marketing'>selected</cfif>>Marketing</option>
		    <option value="Mortgage Banker" <cfif rc.subtitle eq 'Mortgage Banker'>selected</cfif>>Mortgage Banker</option>
		    <option value="Mortgage Broker" <cfif rc.subtitle eq 'Mortgage Broker'>selected</cfif>>Mortgage Broker</option>
		    <option value="Mortgage Loan Officer [MLO]" <cfif rc.subtitle eq 'Mortgage Loan Officer [MLO]'>selected</cfif>>Mortgage Loan Officer [MLO]</option>
		    <option value="Open a Net Branch" <cfif rc.subtitle eq 'Open a Net Branch'>selected</cfif>>Open a Net Branch</option>
		    <option value="Operations Manager" <cfif rc.subtitle eq 'Operations Manager'>selected</cfif>>Operations Manager</option>
		    <option value="Post Closing Auditor" <cfif rc.subtitle eq 'Post Closing Auditor'>selected</cfif>>Post Closing Auditor</option>
		    <option value="Processor" <cfif rc.subtitle eq 'Processor'>selected</cfif>>Processor</option>
		    <option value="Quality Control Manager" <cfif rc.subtitle eq 'Quality Control Manager'>selected</cfif>>Quality Control Manager</option>
		    <option value="Receptionist" <cfif rc.subtitle eq 'Receptionist'>selected</cfif>>Receptionist</option>
		    <option value="Regional Manager" <cfif rc.subtitle eq 'Regional Manager'>selected</cfif>>Regional Manager</option>
  		    <option value="Retail Operations" <cfif rc.subtitle eq 'Retail Operations'>selected</cfif>>Retail Operations</option>
		    <option value="Retail Sales" <cfif rc.subtitle eq 'Retail Sales'>selected</cfif>>Retail Sales</option>
		    <option value="Sales Manager" <cfif rc.subtitle eq 'Sales Manager'>selected</cfif>>Sales Manager</option>
		    <option value="Technology" <cfif rc.subtitle eq 'Technology'>selected</cfif>>Technology</option>
		    <option value="Underwriter" <cfif rc.subtitle eq 'Underwriter'>selected</cfif>>Underwriter</option>
		    <option value="VA Underwriter" <cfif rc.subtitle eq 'VA Underwriter'>selected</cfif>>VA Underwriter</option>
		    <option value="Web Design" <cfif rc.subtitle eq 'Web Design'>selected</cfif>>Web Design</option>
		    <option value="Wholesale Acct Exec" <cfif rc.subtitle eq 'Wholesale Acct Exec'>selected</cfif>>Wholesale Acct Exec</option>
		    <option value="Wholesale Management" <cfif rc.subtitle eq 'Wholesale Management'>selected</cfif>>Wholesale Management</option>
		    <option value="Wholesale Operations" <cfif rc.subtitle eq 'Wholesale Operations'>selected</cfif>>Wholesale Operations</option>
		    <option value="Wholesale Sales" <cfif rc.subtitle eq 'Wholesale Salesgy'>selected</cfif>>Wholesale Sales</option>
		</select>
		<!--- <input class="normalHelp" name="subtitle" value="#rc.subtitle#" type="text"  maxlength="255"  style="width:95%"> --->
		<br /><BR />
		Compensation Package<br />
		<input class="normalHelp" name="salary" value="#application.content.getAttribute(rc.q_content.attribs, 'salary')#" type="text"  maxlength="255"  style="width:95%">
		<br /><BR />
		NMLS License Required: &nbsp;
		<!---<input class="normalHelp" name="licensed" value="#application.content.getAttribute(rc.q_content.attribs, 'licensed')#" type="text"  maxlength="255"  style="width:75%">--->
		<select name="licensed">
			<option <cfif application.content.getAttribute(rc.q_content.attribs, 'licensed') eq 1>selected</cfif> value="1">Yes</option>
			<option <cfif application.content.getAttribute(rc.q_content.attribs, 'licensed') neq 1>selected</cfif> value="0">No</option>
		</select>&nbsp;<br />
		States: &nbsp;
		<input class="normalHelp" name="states" value="#application.content.getAttribute(rc.q_content.attribs, 'states')#" type="text"  maxlength="255"  style="width:50%"><br><br />
		Start Date<br />
		<input class="normalHelp" name="jobStartDate" value="#application.content.getAttribute(rc.q_content.attribs, 'jobStartDate')#" type="text"  maxlength="255"  style="width:95%"><br><br />
		How to Apply<br />
		<input class="normalHelp" name="howToApply" value="#application.content.getAttribute(rc.q_content.attribs, 'howToApply')#" type="text"  maxlength="255"  style="width:95%"><br><br />
		<br /><BR />
		Body<br />
		#application.form.textEditor("desc",rc.desc)#
		<BR>
	 	<div align="center">
			 By submitting this entry, you agree to the <a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions">Terms & Conditions</a>.<br />
		<br />
		
		
	
		<input type="submit" value="Save" class="button" />
		<input type="button" value="Cancel" onclick="history.back();" class="button" />
		<input type="button" onclick="duplicatePost();" value="Clone" class="button">
		</div>
	</div>
	</div>
</cfoutput>
     
        
