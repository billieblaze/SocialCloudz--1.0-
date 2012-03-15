<cfcomponent>

	<cffunction name="init" returntype="paypal" access="public" output="false" >
		<cfreturn this>
	</cffunction>
	
	<cffunction name="processTransaction">
		<cfargument name="dataStruct">
		<cfhttp url="https://api-3t.paypal.com/nvp" method="post">
			<cfhttpparam name="USER" value="bill_api1.socialcloudz.com" type="formfield">
			<cfhttpparam name="PWD" value="MQC43TJKYH3TM7EY" type="formfield">
			<cfhttpparam name="SIGNATURE" value="AdOItfhwbDQ29dp2MiFLZ-ow2ITyA-AuZLfGbQWlfXWTqQCaHGcCqKk5" type="formfield">
			
			<cfhttpparam name="PAYMENTACTION" value="Sale" type="formfield">
			<cfhttpparam name="METHOD" value="DoDirectPayment" type="formfield">
			<cfhttpparam name="VERSION" value="54" type="formfield">
			<cfhttpparam name="IPADDRESS" value="#arguments.datastruct.ipaddress#" type="formfield">
			
			<cfhttpparam name="CREDITCARDTYPE" value="#arguments.datastruct.cardtype#" type="formfield">
			<cfhttpparam name="ACCT" value="#arguments.datastruct.cardnumber#" type="formfield">
			<cfhttpparam name="EXPDATE" value="#arguments.datastruct.cardexp#" type="formfield">
			<cfhttpparam name="CVV2" value="#arguments.datastruct.cardcvv2#" type="formfield">
			
			<cfhttpparam name="FIRSTNAME" value="#arguments.datastruct.firstname#" type="formfield">
			<cfhttpparam name="LASTNAME" value="#arguments.datastruct.lastname#" type="formfield">
			<cfhttpparam name="STREET" value="#arguments.datastruct.street#" type="formfield">
			<cfhttpparam name="CITY" value="#arguments.datastruct.city#" type="formfield">
			<cfhttpparam name="STATE" value="#arguments.datastruct.state#" type="formfield">
			<cfhttpparam name="COUNTRYCODE" value="#arguments.datastruct.countrycode#" type="formfield">
			<cfhttpparam name="ZIP" value="#arguments.datastruct.zip#" type="formfield">
			<cfhttpparam name="EMAIL" value="#arguments.datastruct.email#" type="formfield">
			
			<cfhttpparam name="DESC" value="#arguments.datastruct.desc#" type="formfield">
			<cfhttpparam name="AMT" value="#arguments.datastruct.amount#" type="formfield">
		</cfhttp>
		<cfreturn application.util.querystringtostruct(urldecode(cfhttp.filecontent))>
    </cffunction>
</cfcomponent>