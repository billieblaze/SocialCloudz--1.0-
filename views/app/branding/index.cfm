<cfoutput>
	To further brand your site as your own, you can pay to remove the SocialCloudZ branding. 
	If you purchase this service, we will remove our logo from the top of your site and also remove the 
	&quot;Social CMS Platform by SocialCloudZ&quot; link from the footer.<br>
	<br>
	<cfif application.community.settings.getValue('Branding')>
		You have already disabled branding on your site.
	<cfelse>
		<b>Remove Branding: </b> $5/month<br><br>
	    <form action="/index.cfm/index.cfm/commerce/cart/add" method="post">
	        <input type="hidden" name="successPage" value="http://#request.community.baseurl#/index.cfm/app/dashboard/premium/communityID/#request.community.communityID###ui-tabs-3" />
	        <input type="hidden" name="c" value="#request.community.communityID#" />
			<input type="hidden" name="productID" value="12" />
			<input type="hidden" name="price" value="5">
			<input type="hidden" name="quantity" value="1">
			<input type="submit" value="Proceed to Payment" class="button" />
	  </form>
	</cfif>
	<br>
	<br>
</cfoutput>