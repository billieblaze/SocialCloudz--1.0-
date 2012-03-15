<cfif request.community.bandwidth lte application.server.bandwidth.check(request.community.communityID, 'month').total
		or 
		request.community.storage lte application.server.storage.check(request.community.communityID, 'month')>

	<div class="mod">
		<div class="hd">Attention</div>
		<div class="bd">
			<cfif request.community.bandwidth lte application.server.bandwidth.check(request.community.communityID, 'month').total>
				You have exceeded your bandwidth allocation.<BR><BR>
			</cfif>
			<cfif request.community.storage lte application.server.storage.check(request.community.communityID, 'month')>
				You have exceeded your storage allocation. <BR /><BR>
			</cfif>
		</div>
		<div class="ft"></div>
	</div>
</cfif>