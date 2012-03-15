/*
*	CFFM.JS (version 1.3)
*   see http://www.opensourcecf.com/cffm
*/

$(document).ready(function() {
});

function OpenFile( fileUrl )
{
	if (editorType == 'fck') {
		window.opener.SetUrl( fileUrl ) ;
		window.close() ;
		window.opener.focus() ;
	} else if (editorType == 'mce') {
		if (editorResourceType == 'file')
		{
			targetId = 'href';
		} else if ( editorResourceType == 'flash' ) {
			targetId = 'file';
		} else { 
			targetId = 'src';
		}
		srcInput = window.opener.win2.document.getElementById(targetId);
		srcInput.value = fileUrl;

		window.close() ;
		window.opener.win2.focus() ;
	} else if (editorType == 'cke') {
//		var target = window.opener.document.getElementById(instance);
		window.opener.CKEDITOR.tools.callFunction(CKEditorFuncNum, fileUrl);
		window.close();
	}
}
$(function(){ 
	loadDirectoryListing(true);
});

function fn_showTotalUsage() 
{
	var url = cffmFilename + '?action=getTotalUsage&subdir='+escape(subdir);
	url += '&showTotalUsage=' + showTotalUsage;
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$('#showTotalUsage').load(url);
	return false;
}

$.tablesorter.addParser({
	id: "anchor_text",
	is: function(s) {return false;},
	format: function(s) {return $(s).text();},
	type: "text"
});

$.tablesorter.addParser({
	id: "filesize",
	is: function(s) {return false;},
	format: function(s) {
        var regExp = /(kb|mb|gb)/i;
        var type = s.search(regExp) != -1 ? s.match(regExp)[0] : "";
        switch (type.toLowerCase()) {
                case "kb" : mult = 1024; break;
                case "mb" : mult = 1048576; break;
                case "gb" : mult = 1073741824; break;
                default : mult = 1;
        };
        s = parseFloat(s.replace(/[^0-9\.\-]/g,''));
        return isNaN(s) ? "" : s * mult;
	},
	type: "numeric"
});	


function bindTable(){
	var theTable = $('#fileTable');
	theTable.tablesorter({
	headers:{
		0:{sorter: false},
		2:{sorter:'anchor_text'},
		3:{sorter:'filesize'},
		4:{sorter:'shortdate'},
		5:{sorter: false}
	},
	widgets:['zebra']});

/*	$(".cffmIcon").hover(
		function() {
			$(this).css('border','1px solid #3300ff');
		},
		function() {
			$(this).css('border','1px solid white');
		}
	);
*/
	$('#filter').unbind();
	$("#filter").keyup(function(e) {
		var keyCode = e.keyCode || window.event.keyCode;
		if(keyCode == 27){
			$('#filter').val('');
			$.uiTableFilter($('#fileTable'),'');
			$('#filterBtn').show();
		} else {
			$('#filterBtn').show();
			$.uiTableFilter(theTable, this.value);
		}
	});
}

