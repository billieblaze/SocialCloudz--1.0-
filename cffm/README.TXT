  _____ ______ ______ __  __ 
 / ____|  ____|  ____|  \/  |
| |    | |__  | |__  | \  / |
| |    |  __| |  __| | |\/| |
| |____| |    | |    | |  | |
 \_____|_|    |_|    |_|  |_|
 
Project:		CFFM version 1.31
Description:	Coldfusion File Manager
Author: 		Rick Root (rick@webworksllc.com)
Homepage:		http://www.opensourcecf.com/cffm

INSTALLATION
************

#1 - make a directory under your web root for CFFM and put it there
#2 - modify the <cfinvokeargument> values in cffm.cfm
     They are heavily commented to help you figure out what
	 to put in them.


CFINVOKEARGUMENTS (ie, How to set up CFFM)	 
******************************************
includeDir		The physical path to the root of your file 
				manager.  You can use ExpandPath() if you want
				or "ram:///" (with three slashes) for the CF9
				RAM drive.  SUGGESTION:  This might be set in
				your application.cfc
				
				Example 1:  "#expandPath(".")#/custom"
				Example 2:  "C:\Inetpub\wwwroot\custom"
				Example 3:  "/home/opensourcecf/public_html/custom"
				
includeDirWeb	The web path to your file managers root folder.
				You can choose to include the domain or not.
				
				For ram drive (CF9) or other Virtual File Systems
				use "/"
				
				Example 1:  http://www.opensourcecf.com/custom
				Example 2:  /custom
				
				While CFFM can work with a relative path (like "./custom"), 
				if you plan to integrate it with an editor of any kind, make
				sure your cfinvokeargument value for IncludeDirWeb is a full 
				path to your files directory OR a "root relative" path.. ie:

				http://www.opensourcecf.com/cffm/demo/custom
				 - or -
				/cffm/demo/custom

disallowedExtensions
				File extensions that are not allowed.

allowedExtensions
				File extensions you explicitly allow.  This overrides
				the disallowedExtensions setting because its more 
				restrictive.  Also, if you're using this, you can't
				create files without extensions.
				
				You could use this setting to restrict uploads to
				images by setting it to "jpg,gif,png"


editableExtensions
				File extensions that are editable text files.  If
				you leave this empty, editing of text files will
				not be available.

				Example:  "txt,cfm,htm,html"
				
overwriteDefault
				There are several places where a checkbox appears 
				to overwrite existing.  This controls what it defaults 
				to.
				Yes or No

iconPath		web path to the location of the icons used by cffm.

debug			Not used in current code.
				0 or 1

templateWrapperAbove
templateWrapperBelow
				Wrap CFFM with these template files via
				cfinclude.  By default, CFFM wraps itself
				in a very plain template.

cffmFilename	name of this file.  You should not change this.

enableImageDimensionsInDirList
				Yes or No
maxImageDimensionsPerFileListing
				Integer
				
				CFFM can put image dimensions in the image
				preview but this could be a bit of a drain,
				so if you have it enabled, you should set
				the number of images it will figure the 
				dimensions of to some relatively small number
				or a directory listing with lots of images
				will be very slow.
				
readOnly		Sets your whole file system to read only.
				Disables edit text files, manipulate images
				upload, delete, rename, and create.
				Yes or No
				
allowUnzip		Whether or not to allow users to unzip files
				on the server.  
				Yes or No

allowCreateDirectory
				Whether or not to allow users to create new
				directories.
				Yes or No

allowMultipleUploads
				Whether or not to allow multiple uploads
				Yes or No
maxUploadSize	Maximum size, in bytes, of each uploaded file

uploadQueueMaxFiles
				The maximum number of files that can be uploaded
				at once.  Ignored if allowMultipleUplodas = false
useContextMenus
				This option use jquery context menus for file actions.

useFileActionButtons
				This option uses standard buttons for file actions.
				

				

LICENCE
*******
By using this code, you are agreeing to the terms of the license
agreement found in LICENSE.TXT.

FEEDBACK
********
Please send your feedback to rick@webworksllc.com

If you incorporate CFFM into an application, please let me know.
It will make me feel good about myself.

CF9 RAM DRIVE (VIRTUAL FILE SYSTEM)
************************************
To use CFFM to manage files in your RAM disk, set your 
includeDir to ram:// and your includeDirWeb to /
Image Manipulation is disabled when using the RAM disk because
imageCFC cannot read/write to the RAM disk.  Stay tuned.

RAILO VIRTUAL FILE SYSTEMS
**************************
Gert tells me that CFFM works with other virtual file systems
that RAILO offers, like the ftp:// virtual file system.  These
should work the same as the RAM drive (see above)

