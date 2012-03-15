<cfparam name="form.newType" default="">
<cfparam name="form.newNodeID" default="">
<cfparam name="form.parentNodeID" default="">
<cfoutput>
	<cfdump var='#rc.setData#'>
<h1>Insert a node</h1>
	<form action="/index.cfm/util/nestedSet/submit" method="post">
		New type:<input type="text" name="newType" value="#form.newType#"><BR>
		New nodeID:<input type="text" name="newNodeID" value="#form.newNodeID#"><BR>
		New parentNodeID:<input type="text" name="parentNodeID" value="#form.parentNodeID#"><BR>
	
		<input type="submit" name="submit">
	</form>

<h1>Delete a node</h1>
	<form action="/index.cfm/util/nestedSet/delete" method="post">
		type:<input type="text" name="type" value=""><BR>
		nodeID:<input type="text" name="nodeID" value=""><BR>
		<input type="submit" name="submit">
	</form>


</cfoutput>