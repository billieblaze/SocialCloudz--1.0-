<cfinclude template="/config/settings.cfm">
<Cfif not isdefined('application.server')>
  <cfset application.server = createObject('component', '/model/server/serverService').init(datasource='statistics', xmlDefinition="/model/server/server.xml")>
</cfif>
<Cfif not isdefined('session.mosso')>
<cfset session.mosso = CreateObject("component", "model.cloudfiles").init(application.MOSSO_USER, application.MOSSO_KEY) />
</cfif>
<Cfparam name="url.memberID" default="1">

<cfdirectory action="list" directory="/mnt/content/users/#url.memberID#"  recurse="true" name="dirList">
<table border=1 cellpadding="2" style="font-family: arial; font-size:11px;">
	<Cfoutput query="dirList">
		<tr>
		<cfif not  dirList.name contains 'resize_to' and dirList.type eq 'File'>
			<cfset filedata = 0 >		
			<cftry>
				<cfset file = dirlist.name>
				<cfset newFile = "#createUUID()#.#listLast(dirList.name,'.')#">
				
				<Cfif file contains '.jpg' or file Contains '.gif' or file Contains '.png' or file Contains '.jpeg'>
					<cfset fileData = checkContentImage(file)>	
				<Cfelse>
					<cfset fileData = checkContentOther(file)>	 
				</cfif>
				
				<cfcatch>
					
					<cfoutput><td>ERROR</td><td colspan="3">#file# - #cfcatch.message#</td></tr></cfoutput>
				</cfcatch>
			</cftry>
			
			<Cfif isdefined('filedata') and not isSimpleValue(fileData)>
					<td>#fileData.status#</td>
					<td>#file#</td>
					<td>#fileData.type#</td>
					<td>#fileData.id#</td>
			<Cfelse>
					<td colspan = "3">NOT FOUND</td>
					<td>#file#</td>
			</cfif>
			</tr>
			<tr>
				<td colspan=4>
					Copying: 						
							<Cfif not checkConverted(newfile) and isdefined('filedata') and not isSimpleValue(fileData)>
								<cftry>
									<cfset container = setupContainer(fileData)>
									Created Container: #container.name#<br>
									<cfcatch>#cfcatch.message#<BR>#cfcatch.detail#</cfcatch>
								</cftry>
								<cftry>
									<Cfset sendToCloudFiles(fileData,  file, container,newfile, dirlist.directory)>
									Sent to Cloud Files<br />
									<cfcatch>#cfcatch.message#<BR>#cfcatch.detail#</cfcatch>
								</cftry>
								
								<cftry>
									<cfset saveData(fileData, file, container,newfile)>
									Data Saved<br />
									<cfcatch>#cfcatch.message#<BR>#cfcatch.detail#</cfcatch>
								</cftry>

							</cfif>
				</td>
		</cfif>
		</tr>
	</cfoutput>
</table>
 
<cffunction name="checkContentImage">
	<cfargument name="fileName">
		<cfquery datasource="contentstore" name="getContent">
			select sa.contentID, memberID, communityID, contentType, parentID from standardattribs sa
			inner join community co on sa.contentID = co.communityID
			inner join content c on c.contentID = sa.contentID
			where image like '%#filename#'
		</cfquery>
		<!-- is a content image --->
		<Cfif getcontent.recordcount eq 1>
			<cfset contentDetails = { status = 'EXISTS', type = 'content', id = getcontent.contentID, memberID = getContent.memberID, contentType=getContent.contentType, communityID = getContent.communityID, parentID = getContent.parentID} >
		<cfelse>

			<cfquery datasource="contentstore" name="getAttribs">
				select a.contentID, memberID, communityID, contentType, parentID from attribs a 
				inner join community co on a.contentID = co.contentID
				inner join content c on c.contentID = a.contentID
				where keyvalue like '%#filename#'
			</cfquery>
			
			<Cfif getAttribs.recordcount eq 1>
				<cfset contentDetails = { status = 'EXISTS', type = 'attribs', id = getAttribs.contentID, memberID = getAttribs.memberID, contentType=getAttribs.contentType, communityID = getAttribs.communityID, parentID = getATtribs.parentID} >
			<cfelse>
				<cfquery datasource="members" name="getMembers">
					select image, memberid, communityID from members.membersaccount
					where image like '%#filename#'
				</cfquery>
				
				<Cfif getMembers.recordcount eq 1>
					<cfset contentDetails = { status = 'EXISTS', type = 'profile', id = getMembers.memberID, memberID = getMembers.memberID, contentType='', communityID = getMembers.communityID, parentID = ''} >
				<cfelse>		
					<cfquery datasource="community" name="getHTML">
						select modulepage.*, c.adminID as memberID from `community`.`module_html`
						inner join modulepage on modulepage.moduleSettingID = module_html.id
						inner join community c on c.communityID = modulepage.communityID
						where html like '%#filename#%'
					</cfquery>
					<Cfif getHTML.recordcount eq 1>
						<cfset contentDetails = { status = 'EXISTS', type = 'html', id = '', memberID = getHTML.memberID, contentType='', communityID = '', parentID = ''} > <!--- TODO: communityID --->
					<cfelse>
						<Cfreturn 0>	
					</cfif>
				</cfif>
			</cfif>
		</cfif>