CKEDITOR 3.0+ INTEGRATION
**************************
You can put these options in your config.js file or (more
desirable), use them when you create each instance of CKEditor
like this:

CKEDITOR.replace( 'editor1',
		{
			filebrowserBrowseUrl : '/path/to/cffm.cfm?editorType=cke&EDITOR_RESOURCE_TYPE=file',
			filebrowserImageBrowseUrl : '/path/to/cffm.cfm?editorType=cke&EDITOR_RESOURCE_TYPE=image',
			filebrowserFlashBrowseUrl : '/path/to/cffm.cfm?editorType=cke&EDITOR_RESOURCE_TYPE=flash',
			filebrowserUploadUrl : '/path/to/cffm.cfm?action=QuickUpload&editorType=cke&EDITOR_RESOURCE_TYPE=file',
			filebrowserImageUploadUrl : '/path/to/cffm.cfm?action=QuickUpload&editorType=cke&EDITOR_RESOURCE_TYPE=image',
			filebrowserFlashUploadUrl : '/path/to/cffm.cfm?action=QuickUpload&editorType=cke&EDITOR_RESOURCE_TYPE=flash'
		} 
);


FCKEDITOR AND TINYMCE INTEGRATION
**********************************
This file manager integrates nicely with both TinyMCE (1.45+),
FCKeditor 2.0+, and ckEditor 3.0+.

FCKEDITOR 2.0+ :
 - and -
FCKEditor in Coldfusion 8+ - <cftextarea richtext="true">

Use the FCKEditor Javascript API to add CFFM support to a 
specific instance of FCKeditor.  Place the script on the 
page where you've used <cftextarea richtet="true">:

<script>
function FCKeditor_OnComplete(editorInstance)
{
	// set relative path to CFFM
	var cffmPath = "/path/to/cffm/cffm.cfm";
	// enable server browser
	editorInstance.EditorWindow.parent.FCK.Config.LinkBrowser		= true;
	editorInstance.EditorWindow.parent.FCK.Config.ImageBrowser		= true;
	editorInstance.EditorWindow.parent.FCK.Config.FlashBrowser		= true;
	// enable quick upload
	editorInstance.EditorWindow.parent.FCK.Config.LinkUpload		= true;
	editorInstance.EditorWindow.parent.FCK.Config.ImageUpload		= true;
	editorInstance.EditorWindow.parent.FCK.Config.FlashUpload		= true;
	// set urls
	editorInstance.EditorWindow.parent.FCK.Config.LinkBrowserURL	= cffmPath + "?EDITOR_RESOURCE_TYPE=file&editorType=fck";
	editorInstance.EditorWindow.parent.FCK.Config.ImageBrowserURL	= cffmPath + "?EDITOR_RESOURCE_TYPE=image&editorType=fck";
	editorInstance.EditorWindow.parent.FCK.Config.FlashBrowserURL	= cffmPath + "?EDITOR_RESOURCE_TYPE=flash&editorType=fck";
	editorInstance.EditorWindow.parent.FCK.Config.LinkUploadURL		= cffmPath + "?EDITOR_RESOURCE_TYPE=file&editorType=fck&action=quickupload";
	editorInstance.EditorWindow.parent.FCK.Config.ImageUploadURL	= cffmPath + "?EDITOR_RESOURCE_TYPE=image&editorType=fck&action=quickupload";
	editorInstance.EditorWindow.parent.FCK.Config.FlashUploadURL	= cffmPath + "?EDITOR_RESOURCE_TYPE=flash&editorType=fck&action=quickupload";
}

</script>

TINYMCE 1.45+ :
	In your javascript where you implement tinymce, you need to create a callback function like this:

	This hasn't been tested in ages.
	
<script language="Javascript">
	function cffmCallback(field_name, url, type, win) 
	{
		// Do custom browser logic
		url = '/path/to/cffm/cffm.cfm?editorType=mce&EDITOR_RESOURCE_TYPE=' + type;
		x = 700; // width of window
		y = 500; // height of window
		win2 = win; // don't ask, it works.  win2 ends up being global to the page, while win is only accessible to the function.
		cffmWindow = window.open(url,"","width="+x+",height="+y+",left=20,top=20,bgcolor=white,resizable,scrollbars,menubar=0");
		if ( cffmWindow != null )
		{
			// bring the window to the front
			cffmWindow.focus();
		}	
	}
	// then modify your init() call to include the callback reference:
	tinyMCE.init({
		file_browser_callback : "cffmCallback"
	});

</script>	


