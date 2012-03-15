<cfscript>
plans = event.getvalue('plans');
</cfscript>

<cffunction name="checkMark">
	<cfargument name="value">
    <cfif arguments.value eq 1>
		<cfset rVal = '<img src="#application.cdn.fam#accept.png" alt="" />'>
    <cfelse>
	    <cfset rVal = '<img src="#application.cdn.fam#cross.png" alt="" />'>
    </cfif>
    <cfreturn rVal>
</cffunction>

<div class="mod">
	<div class="hd">Upgrade your plan</div>
	<div class="bd">
	<cfoutput>
	
		<form action='/index.cfm/commerce/upgrade/submit' method='post' name="priceForm">
		<input type="hidden" name="startPage" value="http://#request.community.baseurl#/index.cfm/commerce/upgrade/index" />
		<input type="hidden" name="successPage" value="http://#request.community.baseurl#/index.cfm/commerce/upgrade/index" />
		<table width="100%" style="border: 1px solid gray; font-size: 14px;" >
		    <tbody>
		        <TR style="background-color: silver;">
		        	<TD>Select a Plan</TD>
		            <TD align="center">
			            <input type="radio" name="planID" value="1" <cfif request.community.planid eq 1>checked</cfif>>
		            </TD>
		            <TD align="center">
			            <input type="radio" name="planID"  value="2" <cfif request.community.planid eq 2>checked</cfif>>					
					</TD>
		        </TR>    
		        <tr style="background-color: silver;font-weight: bold;">
		            <td>&nbsp;</td>
					 <td width="90" align="center">#plans.title[1]#</td>
		            <td width="90" align="center">#plans.title[2]#</td>
		        </tr>
		        <tr style="border-bottom: 1px solid gray; height: 25px;">
		            <td>Subscription</td>
			         <td align="center">$#plans.cost[1]#/mo.</td>   
					 <td align="center">$#plans.cost[2]#/mo.</td>
		        </tr>
		        <tr>
		            <td style="background-color: silver;font-weight: bold; height: 25px;" colspan="3">General</td>
		        </tr>
		        <tr style="border-bottom: 1px solid gray; height: 25px;">
		            <td>Bandwidth</td>
					<TD align="center">#application.util.byteConvert(plans.bandwidth[1])#</TD>
		            <td align="center">#application.util.byteConvert(plans.bandwidth[2])#</td>
		        </tr>
		        <tr style="border-bottom: 1px solid gray; height: 25px;">
		            <td>Storage</td>
		            <td align="center">#application.util.byteConvert(plans.storage[1])#</td>
		            <td align="center">#application.util.byteConvert(plans.storage[2])#</td>
		        </tr>
		        <tr style="height: 25px;">
		            <td>Your Domain Name</td>
		            <td align="center">#checkmark(plans.domain[1])#</td>
		            <td align="center">#checkmark(plans.domain[2])#</td>
		        </tr>
		        <tr>
		            <td style="background-color: silver;font-weight: bold; height: 25px;" colspan="3">Advertising</td>
		        </tr>
		        <tr style="border-bottom: 1px solid gray; height: 25px;">
		            <td>Your Advertising</td>
		            <td align="center">#checkmark(plans.advertising[1])#</td>
					<td align="center">#checkmark(plans.advertising[2])#</td>
		        </tr>
		        <tr style="height: 25px;">
		            <td>SocialCloudz Branding</td>
				    <td align="center">#checkmark(plans.branding[1])#</td>   
		    		<td align="center">#checkmark(plans.branding[2])#</td>
		        </tr>
		        <tr>
		            <td style="background-color: silver;font-weight: bold; height: 25px;" colspan="3">Services</td>
		        </tr>
		        <tr style="border-bottom: 1px solid gray; height: 25px;">
		            <td>Premium Support</td>
		            <td align="center">#checkmark(plans.support[1])#</td>
		            <td align="center">#checkmark(plans.support[2])#</td>
		        </tr>
		    </tbody>
		</table>
		<div align="center">
			<input type="submit" value="Update">
		</div>
		</cfoutput>		
		
		
	</div>
	<div class="ft"></div>
</div>