</cffunction>

<cffunction name="checkContentOther">
	<cfargument name="fileName">
		<cfquery datasource="contentstore" name="getAttribs">
				select a.contentID, memberID, communityID, contentType, parentID from attribs a 
				inner join community co on co.contentID = a.contentID
				inner join content c on c.contentID = a.contentID
				where keyvalue like '%#filename#'
			</cfquery>
			
			<Cfif getAttribs.recordcount eq 1>
				<cfset contentDetails = { status = 'EXISTS', type = 'attribs / other', id = getAttribs.contentID, memberID = getAttribs.memberID, contentID = getAttribs.contentID, contentType=getAttribs.contentType, communityID = getAttribs.communityID, parentID = getATtribs.parentID} >
			<cfelse>
					<Cfreturn 0>	
			</cfif>
			<Cfreturn contentDetails>
</cffunction>

<cffunction name="checkConverted">
	<cfargument name="file">
	
	<cfquery datasource="statistics" name="checkFile">
		select * from files where file = '#arguments.file#'
	</cfquery>
	
	<cfif checkFile.recordcount eq 0>
		<cfreturn 0>
	<cfelse>
		<Cfreturn 1>
	</cfif>
</cffunction>


<Cffunction name="setupContainer">
	<cfargument name="fileData">
	
	<Cfif isdefined('fileData.contentType')>
		<!--- Contentstore - gallery and music children go in one folder, all other goes in a contenttype folder --->
		<Cfif fileData.contentType eq 'gallery'>
			<Cfset container = 'user_#fileData.memberid#_Gallery_#fileData.contentID#'>	
		<Cfelseif fileData.contentType eq 'Photo'>
			<Cfset container = 'user_#fileData.memberid#_Gallery_#fileData.parentID#'>	
		<cfelseif fileData.contentType eq 'Music'>
			<Cfset container = 'user_#fileData.memberid#_Music_#fileData.contentID#'>
		<cfelseif fileData.contentType eq 'Song'>
			<Cfset container = 'user_#fileData.memberid#_Music_#fileData.parentID#'>
		<cfelse>
			<Cfset container = 'user_#fileData.memberid#_#fileData.contentType#'>
		</cfif>
	<cfelse>
		<!--- profile pics and uploaded files go here --->
		<Cfset container = 'user_#fileData.memberid#'>
	</cfif>
		
	<cfif session.mosso.createContainer(container)>
		<cfset uri = session.mosso.enableCDN(container) />
	</cfif>
	
	<cfreturn session.mosso.getContainer(container) />
</cffunction>

<cffunction name="sendToCloudFiles">
	<Cfargument name="fileData">
	<Cfargument name="file">
	<Cfargument name="container">
	<Cfargument name="newfile">	
	<Cfargument name="directory">	
	
	<Cfset metaData = { contentType =fileData.contentType, contentID =  fileData.contentID, communityID = fileData.communityID, originalFilename = file }>
	<cfset session.mosso.putObject( container.name, newfile, '#directory#/#file#', getMimeType(file), metadata) />

</cffunction>

<cffunction name="saveData">
	<Cfargument name="fileData">
	<Cfargument name="file">
	<Cfargument name="container">
	<Cfargument name="newfile">		
<Cfargument name="directory">	
		<cfscript>
			rc.data = structNew();
			rc.data.contentID = fileData.contentID;
			rc.data.cdnurl = container.cdn.uri;
			rc.data.container = container.name;
			rc.data.file =  file;
			rc.data.filesize = getFileInfo('#directory#/#file#').size;
			rc.data.originalName = file; 
			request.session.communityId = fileData.communityID;	
			request.session.memberID = fileData.memberID;
			rc.data.communityID = fileData.communityID;
			rc.data.memberID = fileData.memberID;
			rc.data.fktype = fileData.type;
			rc.data.fileID = application.server.storage.save(rc.data);
		</cfscript>
