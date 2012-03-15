var moduleData = new Object();
var moduleID = '';
var editPage = 0;

function showEditClose(){
	$("div.mod div.hd div.toolbar").show();
	$("div.mod div.hd .move").css('cursor', 'move');
}

function closeEdit(){ 	window.location.reload(); }

function saveModulePosition (){ 
	$(".list").each(function(){
		thisListData=$(this).sortable('toArray');
		moduleData[$(this).attr('id')] = thisListData;
    }); 

	postData = $.toJSON(moduleData);
	$.post('/index.cfm/cms/modules/save', { 	data: postData,	page: thisPage });
}

function doAddModule(moduleID,page){
	$.ajax({
	url: '/index.cfm/cms/modules/add/moduleID/'+moduleID+'/page/'+page+ "/r/"+Math.random(), 
	dataType: 'text',
	success: function(data){
			var moduleContent =$.ajax({
				url: '/index.cfm/cms/modules/load/moduleSettingID/'+data+ "/r/"+Math.random(),
				dataType: 'text',
				success: function(data){
					$('ul#list1.list').append(data);
					showEditClose();
					$.jGrowl('Module has been added');
				}
			});
		}
	});
}

function doAddMyModule(moduleSettingID,page){
	var moduleContent =	$.ajax({
		url: '/index.cfm/cms/modules/addMyModule/moduleSettingID/'+moduleSettingID+'/page/'+page+ "/r/"+Math.random(), 
		dataType: 'text',
		success: function(data){
				var moduleContent =$.ajax({
					url: '/index.cfm/cms/modules/load/moduleSettingID/'+moduleSettingID+ "/r/"+Math.random(),
					dataType: 'text',
					success: function(data){
						$('ul#list1.list').append(data);
						showEditClose();
						$.jGrowl('Module has been added');
					}
				});
			}
		});
	
}


$(document).ready(function($) {	
	
	$(".adminCMSPage").modalAjax({
			url: '/index.cfm/cms/page/admin?r='+Math.random(),
			title: 'Admin CMS Pages',
			width: 700,
			initAjaxForm: true,
			ajaxFormSuccess: function(data){
				location.href=data;
			}
	});
	
	$("#addModule").modalAjax({
		url: '/index.cfm/cms/modules/index/page/'+thisPage +'/type/'+contentType+ "/r/"+Math.random(),
		title: 'Add Module',
		width: 750,
		initTabs: true
	});

	$('#siteDesigner').modalAjax({
		url: '/index.cfm/cms/style/index/page/'+thisPage +'/dbTable/style/type/advanced/r/'+Math.random(),
		title: 'Site Designer',
		width: 650,
		initTabs: true
	});
		
	$('#pageSettings').modalAjax({
		url: '/index.cfm/cms/settings/index/page/'+thisPage+'/contentType/'+contentType + "?r="+Math.random(),
		title: 'Page Settings',
		width: 500,
		destroyFunction: showEditClose,
		initAjaxForm: true,
		ajaxFormClose: true
	});
	
	$("#pageMeta").modalAjax({
		url: '/index.cfm/cms/page/form/page/'+thisPage,
		title: 'Edit Page Meta Data',
		width: 550,
		initAjaxForm: true,
		ajaxFormClose: true
	});
	
	
	$("#pageLayout").modalAjax({
		url: '/index.cfm/cms/layout/index/page/'+thisPage + "/r/"+Math.random(),
		title: 'Edit Page Layout',
		width: 300
	});
	
	$("div.mod div.hd div a.edit").modalAjax({
		url: '/index.cfm/cms/modules/edit/editfile/!rel!/id/!alt!/r/'+Math.random(),
		title: 'Edit Page Layout',
		width: 730,
		initTabs: true, 
		initAjaxForm: true, 
		initCKEditor: true,
	    ajaxFormTarget: 'li#module!alt!',
	    ajaxFormSuccess: function(){
			$.jGrowl('Module updated successfully');
		},
		ajaxFormClose: true
	});
	
	$('#menuEditor').modalAjax({
		url: '/index.cfm/cms/menu/index/r'+Math.random(),
		title: 'Menu Editor',
		width: 700
	});

	$('#templateSelector').modalAjax({
		url: '/index.cfm/cms/template/index/r'+Math.random(),
		title: 'Change Template',
		width: 500
	});
	
	$("#editPage").click(function(){
		
		if (editPage == 0){
			$(".list").sortable({
				connectWith: '.list',
				handle: '.draggable .hd .move',
				placeholder: 'ui-sortable-placeholder',
				stop: function(){	saveModulePosition();	}
			});
			
			showEditClose();
				
			$("ul.list").css({	border: '1px dotted gray',	minHeight: '20px',	margin: '5px',	backgroundColor: '#EEEEEE' });			
			$.jGrowl("Welcome to Edit Mode.  <BR><BR><a href='#' id='pageMeta' class='blackText'>Edit Page Meta Data</a><BR><a href='#' id='pageLayout' class='blackText'>Edit Page Layout</a><BR><a href='#' id='pageSettings' class='blackText'>Edit Page Settings</a><BR><a href='#' id='addModule' class='blackText'>Add Modules</a><BR><a href='#' class='adminCMSPage blackText'>Manage Pages</a><BR><BR> You can drag and drop modules to the silver target areas to change their positioning.<BR><BR>Clicking <img src='/images/wrench.png'> will bring up the edit dialog for a given module.  <BR><BR>Clicking <img src='/images/cancel.png'> will delete a module.  <BR><BR><input type='button' onclick='closeEdit();' value='Exit Edit Mode'>", 
						{sticky: true, 
						closer: false,
						close: function(){
							editPage = 0;
						}
			});
			editPage = 1;
		}
	});
	
	$("div.mod div.hd div a.close").live('click',function() {
		if (confirm('Are you sure you want to delete this module? Your module will remain in the "My Modules" list if you need it again.')){
			module = $(this).parent().parent().parent().parent();
			module.fadeOut('slow', function(){	module.remove(); saveModulePosition();		 });
		}			
	});

	
});