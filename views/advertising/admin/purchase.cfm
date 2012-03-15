<cfoutput>
	You may remove and control your own advertising.  You will be billed monthly.<br /><br />
	<b>Ad Control: </b> $5/month<br><br>
	<br /><br />
	<form action="/index.cfm/index.cfm/commerce/cart/add" method="post">
		<input type="hidden" name="successPage" value="http://#request.community.baseurl#/index.cfm/app/dashboard/premium/communityID/#request.community.communityID###ui-tabs-2" />
        <input type="hidden" name="c" value="#request.community.communityID#" />
		<input type="hidden" name="productID" value="11" />
		<input type="hidden" name="price" value="20">
		<input type="hidden" name="quantity" value="1">
		<input type="submit" value="Proceed to Payment" class="button" />
  </form>
</cfoutput>