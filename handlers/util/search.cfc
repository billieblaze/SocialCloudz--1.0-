<!-----------------------------------------------------------------------
Author 	 :	Bill Berzinskas
Date     :	11/7/2010
Description : 			
 upload handler
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">
	
	<cffunction name="autocomplete" returntype="Void" output="false">
		<cfargument name="event" type="any">
	  	<cfscript>
			var rc = event.getCollection();
			var results = application.search.autocomplete(event.getValue('term',''));
			event.renderData('plain', application.utils.jsonEncode(application.util.QueryToArrayOfStructures(results)));
		</cfscript>
	</cffunction>
	
	<cffunction name="index">
	  <cfargument name="event" />
	  <cfscript>
		  	var rc = event.getCollection();
			announceInterception('checkPrivate');
			request.layout.edit = 1;
			event.setvalue('sResults', application.search.all(search=rc.search, contentType=rc.searchType, updateviews = 0));
			rc.sideBar = renderView('util/searchNav');
		</cfscript>
	</cffunction>
</cfcomponent>