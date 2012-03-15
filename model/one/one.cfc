<cfcomponent name="one">

   <cfset variables.instance.oneID = createUUID() />
   <cfset variables.instance.providers = arrayNew(1) />
   
   <cffunction name="init" displayname="init" access="public" output="false" returntype="one">
      <cfargument name="oneID" type="uuid" required="false" default="#createUUID()#" />
      <cfargument name="providers" type="array" required="false" default="#arrayNew(1)#"/>
	      <cfset variables.instance = structNew() />  
	      <cfset setOneID(arguments.oneID) />
	      <cfset variables.instance.providers = arguments.providers>
	  <cfreturn this />
   </cffunction>

   <cffunction name="getOneID" access="public" hint="Getter for oneID" output="false" returnType="uuid">
      <cfreturn variables.instance.oneID />
   </cffunction>

   <cffunction name="setOneID" access="public" hint="Setter for oneID" output="false" returnType="void">
      <cfargument name="oneID" hint="" required="yes" type="uuid" />
      <cfset variables.instance.oneID = arguments.oneID />
   </cffunction>

   <cffunction name="getProviders" access="public" hint="Getter for Provider" output="false" returnType="array">
		<cfargument name="provider">
		<cfargument name="context">
		<cfargument name="role">
		<cfargument name="category">
		<cfscript>
			var rVal = variables.instance.providers;

			if (structKeyExists(arguments, 'provider')){
				rVal = this.applyFilter(rVal, 'provider', arguments.provider);
			}
			
			if (structKeyExists(arguments, 'context')){
				rVal = this.applyFilter(rVal, 'context', arguments.context);
			}
			
			if (structKeyExists(arguments, 'role')){
				rVal = this.applyFilter(rVal, 'role', arguments.role);
			}
			
			if (structKeyExists(arguments, 'category')){
				rVal = this.applyFilter(rVal, 'category', arguments.category);
			}
			
			return rVal;
		</cfscript>
   	</cffunction>
	
	<cffunction name="applyFilter">
		<cfargument name="data">
		<cfargument name="filterKey">
		<cfargument name="filterValue">
		
		<cfscript>
			var rVal = arrayNew(1);
			var i = 0;
			for(i=1;i lte arrayLen(arguments.data); i = i+1){
			    if (structKeyExists(arguments.data[i],arguments.filterKey) and evaluate('arguments.data[i].#arguments.filterKey#') eq arguments.filterValue){
			        arrayAppend(rVal, arguments.data[i]);
			    }
			}
	
			if (arrayLen(rVal)){
				return rVal;
			} else { 
				return arguments.data;
			}
		</cfscript>
	</cffunction>
	
   <cffunction name="getProvider" access="public" hint="Getter for Provider" output="false" returnType="struct">
	   	<cfargument name="provider">
	   	<cfset var pointer = arrayOfStructsFind(variables.instance.providers, 'provider', arguments.provider)>
	   	<cfif pointer eq 0>
	    	<cfset this.addProvider({provider=arguments.provider, authkey = ''})>
	    	<cfset pointer = 1>
		</cfif>
		<cfreturn variables.instance.providers[pointer]  />
   </cffunction>

   <cffunction name="addProvider" access="public" hint="Setter for Provider (really an appender)" output="false" returnType="void">
     <cfargument name="provider" required="yes" />
	 <Cfset var currentLength = arrayLen(variables.instance.providers)>
	 <cfset var nextPointer = currentLength + 1/>
	 <cfset var existPointer = arrayOfStructsFind(variables.instance.providers, 'provider', arguments.provider.provider)>
	 <cfif existPointer eq 0>
		 <cfset variables.instance.providers[nextPointer] = arguments.provider>
	 <cfelse>
		 <cfset variables.instance.providers[existPointer] = arguments.provider>
  	 </cfif>
 </cffunction>

  <cffunction name="updateMemberID" access="public" hint="Setter for Provider (really an appender)" output="false" returnType="void">
     <cfargument name="provider" required="yes" />
	 <cfargument name="memberID" required="yes">
	 <cfset var existPointer = arrayOfStructsFind(variables.instance.providers, 'provider', arguments.provider)>
	 <cfset variables.instance.providers[existPointer].memberID = arguments.memberID>
  </cffunction>

  <cffunction name="deleteProvider" access="public" hint="Setter for Provider (really an appender)" output="false" returnType="void">
     <cfargument name="provider" required="yes" type="struct" />
	 <cfset var existPointer = arrayOfStructsFind(variables.instance.providers, 'provider', arguments.provider.provider)>
	<cfset arrayDeleteAt(variables.instance.providers, existPointer)>
 </cffunction>


<cfscript>
/**
* Returns the position of an element in an array of structures.
*
* @param array      Array to search. (Required)
* @param searchKey      Key to check in the structs. (Required)
* @param value      Value to search for. (Required)
* @return Returns the numeric index of a match.
* @author Nath Arduini (nathbot@gmail.com)
* @version 0, June 11, 2009
*/
function arrayOfStructsFind(Array, SearchKey, Value){
    var result = 0;
    var i = 1;
    var key = "";
    for (i=1;i lte arrayLen(array);i=i+1){
        for (key in array[i])
        {
            if(array[i][key]==Value and key == SearchKey){
                result = i;
                return result;
            } 
        }
    }

	return result;
}
</cfscript>
</cfcomponent>