</cffunction>

<cfscript>
/**
* Returns mime type and subtype for a file.
*
* @param filename      File name to examine. (Required)
* @return Returns a string.
* @author Kenneth Rainey (&#107;&#105;&#112;&#46;&#114;&#97;&#105;&#110;&#101;&#121;&#64;&#105;&#110;&#99;&#97;&#112;&#105;&#116;&#97;&#108;&#46;&#99;&#111;&#109;)
* @version 1, April 21, 2004
*/
function getMimeType(filename) {
    var mimeStruct=structNew();
    var fileExtension ="";
    //extract file extension from file name
    fileExtension = Reverse(SpanExcluding(Reverse(fileName),"."));
    //build mime type array
    mimeStruct.ai="application/postscript";
    mimeStruct.aif="audio/x-aiff";
    mimeStruct.aifc="audio/x-aiff";
    mimeStruct.aiff="audio/x-aiff";
    mimeStruct.asc="text/plain";
    mimeStruct.au="audio/basic";
    mimeStruct.avi="video/x-msvideo";
    mimeStruct.bcpio="application/x-bcpio";
    mimeStruct.bin="application/octet-stream";
    mimeStruct.c="text/plain";
    mimeStruct.cc="text/plain";
    mimeStruct.ccad="application/clariscad";
    mimeStruct.cdf="application/x-netcdf";
    mimeStruct.class="application/octet-stream";
    mimeStruct.cpio="application/x-cpio";
    mimeStruct.cpt="application/mac-compactpro";
    mimeStruct.csh="application/x-csh";
    mimeStruct.css="text/css";
    mimeStruct.dcr="application/x-director";
    mimeStruct.dir="application/x-director";
    mimeStruct.dms="application/octet-stream";
    mimeStruct.doc="application/msword";
    mimeStruct.drw="application/drafting";
    mimeStruct.dvi="application/x-dvi";
    mimeStruct.dwg="application/acad";
    mimeStruct.dxf="application/dxf";
    mimeStruct.dxr="application/x-director";
    mimeStruct.eps="application/postscript";
    mimeStruct.etx="text/x-setext";
    mimeStruct.exe="application/octet-stream";
    mimeStruct.ez="application/andrew-inset";
    mimeStruct.f="text/plain";
    mimeStruct.f90="text/plain";
    mimeStruct.fli="video/x-fli";
    mimeStruct.gif="image/gif";
    mimeStruct.gtar="application/x-gtar";
    mimeStruct.gz="application/x-gzip";
    mimeStruct.h="text/plain";
    mimeStruct.hdf="application/x-hdf";
    mimeStruct.hh="text/plain";
    mimeStruct.hqx="application/mac-binhex40";
    mimeStruct.htm="text/html";
    mimeStruct.html="text/html";
    mimeStruct.ice="x-conference/x-cooltalk";
    mimeStruct.ief="image/ief";
    mimeStruct.iges="model/iges";
    mimeStruct.igs="model/iges";
    mimeStruct.ips="application/x-ipscript";
    mimeStruct.ipx="application/x-ipix";
    mimeStruct.jpe="image/jpeg";
    mimeStruct.jpeg="image/jpeg";
    mimeStruct.jpg="image/jpeg";
    mimeStruct.js="application/x-javascript";
    mimeStruct.kar="audio/midi";
    mimeStruct.latex="application/x-latex";
    mimeStruct.lha="application/octet-stream";
    mimeStruct.lsp="application/x-lisp";
    mimeStruct.lzh="application/octet-stream";
    mimeStruct.m="text/plain";
    mimeStruct.man="application/x-troff-man";
    mimeStruct.me="application/x-troff-me";
    mimeStruct.mesh="model/mesh";
    mimeStruct.mid="audio/midi";
    mimeStruct.midi="audio/midi";
    mimeStruct.mif="application/vnd.mif";
    mimeStruct.mime="www/mime";
    mimeStruct.mov="video/quicktime";
    mimeStruct.movie="video/x-sgi-movie";
    mimeStruct.mp2="audio/mpeg";
    mimeStruct.mp3="audio/mpeg";
    mimeStruct.mpe="video/mpeg";
    mimeStruct.mpeg="video/mpeg";
    mimeStruct.mpg="video/mpeg";
    mimeStruct.mpga="audio/mpeg";
    mimeStruct.ms="application/x-troff-ms";
    mimeStruct.msh="model/mesh";
    mimeStruct.nc="application/x-netcdf";
    mimeStruct.oda="application/oda";
    mimeStruct.pbm="image/x-portable-bitmap";
    mimeStruct.pdb="chemical/x-pdb";
    mimeStruct.pdf="application/pdf";
    mimeStruct.pgm="image/x-portable-graymap";
    mimeStruct.pgn="application/x-chess-pgn";
    mimeStruct.png="image/png";
    mimeStruct.pnm="image/x-portable-anymap";
    mimeStruct.pot="application/mspowerpoint";
    mimeStruct.ppm="image/x-portable-pixmap";
    mimeStruct.pps="application/mspowerpoint";
    mimeStruct.ppt="application/mspowerpoint";
    mimeStruct.ppz="application/mspowerpoint";
    mimeStruct.pre="application/x-freelance";
    mimeStruct.prt="application/pro_eng";
    mimeStruct.ps="application/postscript";
    mimeStruct.qt="video/quicktime";
    mimeStruct.ra="audio/x-realaudio";
    mimeStruct.ram="audio/x-pn-realaudio";
    mimeStruct.ras="image/cmu-raster";
    mimeStruct.rgb="image/x-rgb";
    mimeStruct.rm="audio/x-pn-realaudio";
    mimeStruct.roff="application/x-troff";
    mimeStruct.rpm="audio/x-pn-realaudio-plugin";
    mimeStruct.rtf="text/rtf";
    mimeStruct.rtx="text/richtext";
    mimeStruct.scm="application/x-lotusscreencam";
    mimeStruct.set="application/set";
    mimeStruct.sgm="text/sgml";
    mimeStruct.sgml="text/sgml";
    mimeStruct.sh="application/x-sh";
    mimeStruct.shar="application/x-shar";
    mimeStruct.silo="model/mesh";
    mimeStruct.sit="application/x-stuffit";
    mimeStruct.skd="application/x-koan";
    mimeStruct.skm="application/x-koan";
    mimeStruct.skp="application/x-koan";
    mimeStruct.skt="application/x-koan";
    mimeStruct.smi="application/smil";
    mimeStruct.smil="application/smil";
    mimeStruct.snd="audio/basic";
    mimeStruct.sol="application/solids";
    mimeStruct.spl="application/x-futuresplash";
    mimeStruct.src="application/x-wais-source";
    mimeStruct.step="application/STEP";
    mimeStruct.stl="application/SLA";
    mimeStruct.stp="application/STEP";
    mimeStruct.sv4cpio="application/x-sv4cpio";
    mimeStruct.sv4crc="application/x-sv4crc";
    mimeStruct.swf="application/x-shockwave-flash";
    mimeStruct.t="application/x-troff";
    mimeStruct.tar="application/x-tar";
    mimeStruct.tcl="application/x-tcl";
    mimeStruct.tex="application/x-tex";
    mimeStruct.texi="application/x-texinfo";
    mimeStruct.texinfo="application/x-texinfo";
    mimeStruct.tif="image/tiff";
    mimeStruct.tiff="image/tiff";
    mimeStruct.tr="application/x-troff";
    mimeStruct.tsi="audio/TSP-audio";
    mimeStruct.tsp="application/dsptype";
    mimeStruct.tsv="text/tab-separated-values";
    mimeStruct.txt="text/plain";
    mimeStruct.unv="application/i-deas";
    mimeStruct.ustar="application/x-ustar";
    mimeStruct.vcd="application/x-cdlink";
    mimeStruct.vda="application/vda";
    mimeStruct.viv="video/vnd.vivo";
    mimeStruct.vivo="video/vnd.vivo";
    mimeStruct.vrml="model/vrml";
    mimeStruct.wav="audio/x-wav";
    mimeStruct.wrl="model/vrml";
    mimeStruct.xbm="image/x-xbitmap";
    mimeStruct.xlc="application/vnd.ms-excel";
    mimeStruct.xll="application/vnd.ms-excel";
    mimeStruct.xlm="application/vnd.ms-excel";
    mimeStruct.xls="application/vnd.ms-excel";
    mimeStruct.xlw="application/vnd.ms-excel";
    mimeStruct.xml="text/xml";
    mimeStruct.xpm="image/x-xpixmap";
    mimeStruct.xwd="image/x-xwindowdump";
    mimeStruct.xyz="chemical/x-pdb";
    mimeStruct.zip="application/zip";
    if(structKeyExists(mimeStruct,fileExtension)) return mimeStruct[fileExtension];
    else return "unknown/unknown";
}
</cfscript>
