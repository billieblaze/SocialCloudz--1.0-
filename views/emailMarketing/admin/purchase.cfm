<cfoutput>
	Contact your members with external emails or newsletters. <BR><BR>
	<b>Email Marketing: </b> $20/month<br><br>
	<form action="/index.cfm/index.cfm/commerce/cart/add" method="post">
		<input type="hidden" name="successPage" value="http://#request.community.baseurl#/index.cfm/app/dashboard/premium/communityID/#request.community.communityID###ui-tabs-1" />
        <input type="hidden" name="c" value="#request.community.communityID#" />
		<input type="hidden" name="productID" value="18" />
		<input type="hidden" name="price" value="20">
		<input type="hidden" name="quantity" value="1">
		<input type="submit" value="Proceed to Payment" class="button" />
  	</form>
</cfoutput>
