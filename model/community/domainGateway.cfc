<cfcomponent extends="../baseGateway" >
	<cffunction name="get">
	 	<cfargument name="name">
	 	<cfargument name="domainID">
	 	<cfreturn super.get('domains', arguments)>
	</cffunction>

    <cffunction name="save">
    	<cfargument name="dataStruct">
        <cfscript>
			return super.save('domains', arguments.datastruct);
		</cfscript>
    </cffunction>
	
	<cffunction name="getMask">
		<cfargument name="domain">
        <cfscript>
			var mask = super.get('dnsMask',{id = arguments.domain.getID()} );
			var myStruct = this.queryRowToStruct(mask);
			if (mask.recordcount eq 1){
				arguments.domain.setMemento( memento = myStruct );
	      		return true;
			} else { 
	   			return false;
   			}
		</cfscript>
	</cffunction>
	
	<cffunction name="listMask">
		<cfargument name="subdomain">
		<cfargument name="domain">
		<cfargument name="communityID">
		<cfargument name="sort" default="id desc">
        <cfscript>
			return super.get('dnsMask', arguments, arguments.sort);
		</cfscript>
	</cffunction>
	
	<cffunction name="saveMask">
		<cfargument name="dataStruct">
        <cfscript>
			return super.save('dnsMask', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteMask">
		<cfargument name="id">
        <cfscript>
			return super.delete('dnsMask', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>