function setupImagePreview(){
	bindTable();
	if (useContextMenus) {
		addContextMenu();
	}
	
	try
	{
		$('a.imgPreview').imgPreview({
		    containerID: 'imgPreviewWithStyles',
			// using this special non standard attribute in CFFM
			// since sometimes the href is a javascript call to 
			// insert an image into an HTML editor.
			srcAttr: 'imgsrc',
		    imgCSS: {
		        // Limit preview size:
		        height: 100
		    },
		    // When container is shown:
		    onShow: function(link)
			{
				var dimensions = $(link).attr('dimensions');
		        $('<span>' + $(link).text() + '<br/>' + dimensions + '</span>').appendTo(this);
		    },
		    // When container hides: 
		    onHide: function(link){
		        $('span', this).remove();
		    }
		});
	}catch(e) {
		// ignore errors, here were no anchors I guess.
	}
}
function loadDirectoryListing(hideForms){
	if (hideForms) {
		hideAllForms();
	}
/*	$('#mainContent').html('<img src="cffmIcons/spin1.gif" hspace="50" vspace="50" alt="Loading Directory Listing...">'); */
	$('#mainContent').block({message:'<span style="font-size:15px;">One moment please... Refreshing directory.</span>',fadeIn:0,fadeOut:0});
	var url = cffmFilename + '?action=showDirectoryListing&subdir='+escape(subdir);
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$('#mainContent').load(url,null,setupImagePreview);
	$.unblockUI();
	return false;
}
function deleteIt(filetype, file) 
{
	if(confirm('Are you sure you want to delete this '+filetype + '?\n\n' + escape(file)))
	{
		var url = cffmFilename + '?action=delete&subdir='+escape(subdir);
		url += '&deleteFilename='+escape(file);
		url += '&ts='+getEpochTime();
		url += editorDetailsToUrl();
		$.getJSON(url, null, rh_deleteIt);
	}
}
function rh_deleteIt(data)
{
	if(data.ERRORMESSAGE!='') {
		alert(data.ERRORMESSAGE);
	} else {
		loadDirectoryListing(true);
	}
}

function rh_createNew(data, textstatus)
{
	if(data.ERRORMESSAGE!='') 
	{
		alert(data.ERRORMESSAGE);
		if (document.getElementById('fsCreateFileForm').style.display=='block') 
		{
			document.getElementById('newFilename').style.border='1px solid red';
			document.getElementById('newFilename').focus();
			document.getElementById('newFilename').select();
		} else if (document.getElementById('fsCreateDirectoryForm').style.display=='block') 
		{
			document.getElementById('newDirectoryName').style.border='1px solid red';
			document.getElementById('newDirectoryName').focus();
			document.getElementById('newDirectoryName').select();
		}
	} else {
		loadDirectoryListing(true);
		hideAllForms();
	}
}
function createFile(frm) 
{
	var url = cffmFilename + '?action=create&createNewFileType=file&subdir='+escape(subdir);

	var tmp = frm.newFilename.value;	
	if (tmp!= '' && tmp != null) {
		url += '&createNewFilename=' + escape(tmp);
		if (frm.createFileOverwrite.checked) {
			url += '&overwrite=true';
		} else {
			url += '&overwrite=false';
		}
		url += '&ts='+getEpochTime();
		url += editorDetailsToUrl();
		$.getJSON(url,null,rh_createNew);
	} else {
		document.getElementById('newFilename').style.border='1px solid red';
	}
	return false;
}
function createDirectory(frm)
{
	var url = cffmFilename + '?action=create&createNewFileType=directory&subdir='+escape(subdir);
	var tmp = frm.newDirectoryName.value;	
	if (tmp!= '' && tmp != null) {
		url += '&createNewFilename=' + escape(tmp);
		url += '&ts='+getEpochTime();
		url += editorDetailsToUrl();
		$.getJSON(url,null,rh_createNew);
	} else {
		document.getElementById('newDirectoryName').style.border='1px solid red';
	}
	return false;
}
function changeDirectory(dir)
{
	subdir = dir;
	var newWebPath = includeDirWeb;
	if (includeDirWeb == '/') {
		newWebPath += subdir;
	} else {
		newWebPath += '/'+subdir;
	}
	if (newWebPath.length > 1) {
		newWebPath = newWebPath.replace(/\/$/,"");
	}
	$('#currentSubdir').html(newWebPath);
	loadDirectoryListing(true);
}
function showRenameForm(filename)
{
	hideAllForms();
	document.getElementById('renameOldFilename').value = filename;
	document.getElementById('renameNewFilename').value = filename;
	document.getElementById('fsRenameForm').style.display='block';
	document.getElementById('renameNewFilename').focus();
	
}

function hideRenameForm()
{
	document.getElementById('renameOldFilename').value = '';
	document.getElementById('renameNewFilename').value = '';
	hideAllForms();
}

