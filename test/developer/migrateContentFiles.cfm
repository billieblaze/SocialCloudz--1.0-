<cfinclude template="/config/settings.cfm">
  <cfset application.server = createObject('component', '/model/server/serverService').init(datasource='statistics', xmlDefinition="/model/server/server.xml")>

<Cfparam name="url.offset" default="1"		>
<Cfquery name="GetFiles" datasource="ContentstoreProd">	
	select directory, file, filesize, c.contentid, contenttype from contentstore.files f
	where fileID = 0 
	order by contentID desc
	limit 10
</cfquery>

<cfset session.mosso = CreateObject("component", "model.cloudfiles").init(application.MOSSO_USER, application.MOSSO_KEY) />

<Cfloop query="getFiles">
	<Cftry>
	<Cfset container = 'user_#getFiles.memberid#'>
	<cfset newFile = "#createUUID()#.#listLast(getFiles.image,'.')#">


	<cfset containerDetails = session.mosso.getContainer(container) />
	<Cfset metaData = structNew()>
	<cfset metadata['contentType'] =getFiles.contentType>
	<cfset metadata['contentID'] = getfiles.contentID>
	<cfset metadata['communityID'] = getFiles.communityID>
	
	<Cfset metadata['originalFilename'] = listLast(getFiles.image, '/')>
	<cfset session.mosso.putObject( container, newfile, '/mnt/#getfiles.directory#/#getfiles.files#', cfhttp.mimetype, metadata) />

		<cfscript>
			rc.data = structNew();
			rc.data.contentID = getFiles.contentID;
			rc.data.cdnurl = containerDetails.cdn.uri;
			rc.data.container = container;
			rc.data.file =  newfile;
			rc.data.filesize = getfiles.filesize;
			rc.data.originalName = listLast(getFiles.image, '/'); 
			request.session.communityId = getFiles.communityID;	
			request.session.memberID = getFiles.memberID;
			rc.data.communityID = getFiles.communityID;
			rc.data.memberID = getFiles.memberID;
			rc.data.fktype = 'image';
			rc.data.fileID = application.server.storage.save(rc.data);
			</cfscript>
		<Cfquery datasource="contentstoreProd" name="foo">
			update contentstore.standardattribs
			set imageID = '#rc.data.fileID#'
			where contentID = #getFiles.contentID#
		</cfquery>	
		<Cfcatch>
			<cfdump var='#cfcatch#'>
		<Cfquery datasource="contentstoreProd" name="foo">
			update contentstore.standardattribs
			set imageID = '-1'
			where contentID = #getFiles.contentID#
		</cfquery>	
		</cfcatch>
		</Cftry>
</cfloop>
