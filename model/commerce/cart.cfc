<cfcomponent>
	<cffunction name="init">
		<cfset this.cart = arrayNew(1)>
		<cfreturn this>
	</cffunction>

	<Cffunction name="get">
		<cfargument name="productID">
		<cfscript>
			var pointer = arrayOfStructsFind(this.cart, 'productID', arguments.productID);
			if (pointer eq 0){
				return 0;
			} else { 
				return this.cart[pointer];	
			}
		</cfscript>
	</cffunction>
	
	<Cffunction name="list">
		<cfreturn this.cart>
	</cffunction>
	
	<cffunction name="add">
		<Cfargument name="productID">
		<cfargument name="quantity">
		<cfargument name="price">
		<cfargument name="planID">
		
		<cfscript>
			var pointer = arrayOfStructsFind(this.cart, 'productID', arguments.productID);
			var hasPlan = arrayOfStructsFind(this.cart, 'planID');
			var planID = '';

			// only one plan at a time in the cart
			if (isdefined('arguments.planID') and hasPlan gt 0){
			 	planID = this.cart[hasPlan].productID;
			 	
			  	if(planID eq arguments.planID){
					return 1;
				} else {
					this.remove(planID);
					pointer = 0;
				}
			}

			// if the product has been added already, increment the quantity
			if (pointer gt 0){
				this.cart[pointer].quantity = this.cart[pointer].quantity + arguments.quantity;
			
			// otherwise, add it to the cart
			} else { 			
				pointer = arrayLen(this.cart)+1;
				this.cart[pointer] = structNew();
				this.cart[pointer].productID = arguments.productID;
				this.cart[pointer].quantity = arguments.quantity;
				this.cart[pointer].price = arguments.price;			
			}
			
			// if it's a plan, store the id
			if (structKeyExists(arguments, 'planId')){
				this.cart[pointer].planID = arguments.planID;
				this.cart[pointer].quantity = 1;
			}
			
			return 1;
		</cfscript>
	</cffunction>
	
	<cffunction name="update">
		<cfargument name="productID">
		<cfargument name="quantity">
		<cfscript>
			var pointer = arrayOfStructsFind(this.cart, 'productID', arguments.productID);
			this.cart[pointer].quantity = arguments.quantity;
			
			return 1;
		</cfscript>
	</cffunction>
	
	<cffunction name="remove">
		<cfargument name="productID">
		<cfscript>
			var pointer = arrayOfStructsFind(this.cart, 'productID', arguments.productID);
			arrayDeleteAt(this.cart,pointer);
			
			return 1;
		</cfscript>
	</cffunction>
	
	<cfscript>
		function arrayOfStructsFind(Array, SearchKey, Value){
		    var result = 0;
		    var i = 1;
		    var key = "";
			
		    for (i=1;i lte arrayLen(array);i=i+1){
		        for (key in array[i])
		        {
		            if ( key eq SearchKey and not isDefined('Value')){
						result = i;
		            	return result;
		            } else if (isDefined('Value')) {
			            if(array[i][key]==Value and key == SearchKey){
			                result = i;
			                return result;
			            }
					}
		        }
		    }
			return result;
		}
	</cfscript>
</cfcomponent>