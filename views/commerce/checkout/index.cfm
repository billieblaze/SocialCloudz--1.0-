
<cfparam name="rc.fname" default="">
<cfparam name="rc.lname" default="">
<cfparam name="rc.address" default="">
<cfparam name="rc.city" default="">
<cfparam name="rc.state" default="">
<cfparam name="rc.zip" default="">
<cfparam name="rc.country" default="">
<cfparam name="rc.ccnumber" default="">
<cfparam name="rc.cardtype" default="">
<cfparam name="rc.ccexpmo" default="">
<cfparam name="rc.ccexpyr" default="">
<cfparam name="rc.cccvv2" default="">

<cfoutput>
<form action="/index.cfm/commerce/checkout/submit" method="post">
	<input type="hidden" name="memberId" value="#request.session.memberID#">
	<input type="hidden" name="c" value="#rc.c#">
	<div class="mod">
	<div class="hd">Payment</div>
	<div class="bd">
		<B>Billing Information:</B> <br />
	 	<table width="100%" border="0">
		<tr>
	        <td width="28%" >Name  </td>
			<TD><input type="text" name="fname" value="#rc.fname#"/> <input type="text" name="lname" value="#rc.lname#"/></td>
	   	</tr>
	    <tr>
	        <td width="28%" >Address</td>
	        <td ><input type="text" name="address" value="#rc.address#" size="47"/></td>
	    </tr>
	    <tr>
	        <td width="28%" ></td>
	        <td >
				<input type="text" name="city" value="#rc.city#"/> 
				<cfmodule template="/customTags/state.cfm" selectName = 'state' value="#rc.state#">
				<input type="text" name="zip" value="#rc.zip#" size="7"/>
			</td>
	   	</tr>
	    <tr>
	        <td width="28%" >Country  </td>
	        <td >
  				<cfmodule template="/customTags/country.cfm" selectName = 'country' value="#rc.country#"/>
			</td>
	    </tr>
	    </table>
	   <BR /><BR />
	   <B>Credit Card Information:</B><BR /> 
	    <table width="100%" border="0">
	      <tr>
		      <td width="28%" >Card Type </td>
		        <td >
		        <select name="cardType">
		        	<option value="Visa">Visa</option>
		            <option value="Mastercard">Mastercard</option>
		            <option value="Amex">American Express</option>
		            <option value="Discover">Discover</option>
		        </select>
		        </td>
          </tr>
	      <tr>
		      	<td width="28%" >Card Number </td>
	          	<td ><input type="text" name="ccnumber" value="#rc.ccnumber#"/></td>
	      </tr>
	      <tr>
		      	<td width="28%" >Expiration </td>
	        	<td ><input type="text" name="ccExpMo" value="#rc.ccexpmo#" size="3"/>/<input type="text" name="ccExpYr" value="#rc.ccexpyr#" size="5"/></td>
	      </tr>
	      <tr>
	      		<td width="28%" >CVV2 </td>
	        	<td ><input type="text" name="cccvv2" value="#rc.cccvv2#" size="3"/></td>
	      </tr>
		</table>
		<BR /><BR /> 
		<Div align="center">
			<input type="submit" value="Next">
		</Div>
		<cfif rc.planID neq 0>
			After your free trial, you will be charged a monthly subscription fee.  
			To avoid these charges, you may cancel your subscription at any time during the trial 
			period by going to the Change My Plan section of my.socialgo.com 
		</cfif>
		</cfoutput>
	</div>
	<div class="ft"></div>
</div>