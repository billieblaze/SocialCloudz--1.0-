<cfsetting enablecfoutputonly="yes">
<!---
	CFFM 1.31
	Written by Rick Root (rick@webworksllc.com)
	See LICENSE.TXT for copyright and redistribution restrictions.
--->
<cfscript>
	// **************************************************
	// LOAD THE RESOURCE BUNDLE FIRST
	// **************************************************
	variables.rbm = createObject('component','javaRB');
	variables.defaultJavaLocale = "en_US";
	variables.rbDir= expandPath("./");
	variables.rbFile= rbDir & "cffm.properties"; //base resource file
	variables.resourceKit = variables.rbm.getResourceBundle("#variables.rbFile#","#variables.defaultJavaLocale#");

	/* *****************************************
  	   ** WHICH IMAGE COMPONENT ARE WE USING? **
	   *****************************************

	**	IMPORTANT.  If you want to use ImageCFC on coldfusion 8 or
	**  above, just change "true" to "false" in the if statement.
	**
	** If you want to use another image component, just make your
	** own imageObject_whatever.cfc and set it here.  The 
	** ImageObject_xxx.cfc is just a wrapper for image manipulation.
	** cffm does not make any direct calls to the image component.
	*/
	
	if (true and server.coldfusion.productName contains "ColdFusion" and val(server.coldfusion.productversion) gte 8) {
		variables.imageComponent = "ImageObject_cfimage";
	} else {
		variables.imageComponent = "ImageObject_imagecfc";
	}
	
	files = application.server.storage.get(memberId = request.session.memberID);	
	
	container = 'user_#request.session.memberID#';
	session.mosso = CreateObject("component", "model.cloudfiles").init(application.MOSSO_USER, application.MOSSO_KEY);

	if (session.mosso.createContainer(container)){
		uri = session.mosso.enableCDN(container);
	}

	containerDetails = session.mosso.getContainer(container);
	
</cfscript>
<!---	
	**************************************************
	INITIALIZE the CFC
	**************************************************
--->
<cfset cffm = createObject("component","cffm")>
<cfinvoke component="#cffm#" method="init">
	<!--- includeDir = You can and probably should hard code this... by default, the directory is a 
		directory named "custom" located in the same directory as this file. 
		FOR RAM DRIVE:  use "ram:///" (CF9+)
		--->
	<cfinvokeargument name="includeDir" value="#application.tempUpload#">
	<cfinvokeargument name="includeDirWeb" value="#containerdetails.cdn.uri#">
	
	<!--- disallowedExtensions = file extensions you don't want people to upload --->
	<cfinvokeargument name="disallowedExtensions" value="cfm,cfml,cfc,dbm,dbml,php,php3,php4,php5,asp,aspx,pl,plx,pls,cgi,jsp,pif,scr,vbs,exe">
	<!---
	// allowedExtensions = 
	// as an alternative to disallowing extensions, you can allow 
	// only certain extensions.  This overrides the disallowedExtensions
	// setting.  You might use this to restrict the user to uploading
	// images or something.
	--->
	<cfinvokeargument name="allowedExtensions" value="jpg,gif,png,txt,html,htm,pdf">
	<!--- editableExtensions:  specifies what kind of files can be edited with the simple text editor --->
	<cfinvokeargument name="editableExtensions" value="cfm,cfml,cfc,dbm,dbml,php,php3,php4,asp,aspx,pl,plx,pls,cgi,jsp,txt,html,htm,log,csv,js,css">
	<!---
	// overwriteDefault = 
	// There are several places where a checkbox appears to overwrite
	// existing.  This controls what it defaults to.  On or off.
	--->
	<cfinvokeargument name="overwriteDefault" value="true">
	<!--- iconPath = web path to the location of the icons used by CFFM --->

	<cfinvokeargument name="debug" value="0">
	<!--- file to be cfincluded above all CFFM output --->
	<cfinvokeargument name="templateWrapperAbove" value="">
	<!--- file to be cfincluded below all CFFM output --->
	<cfinvokeargument name="templateWrapperBelow" value="">
	<!--- name of this file.  You should not change this. --->
	<cfinvokeargument name="cffmFilename" value="#GetfileFromPath(getBaseTemplatePath())#">
	<cfinvokeargument name="enableImageDimensionsInDirList" value="true">
	<cfinvokeargument name="maxImageDimensionsPerFileListing" value="20">
	<cfinvokeargument name="readOnly" value="false">
	<Cfinvokeargument name="allowUnzip" value="false">
	<cfinvokeargument name="allowCreateDirectory" value="false">
	<cfinvokeargument name="allowMultipleUploads" value="false">
	<cfinvokeargument name="maxUploadSize" value="5000000">
	<cfinvokeargument name="useContextMenus" value="false">
	<cfinvokeargument name="useFileActionButtons" value="false">
</cfinvoke>
<!--- place the resource kit in the cffm object --->
<cfset cffm.resourceKit = variables.resourceKit>
<cfif structKeyExists(url,"CKEditorFuncNum")>
	<cfset cffm.ckEditorFuncNum = val(url.ckEditorFuncNum)>
</cfif>

<!---	**************************************************
		END OF CONFIGURATION SECTION.
		YOU DO NOT NEED TO MAKE ANY CHANGES BELOW HERE
		**************************************************


		**************************************************
		ACTUAL CODE BEGINS HERE... 
		
		FIRST WE MUST DO VARIABLE INITIALIZATION
		
		IMPORTANT NOTE:  Session Management on the server or cookies
		on the browser are required in order for CFFM to be used as
		a file browser for HTML editors such as FCKeditor or TinyMCE
		**************************************************
--->

