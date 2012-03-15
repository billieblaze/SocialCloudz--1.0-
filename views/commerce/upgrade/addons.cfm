<cfscript>
premium = event.getvalue('premium');
products = event.getvalue('products');
</cfscript>
<cfoutput>

<div class="mod">
	<div class="hd">Premium</div>
	<div class="bd">

	    <cfloop query="premium">
			<cfif not isStruct(request.session.cart.get(id))>
				<cfset checkSetting = application.community.settings.getValue(premium.modifier)>
				<cfif checkSetting eq 0>
					<input type="checkbox" name="premium" value='#ID#' /> #name# - $#cost#<BR />
				<cfelse>
					<img src="/images/fam/tick.png" width="10" height="10"> #name#<br>
				</cfif>
			</cfif>
		</cfloop>
    </div>
    <div class="ft"></div>
</div>

<div class="mod">
	<div class="hd">Add-ons</div>
	<div class="bd">
		<cfloop query="products">
			<cfif not isStruct(request.session.cart.get(id))>
				<input type="checkbox" name="addOn" value="#ID#" /> #name# - $#cost#<BR />
			</cfif>
		</cfloop>
	</div>
	<div class="ft"></div>
</div>
</form>
</cfoutput>