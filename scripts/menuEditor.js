var menuPosition = 0; 
 
$('#cmsForm').live('submit', function() {
	var options = { 
		 success:    function(response) { 
	var myTitle = $('#cmsForm #title').val().replace(' ', '_');
		$('#menuCMS').append('<option value="/'+$('#cmsForm #title').val()+'.cfm">'+ myTitle+'.cfm :: /'+$('#cmsForm #title').val()+'</option>');
	}};

	$(this).ajaxSubmit(options);
	return false; 
});
		
$('a#addLI').live( 'click', function(ev) {
    var liCount = $('#ul1 li').length;
    liCount++;
	var li = document.createElement('LI');
	li.id = 'li1_'+liCount;
	li.className = 'listMenu';
	li.innerHTML = 'New Item';
	$('#ul1').append(li);
	$('#li1_'+liCount).addClass('ui-state-default');
	$('#li1_'+liCount).addClass('pad2');
	$('#li1_'+liCount).addClass('bold');
	menuData[liCount-1] = new Object();
	menuData[liCount-1].sortorder = liCount;
	menuData[liCount-1].newwindow = 0;
	menuData[liCount-1].title = 'New Item';
	menuData[liCount-1].url = '';
	menuData[liCount-1].visibleto = 0;	
	menuData[liCount-1].visibletoprofiletype = 0;				
	menuData[liCount-1].type = 0;				
	menuData[liCount-1].feature = 0;
	menuData[liCount-1].cms = 0;
	return false;							 
});

 $('input#delLI').live( 'click', function(ev) {
    // Remove Item
	var liCount = $('#ul1 li').length;
	thisPos = menuPosition + 1;
	$('#li1_' + thisPos).remove();
	delete menuData[menuPosition];
	
});

function saveMenu(){
	$('#menuJSON').val($.toJSON(menuData));
	$('#menuOrder').val(parseList());
}

function parseList(){
	var out = '';
  $("#ul1 li").each(function(){
                out += $(this).attr('id').split("_")[1] + " ";
	 });
  
  return out;
}

$('#ul1 li').live('click', function(ev) {  
	var tar = ev.target;  
	$('#menuTitle').val($(tar).html());
	tmp_pos = tar.id.split('_');
	menuPosition = tmp_pos[1] - 1; 
	menuSortOrder = menuData[menuPosition].sortorder;
	menuNewWindow = menuData[menuPosition].newwindow;
	menuTitle = menuData[menuPosition].title;
	menuURL = menuData[menuPosition].url;
	menuVisibleTo = menuData[menuPosition].visibleto;
	menuVisibleToProfileType = menuData[menuPosition].visibletoprofiletype;
	menuType = menuData[menuPosition].type;
	menuFeature = menuData[menuPosition].feature;
	menuCMS = menuData[menuPosition].cms;	
	setCheckedValue(document.forms['menu'].elements['menuType'], menuType);

	if (menuType == '0'){ 
		$('#menuCMS').val(menuCMS);
	} else if(menuType == '1'){
		$('#menuURL').val(menuURL);
	} else if(menuType == '2'){
		$('#menuFeature').val(menuFeature);
	}

	if(menuNewWindow == 1){
		document.getElementById('menuNewWindow').checked = true;
	} else {
		document.getElementById('menuNewWindow').checked = false;		
	}
	changeMenuValue(menuVisibleTo, menuVisibleToProfileType);
});

function setCheckedValue(radioObj, newValue) {
 if(!radioObj)
 return;
 var radioLength = radioObj.length;
 if(radioLength == undefined) {
 radioObj.checked = (radioObj.value == newValue.toString());
 return;
 }
 for(var i = 0; i < radioLength; i++) {
 radioObj[i].checked = false;
 if(radioObj[i].value == newValue.toString()) {
 radioObj[i].checked = true;
 }
 }
}

function changeMenuValue(value, profileType){
	for (var i=0; i < document.forms['menu'].menuVisible.length; i++) {
		if (document.forms['menu'].menuVisible[i].value == value) {
			document.forms['menu'].menuVisible[i].selected = true;
		}
	}
	
	for (var i=0; i < document.forms['menu'].menuVisibleProfileType.length; i++) {
		if (document.forms['menu'].menuVisibleProfileType[i].value == profileType) {
			document.forms['menu'].menuVisibleProfileType[i].selected = true;
		}
	}
}

function updateJSON(){
	menuData[menuPosition].title = $('#menuTitle').val();
	menuData[menuPosition].url = $('#menuURL').val();
	menuData[menuPosition].visibleto = $('#menuVisible').val();
	menuData[menuPosition].visibletoprofiletype = $('#menuVisibleProfileType').val();
	
	if($('input#menuNewWindow').is(':checked') == true){
		menuData[menuPosition].newwindow = 1;
	} else {
		menuData[menuPosition].newwindow = 0;
	}
	//window.alert(menuData[menuPosition].newwindow);
	
	for (var i=0; i < document.menu.menuType.length; i++){
	   if (document.menu.menuType[i].checked){
	  		menuData[menuPosition].type  = document.menu.menuType[i].value;		
		}
     }

	menuData[menuPosition].feature = $('#menuFeature').val();
	menuData[menuPosition].cms = $('#menuCMS').val();
}


$('.tTip').betterTooltip({speed: 150, delay: 100});
$("#ul1").sortable({stop: function(){saveMenu();}});
$("#ul1").disableSelection();
