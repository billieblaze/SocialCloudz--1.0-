<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 commerce checkout
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>

	<cffunction name="index" returntype="Void" output="false">
        <cfargument name="event">

        <cfset var rc = event.getCollection()>

		<cfparam name="rc.planID" default="">
        <cfparam name="rc.productID" default="">
        <cfscript>
			if(isdefined('rc.startpage')) request.session.startpage = rc.startpage;
			if(isdefined('rc.successpage')) request.session.successpage = rc.successpage;
			request.layout.columns = 1;	
	    </cfscript>   
      </cffunction>
	
    <cffunction name="submit">
        <cfargument name="event">
		<cfset var rc = event.getCollection()>
		<cfparam name="rc.productID" default="0">
		<cfscript>
			// Setup Processing
			rc.ipaddress = request.session.ipaddress;
			rc.memberid = request.session.memberID;
			rc.email = request.session.email;
			rc.cardexp = '#rc.ccexpmo##rc.ccexpyr#';
			rc.desc = '#request.community.parent.baseurl# Web Services';
			rc.total = 0;			
			rc.communityID = rc.c;
			// todo: validation
			
			// Create Account
			rc.accountID = application.commerce.account.save(rc);
			
			// Create Transaction
			rc.response = 'handshake';
			rc.transactionID = application.commerce.transaction.save(rc);
			 
			cart = request.session.cart.list();

			productdata = structnew();
			productdata.transactionID = rc.transactionID;
			productdata.accountID = rc.accountID;
			productdata.communityID = rc.communityID;
			
			for(i=1; i lte arrayLen(cart); i=i+1){
				product = application.commerce.product.get(cart[i].productID);
				productdata.productID = product.ID;
				rc.total = rc.total + product.cost;
				application.commerce.transactionProduct.save(productdata);

				communityData.communityID = rc.communityID;
				communityData.bandwidth = request.community.bandwidth;
				communityData.storage = request.community.storage;
				
				if ( isdefined('cart[i].planID')){
					plan = application.commerce.plan.get(cart[i].planID);
					communityData.bandwidth = plan.bandwidth;
					communityData.storage = plan.storage;
					communityData.planID = plan.planID;
					if ( application.community.settings.get('ads') eq 0){ 
						communityData.ads = plan.advertising;
					}
					
					if ( application.community.settings.get('branding') eq 0){ 
						communityData.branding = plan.branding;
					}
				}
				
				switch (product.modifier){
					// Numerical Modifiers
					case "Bandwidth":
						communitydata.bandwidth = communitydata.bandwidth + product.modifierAmount;
						break;
					case "Storage":
						communitydata.storage = communitydata.storage + product.modifierAmount;
						break;
					// Bit Modifiers	
					case "Ads":
						communitydata.ads = 1;
						break;
					case "Branding":
						communitydata.branding = 1;
						break;
					case "Massmail":
						communitydata.massmail = 1;
						break;								
				}	

				productData.lastBilled = now();
				productData.recurringFrequency = 1;
				application.commerce.recurring.save(productData);
			}
					
			// Charge
			if (rc.ccnumber eq '1234123412341234'){
				response.ack = 'success';
				response.profileID = '';
				response.l_shortmessage0 = 'short';
				response.l_longmessage0 = 'long';
			} else {
				application.paypal.processTransaction(rc);
			}
			
			// Fail			
			if (response.ack neq 'success'){
				request.message = 'Error - #response.l_shortmessage0# - #response.l_longmessage0#';
				transactiondata.response = response.l_shortmessage0;								
				application.commerce.transaction.save(transactiondata);
				
			// Success	
			} else {
				transactiondata = rc;
				transactiondata.response = response.ack & ' - ' &  response.profileID;
				transactiondata.id = rc.transactionid;
				application.commerce.transaction.save(transactiondata);

				if(isdefined('communityData')){			
					 application.community.gateway.save(communityData);			 
				  	 application.community.settings.save(communitydata); 
				}
				 
				request.session.cart = createObject('component', 'model.commerce.cart').init();
				application.session.saveSession(cookie.token, request.session);
			}

			// If error, back to the form
			if (request.session.message neq ''){
				runEvent('commerce.checkout.main');
				event.setView('commerce/checkout/index');
			} else {	
				if ( isdefined('request.session.successPage')){
					relocate('#request.session.successpage#');
				} else { 
					setNextEvent('commerce.checkout.complete');
				}
			}
		</cfscript>
    </cffunction>
</cfcomponent>