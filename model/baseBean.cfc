<Cfcomponent>
	<cffunction name="init">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getMemento" output="false" access="public" returntype="struct" hint="Default memento dump function - only works if the CFC is using cfproperty tags">
        <cfset var instance = StructNew()>
        <cfset var md = getMetaData(this).properties>
        <cfset var x = 0>
       
        <cfloop from="1" to="#ArrayLen(md)#" index="x">
            <cfset instance[md[x].name] = variables[md[x].name]>
        </cfloop>
        <cfreturn instance>
    </cffunction>

	<cffunction name="setMemento" access="public"  output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset var thisItem = ''>
		<cfloop collection="#arguments.memento#" item="thisItem">
			<cfset 'variables.#thisItem#' = evaluate('arguments.memento.#thisItem#') />
		</cfloop>
	</cffunction>
	
</cfcomponent>