function showUploadForm()
{
	hideAllForms();
	createUploader();
	document.getElementById('fsUploadForm').style.display='block';
}
function hideUploadForm()
{
	$('#fileuploader').html('');
	hideAllForms();
}
function hideAllForms() {
	document.getElementById('fsRenameForm').style.display='none';
	document.getElementById('fsUploadForm').style.display='none';
	document.getElementById('fsCopyMoveForm').style.display='none';
	$('#copyMoveFormContents').html('');
	document.getElementById('fsCreateFileForm').style.display='none';
	document.getElementById('newFilename').value = '';
	document.getElementById('fsCreateDirectoryForm').style.display='none';
	document.getElementById('newDirectoryName').value = '';
	document.getElementById('newDirectoryName').style.border='1px solid #999999';
	document.getElementById('newFilename').style.border='1px solid #999999';

}
function rename(renameOldFilename,renameNewFilename,renameOverwrite) 
{
	var url = cffmFilename + '?action=rename&subdir='+escape(subdir);
	url += '&renameNewFilename=' + escape(renameNewFilename);
	url += '&renameOldFilename=' + escape(renameOldFilename);
	if (renameOverwrite) {
		url += '&overwriteExisting=true';
	}
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$.getJSON(url,null,rh_rename);
	return false;
	
}
function rh_rename(data, textstatus)
{
	if(data.ERRORMESSAGE!='') {
		alert(data.ERRORMESSAGE);
	} else {
		loadDirectoryListing(true);
		hideAllForms();
	}
}

function showCopyMoveForm(filename)
{
	hideAllForms();
	var url = cffmFilename + '?action=copymoveForm&subdir='+escape(subdir);
	url += '&editFilename=' + escape(filename);
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$('#copyMoveFormContents').load(url);
	document.getElementById('fsCopyMoveForm').style.display='block';
	return false;
}
function copymove(frm) {
	try
	{
		var url = cffmFilename + '?subdir='+escape(subdir);
		if (frm.action[0].checked) {
			url += '&action=move';
		} else {
			url += '&action=copy';
		}
		if (frm.overwrite.checked) {
			url += '&overwrite=true';
		} else {
			url += '&overwrite=false';
		}
		url += '&moveToSubdir='+frm.moveToSubdir[frm.moveToSubdir.selectedIndex].value;
		url += '&moveFilename='+escape(frm.moveFilename.value);
		url += '&ts='+getEpochTime();
		url += editorDetailsToUrl();
		$.getJSON(url,null,rh_copymove);
		return false;
	}catch(err){
		alert(err);
		return false;
	}
}
function rh_copymove(data, textstatus)
{
	if(data.ERRORMESSAGE!='') {
		alert(data.ERRORMESSAGE);
	} else {
		loadDirectoryListing(true);
		hideAllForms();
	}
}


function showUnzipForm(editFilename)
{
	var url = cffmFilename + '?subdir='+escape(subdir);
	url += '&action=viewzip';
	url += '&editFilename='+escape(editFilename);
	hideAllForms();
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$('#mainContent').load(url,null,rh_showUnzipForm);
}
function rh_showUnzipForm(data, textstatus)
{
	
}

function unzip(frm) {
	try
	{
		var url = cffmFilename + '?subdir='+escape(subdir);
		url += '&action=unzip';
		url += '&unzipToSubdir='+frm.unzipToSubdir[frm.unzipToSubdir.selectedIndex].value;
		url += '&unzipFilename='+escape(frm.unzipFilename.value);
		url += '&ts='+getEpochTime();
		url += editorDetailsToUrl();
		$.getJSON(url,null,rh_unzip);
		return false;
	}catch(err){
		alert(err);
		return false;
	}
}
function rh_unzip(data, textstatus)
{
	if(data.ERRORMESSAGE!='') {
		alert(data.ERRORMESSAGE);
	} else {
		subdir = data.NEWSUBDIR;
		hideAllForms();
		loadDirectoryListing(true);
	}
}

