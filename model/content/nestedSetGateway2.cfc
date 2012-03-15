<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfset var qSet = ''>
		<cfquery datasource="#this.datasource#" name="qSet">

		select CONCAT( REPEAT( '----', (COUNT(ct.contenttype) - 1)), ct.contenttype) as name
		from nestedsets ns
		inner join nestedsets node on ns.lft BETWEEN node.lft AND node.rgt
		inner join contenttype ct on ct.contentTypeId = ns.nodeID
		group by ct.contenttype
		order by ns.lft;
		</cfquery>
		<cfreturn qSet>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="newType">
		<cfargument name="newNodeID">
		<cfargument name="parentNodeID">

		<cfset var qSet = ''>
		<cfset var qSet2 = ''>
		<cfquery datasource="#this.datasource#" name="qSet">
			SELECT  rgt
			FROM contentstore.nestedsets
			WHERE type = '#arguments.newType#' 
			and nodeId = '#arguments.parentNodeID#';
		</cfquery>

		<cfquery datasource="#this.datasource#" name="qSet2">
			UPDATE contentstore.nestedsets 
			SET rgt = rgt + 2 
			WHERE rgt >= '#qSet.rgt#' 
			and type='#arguments.newType#';
		</cfquery>

		<cfquery datasource="#this.datasource#" name="qSet2">
			UPDATE contentstore.nestedsets 
			SET lft = lft + 2 
			WHERE lft > '#qSet.rgt#' 
			and type='#arguments.newType#';
		</cfquery>

		<cfquery datasource="#this.datasource#" name="qSet2">
			INSERT INTO contentstore.nestedsets
			(type, nodeId, lft, rgt)
			VALUES
			('#arguments.newType#', '#arguments.newNodeID#', '#qSet.rgt#' , '#qSet.rgt+1#');
		</cfquery>
	</cffunction>
	
	<cffunction name="delete">

	</cffunction>
</cfcomponent>	

