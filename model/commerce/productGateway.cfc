<cfcomponent extends="../baseGateway">
	<cffunction name="get">
    	<cfargument name="ID">
    	<cfargument name="planID">
        <cfargument name="type" default="">
        <cfscript>
			return super.get('products', arguments);
		</cfscript>    
    </cffunction>
	
	<cffunction name="getFromIDList">
    	<cfargument name="idList">
		<Cfset var qGet = ''>
        <cfquery name="qGet" datasource='#this.datasource#'>
        	select * from products 
			where ID in (#arguments.idList#)
        </cfquery>
        <cfreturn qGet>
    </cffunction>
    
	<cffunction name="save">
       	<cfargument name="datastruct">
        <cfscript>
			return super.save('products', arguments.datastruct);
		</cfscript>
	</cffunction>

	<cffunction name="delete">
       	<cfargument name="id">
        <cfscript>
			return super.delete('products', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>