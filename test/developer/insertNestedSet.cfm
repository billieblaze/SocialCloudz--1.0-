<cfparam name="form.newType" default="">
<cfparam name="form.newnodeID" default="">
<cfparam name="form.parentNodeID" default="">

<cfset contentService = createobject('component', '/model/content/contentService').init(datasource='contentstore', xmlDefinition="/model/content/contentstore.xml")>
<cfif isdefined('form.submit')>
	<cfset contentService.nestedSet.save(argumentcollection=form)>
</cfif>

<cfset content='#contentService.nestedSet.get()#'>
<cfdump var='#content#'>
<cfoutput>
	<cfloop query="content">
		<cfloop from="1" to="#depth#" index="i">
		-
		</cfloop>	
			#contentType# :: #contentID# - #depth#<br>
	</cfloop>


	<form action="" method="post">
		New type:<input type="text" name="newType" value="#form.newType#"><BR>
		New nodeID:<input type="text" name="newnodeID" value="#form.newnodeID#"><BR>
		New parentNodeID:<input type="text" name="parentNodeID" value="#form.parentNodeID#"><BR>
		<input type="submit" name="submit">
	</form>
</cfoutput>

<h1>Last Submitted</h1>
<cfdump var='#form#'>
