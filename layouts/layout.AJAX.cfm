<cfsetting showdebugoutput="false">
<cfset event.showdebugpanel("false")>
<cfoutput>
		<!--- todo: centrailize this for all ajax calls..  PROBABLy use messagebox.. --->
		<cfif request.session.message neq ''>
			alertuser('<cfoutput>#request.session.message#</cfoutput>');
			<cfset request.session.message = ''>
		</cfif> 	
		
	#getPlugin("messageBox").renderit(true)#
	#renderView()#
	<script>stripeTable();</script>
</cfoutput>
