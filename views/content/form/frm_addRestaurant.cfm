<cfoutput>
<script language="javascript" src="/scripts/form_autofocus.js"></script>
	#renderView('content/form/frm_top')#
		<div class="ui-widget">
	<div class="ui-widget-header">Add a Restaurant</div>
    <div class="ui-widget-content" align="Center"> 
    <div id="tabs">
    <ul>
        <li ><a href="##tabs-1" class="blackText">Details</a></li>
        <li><a href="##tabs-2" class="blackText">Edit Menu</a></li>
    </ul>            
        <div id="tabs-1" class="ui-tabs-hide">
				Title<br />
<input class="normalHelp" name="title" value="#rc.title#" type="text"  maxlength="255"  style="width:100%">
				<br /><BR />
			Body<br />
				#application.form.textEditor("desc",rc.desc)#
<BR>
<table width="100%">
<tr>
	<TD rowspan="6" valign="top">Cuisine<BR>
	<select name="food" multiple size="10">
		<cfset cuisineList = 'american,asian fusion,bakeries,barbeque,basque,beer,breakfast,british,brunch,burgers,cajun,chinese,coffee & tea,creole,deli,french,gastropub,german,greek,indian,irish pub,italian,japanese,mediterranean,mexican,middle eastern,pizza,polish,sandwiches,seafood,southern,spanish,spirits,sports bar,steakhouse,sushi,tapas,tex-mex,thai,vegetarian,vietnamese,wine'>
		<cfloop list="#cuisineList#" index="i">
			<option value="#i#" <cfif trim(application.content.getAttribute(rc.q_content.attribs, 'food')) contains i>selected</cfif>>#i#</option>
		</cfloop>
	</select>
	</TD>
<Td  valign="top">
Rating 
</td><td>
  <cfset ratingLevel = application.content.getAttribute(rc.q_content.attribs, 'ratingLevel')>
	<select name="ratingLevel">
	<option value="1" <cfif ratingLevel eq 1>selected</cfif>>1</option>
	<option value="2" <cfif ratingLevel eq 2>selected</cfif>>2</option>
	<option value="3" <cfif ratingLevel eq 3>selected</cfif>>3</option>
	<option value="4" <cfif ratingLevel eq 4>selected</cfif>>4</option>
	<option value="5" <cfif ratingLevel eq 5>selected</cfif>>5</option>
	</select>
</td><TD>
 Shade 
</td><td>
<select name="shade">
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'shade') eq 1>selected</cfif> value="1">Yes</option>
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'shade') neq 1>selected</cfif> value="0">No</option>
</select>
</TD></tr>
<TR><TD>
Price
</td><td>   
	<cfset price= application.content.getAttribute(rc.q_content.attribs, 'price')>
	<select name="price">
	<option value="$" <cfif price eq '$'>selected</cfif>>$</option>
	<option value="$$" <cfif price eq '$$'>selected</cfif>>$$</option>
	<option value="$$$" <cfif price eq '$$$'>selected</cfif>>$$$</option>
	<option value="$$$$" <cfif price eq '$$$$'>selected</cfif>>$$$$</option>
	</select>
</td><TD>
Under Cover
</td><td>   
<select name="undercover">
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'undercover') eq 1>selected</cfif> value="1">Yes</option>
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'undercover') neq 1>selected</cfif> value="0">No</option>
</select>
</TD></tr>
<TR><TD>
## of outside tables  
</td><td>
<cfset tables = application.content.getAttribute(rc.q_content.attribs, 'tables')>
<select name="tables">
<cfloop from="1" to="200" index="i">
<option value="#i#" <cfif tables eq i>selected</cfif>>#i#</option>
</cfloop>
</select>
</td><TD>
Lunch   
</td><td>
<select name="lunch">
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'lunch') eq 1>selected</cfif> value="1">Yes</option>
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'lunch') neq 1>selected</cfif> value="0">No</option>
</select>
</TD></tr>
<TR><TD>
Sunny at Lunch 
</td><td>
<select name="sunny">
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'sunny') eq 1>selected</cfif> value="1">Yes</option>
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'sunny') neq 1>selected</cfif> value="0">No</option>
</select>
</td><TD>
Dinner 
</td><td>
<select name="dinner">
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'dinner') eq 1>selected</cfif> value="1">Yes</option>
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'dinner') neq 1>selected</cfif> value="0">No</option>
</select>
</TD></tr>
<TR><TD>
 Umbrella's   
</td><td>
<select name="umbrellas">
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'umbrellas') eq 1>selected</cfif> value="1">Yes</option>
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'umbrellas') neq 1>selected</cfif> value="0">No</option>
</select>
</td>
<TD>
Brunch   
</td><td>
<select name="brunch">
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'brunch') eq 1>selected</cfif> value="1">Yes</option>
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'brunch') neq 1>selected</cfif> value="0">No</option>
</select><BR>
</td>
</tr>
<tr><td>
Pet Friendly 
</td><td>
<select name="pets">
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'pets') eq 1>selected</cfif> value="1">Yes</option>
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'pets') neq 1>selected</cfif> value="0">No</option>
</select>

</td><td>Patio Heaters</td>
<td>
<select name="heaters">
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'heaters') eq 1>selected</cfif> value="1">Yes</option>
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'heaters') neq 1>selected</cfif> value="0">No</option>
</select>
</td></tr>
<tr><td>
Romantic
</td><td>
<select name="romantic">
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'romantic') eq 1>selected</cfif> value="1">Yes</option>
<option <cfif application.content.getAttribute(rc.q_content.attribs, 'romantic') neq 1>selected</cfif> value="0">No</option>
</select>

</td><td></td>
<td>
</td></tr>
</table>
<BR>
				  <div align="center">
 By submitting this entry, you agree to the <a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions">Terms & Conditions</a>.<br />
<br />
<input type="submit" value="Save" class="button" /><input type="button" value="Cancel" onclick="history.back();" class="button" /></div>
	     </div>
              	<cfset frameHeight = 1500>  
	        <div id="tabs-2" class="ui-tabs-hide">   
    <iframe src="	/index.cfm/content/form/child/#event.getvalue('contentType')#/#rc.q_content.contentID#" scrolling="no" height="#frameheight#" width="100%" frameborder="0">
    </iframe>
</div>
		<br style="clear:left" />
</div>
</div>
</div>
</cfoutput>
<script>
 $(document).ready(function($) {
 		$("#tabs").tabs();
 });
</script>