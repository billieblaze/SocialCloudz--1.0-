<cfoutput>
<form action="#event.buildLink('commerce.cart.update')#" method="post">
<div class="mod">
	<div class="hd">Cart</div>
	<div class="bd">
		<cfset cart = request.session.cart.list()>
		<cfset subtotal = 0>
		<table width="100%">
			<tr>
				<td align="center">Remove</td>
				<td>Name</td>
				<td align="center">Quantity</td>
				<td>Price</td>
				<td>Total</td>
			</tr>
			<cfloop from="1" to="#arrayLen(cart)#" index="i">
				<cfset product = application.commerce.product.get(cart[i].productID)>
				<cfset quantity = cart[i].quantity>
				<cfset price = quantity * product.cost>
				<Cfset subtotal = subtotal + price>
				<tr>
					<td align="center"><input type="checkbox" name="productID" value="#product.id#"></td>			
					<td>#product.name#</td>
					<td align="center"><input type="text" name="quantity_#product.id#" value="#quantity#" style="width:20px"></td>
					<td>#dollarFormat(product.cost)#</td>
					<td>#dollarFormat(price)#</td>
				</tr>
			</cfloop>
			<tr>
				<td colspan="3"></td>
				<td>Total:</td>
				<td>#dollarFormat(subtotal)#</td>
			</tr>
		</table>
		<div align="center">
			<input type="submit" value="Update" class="button">
			<input type="button" value="Empty" class="button" onclick="location.href='#event.buildLink('commerce.cart.clear')#';">
			<input type="button" value="Checkout" class="button" onclick="location.href='#application.secureServer#/index.cfm/commerce/checkout/index?i=#cookie.token#&c=#request.community.communityID#';">
		</div>
	</div>
	<div class="ft"></div>
</div>
</form>
</cfoutput>