<cfscript>
	// see if sessions are enabled 
	try {
		session.test = 1;
		variables.sessionenabled = true;
	}catch(Any temperr){
		variables.sessionenabled = false;
	}
	// ********************************************************
	// editor_resource_type is used when CFFM is 
	// used as a file browser for FCKeditor and TinyMCE
	//
	// ********************************************************

	// ********************************************************
	// same as above, except get the editor type either from the URL
	// or the session or the cookie
	//
	// ********************************************************

	if (isDefined("url.editorType")) {
		variables.editorType = url.editorType;
	} else {
		variables.editorType = "";
	}

	if (isDefined("url.EDITOR_RESOURCE_TYPE")) {
		variables.EDITOR_RESOURCE_TYPE = url.EDITOR_RESOURCE_TYPE;
	} else {
		variables.EDITOR_RESOURCE_TYPE = "file";
	}


	if (variables.editorType eq "cke" AND structKeyExists(url,'CKEditor')) {
		variables.instance = '#jsStringFormat(url.CKEditor)#';
	} else if (variables.editorType eq "fck") {
		variables.instance = '';
	} else if (variables.editorType eq "mce") {
		variables.instance = '';
	} else {
		variables.instance = '';
	}	
	

	// ********************************************************
	// Okay, find out what subdirectory we're working wwith.
	// the value of "subdir" is eventually combined with
	// cffm.includeDir to produce a physical directory path,
	// as well as with cffm.includeDirWeb to produce a web
	// path.
	// ********************************************************

	if (isDefined("url.subdir")) {
		variables.subdir = url.subdir;
	} else if (isDefined("form.subdir")) {
		variables.subdir = form.subdir;
	} else if (variables.sessionEnabled AND isDefined("session.subdir")) {
		variables.subdir = session.subdir;
	} else if (isDefined("cookie.subdir")) {
		variables.subdir = cookie.subdir;
	} else {
		variables.subdir = "";
	}

	// ********************************************************
	// subdir cleanup
	//
	// strip leading and trailing slashes first 
	// ********************************************************
	variables.subdir = cffm.checkSubdirValue(variables.subdir);
	// set the physical path to our current working directory.
	variables.workingDirectory = cffm.createServerPath(variables.subdir);
	// set the logical URL path to our current working directory.
	variables.workingDirectoryWeb = cffm.createWebPath(variables.subdir);

	// ********************************************************
	// copy the subdir to the session or cookie so the app
	// always comes back to the same directory when subdir
	// is NOT specified in the url or form
	// ********************************************************

	if (variables.sessionEnabled) {
		session.subdir = variables.subdir;
	} else {
		cffm.setCFFMCookie("subdir", variables.subdir);
	}
	
	/* determine the proper directory separator */
	variables.dirSep = cffm.getDirectorySeparator();

	// ********************************************************
	// Take a bunch of variable names, rip them out of either
	// the url or form scopes, and put them into the variables
	// scope.
	// ********************************************************
	variables = cffm.createVariables(variables, form, url, "action,subdir,deleteFilename,renameOldFilename,renameNewFilename,editFilename,viewFilename,editFileContent,createNewFilename,createNewFileType,unzipFilename,moveToSubdir,moveFilename,unzipToSubdir,overWrite,rotateDegrees,resizeWidthValue,resizeHeightValue,cropStartX,cropStartY,cropWidthValue,cropHeightValue,preserveAspect,cropToExact,showTotalUsage");

	variables.errorMessage = "";

	if (listFindNoCase("flip,flop,resize,crop,rotate,action,commitChanges,undoChanges,create,delete,rename,move,copy,isEditableImage,save", variables.action) gt 0) 
	{
		returnsJson = true;
		ajaxCall = true;
	} else {
		returnsJson = false;
		ajaxCall = false;
	}
	// set ajaxCall true for these non-JSON calls
	if (listFindNoCase("showImagePreview,showDirectoryListing,getTotalUsage,copymoveForm,manipulateForm,viewzip,viewSource,edit",variables.action) gt 0) 
	{
		ajaxCall = true;
	}

	retVal = structNew();
	retVal.errormessage = "";


	// make sure we can access the working directory	
	if (NOT DirectoryExists(variables.workingDirectory) ) 
	{
		/* oops!  Reset everything and return to the home directory */
		variables.errorMessage = variables.errorMessage & "<li>#cffm.resourceKit['errorMsg.t4']#</li>#Chr(10)#";
		variables.workingDirectory = cffm.includeDir;
		variables.workingDirectoryWeb = cffm.includeDirWeb;
		variables.subdir = "";
		variables.action = "list";
	}


	// **************************************************
	// ARE WE PERFORMING SOME KIND OF ACTION? //
	// **************************************************
	if (variables.action eq "download")
	{
		cffm.downloadFile(variables.workingDirectory, variables.dirsep, downloadFilename);
		// end processing
	} else if (variables.action eq "get") {
		cffm.displayFile(variables.workingDirectory, variables.dirsep, downloadFilename);
		// end processing
	} else if (variables.action eq "delete") {
		if (variables.deleteFilename contains "/" or variables.deleteFilename contains "\") {
			retVal.errorMessage = cffm.resourceKit['errorMsg.t5'];
		} else {
			variables.deleteResults = "";
			variables.fileToDelete = variables.workingDirectory & variables.dirsep & variables.deleteFilename;
			if (cffm.getPathType(fileToDelete) eq "file")
			{
				variables.deleteResults = cffm.deleteFile(variables.fileToDelete);
			} else {
				variables.deleteResults = cffm.deleteDirectory(variables.fileToDelete, "True");
			}
			if (variables.deleteResults.errorCode neq 0) 
			{
				retVal.errorMessage = variables.deleteResults.errorMessage;
			}
		}
		cffm.returnJSON(retval);
		// end processing
	} else if (variables.action eq "unzip") {
		if (variables.unzipFilename contains "/" or variables.unzipFilename contains "\") {
			retVal.errorMessage = cffm.resourceKit['errorMsg.t5'];
			cffm.returnJSON(retval);
		}
		if ( variables.unzipToSubdir neq cffm.checkSubdirValue(variables.unzipToSubdir) )
		{
			retVal.errorMessage = cffm.resourceKit['errorMsg.t3'];
			cffm.returnJSON(retval);
		}

		variables.fileToUnzip = variables.workingDirectory & variables.dirsep & variables.unzipFilename;
		variables.unzipResults = cffm.unzipFile(variables.fileToUnzip,cffm.createServerPath(variables.unzipToSubdir),variables.overwrite);
		if (isStruct(variables.unzipResults) and variables.unzipResults.errorCode neq 0) 
		{
			retVal.errorMessage = variables.unzipResults.errorMessage;
		}
		retVal.newsubdir = variables.unzipToSubdir;
		cffm.returnJSON(retval);
		// end processing
	} else if (variables.action eq "rename") {
		if (variables.renameNewFilename contains "/" or variables.renameNewFilename contains "\") {
			retVal.errorMessage = cffm.resourceKit['errorMsg.t5'];
		} else {
			variables.oldFilename = variables.workingDirectory & variables.dirsep & variables.renameOldFilename;
			variables.newFilename = variables.workingDirectory & variables.dirsep & variables.renameNewFilename;
			variables.renameResults = cffm.renameFile(variables.oldFilename,variables.newFilename,"rename",variables.overWrite);
			if (isStruct(variables.renameResults) and variables.renameResults.errorCode neq 0) 
			{
				retVal.errorMessage = variables.renameResults.errorMessage;
			}
		}
		cffm.returnJSON(retval);
		// end processing
	} else if (variables.action eq "move" or variables.action eq "copy") {
		if ( variables.moveToSubdir neq cffm.checkSubdirValue(variables.moveToSubdir) )
		{
			retVal.errorMessage = cffm.resourceKit['errorMsg.t2'];
			cffm.returnJSON(retval);
		}

		if (variables.moveFilename contains "/" or variables.moveFilename contains "\") 
		{
			retVal.errorMessage = cffm.resourceKit['errorMsg.t5'];
			cffm.returnJSON(retval);
		}

		variables.moveFromPath = cffm.createServerPath(variables.subdir,variables.moveFilename);
		variables.moveToPath = cffm.createServerPath(variables.moveToSubdir,variables.moveFilename);
		if (cffm.getPathType(variables.moveFromPath) eq "directory" AND variables.moveFromPath eq variables.moveToPath)
		{
			retVal.errorMessage = cffm.resourceKit['errorMsg.t6'];
		} else if (cffm.getPathType(variables.moveFromPath) eq "directory" and Find(variables.moveFromPath,variables.moveToPath) eq 1) {
			retVal.errorMessage = cffm.resourceKit['errorMessage.t7'];
		} else if (cffm.getPathType(variables.moveFromPath) eq "file" AND getDirectoryFromPath(variables.moveFromPath) eq variables.moveToPath ) {
			/* don't do anything, because they selected to move the file to the directory it's already in! */
		} else {
			// attempt the move.
			variables.moveResults = cffm.renameFile(variables.moveFromPath,variables.moveToPath,variables.action, variables.overWrite);
			if (isStruct(variables.moveResults) and variables.moveResults.errorCode neq 0)
			{
				retVal.errorMessage = variables.moveResults.errorMessage;
			}
		}
		cffm.returnJSON(retval);
		// end processing
	} else if (variables.action eq "upload") {
		x = GetHttpRequestData();
		if ( len(x.content) gt 0 )
		{
			variables.uploadResults = cffm.uploadFile(
				destination=variables.workingDirectory, 
				overwriteExisting=variables.overwrite, 
				qqfile=url.qqfile);
			cffm.uploadResult(variables.uploadResults);		
		} else if ( structKeyExists(form,'qqfile') and form.qqfile neq "") {
			variables.uploadResults = cffm.uploadFile(
				destination=variables.workingDirectory, 
				overwriteExisting=variables.overwrite, 
				qqfile=form.qqfile);
			cffm.uploadResult(variables.uploadResults);		
		} else {
			tempvar = structNew();
			tempvar.errorCode = 1;
			tempVar.errorMessage = cffm.resourceKit['errorMsg.t30'];
			tempVar.success = false;
			if ( structKeyExists(x.headers,"X-Requested-With")  and x.headers["X-Requested-With"] contains "XmlHTTPRequest")
			{
				tempVar.type = 'xhr';
			} else {
				tempVar.type = 'form';
			}
			tempVar.originalfilename = '';
			tempVar.serverfilename = '';
			cffm.uploadResult(tempVar);
		}
		// end processing
	} else if (variables.action eq "quickupload") {
		if (editorType eq "fck") {
			variables.uploadResults = cffm.uploadFromFCK(variables.workingDirectory, variables.overwrite, form, variables.workingDirectoryWeb, 'NewFile');
		} else if (editorType eq "cke") {
			variables.uploadResults = cffm.uploadFromFCK(variables.workingDirectory, variables.overwrite, form, variables.workingDirectoryWeb, 'UPLOAD');
		} else {
			cffm.fckUploadResult(variables.editorType, 1,'','','editorType #variables.editorType# is not known.');
		}
		
		if (variables.uploadResults.errorCode neq 0)
		{
			variables.errorMessage = variables.errorMessage & "<li>#variables.uploadResults.errorMessage#</li>#Chr(10)#";
			cffm.fckUploadResult(variables.editorType, variables.uploadResults.errorCode,'','',variables.uploadResults.errorMessage);
		} else if (not structKeyExists(variables.uploadResults,"fileurl") ) {
			variables.errorMessage = variables.errorMessage & "<li>#cffm.resourceKit.errorMsg.t25#</li>#Chr(10)#";
			cffm.fckUploadResult(variables.editorType, variables.uploadResults.errorCode,'','',cffm.resourceKit.errorMsg.t25);
		} else {
			cffm.fckUploadResult(variables.editorType, 0,variables.uploadResults.fileUrl,variables.uploadResults.fileName,'');
		}
		// end processing
	} else if (variables.action eq "save") {
		variables.fileToWrite = variables.workingDirectory & variables.dirsep & variables.editFilename;
		variables.saveResults = cffm.saveFile(variables.fileToWrite, variables.editFileContent);
		if (variables.saveResults.errorCode gt 0)
		{
			retVAl.errorMessage = variables.saveResults.errorMessage;
		}
		cffm.returnJSON(retval);
		// end processing
	} else if (variables.action eq "create") {
		if (variables.createNewFilename contains "/" or variables.createNewFilename contains "\") {
			retVal.errorMessage = cffm.resourceKit['errorMsg.t5'];
		} else if (variables.createNewFilename eq "") {
			retVal.errorMessage = cffm.resourceKit['errorMsg.t22'];
		} else {
			variables.fileToCreate = variables.workingDirectory & variables.dirsep & variables.createNewFilename;
			variables.createResults = cffm.createFile(variables.fileToCreate,variables.createNewFileType);
			if (variables.createResults.errorCode gt 0)
			{
				retVal.errorMessage = variables.createResults.errorMessage;
			}
		}
		cffm.returnJSON(retval);
		// end processing
	} else if (listFindNoCase("flip,flop,resize,crop,rotate,manipulateForm,commitChanges,undoChanges,showImagePreview,isEditableImage",action) gt 0) {
		if (variables.editFilename contains "/" or variables.editFilename contains "\") {
			retVal.errorMessage = cffm.resourceKit['errorMsg.t5'];
			cffm.returnJSON(retval);
		} else if (cffm.getPathType(cffm.createServerPath(variables.subdir,variables.editFilename)) neq "file")	{
			retVal.errorMessage = "#cffm.resourceKit['errorMsg.t8']#  #cffm.createServerPath(variables.subdir, variables.editFilename)#";
			cffm.returnJSON(retval);
		} else {
			try {
				variables.image = CreateObject("component","#variables.imageComponent#");
				variables.imagePath = cffm.createServerPath(variables.subdir, variables.editFilename);
				variables.image.init(variables.imagePath);
				imageLoaded = true;
			} catch(Any e) {
				imageLoaded = false;
			}
			if (NOT imageLoaded)
			{
				retVal.errorMessage = cffm.resourceKit['errorMsg.t9'];
				cffm.returnJSON(retval);
			} else if (action eq "isEditableImage") {
				retVal.editFilename = variables.editFilename;
				cffm.returnJSON(retval);
			} else if (listFindNoCase("flip,flop,rotate,resize,crop",variables.action)) {
				try {
					if (variables.action eq "flip") {
						variables.image.flipVertical();
					} else if (variables.action eq "flop") {
						variables.image.flipHorizontal();
					} else if (variables.action eq "rotate") {
						variables.image.rotate(variables.rotateDegrees);
					} else if (variables.action eq "resize") {
						variables.image.resize(variables.resizeWidthValue, variables.resizeHeightValue, yesNoFormat(variables.preserveAspect), yesNoFormat(variables.cropToExact));
					} else if (variables.action eq "crop") {
						variables.image.crop(variables.cropStartX, variables.cropStartY, variables.cropWidthValue, variables.cropHeightValue);
					}
					variables.image.save(variables.imagePath,95);
					imageWritten = true;
				} catch(Any e) {
					// cffm.cffmdump(e);
					retVal.errorMessage = "#e.message# - #e.detail#";
					imageWritten = false;
				}
				retVal.EDITFILENAME = variables.editFilename;
				cffm.returnJSON(retval);
			}
		}
		// end processing
	}
	variables.dirlist = "";
</cfscript>
<!---
	// **************************************************
	// Still processing?
	//
	// we're doing one of the following:
	// action = list					(primary load)
	// action = showImagePreview		(AJAX)
	// action = showDirectoryListing	(AJAX)
	// action = getTotalUsage			(AJAX)
	// action = copymoveForm			(AJAX)
	// action = manipulateForm			(AJAX)
	// action = viewzip					(AJAX)
	// action = viewSource				(AJAX)
	// action = edit					(AJAX)
	// action = commitChanges			(AJAX)
	// action = undoChanges				(AJAX)
	// **************************************************

--->

<cfif listFindNoCase("edit,viewsource,viewzip,renameForm,copymoveForm,manipulateForm",action) gt 0>
	<!--- if we're working with a form, output the "Working with..." header --->
	<cfoutput><p class="cffm_editor">Working with #cffm.getPathType(cffm.createServerPath(variables.subdir,variables.editFilename))#:  #variables.workingDirectoryWeb#/#editFilename# </p></cfoutput>
</cfif>
<!--- if we're showing certain forms, we need a list of all directories --->
<cfif listFindnocase("copymoveform,viewzip,gettotalusage", variables.action) gt 0>
	<cfset variables.listAllFiles = cffm.cffmDirectoryList(cffm.includeDir,"true")>
	<cfif variables.listAllFiles.RecordCount gt 0>
		<cfquery name="variables.listAllDirectories" dbtype="query">
			select * from variables.listAllFiles
			where type = 'Dir'
		</cfquery>
	<cfelse>
		<!--- this is a workaround for CFMX --->
		<cfset variables.listAllDirectories = QueryNew("IGNORE")>
	</cfif>
</cfif>

<cfif action eq "commitChanges">
	<cffile action="COPY" source="#variables.workingDirectory#/#variables.editFilename#" destination="#variables.workingDirectory#/#reReplace(variables.editFilename,"^\_\_TEMP\_\_","","ALL")#">
	<cffile action="DELETE" file="#variables.workingDirectory#/#variables.editFilename#">
	<cfset retVal = structNew()>
	<cfset retVal.errorMessage = "">
	<cfset retVal.resultMessage = "#cffm.resourcekit['Msg.t66']#">
	<cfset retVal.refreshUrl = "#cffm.cffmFilename#?subdir=#urlEncodedFormat(variables.subdir)#">
	<cfset cffm.returnJSON(retVal)>
	<!--- end processing --->
<cfelseif action eq "undoChanges">
	<cffile action="DELETE" file="#variables.workingDirectory#/#variables.editFilename#">
	<cfset retVal = structNew()>
	<cfset retVal.errorMessage = "">
	<cfset retVal.resultMessage = "#cffm.resourcekit['Msg.t67']#">
	<cfset retVal.refreshUrl = "#cffm.cffmFilename#?subdir=#urlEncodedFormat(variables.subdir)#">
	<cfset cffm.returnJSON(retVal)>
	<!--- end processing --->
<cfelseif action eq "showImagePreview">
	<!--- variables.image was created earlier --->
	<cfset variables.imageHeight = variables.image.getImageInfo().height>
	<cfset variables.imageWidth = variables.image.getImageInfo().width>

	<cfif variables.imageWidth gt 400>
		<cfset variables.scale = 400 / variables.imageWidth>
		<cfset variables.displaywidth = 400>
		<cfset variables.displayHeight = Round(variables.imageHeight * variables.scale)>
	<cfelse>
		<cfset variables.scale = 1>
		<cfset variables.displayWidth = variables.imageWidth>
		<cfset variables.displayHeight = variables.imageHeight>
	</cfif>
	<cfcontent type="text/html" reset="true">
	<cfoutput><div>#cffm.resourcekit['Msg.t62']#:  #variables.imageWidth# x #variables.imageHeight#</div></cfoutput>
	<cfif variables.scale lt 1>
		<cfoutput><div>#cffm.resourcekit['Msg.t11']# #NumberFormat(variables.scale*100,"__")# #cffm.resourcekit['Msg.t12']#.  <a target="_blank" href="#variables.workingDirectoryWeb#/#variables.editFilename#">#cffm.resourcekit['Msg.t13']#.</a></div></cfoutput>
	</cfif>
	<cfscript>
		if (cffm.includeDir contains "ram:") {
			variables.linkToFile = "#cffm.cffmFilename#?action=get&subdir=#urlEncodedFormat(subdir)#&downloadFilename=#urlEncodedFormat(editFilename)#&x=#RandRange(1,50000)#";
		} else {
			variables.linkToFile = "#variables.workingDirectoryWeb#/#editFilename#?x=#RandRange(1,50000)#";
		}
	</cfscript>
	<cfoutput><div id="image_preview_2"><img src="#variables.linkToFile#" borer=5 width="#variables.displayWidth#" height="#variables.displayHeight#"></div></cfoutput>
	<cfabort>
<cfelseif variables.action eq "viewSource" or variables.action eq "edit">
	<cfscript>
		if (variables.editFilename contains "/" or variables.editFilename contains "\") {
			variables.errorMessage = variables.errorMessage & "<li>#cffm.resourceKit.errorMsg.t5#</li>#Chr(10)#";
		} else if (cffm.getPathType(cffm.createServerPath(variables.subdir,variables.editFilename)) neq "file")	{
			variables.errorMessage = variables.errorMessage & "<li>#cffm.resourceKit.errorMsg.t8#  #cffm.createServerPath(variables.subdir, variables.editFilename)#</li>#Chr(10)#";		
		} else {
			variables.fileToRead = variables.workingDirectory & variables.dirsep & variables.editFilename;
			variables.readResults = cffm.readFile(variables.fileToRead);
			if (variables.readResults.errorCode is 0) {
				variables.content = variables.readResults.fileContent;
			} else {
				variables.errorMessage = variables.errorMessage & "<li>#variables.readResults.errorMessage#</li>#Chr(10)#";
			}
		}
	</cfscript>
	<cfif isDefined("variables.errorMessage") and variables.errorMessage neq "">
		<cfoutput>
		<fieldset class="cffm_errorMessage">
		<legend>#cffm.resourcekit['Msg.t3']#</legend>
		<ul>
		#variables.errorMessage#
		</ul>
		</fieldset>
		<p><a href="javascript:void(0);" onclick="loadDirectoryListing()"><b>#cffm.resourcekit['Msg.t14']#</b></a></p>
		</cfoutput>
	<cfelse>
		<cfoutput>
		<p><a href="javascript:void(0);" onclick="loadDirectoryListing()"><b>#cffm.resourcekit['Msg.t14']#</b></A></p>
		<form method="post" onsubmit="return false" id="frmEditFile" name="frmEditFile">
		<input type="hidden" name="editFilename" value="#variables.editFilename#">
		<textarea class="cffm_editor" name="editFileContent">#variables.content#</textarea>
		
		<cfif variables.action eq "edit">
		<p>
		<input type="button" class="button" value="#cffm.resourcekit['buttonText.t1']#" onclick="saveTextFile();">
		<input type="button" class="button" value="#cffm.resourcekit['buttonText.t2']#" onClick="loadDirectoryListing();">
		</p>
		</cfif>
		</form>	
		</cfoutput>
	</cfif>
	<cfabort>
<cfelseif action eq "manipulateForm">
	<!--- make a "working copy" --->
	<cfset variables.workingCopy = "No">
	<cfif Find("__TEMP__",variables.editFilename) is 1>
		<cfset variables.workingCopy = "Yes">
	<cfelse>
		<cffile action="COPY" source="#variables.workingDirectory#/#variables.editFilename#" destination="#variables.workingDirectory#/__TEMP__#variables.editFilename#">
		<cfset variables.editFilename = "__TEMP__" & variables.editFilename>
		<cfset variables.workingCopy = "Yes">
	</cfif>
	<!--- variables.image was created earlier --->
	<cfset variables.imageHeight = variables.image.getImageInfo().height>
	<cfset variables.imageWidth = variables.image.getImageInfo().width>
	<cfif NOT variables.workingCopy>
		<cfoutput>
		<p>#cffm.resourcekit['Msg.t61']#</p>
		<p><a href="javascript:void(0);" onclick="loadDirectoryListing();"><b>#cffm.resourcekit['Msg.t14']#</b></A></p>
		</cfoutput>
	<cfelse>
		<cfoutput>
		<p>#cffm.resourcekit['Msg.t72']#
			<a href="javascript:void(0);" onClick="commitChanges('commitChanges');" id="commitChanges"><b>#cffm.resourcekit['Msg.t64']#</b></A>
			<a href="javascript:void(0);" onClick="commitChanges('undoChanges');" id="undoChanges"><b>#cffm.resourcekit['Msg.t65']#</b></A>
		</p>
		</cfoutput>
	</cfif>
	<cfoutput>
	<script language="javascript">
	var editFilename = '#urlEncodedFormat(variables.editFilename)#';
	</script>
	<ul>
	<li>#cffm.resourcekit['Msg.t63']#: 
		<a href="javascript:void(0);" onclick="rotate('flipVertical')"><img align="absmiddle" border=1 src="#cffm.iconPath#/imgFlipVertical.gif" BORDER=0 ALT="Flip image vertically"></a>&nbsp;
		<a href="javascript:void(0);" onclick="rotate('flipHorizontal')"><img align="absmiddle" border=1 src="#cffm.iconPath#/imgFlipHorizontal.gif" BORDER=0 ALT="Flip image horizontally"></a>&nbsp;
		<a href="javascript:void(0);" onclick="rotate(90)"><img align="absmiddle" border=1 src="#cffm.iconPath#/imgRotate90.gif" BORDER=0 ALT="Rotate 90 degrees clockwise"></a>&nbsp;
		<a href="javascript:void(0);" onclick="rotate(180)"><img align="absmiddle" border=1 src="#cffm.iconPath#/imgRotate180.gif" BORDER=0 ALT="Rotate 180 degrees"></a>&nbsp;
		<a href="javascript:void(0);" onclick="rotate(270)"><img align="absmiddle" border=1 src="#cffm.iconPath#/imgRotate270.gif" BORDER=0 ALT="Rotate 90 degrees counter-clockwise"></a>

	<li>#cffm.resourcekit['Msg.t5']#
	<form style="display:inline" method="post" name="frmScaleWidth" onsubmit="return resize('scale',this);">
	<input type="text" size="4" maxlength="4" name="resizeWidthValue" value="0"> #cffm.resourcekit['Msg.t6']#.
	<input type="hidden" name="resizeHeightValue" value="0">
	<input type="submit" class="button" value="#cffm.resourcekit['buttonText.t3']#">
	</form>

	<li>#cffm.resourcekit['Msg.t9']#
	<form style="display: inline" method="post" name="frmScaleHeight" onSubmit="return resize('scale',this);">
	<input type="text" size="4" maxlength="4" name="resizeHeightValue" value="0"> #cffm.resourcekit['Msg.t6']#.
	<input type="hidden" name="resizeWidthValue" value="0">
	<input type="submit" class="button" value="#cffm.resourcekit['buttonText.t3']#">
	</form>

	<li>#cffm.resourcekit['Msg.t10']#
	<form style="display:inline" method="post" name="frmResize" onSubmit="return resize('resize',this);">
	<input type="text" size="4" maxlength="4" name="resizeWidthValue" value="0"> #cffm.resourcekit['Msg.t7']#
	<input type="text" size="4" maxlength="4" name="resizeHeightValue" value="0"> #cffm.resourcekit['Msg.t8']#.
	<input type="submit" class="button" value="#cffm.resourcekit['buttonText.t3']#"><br>
	<input type="checkbox" name="preserveAspect" value="1" onclick="if(this.checked){document.getElementById('cropToExact').style.display='inline'}else{document.getElementById('cropToExact').style.display='none'}">
	#cffm.resourcekit['Msg.t57']#
	<span id="cropToExact" style="display: none;">
	<input type="checkbox" name="cropToExact" value="1">
	#cffm.resourcekit['Msg.t58']#</span>
	</form>

	<li>#cffm.resourcekit['Msg.t59']#
	<form style="display:inline" method="post" name="frmCrop" onSubmit="return crop(this);">
	<input type="text" size="4" maxlength="4" name="cropStartX" value="0"> x
	<input type="text" size="4" maxlength="4" name="cropStartY" value="0">.<br/>
	#cffm.resourcekit['Msg.t60']#
	<input type="text" size="4" maxlength="4" name="cropWidthValue" value="0"> x
	<input type="text" size="4" maxlength="4" name="cropHeightValue" value="0">.
	<input type="submit" class="button" value="#cffm.resourcekit['buttonText.t3']#">
	</form>
	</ul>
	<div id="image_preview"></div>
	</cfoutput>
	<cfabort>
<cfelseif action eq "copymoveForm">
	<cfoutput>
	<a href="javascript:void(0);" onclick="hideAllForms();"><b>#cffm.resourcekit['Msg.t14']#</b></A><p>
	<cfset variables.workingFileType = cffm.getPathType(cffm.createServerPath(variables.subdir,variables.editFilename))>

	<form method="post" name="frmCopyMove" onSubmit="return copymove(this);">
	<input type="hidden" name="moveFilename" value="#variables.editFilename#">
	<input type="radio" name="action" value="move" checked>move
	<input type="radio" name="action" value="copy">copy to:
	<cfset options = 0>
	<select name="moveToSubdir" size="1">
		<cfif variables.subdir neq "">
			<cfset options = options + 1>
			<option value="">#cffm.resourcekit['Msg.t27']#</option>
		</cfif>
		<cfloop query="variables.listAllDirectories">
			<cfset webPath = Replace(ReplaceNoCase(fullPath,cffm.includeDir & variables.dirSep,"","ALL"),"\","/","all")>
			<cfset compare = variables.subdir & iif(len(subdir) gt 0,DE("/"),DE("")) & variables.editFilename>
			<cfif findNoCase(compare, webpath) neq 1>
				<Cfset options = options + 1>
				<option value="#webPath#">#cffm.createWebPath(webPath)#</option>
			</cfif>
		</cfloop>
	</select>
	<cfif options neq 0>
		<input type="submit" class="button" value="#cffm.resourcekit['buttonText.t3']#">
	<cfelse>
		<input type="button" class="button" value="#cffm.resourcekit['buttonText.t2']#" onClick="history.go(-1);">
		#cffm.resourcekit['Msg.t17']#
	</cfif>
	<br>
	<input type="checkbox" name="overwrite" value="true"<cfif cffm.overwriteDefault> CHECKED</cfif>> #cffm.resourcekit['Msg.t15']#.
	</form>
	</cfoutput>
	<cfabort>
<cfelseif action eq "viewzip">
	<cfoutput>
	<a href="javascript:void(0);" onclick="loadDirectoryListing();"><b>#cffm.resourcekit['Msg.t14']#</b></a><p>
	<form method="post" onSubmit="return unzip(this);">
	<input type="hidden" name="unzipFilename" value="#editFilename#">
	Unzip to: 
	<select name="unzipToSubdir" size="1">
	<option value="#variables.subdir#">#cffm.resourcekit['Msg.t1']# (#cffm.createWebPath(variables.subdir)#)</option>
	<cfif variables.subdir neq ""><option value="">#cffm.resourcekit['Msg.t27']# (#cffm.includeDirWeb#)</option></cfif>
	<cfloop query="variables.listAllDirectories">
	<cfset webPath = Replace(ReplaceNoCase(fullPath,cffm.includeDir & variables.dirSep,"","ALL"),"\",variables.dirsep,"all")>
	<cfif webpath neq variables.subdir>
		<option value="#webPath#">#cffm.createWebPath(webPath)#</option>
	</cfif>
	</cfloop>
	</select>
	<input type="submit" class="button" value="#cffm.resourcekit['buttonText.t6']#"> <input type="checkbox" value="true" name="overwrite"<cfif cffm.overwriteDefault> CHECKED</cfif>>#cffm.resourcekit['Msg.t15']#
	</form>
	<cfif cffm.allowedExtensions neq "">
		<p><b>#cffm.resourcekit['Msg.t18']#</b>:  #cffm.resourcekit['Msg.t20']#
		<ul>
		<cfloop list="#cffm.allowedExtensions#" index="thisExt">
			<li>#thisExt#</li>
		</cfloop>
		</ul>
		</p>
	<cfelseif cffm.disallowedExtensions neq "">
		<p><B>#cffm.resourcekit['Msg.t18']#</B>:  #cffm.resourcekit['Msg.t21']#</p>
	</cfif>
	<cfset variables.viewzipResults = cffm.viewZipFile(cffm.createServerPath(variables.subdir,variables.editFilename))>
	<table class="zipcontents"><thead>
	<tr class="headrow">
		<td>#cffm.resourcekit['Msg.t22']#</td>
		<td>#cffm.resourcekit['Msg.t23']#</td>
		<td>#cffm.resourcekit['Msg.t24']#</td>
	</tr></thead><tbody>
	<cfloop query="variables.viewzipResults">
	<tr>
		<td>#name#</td>
		<td>#type#</td>
		<td>#size#</td>
	</tr>
	</cfloop></tbody>
	</table>
	</cfoutput>
	<cfabort>
<cfelseif action eq "getTotalUsage">
	<cfset variables.metadata = cffm.getDirectoryMetadata(variables.listAllFiles)>
	<cfset out = "#cffm.resourcekit['Msg.t40']#: ">
	<cfif variables.metadata.totalSize lt 100>
		<cfset out = out & "&lt;0.1kb">
	<cfelseif variables.metadata.totalSize lt (1024*1024)>
		<cfset out = out & "#numberFormat(round(variables.metadata.totalSize/1024*10)/10,'0.0')#kb">
	<cfelse>
		<cfset out = out & "#numberFormat(round(variables.metadata.totalSize/1024/1024*100)/100,'0.00')#mb">
	</cfif>
	<cfcontent type="text/html" reset="true">
	<cfoutput>#out#</cfoutput>
	<cfabort>
<cfelseif action eq "showDirectoryListing">
	<cfcontent type="text/html" reset="true">

		<cfset variables.dirList = queryNew("attributes,datelastmodified,mode,name,size,type,directory,fullPath")>
<!---	<cfdirectory action="LIST" directory="#variables.workingDirectory#" name="variables.dirList">
			<cfset queryAddRow(variables.dirList)>
			<cfset querySetCell(variables.dirList,"datelastmodified",'')>
			<cfset querySetCell(variables.dirList,"name",'community_#request.community.communityId#')>
			<cfset querySetCell(variables.dirList,"size",'')>
			<cfset querySetCell(variables.dirList,"type",'dir')>
			<cfset querySetCell(variables.dirList,"directory",'')>
			<Cfset querySetCell(variables.dirList,"fullPath",'')>
			<cfdump var='#files#'>--->
		<cfloop query="files">
			<cfset queryAddRow(variables.dirList)>
			<cfset querySetCell(variables.dirList,"datelastmodified",files.dateEntered)>
			<cfset querySetCell(variables.dirList,"name",files.file)>
			<cfset querySetCell(variables.dirList,"size",files.filesize)>
			<cfset querySetCell(variables.dirList,"type",'File')>
			<cfset querySetCell(variables.dirList,"directory",'')>
			<Cfset querySetCell(variables.dirList,"fullPath",files.cdnurl)>
			<!---><cfif type is "dir">
				<!--- go deep! --->
				<cfset cffmDirectoryList(directory & path & name,true,dirInfo)>
			</cfif>
			--->
		</cfloop>
		

	<cfoutput>
	<div class="cffmDirectoryLinks">
	<table>
	<tr>
	<!--- <td align="center" width="40"><a href="javascript:void(0);" onclick="changeDirectory('');"><img class="cffmIcon" src="#cffm.iconPath#/home.png" width="32" height="32" alt="#cffm.resourcekit['Msg.t27']#" title="#cffm.resourcekit['Msg.t27']#">#cffm.resourcekit['Msg.t27']#</a></div></td> --->
	<td align="center" width="40"><a href="javascript:void(0);" onclick="loadDirectoryListing()"><img class="cffmIcon" src="#cffm.iconPath#/refresh.png" width="32" height="32" alt="#cffm.resourcekit['Msg.t28']#" title="#cffm.resourcekit['Msg.t28']#">#cffm.resourcekit['Msg.t28']#</a></div></td>
	<cfif not cffm.readOnly>
		<td align="center" width="40"><a href="javascript:void(0);" onclick="showUploadForm();"><img class="cffmIcon" src="#cffm.iconPath#/upload.png" width="32" height="32" alt="#cffm.resourcekit['Msg.t41']#" title="#cffm.resourcekit['Msg.t41']#">#cffm.resourcekit['Msg.t41']#</a></div></td>
		<cfif cffm.allowCreateDirectory>
			 <td align="center" width="40"><a href="javascript:void(0);" onclick="showCreateDirectoryForm();"><img class="cffmIcon" src="#cffm.iconPath#/newfolder.png" width="32" height="32" alt="#cffm.resourcekit['buttonText.t8']#" title="#cffm.resourcekit['buttonText.t8']#">#cffm.resourcekit['buttonText.t7']#</a></div></td>
		</cfif>
	</cfif>
	</tr>
	</table>
	<div style="float: left;"><em>#cffm.resourcekit['msg.t79']#</em></div>
	<div class="fright">
	<form id="filter-form" action="#cffm.cffmFilename#" method="post" onsubmit="return false;">
	<b>Filter:</b> <input name="filter" id="filter" type="text" value="" size="15"> <input id="filterBtn" type="button" value="Clear" onclick="$('##filter').val(''); $.uiTableFilter($('##fileTable'),''); $('##filterBtn').hide();" style="display:none;"></form></div>
	</div>
	<table id="fileTable" name="fileTable" width="100%" class="tablesorter">
	<colgroup><col><col><col><col><col><col></colgroup>
<thead>
	<tr class="header">
		<th></th>
		<th>Ext&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
		<th width="100%">#cffm.resourcekit['Msg.t22']#</th>
		<th>#cffm.resourcekit['Msg.t24']#</th>
		<th>#cffm.resourcekit['Msg.t29']#&nbsp;&nbsp;</th>
		<cfif cffm.useFileActionButtons>
		<th>#cffm.resourcekit['Msg.t30']#</th>
		</cfif>
	</tr></thead><tbody>
	</cfoutput>
	<cfif variables.subdir neq "">
		<!--- include link to parent directory --->
		<cfset variables.linkToFile =  ListDeleteAt(variables.subdir,listlen(variables.subdir,"/"),"/")>
		<cfoutput>
		<tr>
			<td><a href="javascript:void(0);" onclick="changeDirectory('#jsStringFormat(variables.linkToFile)#');" target="_self"><img src="#cffm.iconPath#/folder_up.gif" border="0"></a></td>
			<td></td>
			<td width="100%">
				<a href="javascript:void(0);" onclick="changeDirectory('#jsStringFormat(variables.linkToFile)#');" target="_self">#cffm.resourcekit['Msg.t31']#</a>
			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<cfif cffm.useFileActionButtons>
			<td>&nbsp;</td>
			</cfif>
		</tr>
		</cfoutput>
	</cfif>
	<cfset variables.totalDirectories = 0>
	<cfset variables.totalFiles = 0>
	<cfset variables.totalSize = 0>
	<cfquery name="sortedDirList" dbtype="query">
		select *, lower(name) as sortname
		from variables.dirlist
		<cfif variables.EDITOR_RESOURCE_TYPE eq "image">
			where
				type = 'Dir'
				or name like '%.png'
				or name like '%.jpg'
				or name like '%.jpeg'
				or name like '%.gif'
		<cfelseif variables.EDITOR_RESOURCE_TYPE eq "flash">
			where
				type = 'Dir'
				or name like '%.swf'
		</cfif>
		order by type, sortname
	</cfquery>
	<cfoutput query="variables.sortedDirList"><cfsilent>
		<cfset variables.dimensionCount = 0>
		<cfscript>
			// ***************************************************
			// all of this cfscript stuff customizes the output
			// in the directory listing based on settings, file type
			// etc...
			// ***************************************************
			variables.editable = 0;
			variables.zipFile = 0;
			variables.editableImage = 0;
			variables.fileIcon = "spacer.gif";
			variables.dimensions = "";
			variables.previewLink = "";
			variables.imgsrc = "";
			if (listLen(name,".") gt 1) {
				variables.extension = lcase(listLast(name,"."));
				if (listFindNoCase(cffm.editableExtensions, variables.extension) gt 0 and type eq "file") {
					variables.editable = 1;
				} else if (listFindNoCase("zip",variables.extension) gt 0) {
					variables.zipFile = 1;
				}
			} else {
				variables.extension = "";
				variables.editable = 0;
			}
			variables.linkclass = "file";
			variables.fileTypeDesc = 'file';
			variables.linkDimensions = "dimensions=#chr(34)##chr(34)#";
			if (type eq "dir") {
				variables.linkclass = "directory";
				variables.fileTypeDesc = 'directory';
				variables.totalDirectories = variables.totalDirectories + 1;
				variables.fileIcon = "folder_closed.gif";
				variables.linkTarget = "_self";
				variables.linkToFile = "";
				if (variables.subdir eq "") {
					variables.linkToFile = variables.linkToFile & name;
				} else {
					variables.linkToFile = variables.linkToFile & variables.subdir & "/" & name;
				}
				onclick = "onclick=#chr(34)#changeDirectory('#jsstringformat(variables.linkToFile)#')#chr(34)#";
				variables.linkToFile = "javascript:void(0);";
			} else {
				variables.fileIcon = "ext/#variables.extension#.gif";
				onclick = "";
				variables.totalFiles = variables.totalFiles + 1;
				variables.totalSize = variables.totalSize + size;
				if (listFindNoCase("gif,jpg,png",variables.extension) gt 0)
				{
					variables.previewLink = "#variables.workingDirectoryWeb#/#name#"; 
					variables.linkclass="imgPreview";
					variables.imgsrc = "#variables.workingDirectoryWeb#/#name#";
					if (variables.extension eq "jpg" or variables.extension eq "png")
					{
						variables.editableImage = 1;
					}
					if ((variables.imageComponent eq "imageobject_cfimage" or cffm.includeDir does not contain "ram://") AND cffm.enableImageDimensionsInDirList AND variables.dimensionCount lt cffm.maxImageDimensionsPerFileListing)
					{
						variables.DimensionCount = variables.DimensionCount + 1;
						if (NOT isDefined("variables.image")) {
							variables.image = createObject("component","#variables.imageComponent#");
						}
						try
						{
							variables.image.init(cffm.createServerPath(variables.subdir,name));
							variables.dimensions = variables.image.getImageInfo().width & "x" & variables.image.getImageInfo().height;
							variables.linkDimensions = "dimensions=#chr(34)##variables.dimensions##chr(34)#";
						} catch(Any e) {
							// next line is for debugging 
							// cffm.cffmdump(e);
							// image won't be editable, but for now
							// let's leave the manipulate link.  To remove
							// it, uncomment the following line:
							// variables.editableImage = 0;
						}
					}
				}
				variables.previewTarget = "_blank";
				variables.previewLink = "#variables.workingDirectoryWeb#/#name#";
				if (variables.editorType eq "")
				{
					// editorType is empty when CFFM is being used as a plain ol' file manager.
					variables.linkTarget = "_blank";
					if (cffm.includeDir contains "ram:") {
						variables.linkToFile = "#cffm.cffmFilename#?action=get&subdir=#urlEncodedFormat(subdir)#&downloadFilename=#urlEncodedFormat(name)#";
					} else {
						variables.linkToFile = "#variables.workingDirectoryWeb#/#name#";
					}
				} else {
					// editor type is "fck" or "mce" or something so we should perform some action when
					// a file is clicked on.
					variables.linkTarget = "_self";
					if ( variables.EDITOR_RESOURCE_TYPE eq "image" AND listFindNoCase("jpg,gif,png",extension) eq 0 )
					{
						// we can only perform the action if the file is an image.
						variables.linktofile='##';
						variables.onclick="onClick=#chr(34)#alert('#cffm.resourcekit['Msg.t32']#.');#chr(34)#";
					} else if ( variables.EDITOR_RESOURCE_TYPE eq "flash" AND lcase(extension) neq "swf") {
						// we can only perform the action if the file is a flash document.
						variables.linkToFile='##';
						variables.onclick="onClick=#chr(34)#alert('Sorry, but this file is not a Flash document.  Flash documents have a .SWF extension.');#chr(34)#";
					} else {
						// we're inserting a link to a file, so any file would be fine.
						variables.linkToFile = "#variables.workingDirectoryWeb#/#name#";
						variables.onClick = "onClick=#chr(34)#OpenFile('#jsStringFormat(variables.linkToFile)#');#chr(34)#";
						variables.linkToFile = '##';
					}
				}
			}
		</cfscript>
		<cfif type eq "file">
			<cfset variables.linkClass = variables.linkClass & " cffm-menu-download">
		</cfif>
		<cfif variables.editorType neq "" AND variables.previewLink neq "">
			<cfset variables.linkClass = variables.linkClass & " cffm-menu-preview">
		</cfif>
		<cfif not cffm.readOnly>		
			<cfset variables.linkClass = variables.linkClass & " cffm-menu-delete cffm-menu-copymove cffm-menu-rename">
		</cfif>
		<cfif variables.editable eq 1>
			<cfset variables.linkClass = variables.linkClass &  " cffm-menu-editfile cffm-menu-viewsource">
		</cfif>
		<cfif not cffm.readOnly and cffm.allowUnzip and variables.zipfile eq 1>
			<cfset variables.linkClass = variables.linkClass &  " cffm-menu-unzip">
		</cfif>
		<cfif (variables.imageComponent eq "imageobject_cfimage" or cffm.includeDir does not contain "ram://") and not cffm.readOnly and variables.editableImage>
			<cfset variables.linkClass = variables.linkClass &  " cffm-menu-editimage">
		</cfif>
		<cfset variables.linkClass = variables.linkClass &  " addContextMenu">
	</cfsilent>
	
	<tr>
		<td><a #variables.linkDimensions# href="#variables.linkToFile#" target="#variables.linkTarget#" #onclick#><img src="#cffm.iconPath#/#variables.fileIcon#" border="0"></a></td>
		<td><cfif type eq "FILE">#lcase(ListLast(name,"."))#<CFELSE>dir</CFIF></td>
		<td width="100%">
			<a filetypedesc="#variables.fileTypeDesc#" class="#variables.linkclass#" #variables.linkDimensions# href="#variables.linkToFile#" target="#variables.linkTarget#" #onclick#<cfif variables.imgsrc neq ""> imgsrc="#variables.imgsrc#"</cfif>>#name#</a>
			<cfif variables.editorType neq "" AND variables.previewLink neq "">&nbsp;<a class="previewLink button" target="_blank" href="#variables.previewLink#">#cffm.resourcekit['Msg.t48']#</a></cfif>
		</td>
		<td class="right"><cfif type eq "FILE"><cfif size lt 100>&lt;0.1kb<cfelseif size lt 10000>#numberFormat(round(size/1024*10)/10,'0.0')#kb<cfelseif size lt 1000000>#round(size/1024)#kb<cfelse>#round(size/1024/1024)#mb</cfif><cfelse><center>-</center></cfif></td>
		<td class="right nowrap">#dateFormat(dateLastModified,"MM/d/yyyy")# #TimeFormat(dateLastModified,"HH:mm:ss")#</td>
		<cfif cffm.useFileActionButtons>
		<td class="actionLinks nowrap"><cfif not cffm.readOnly><a href="javascript:void(0);" onclick="deleteIt('#variables.fileTypeDesc#','#jsStringFormat(name)#');">#cffm.resourcekit['Msg.t50']#</a>&nbsp;<a href="javascript:void(0);" onclick="showRenameForm('#jsStringFormat(name)#');">#cffm.resourcekit['Msg.t51']#</a>&nbsp;<a href="javascript:void(0);" onclick="showCopyMoveForm('#jsStringFormat(name)#')">#cffm.resourcekit['Msg.t52']#</a>&nbsp;<cfif variables.editable eq 1><a href="javascript:void(0);" onclick="editFile('#jsStringFormat(name)#');">#cffm.resourcekit['Msg.t53']#</a>&nbsp;</cfif></cfif><cfif variables.editable eq 1><a href="javascript:void(0);" onclick="viewSource('#jsStringFormat(name)#');">#cffm.resourcekit['Msg.t54']#</a>&nbsp;</cfif><cfif not cffm.readOnly and cffm.allowUnzip and variables.zipfile eq 1><a href="javascript:void(0);" onclick="showUnzipForm('#jsStringFormat(name)#');">#cffm.resourcekit['Msg.t55']#</a>&nbsp;</cfif><cfif (variables.imageComponent eq "imageobject_cfimage" or cffm.includeDir does not contain "ram://") and not cffm.readOnly and variables.editableImage><a href="javascript:void(0);" onclick="showManipulateForm('#jsStringFormat(name)#');">#cffm.resourcekit['Msg.t75']#</a></cfif></td>
		</cfif>
	</tr>
	</cfoutput>
	<cfoutput></tbody>
	</table>
	#cffm.resourcekit['Msg.t33']# #variables.totalDirectories# <cfif variables.totalDirectories IS 1>#cffm.resourcekit['Msg.t34']#<cfelse>#cffm.resourcekit['Msg.t35']#</cfif> 
	#cffm.resourcekit['Msg.t36']# #variables.totalFiles# <cfif variables.totalFiles eq 1>#cffm.resourcekit['Msg.t37']#<cfelse>#cffm.resourcekit['Msg.t38']#</cfif>.<br>
	#cffm.resourcekit['Msg.t39']# #NumberFormat(variables.totalSize,"_,___")# bytes.
	<span id="showTotalUsage"><a href="javascript:void(0);" onclick="fn_showTotalUsage();">#cffm.resourcekit['Msg.t45']#</a></span>
	</cfoutput>
	<cfabort>
</cfif>


<!---
	everything below here is what appears on the main
	cffm page the first time its called.  Everythingabove
	is an ajax call that either returns HTML to be placed 
	on the page, or returns a JSON object to be dealt with.
--->


<cfoutput>
<!-- powered by CFFM:  http://www.opensourcecf.com/cffm -->#chr(10)#</cfoutput>
<cfif cffm.templateWrapperAbove neq "">
	<cfsetting enablecfoutputonly="no">
	<CFINCLUDE TEMPLATE="#cffm.templateWrapperAbove#">
	<cfsetting enablecfoutputonly="yes">
<cfelse>
	<cfoutput><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"><title>File Manager version #cffm.version#</title></cfoutput>
</cfif>
<cfoutput>
<link rel="stylesheet" type="text/css" href="./cffmDefault.css">
<link href="./fileuploader/fileuploader.css" rel="stylesheet" type="text/css">	
<link href="./tablesorter/tablesorter.blue.css" rel="stylesheet" type="text/css">
<script src="./jquery-1.3.2.min.js" type="text/javascript"></script>
<script src="./imgpreview.min.0.22.jquery.js" type="text/javascript"></script>
<script src="./jquery.blockUI.js" type="text/javascript"></script>
<script src="./fileuploader/fileuploader.js?ts=#Now().getTime()#" type="text/javascript"></script>
<script src="./tablesorter/jquery.tablesorter.min.js" type="text/javascript"></script>
<script src="./tablesorter/jquery.uitablefilter.js" type="text/javascript"></script>
<script src="./contextMenu/jquery.contextMenu.js" type="text/javascript"></script> 
<link href="./contextMenu/jquery.contextMenu.css" rel="stylesheet" type="text/css" /> 

<cfset allowedExtensionsJSList = "">
<cfloop list="#cffm.allowedExtensions#" index="ext">
	<cfset allowedExtensionsJSList = listAppend(allowedExtensionsJSList,"'#ext#'")>
</cfloop>
<script src="./cffm.js?ts=#Now().getTime()#" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
// set some javascript variables
var allowMultiple = <cfif cffm.allowMultipleUploads>true<cfelse>false</cfif>;
var allowedExtensions = [#allowedExtensionsJSList#];
var maxUploadSize = <cfoutput>#cffm.maxUploadSize#</cfoutput>;
var editorType = '#variables.editorType#';
var editorResourceType = '#trim(lcase(variables.EDITOR_RESOURCE_TYPE))#';
var instance = '#variables.instance#';
var fileUploader_typeError = '#JSStringFormat(cffm.resourcekit['fileUploader.typeError'])#';
var fileUploader_sizeError = '#JSStringFormat(cffm.resourcekit['fileUploader.sizeError'])#';
var fileUploader_minSizeError = '#JSStringFormat(cffm.resourcekit['fileUploader.minSizeError'])#';
var fileUploader_emptyError = '#JSStringFormat(cffm.resourcekit['fileUploader.emptyError'])#';
var fileUploader_onLeave = '#JSStringFormat(cffm.resourcekit['fileUploader.onLeave'])#';
var useContextMenus = <cfif cffm.useContextMenus>true<cfelse>false</cfif>;
var useFileActionButtons = <cfif cffm.useFileActionButtons>true<cfelse>false</cfif>;
<cfif structKeyExists(url,"CKEditorFuncNum")>var CKEditorFuncNum = #CKEditorFuncNum#;</cfif>
var cffmFilename = '#cffm.cffmFilename#';
var includeDirWeb = '#replace(cffm.includeDirWeb,"'","\'","ALL")#';
// these will change as the user performs verous actions
var subdir = '#replace(variables.subdir,"'","\'","ALL")#';
var showTotalUsage = #val(variables.showTotalUsage)#;
</script>
<cfif cffm.templateWrapperAbove eq "">
</head><body>
</CFIF>
<div id="cffm">
<p class="cffm_location">#cffm.resourcekit['Msg.t1']#:  <span id="currentSubdir">#variables.workingDirectoryWeb#</span></p>
</cfoutput>

<cfif isDefined("variables.errorMessage") and variables.errorMessage neq "">
	<cfoutput>
	<fieldset class="cffm_errorMessage">
	<legend>#cffm.resourcekit['Msg.t3']#</legend>
	<ul>
	#variables.errorMessage#
	</ul>
	</fieldset>
	</cfoutput>
</cfif>

<cfif not cffm.readOnly>
	<cfoutput>
	<fieldset id="fsUploadForm" style="display:none;">
		<legend>#cffm.resourcekit['Msg.t41']#</legend>
		<div id="fileuploader"></div>
	</fieldset>
	
	<fieldset id="fsRenameForm" style="display:none;">
		<legend>#cffm.resourcekit['Msg.t73']#</legend>
		<form action="#cffm.cffmFilename#" method="post" name="frmRename" onSubmit="return rename(this.renameOldFilename.value, this.renameNewFilename.value, this.renameOverwrite.checked);" style="display:inline;">
		<input type="hidden" name="renameOldFilename" id="renameOldFilename" value="">
		<input onFocus="select();" type="text" size="40" maxlength="200" name="renameNewFilename" id="renameNewFilename" value="">
		<input type="submit" class="button" value="#cffm.resourcekit['buttonText.t4']#">
		<input type="button" class="button" value="#cffm.resourcekit['buttonText.t2']#" onclick="hideRenameForm();">
		<br><label for="renameOverwrite"><input type="checkbox" id="renameOverwrite" name="renameOverwrite" value="true"<cfif cffm.overwriteDefault> checked</cfif>> #cffm.resourcekit['Msg.t15']#.</label>
		</form>
	</fieldset>

	<fieldset id="fsCopyMoveForm" style="display:none;">
		<legend>#cffm.resourcekit['Msg.t74']#</legend>
		<div id="copyMoveFormContents"></div>
	</fieldset>

	<fieldset id="fsCreateFileForm" style="display:none;">
		<legend>#cffm.resourcekit['Msg.t42']#</legend>
		<form action="#cffm.cffmFilename#" method="post" name="frmCreateFile" onSubmit="return createFile(this);" style="display:inline;">
		#cffm.resourcekit['Msg.t76']#:
		<input type="text" size="20" name="newFilename" id="newFilename">
		<input type="submit" value="#cffm.resourcekit['buttonText.t7']#">
		<input type="button" onClick="hideAllForms();" value="#cffm.resourcekit['buttonText.t2']#"><br/>
		<label for="createFileOverwrite"><input type="checkbox" name="createFileOverwrite" id="createFileOverwrite"<cfif cffm.overwriteDefault> checked</cfif>>#cffm.resourcekit['Msg.t15']#</label>
		</form>
	</fieldset>
	
	<fieldset id="fsCreateDirectoryForm" style="display:none;">
		<legend>#cffm.resourcekit['Msg.t43']#</legend>
		<form action="#cffm.cffmFilename#" method="post" name="frmCreateDirectory" onSubmit="return createDirectory(this);" style="display:inline;">
		#cffm.resourcekit['Msg.t77']#:
		<input type="text" size="20" name="newDirectoryName" id="newDirectoryName">
		<input type="submit" value="#cffm.resourcekit['buttonText.t8']#">
		<input type="button" onClick="hideAllForms();" value="#cffm.resourcekit['buttonText.t2']#">
		</form>
	</fieldset>
	
	</cfoutput>
</cfif>

<cfoutput>
<noscript>#cffm.resourcekit['errorMsg.t26']#</noscript>
<div id="mainContent"></div>
<cfif cffm.useContextMenus>
<ul id="myMenu" class="contextMenu">
    <li class="download">
        <a href="##download">#cffm.resourcekit['msg.t80']#</a>
    </li>
    <li class="delete">
        <a href="##delete">#cffm.resourcekit['msg.t50']#</a>
    </li>
    <li class="rename">
        <a href="##rename">#cffm.resourcekit['msg.t51']#</a>
    </li>
    <li class="copymove">
        <a href="##copymove">#cffm.resourcekit['msg.t52']#</a>
    </li>
    <li class="editimage">
        <a href="##editimage">#cffm.resourcekit['msg.t75']#</a>
    </li>
    <li class="unzip">
        <a href="##unzip">#cffm.resourcekit['msg.t55']#</a>
    </li>
    <li class="editfile">
        <a href="##editfile">#cffm.resourcekit['msg.t53']#</a>
    </li>
    <li class="viewsource">
        <a href="##viewsource">#cffm.resourcekit['msg.t54']#</a>
    </li>
</ul>
</cfif>
</div><!--- end div id=cffm --->
</cfoutput>

<cfif cffm.templateWrapperBelow neq "">
	<cfsetting enablecfoutputonly="no">
	<CFINCLUDE TEMPLATE="#cffm.templateWrapperBelow#">
<cfelse>
	<cfoutput></body></html></cfoutput>
</cfif>
