<cfinclude template="/config/settings.cfm">
  <cfset application.server = createObject('component', '/model/server/serverService').init(datasource='statistics', xmlDefinition="/model/server/server.xml")>

<Cfparam name="url.offset" default="1"		>
<Cfquery name="GetFiles" datasource="members">	
	select image,memberID,communityID from membersaccount
	where image != '' and image not like '%/images/%'
</cfquery>

<Cfloop query="getFiles">

	<Cfset container = 'user_#getFiles.memberid#'>
	<cfset newFile = "#createUUID()#.#listLast(getFiles.image,'.')#">

<cfset file = listLast(image,'/')>
<cfset directory = replace(getFiles.image, file, '')>
<Cfdump var='#file#'>
<Cfdump var='#directory#'>
<Cftry>
<cfdump var="http://www.socialcloudz.com/tools/copyFile.cfm?container=#container#&newFile=#newFile#&directory=/mnt/#directory#/&file=#file#">
		<cfhttp method="get" url="http://www.socialcloudz.com/tools/copyFile.cfm?container=#container#&newFile=#newFile#&directory=/mnt/#directory#/&file=#file#">
		<Cfdump var='#cfhttp#'>
		<cfscript>
			rc.data = structNew();
			rc.data.contentID = getFiles.memberID;
			rc.data.cdnurl = listgetat(trim(cfhttp.filecontent),1,'|');
			rc.data.container = container;
			rc.data.file =  newfile;
			rc.data.filesize = listgetat(trim(cfhttp.filecontent),2,'|');
			rc.data.originalName = listLast(getFiles.image, '/'); 
			request.session.communityId = getFiles.communityID;	
			request.session.memberID = getFiles.memberID;
			rc.data.communityID = getFiles.communityID;
			rc.data.memberID = getFiles.memberID;
			rc.data.fktype = 'profilePic';
			rc.data.fileID = application.server.storage.save(rc.data);
		</cfscript>
		<Cfquery datasource="members" name="foo">
			update members.membersaccount
			set image = '#rc.data.fileID#'
			where memberID = #getFiles.memberID#
			and communityID = #getfiles.communityID#
		</cfquery>	
		<cfcatch></cfcatch>
	</cftry>
</cfloop>