function showManipulateForm(editFilename)
{
	var url = cffmFilename + '?subdir='+escape(subdir);
	url += '&action=isEditableImage';
	url += '&editFilename='+escape(editFilename);
	hideAllForms();
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$.getJSON(url,null,rh_showManipulateForm);
}
function rh_showManipulateForm(data, textstatus)
{
	if(data.ERRORMESSAGE!='') {
		alert(data.ERRORMESSAGE);
	} else {
		showManipulateForm2(data.EDITFILENAME)
	}
}

function showManipulateForm2(editFilename)
{
	var url = cffmFilename + '?subdir='+escape(subdir);
	url += '&action=manipulateForm';
	url += '&editFilename='+escape(editFilename);
	hideAllForms();
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$('#mainContent').load(url,null,rh_showManipulateForm2);
}
function rh_showManipulateForm2(data, textstatus)
{
	refreshPreview();
}

function commitChanges(action) {
	var url = cffmFilename + '?editFilename='+editFilename+'&subdir='+escape(subdir);
	url += '&action='+action;
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$.getJSON(url,null,rh_commitResult);
}
function rh_commitResult(data) {
	if (data.ERRORMESSAGE != '') {
		alert(data.ERRORMESSAGE);
	} else {
		alert(data.RESULTMESSAGE);
		hideAllForms();
		loadDirectoryListing(true);
	}
}

function rotate(degrees)
{
	var url = cffmFilename + '?editFilename='+editFilename+'&subdir='+escape(subdir);
	if (degrees == 'flipVertical') {
		url += '&action=flip';
	} else if (degrees == 'flipHorizontal' ) {
		url += '&action=flop';
	} else {
		url += '&action=rotate';
		url += '&rotateDegrees='+degrees;
	}
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$.getJSON(url,null,rh_manipulate);
}
function rh_manipulate(data) {
	if (data.ERRORMESSAGE != '') {
		alert(data.ERRORMESSAGE);
	} else {
		refreshPreview();
	}
}
function resize(action,frm) 
{
	var url = cffmFilename + '?editFilename='+editFilename+'&subdir='+escape(subdir);
	url += '&action=resize';
	url += '&resizeHeightValue=' + frm.resizeHeightValue.value;
	url += '&resizeWidthValue=' + frm.resizeWidthValue.value;
	if (action == 'resize') {
		if (frm.preserveAspect.checked) {
			url += '&preserveAspect=1';
			if (frm.cropToExact.checked) {
				url += '&cropToExact=1';
			} else {
				url += '&cropToExact=0';
			}
		} else {
			url += '&preserveAspect=0';
			url += '&cropToExact=0';
		}
	}
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$.getJSON(url,null,rh_manipulate);
	return false;
}
function crop(frm) 
{
	var url = cffmFilename + '?editFilename='+editFilename+'&subdir='+escape(subdir);
	url += '&action=crop';
	url += '&cropHeightValue=' + frm.cropHeightValue.value;
	url += '&cropWidthValue=' + frm.cropWidthValue.value;
	url += '&cropStartX=' + frm.cropStartX.value;
	url += '&cropStartY=' + frm.cropStartY.value;
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$.getJSON(url,null,rh_manipulate);
	return false;
}
function refreshPreview()
{
	url = cffmFilename + '?action=showImagePreview&subdir='+escape(subdir)+'&editFilename='+editFilename;
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$("#image_preview").load(url);
}
function getEpochTime() {
	var a = new Date();
	return a.getTime();
}




function showCreateFileForm()
{
	hideAllForms();
	document.getElementById('fsCreateFileForm').style.display='block';
	document.getElementById('newFilename').focus();
}
function showCreateDirectoryForm()
{
	hideAllForms();
	document.getElementById('fsCreateDirectoryForm').style.display='block';
	document.getElementById('newDirectoryName').focus();
}

