<cfset HH = DateFormat( now(), "HH" )>
<cfset MM = DateFormat( now(), "MM" )>
<cfset ampm = DateFormat( now(), "TT" )>
<cfset html = html & "<div class=""left sp6""><input type=""text"" name=""" & fieldName & "_HH"" value=""" & HH & """ class=""tiny"" onkeypress=""return twFormIsNumberKey(event)"" maxlength=""2""><div class=""info"">HH</div></div><div class=""left sep"">:</div>">
<cfset html = html & "<div class=""left sp6""><input type=""text"" name=""" & fieldName & "_MM"" value=""" & MM & """ class=""tiny"" onkeypress=""return twFormIsNumberKey(event)"" maxlength=""2""><div class=""info"">MM</div></div><div class=""left sep""></div>">
<cfset html = html & "<div class=""left sp6""><select name=""" & fieldName & "_TT""><option value=""AM""">
	<cfif ampm EQ "AM"><cfset html = html & " selected"></cfif>
<cfset html = html & ">AM</option><option value=""PM""">
<cfif ampm EQ "PM"><cfset html = html & " selected"></cfif>
<cfset html = html & ">PM</option></select><div class=""info"">AM/PM</div></div>">
<cfinclude template="../../inc_js_assist_twFormIsNumberKey.cfm">