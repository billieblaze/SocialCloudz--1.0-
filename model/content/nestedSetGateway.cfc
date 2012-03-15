<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfset var qSet = ''>
		<cfquery datasource="#this.datasource#" name="qSet">
			select contentID,contentType, COUNT(c.contentID) as depth
			from nestedsets ns
			inner join nestedsets node on ns.lft BETWEEN node.lft AND node.rgt
			inner join content c on c.contentId = ns.nodeID
			group by ns.nestedSetID, c.contentID,ns.nodeID
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
			WHERE nodeId = '#arguments.parentNodeID#';
		</cfquery>

		<cfquery datasource="#this.datasource#" name="qSet2">
			UPDATE contentstore.nestedsets 
			SET rgt = rgt + 2 
			WHERE rgt >= '#qSet.rgt#' 
		</cfquery>

		<cfquery datasource="#this.datasource#" name="qSet2">
			UPDATE contentstore.nestedsets 
			SET lft = lft + 2 
			WHERE lft > '#qSet.rgt#' 
		</cfquery>
		<cfquery datasource="#this.datasource#" name="qSet2">
			INSERT INTO contentstore.nestedsets
			( type, nodeId, lft, rgt)
			VALUES
			( '#arguments.newtype#', '#arguments.newNodeID#', '#qSet.rgt#' , '#qSet.rgt+1#');
		</cfquery>
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="type">
		<cfargument name="nodeID">
		<cfset var qGet = ''>
		<Cfquery datasource="#this.datasource#" name="qGet"> 
			SELECT  lft, rgt, rgt - lft + 1 as width
			FROM nestedsets
			WHERE nodeId = '#arguments.nodeID#';
		</cfquery>
		
		<Cfquery datasource="#this.datasource#"> 
			DELETE FROM nestedsets 
			WHERE lft BETWEEN #qGet.lft# AND #qGet.rgt#;
		</cfquery>
		
		<Cfquery datasource="#this.datasource#"> 
			UPDATE nestedsets 
			SET rgt = rgt - #qGet.width#
			WHERE rgt > #qGet.rgt#;
		</cfquery>
		
		<Cfquery datasource="#this.datasource#"> 
			UPDATE nestedsets
			SET lft = lft - #qGet.width# 
			WHERE lft > #qGet.rgt#;
		</cfquery>
	</cffunction>
</cfcomponent>	

