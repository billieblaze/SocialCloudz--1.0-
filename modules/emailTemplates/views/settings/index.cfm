<cfsetting showdebugoutput="no">
<cfscript>
	userpreferences = event.getvalue('preferences');
	application.form.ajaxFormSubmit('settingForm');
</cfscript>
<cfoutput>
<form action="#event.buildLink('emailTemplates.settings.submit')#" method="post" id="settingForm">
  <input type='hidden' name='memberid' value='#rc.memberID#'>
    <cfset lastSection=""/>
    <cfloop query="UserPreferences">
      <cfif lastSection neq section >
        <cfset cnt = 1>
        <cfset lastSection = section />
        <B>#section#</B><hr>
		</cfif>
      <table width="100%" border="0" >
      <tr>
        <td width="30%" align="right">#DisplayName#</td>
        <td width="5%"></td>
        <td height="35" align="center">
		<select name="#name#">
		<option value="1" <cfif value eq 1>Selected</cfif>>Yes</option>
		<option value="0" <cfif value eq 0>Selected</cfif>>No</option>
		</td>
      </tr>
      <cfset cnt = cnt + 1>
      </table>
    </cfloop>
    <div align="center"><input type="submit" value="Update"  class="button" /></div>
</form>
</cfoutput>