function editFile(filename) 
{
	var url = cffmFilename + '?action=edit';
	url += '&subdir=' + escape(subdir);
	url += '&editFilename=' + escape(filename);
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$('#mainContent').load(url);
}
function viewSource(filename) 
{
	var url = cffmFilename + '?action=viewSource';
	url += '&subdir=' + escape(subdir);
	url += '&editFilename=' + escape(filename);
	url += '&ts='+getEpochTime();
	url += editorDetailsToUrl();
	$('#mainContent').load(url);
}
function saveTextFile()
{
	var url = cffmFilename;
	url += '?ts='+getEpochTime();
	url += editorDetailsToUrl();
	var params = new Object();
	params.subdir = subdir;
	params.action = 'save';
	params.editFilename = document.getElementById('frmEditFile').editFilename.value;
	params.editFileContent = document.getElementById('frmEditFile').editFileContent.value;
	datastring = $.param(params);
	$.post(	url, datastring, rh_SaveTextFile, 'json' );
	return false;
}
function rh_SaveTextFile(data)
{
	if(data.ERRORMESSAGE!='') {
		alert(data.ERRORMESSAGE);
	} else {
		loadDirectoryListing(true);
		alert('The file was saved.');
	}
}
function editorDetailsToUrl()
{
	var ret = '&EDITOR_RESOURCE_TYPE='+editorResourceType;
	ret += '&editorType=' + editorType;
	return ret;
}

function createUploader()
{
	var uploader = new qq.FileUploader({
		element: document.getElementById('fileuploader'),
		action: 'cffm.cfm',
		// this js variable is defined in cffm.cfm
		multiple: allowMultiple,
		// this js variable is defined in cffm.cfm
		sizeLimit: maxUploadSize,
		/// additional data to send, name-value pairs
		params: {
			action: 'upload', 
			// this js variable is defined in cffm.cfm
			subdir: subdir
		},
		// this js variable is defined in cffm.cfm
		allowedExtensions: allowedExtensions,
		// these JS variables are defined in cffm.cfm
        messages: {
            typeError: fileUploader_typeError,
            sizeError: fileUploader_sizeError,
            minSizeError: fileUploader_minSizeError,
            emptyError: fileUploader_emptyError,
            onLeave: fileUploader_onLeave
        },
		onComplete: function(id, fileName, responseJSON)
		{
			if (! responseJSON.success) {
				if (isNaN(id)) {
					id = id.replace(/\D/g,'');
				}
				$('.qq-upload-list li').eq(id).append('<span class="uploaderrormessage"> '+responseJSON.error+'</span>');
			} else {
				loadDirectoryListing(false);
			}
		},
		showMessage: function(msg) {
			alert(msg);
		}
	});
}

function addContextMenu() 
{
    $('a.addContextMenu').contextMenu({
        menu: 'myMenu'
    },
        function(action, el, pos) {
		if (action == 'download') 
		{
			var url = cffmFilename + '?action=download&subdir='+escape(subdir);
			url += '&downloadfilename='+escape($(el).html());
			alert(url);
			window.location.href = url;
		} else if (action == 'delete') {
			deleteIt( $(el).attr('filetypedesc'), $(el).html() );
		} else if (action == 'rename') {
			showRenameForm( $(el).html() );
		} else if (action == 'copymove') {
			showCopyMoveForm( $(el).html() );
		} else if (action == 'editfile') {
			editFile( $(el).html() );
		} else if (action == 'viewsource') {
			viewSource( $(el).html() );
		} else if (action == 'unzip') {
			showUnzipForm( $(el).html() );
		} else if (action == 'editimage') {
			showManipulateForm( $(el).html() );
		} else {
			alert('Action not handled: '+action);
		}
    },
		function(menu, srcElement) {
			menu.disableContextMenuItems();
			var classes = srcElement.attr('class');
			var classes2 = classes.split(' ');
			var actions = 'download,delete,rename,copymove,editimage,unzip,editfile,viewsource';
			var arrActions = actions.split(',');
			for (var clazz in classes2) {
				for (var action in arrActions) {
					if ( classes2[clazz] == 'cffm-menu-'+arrActions[action] ) {
						menu.enableContextMenuItems('#'+arrActions[action]);
					}
				}
			}
		}
	
	);

}
