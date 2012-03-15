/* Utility */
function HTMLEditFormat(val){
	var s = String(val);
	return s.replace(/\"/g,"&quot;");
}

function backgroundFade( bOn )
{
	if( bOn ){
		var arrayPageSize = getPageSize();
		$('overlay').style.height = (arrayPageSize[1]+1000) + "px";
		$('overlay').style.display = "block";
	}
	else $('overlay').style.display = "none";
}

function updateForm( val, fieldName )
{
	switch( fieldName )
	{
	
		case 'description':
			$('formDescription').innerHTML = val.replace(/\n/g, "<br/>");
			break;
		//Next are form items that don't visually effect the preview
		case 'confirmationOpt':
		case 'confirmMsg':
		case 'redirectURL':
		case 'submitbuttontext':
		case 'formEmailVal':
		case 'formEmailVal':
			break;
		case 'formCopyEmailCheckbox':
			if( val ) $("formCopyEmailCheckboxDiv").removeClassName('hide');
			else $("formCopyEmailCheckboxDiv").addClassName('hide');
			break;
		case 'formReceiptCheckbox':
			if( val ) $("formReceiptEmailDiv").removeClassName('hide');
			else $("formReceiptEmailDiv").addClassName('hide');
			break;			
		default:
			alert( "No handler for '" + fieldName + "'" );
	}
}
function updateProps( val, fieldName )
{
	switch( fieldName )
	{
		case 'fieldtype':
			//go through all the defaults and apply them if they are not set already
			var defaults = interfaces[ val ].defaults;
			var keys = Object.keys( defaults );
			keys.each(function(key){
				if( formItems[ currSelElm.id ][ key ] == null ) formItems[ currSelElm.id ][ key ] = defaults[ key ];
			});
			var oldFieldType = formItems[ currSelElm.id ][ fieldName ];
			formItems[ currSelElm.id ][ fieldName ] = val;
			loadCurrentFieldSettings();
			updateCurrentFieldPreview();
			
			//if the field is no longer suitable for conditional logic, then we need to remove any cl references to it
			if( ( oldFieldType == "dropdown" || oldFieldType == "multipleChoice" ) && ( val != "dropdown" && val == "multipleChoice" ) ){
				//loop through all fields
				for( id in formItems )
				{
					if( id == currSelElm.id ) continue;
					if( formItems[id][ "conditionallogic" ] && formItems[id][ "conditionallogic" ].checks ){
						var checks = formItems[id][ "conditionallogic" ].checks;
						for( var i=checks.length-1;i>=0;i--) if( checks.field == currSelElm.id ) checks.splice(i,0);
						if( checks.length == 0 ) formItems[id][ "conditionallogic" ] = null;

					}
				}
			}
			
			break;
		case 'title':
			updateEmailFieldList();
		case 'size':
		case 'isrequired':
		case 'isunique':
		case 'isprivate':
		case 'defaultval':
		case 'instructions':
			formItems[ currSelElm.id ][ fieldName ] = val;
			updateCurrentFieldPreview();
			break;
		default:
			formItems[ currSelElm.id ][ fieldName ] = val;
			//alert( "No handler for '" + fieldName + "'" );
			updateCurrentFieldPreview();
	}
}
function loadCurrentFieldSettings()
{
	var o = formItems[ currSelElm.id ];
	
	//update the field tab with the default options
	$("fieldTitle").value =  o.title;
	$("fieldSize").value =  o.size;
	$("fieldtype").value =  o.fieldtype;
	$("fieldRequired").checked =  (o.isrequired?true:false);
	((o.isprivate == "1")? $("fieldPrivate") : $("fieldPublic") ).checked = true;
	$("fieldInstructions").value =  (( o.instructions != null )?o.instructions:"");
	$("fieldDefault").value =  (( o.defaultval != null )?o.defaultval:"");
	
	//Fields extra options - defaults
	if( interfaces[ o.fieldtype ].options == null ) interfaces[ o.fieldtype ].options = {};
	if( interfaces[ o.fieldtype ].options.showDefault == null ) interfaces[ o.fieldtype ].options.showDefault = 1;
	if( interfaces[ o.fieldtype ].options.showFieldSize == null ) interfaces[ o.fieldtype ].options.showFieldSize = 1;
	if( interfaces[ o.fieldtype ].options.showInstructions == null ) interfaces[ o.fieldtype ].options.showInstructions = 1;
	if( interfaces[ o.fieldtype ].options.showFieldUnique == null ) interfaces[ o.fieldtype ].options.showFieldUnique = 1;
	
	//Execute Field Options
	$("listTextDefault").style.display = (interfaces[ o.fieldtype ].options.showDefault?"block":"none");
	$("listFieldSize").style.display = (interfaces[ o.fieldtype ].options.showFieldSize?"block":"none");
	$("listInstructions").style.display = (interfaces[ o.fieldtype ].options.showInstructions?"block":"none");
	$("fieldUniqueOpt").style.display = (interfaces[ o.fieldtype ].options.showUnique?"block":"none");
	
	//Remove any left over extra fields
	$$('.extra').invoke('remove');
	
	//Conditional Logic
	updateConditionalLogicDisplay();
	
	//Add any Extra Edit Options
	if( interfaces[ o.fieldtype ].extraOptions )
	{
		var extraOptsHTML = interfaces[ o.fieldtype ].extraOptions(o);
	}
	
	$("fieldTitle").select();
}
function editItem(e)
{
	//We must force the blur to execute before changing to another element
  	form = $("fieldProps");
    var elements = Form.getElements(form);
    for (var i = 0; i < elements.length; i++) elements[i].blur();
  
	//var elm = Event.element(e);
	var elm = Event.findElement(e, 'LI');
	selectElm( elm );
	
	loadCurrentFieldSettings();
	
	//Turn off the "No Fields Selected" message and turn on the properties list
	$("nofieldSel").style.display = "none";
	$("fieldProps").style.display = "block";
	
	//switch to the field tab
	formWizTabs.setSelectedIndex(1);
}

function showFields()
{
	formWizTabs.setSelectedIndex(0);
	new Effect.Highlight('formWizAddField', {startcolor:'#FFF6BF', endcolor:'#ffffff',restorecolor:true})
}

function alertMsg( msgTitle, msg, msgtype )
{
	$("alertMessageH3").innerHTML = msgTitle;
	$("alertMessageTxt").innerHTML = msg;
	
	backgroundFade( true );
	
	var iebody=(document.compatMode && document.compatMode != "BackCompat")? document.documentElement : document.body;
	var scrollY = document.all? iebody.scrollTop : window.pageYOffset;
	$("alertMessage").style.top = (scrollY+25) + "px";
	Effect.Appear( "alertMessage" );
}
function closeAlertMessage()
{
	backgroundFade( false );
window.opener.location.href = window.opener.location.href;

	$( "alertMessage").style.display = "none";
window.close();
}

function showResponse(originalRequest, json)
{
	//put returned XML in the textarea
	if( json.SUCCESS )
	{
		alertMsg( json.MSGTITLE, json.MESSAGE, json.MSGTYPE )
	}
	else{
		alertMsg( json.MSGTITLE, json.MESSAGE, json.MSGTYPE )
	}
	//Turn off the save form
	$( "saveMessage").style.display = "none";
}
function continueSave()
{
	//Load form data from screen into formInfo structure
	
	formInfo.desc = $F("formDesc");
	formInfo.submitbuttontext = $F("formSubmitButtonText");
	formInfo.confirmationType = $("confirmationType_Message").checked ? "Show Text":"redirect";
	formInfo.confirmmsg = $F("confirmMsg");
	formInfo.redirecturl = $F("formRedirectVal");
	formInfo.includeonsubmit = $F("includeOnSubmit");
	if( $("formStyle") ) formInfo.formstyle = $F("formStyle");
	formInfo.fieldorder = getFieldOrder();
		
	//email notification options
	formInfo.formcopyemailcheckbox = $("formCopyEmailCheckbox").checked;
	formInfo.formcopyemailto = $("formCopyEmailTo").value;
	//checkboxes for email
	formInfo.formreceiptcheckbox = $("formReceiptCheckbox").checked;
	formInfo.formreceiptemailto = $("formReceiptEmailTo").value;
	formInfo.formreceiptemailreplyto = $("formReceiptEmailReplyTo").value;
	formInfo.formreceiptemailmsg = $("formReceiptEmailMsg").value;
	
	
	var formData = {};
	formData.formInfo = formInfo;
	formData.formItems = formItems;
	wddxSerializer = new WddxSerializer();
    wddxPacket = wddxSerializer.serialize( formData );
	
	var pars = 'instanceId=' + instanceId + '&wddxPacket=' + escape( wddxPacket );
	
	var url = PluginPageLoaderURL + "?cmsfile=../../actions/act_save.cfm&instanceId="+instanceId;
	
	try {
		if( typeof(ref) ) url += ("&ref=" + ref);
	} catch(e) {
	}
	
	var myAjax = new Ajax.Request(
		url, 
		{
			method: 'post', 
			parameters: pars, 
			onComplete: showResponse
		});
}
function saveForm()
{
	backgroundFade( true );
	var iebody=(document.compatMode && document.compatMode != "BackCompat")? document.documentElement : document.body;
	var scrollY = document.all? iebody.scrollTop : window.pageYOffset;
	$("saveMessage").style.top = (scrollY+25) + "px";
	Effect.Appear( "saveMessage" );
	continueSave();
}

var currSelElm = null;

function showOrHideSelectedLIOptions( bShow )
{
	//position the copy/remove buttons
	if( !bShow )
	{
		Effect.Fade( "addDeleteButtons" );
		Effect.Appear( "editArrow" );
		
		//Turn on the "No Fields Selected" message and turn off the properties list
		$("nofieldSel").style.display = "block";
		$("fieldProps").style.display = "none";
	}
	else
	{
		Effect.Appear( "editArrow" );
		//position the arrow
		xy = Position.cumulativeOffset(currSelElm);
		x = xy[0];
		y = xy[1];
		$("editArrow").style.top = (y+5)+"px";
		//Display the "duplicate/Delete" Buttons
		wh = currSelElm.getDimensions();
		x = ( x + wh.width ) - 40;
		y = ( y + wh.height ) - 10;
		$("addDeleteButtons").style.left = x+"px";
		$("addDeleteButtons").style.top = y+"px";
		Effect.Appear( "addDeleteButtons" );
		
		//add padding to the top of fieldProps form to push the form down
		y = xy[1] - 60;
		if( y < 0 ) y = 0;
		$("fieldProps").style.paddingTop = y + "px";
		
		//Update the number
		var LIs = $A( $("formFields").getElementsByTagName('li')).map(Element.extend);
		for( var i=0;i<LIs.length;i++ )
		{
			if( LIs[i] == currSelElm ) break;
		}
		$("fieldPos").innerHTML = (i+1) + ".";
		
		//Turn off the "No Fields Selected" message and turn on the properties list
		$("nofieldSel").style.display = "none";
		$("fieldProps").style.display = "block";
	
	}
}

function selectElm( elm )
{
	if( currSelElm != null && currSelElm != elm ) currSelElm.removeClassName('selected');
	currSelElm = elm;
	elm.addClassName('selected');

	//position the copy/remove buttons
	if( elm.tagName.toLowerCase() != "li" ) showOrHideSelectedLIOptions( false );
	else showOrHideSelectedLIOptions( true );
}

function onClickFormIntro()
{
	selectElm( $('formIntro') );
	//switch to the form tab
	formWizTabs.setSelectedIndex(2);
}

var addedFieldCounter = 0;

function getUniqueIdForField()
{
	var z = new UUID().toString();
	return z.replace(/-/g, '').toLowerCase();
}

function updateFieldPreview(id)
{
	var o = formItems[ id ];
	var html = "";
	
	if( o.fieldtype == "sectionBreak" ){
	
		html += "<div class=\"sectionBreak\">" + o.title + "</div>";
		if( o.instructions ) html += "<div class=\"instructions\">" + o.instructions.replace(/\n/g,"<br/>") + "</div>";

	}
	else{
		html = getLabel(o);
		if( o.instructions ) html += "<div class=\"instructions\">" + o.instructions.replace(/\n/g,"<br/>") + "</div>";
		html += "<div class=\"field\">"
		html += interfaces[ o.fieldtype ].preview( o );
		html += "</div>";
	}
	
	$( id ).innerHTML = html;
	
	if( o.isprivate == "1" ) $(id).addClassName("isprivate");
	else $(id).removeClassName("isprivate");

}

function updateCurrentFieldPreview()
{
	updateFieldPreview( currSelElm.id );
	showOrHideSelectedLIOptions( true );
}

function getLabel(o)
{
	var html = "";
	html += "<label>" + o.title;
	if( o.isrequired == "1" ) html += "<span class=\"req\">*</span>";
	html += "</label>";

	return html;
}

function getFieldOrder()
{
	var lis = $("formFields").getElementsBySelector("li");
	var newFieldOrder = [];
	for( var i=0;i<lis.length;i++ )
	{
		newFieldOrder.push( lis[i].id );
	}

	//remove any left over items from before
	for( id in formItems )
	{
		if( newFieldOrder.indexOf( id ) == -1 ) delete formItems[id];
	}
	
	return newFieldOrder;
}
function onFinishSort()
{
	formInfo.fieldorder = getFieldOrder();
}
function updateEmailFieldList()
{
	var emailList = [];
	var emailListNames = [];
	var count = 0;
	var o = $("formReceiptEmailTo");
	var selVal = o.value;
	o.options.length = 0;
	for( var id in formItems ){
		count++;
		if( formItems[id].fieldtype == "email" )
		{
			emailList.push( id );
			emailListNames.push( formItems[id].title );
			var x = new Option( "" + count+". "+" " + formItems[id].title, id );
			o.options[ o.options.length ] = x;
		}
	}
	o.value = selVal;
}
function addFieldToLIList( o, bInsertAtCurrentPos, id )
{
	//find a unique if to used for this form item
	if( id == null ) id = getUniqueIdForField();
	//store the data for this form Item
	formItems[id] = o;
	
	if( o.fieldtype == "email" )
	{
		updateEmailFieldList();
	}
	
	var html = "<li style='display:none' id='" + id + "'></li>";
	
	//Insert the new LI element either after the selected item or at the end
	if( bInsertAtCurrentPos && currSelElm )
	{
		new Insertion.After( currSelElm, html );
	}
	else{
		new Insertion.Bottom( 'formFields', html );
	}
	
	//Update the field
	updateFieldPreview( id );

	//Fade in the new LI Element	
	Effect.Appear( id );

	//Add the onclick handler
	Event.observe( id, 'click', editItem );
	
	//Make the list sortable
	Sortable.create('formFields',{ghosting:false,constraint:'vertical',onUpdate: onFinishSort })
}
function addField( fieldtype )
{
	if( interfaces[ fieldtype ] == null ) { alert("fieldtype '" + fieldtype + "' not found.");return;}

	//Turn off the "no fields defined" message
	$( "nofieldsMsg").style.display = "none";
	Effect.Appear("formButtons");

	//Get the defaults for this field
	var o = null;
	//if the interface exposes a createNew, then use it
	if( interfaces[ fieldtype ].createNew ) o = interfaces[ fieldtype ].createNew();
	else o = deepObjCopy( interfaces[ fieldtype ].defaults );
	if( o.title == null ) o.title = "Untitled";
	o.fieldtype = fieldtype;

	//Add the field to the visual list
	addFieldToLIList( o, false );
	
	//Turn off the "No Fields" message
	//$("nofieldsMsg").style.display = "none";
}
function deepObjCopy(dupeObj) {
	if( dupeObj == null ) return null;
    var retObj = new Object();
    if (typeof(dupeObj) == 'object') {
        if (typeof(dupeObj.length) != 'undefined')
            var retObj = new Array();
        for (var objInd in dupeObj) {   
            if (typeof(dupeObj[objInd]) == 'object') {
                retObj[objInd] = deepObjCopy(dupeObj[objInd]);
            } else if (typeof(dupeObj[objInd]) == 'string') {
                retObj[objInd] = dupeObj[objInd];
            } else if (typeof(dupeObj[objInd]) == 'number') {
                retObj[objInd] = dupeObj[objInd];
            } else if (typeof(dupeObj[objInd]) == 'boolean') {
                ((dupeObj[objInd] == true) ? retObj[objInd] = true : retObj[objInd] = false);
            }
        }
    }
    return retObj;
}
function duplicate()
{
	//create a copy of the current form Items attributes
	var o = null;
	//if the interface exposes a duplicate(), then use it
	var fieldtype = formItems[ currSelElm.id ].fieldtype;
	if( interfaces[ fieldtype ].duplicate ) o = interfaces[ fieldtype ].duplicate( formItems[ currSelElm.id ] );
	else o = deepObjCopy( formItems[ currSelElm.id ] );
	//Add the field to the visual list
	addFieldToLIList( o, true );
}
var elmsToDelete = [];
function deleteElms()
{
	elmsToDelete.each(function(elm){ try{ Element.remove( elm ); }catch(e){} });
}
function removeItem()
{
	//turn off the selected LI Options
	showOrHideSelectedLIOptions( false );
	Effect.Fade( currSelElm );
	elmsToDelete.push( currSelElm );
	setTimeout( "deleteElms()", 1000 );

	delete formItems[ currSelElm.id ];
	currSelElm = null;
	
	
	//Display the no fields message if there are none
	var numFormFields = ( Object.keys( formItems ).length );
	if( numFormFields == 0 ) Effect.Appear( "nofieldsMsg" );

	//mark this element as deleted
	updateEmailFieldList();
}


//
// getPageSize()
// Returns array with page width, height and window width, height
// Core code from - quirksmode.com
// Edit for Firefox by pHaez
//
function getPageSize(){
	
	var xScroll, yScroll;
	
	if (window.innerHeight && window.scrollMaxY) {	
		xScroll = window.innerWidth + window.scrollMaxX;
		yScroll = window.innerHeight + window.scrollMaxY;
	} else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
		xScroll = document.body.scrollWidth;
		yScroll = document.body.scrollHeight;
	} else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
		xScroll = document.body.offsetWidth;
		yScroll = document.body.offsetHeight;
	}
	
	var windowWidth, windowHeight;
	
//	console.log(self.innerWidth);
//	console.log(document.documentElement.clientWidth);

	if (self.innerHeight) {	// all except Explorer
		if(document.documentElement.clientWidth){
			windowWidth = document.documentElement.clientWidth; 
		} else {
			windowWidth = self.innerWidth;
		}
		windowHeight = self.innerHeight;
	} else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
		windowWidth = document.documentElement.clientWidth;
		windowHeight = document.documentElement.clientHeight;
	} else if (document.body) { // other Explorers
		windowWidth = document.body.clientWidth;
		windowHeight = document.body.clientHeight;
	}	
	
	// for small pages with total height less then height of the viewport
	if(yScroll < windowHeight){
		pageHeight = windowHeight;
	} else { 
		pageHeight = yScroll;
	}

	// for small pages with total width less then width of the viewport
	if(xScroll < windowWidth){	
		pageWidth = xScroll;		
	} else {
		pageWidth = windowWidth;
	}
	arrayPageSize = new Array(pageWidth,pageHeight,windowWidth,windowHeight) 
	
	return arrayPageSize;
}

function shortVersion(v,s){
	if( s == null ) s = 15;
	if( v.length <= s) return v;
	
	if( v.length*2 < s || s <= 5 ){
		v = v.substring( 0, s-2 ) + "..";
	}
	else{//split into 2 parts
		v = v.substring( 0, (s/2)-2 ) + ".. .." + v.substring( (v.length-1)-((s/2)-4), v.length );
	}
	return v;
}
function onChangeConditionLogic(opt,val){
	formItems[ currSelElm.id ][ "conditionallogic" ][opt] = val;
}
function onChangeConditionLogicCheck(i,field,val,action){
	if( formItems[ currSelElm.id ][ "conditionallogic" ].checks[i][field] != val ){
		formItems[ currSelElm.id ][ "conditionallogic" ].checks[i][field] = val;
		if( field == "field" )
		{
			updateConditionalLogicDisplay();
			if( action != "blur" ) $("conditionalLogic_"+field+i).focus();
		}
	}
}
function updateConditionalLogicDisplay(){
	var bConditionalLogicEnabled = ( formItems[ currSelElm.id ][ "conditionallogic" ] != null && formItems[ currSelElm.id ][ "conditionallogic" ].checks != null && formItems[ currSelElm.id ][ "conditionallogic" ].checks.length != null && formItems[ currSelElm.id ][ "conditionallogic" ].checks.length > 0 );
	if( !bConditionalLogicEnabled ){
		$("conditionalLogicBut").style.display="block";
		$("conditionalLogicDiv").style.display="none";
		formItems[ currSelElm.id ][ "conditionallogic" ] = null;
		return;
	}

	$("conditionalLogicShowOrHide").selectedIndex == (formItems[ currSelElm.id ][ "conditionallogic" ].action == "Show")?0:1;
	$("conditionalLogicShowOrHide").selectedIndex == (formItems[ currSelElm.id ][ "conditionallogic" ].bool == "AND")?0:1;

	//render the html to match the existing conditions
	var html = '<table cellpadding="0" cellspacing="5" id="conditionalLogicTable">';
	var checks = formItems[ currSelElm.id ][ "conditionallogic" ].checks;
	for( var i=0;i<checks.length;i++){
		html += '<tr>';
		html += '<td><select id="conditionalLogic_field'+i+'" onchange="onChangeConditionLogicCheck('+i+',\'field\',this.value)" onblur="onChangeConditionLogicCheck('+i+',\'field\',this.value,\'blur\')" onkeyup="onChangeConditionLogicCheck('+i+',\'field\',this.value)">';
		var bMatchFound = false;
		var firstSelectFieldId = null;
		var fieldIdsInOrder = getFieldOrder();
		for( var fieldNo=0, id; fieldNo<fieldIdsInOrder.length; fieldNo++ ){
			id = fieldIdsInOrder[ fieldNo ];
			if( formItems[id].fieldtype == "dropdown" || formItems[id].fieldtype == "multipleChoice" )
			{
				if( firstSelectFieldId == null ) firstSelectFieldId = id;
				html += '<option value="' + id + '"';
				if( checks[i].field == id ) { html += " selected"; bMatchFound = true; }
				html += '>' + shortVersion( formItems[id].title, 20 );
			}
		}
		
		//if we didn't find a single lookup list then drop the conditional logic and exit
		if( firstSelectFieldId == null ) { formItems[ currSelElm.id ][ "conditionallogic" ] = null; return; }
		
		//if we didn't find the field we are looking for, then set the selected field to the first found
		if( !bMatchFound && fieldIdsInOrder.length ) checks[i].field = firstSelectFieldId;
		html += '</select></td>';
		html += '<td><select id="conditionalLogic_condition'+i+'" onchange="onChangeConditionLogicCheck('+i+',\'condition\',this.value)" onblur="onChangeConditionLogicCheck('+i+',\'condition\',this.value)" onkeyup="onChangeConditionLogicCheck('+i+',\'condition\',this.value)">';
		html += '<option value="=="' + ((checks[i].condition=="==")?" selected":"") + '>is<option value="!="' + ((checks[i].condition=="!=")?" selected":"") + '>is not</select>';
		html += '</td>';
		html += '<td><select id="conditionalLogic_option'+i+'" onchange="onChangeConditionLogicCheck('+i+',\'option\',this.value)" onblur="onChangeConditionLogicCheck('+i+',\'option\',this.value)" onkeyup="onChangeConditionLogicCheck('+i+',\'option\',this.value)">';
		
		var o = formItems[ checks[i].field ];
		var bMatchFound = false;
		for( var optNo=0; optNo<o.options.length; optNo++ ){
			html += '<option value="' + HTMLEditFormat( o.options[optNo] ) + '"';
			if( o.options[optNo] == checks[i].option ) { html += " selected"; bMatchFound = true; }
			html +='>' + HTMLEditFormat( shortVersion( o.options[optNo], 12 ) );
		}
		if( !bMatchFound && o.options.length ) checks[i].option = o.options[0];
		
		html += '</select></td>';
		
			html += '<td width="36"><div class=\"left\">';
			html += '<a href="javascript:addConditionalLogic(' + i + ')"><img src="images/icons/add.png" width="16" height="16" alt="" border="0"></a>';
			html += '<a href="javascript:delConditionalLogicCheck(' + i + ')"><img src="images/icons/delete.png" width="16" height="16" alt="" border="0"></a>';
			html += '</div></td>';
		
		html += '</tr>';
	}
	html += '</table>';
	$("conditionalLogicTableDiv").innerHTML = html;
	$("conditionalLogicBut").style.display="none";
	$("conditionalLogicDiv").style.display="block";
}

function addConditionalLogic(afterPos){
	
	if( formItems[ currSelElm.id ][ "conditionallogic" ] == null ){
		formItems[ currSelElm.id ][ "conditionallogic" ] = {};
		formItems[ currSelElm.id ][ "conditionallogic" ].action = "Show";//1=show,0=hide
		formItems[ currSelElm.id ][ "conditionallogic" ].bool = "OR";//1=any,0=all
		formItems[ currSelElm.id ][ "conditionallogic" ].checks = [];
	}

	//set the initial conditional option to the first value available
	var count=0;
	var pos = formItems[ currSelElm.id ][ "conditionallogic" ].checks.length;

	if( pos == 0 ){
		var fieldIdsInOrder = getFieldOrder();
		for( var fieldNo=0, id; fieldNo<fieldIdsInOrder.length; fieldNo++ )
		{
			id = fieldIdsInOrder[ fieldNo ];
			if( id != currSelElm.id ){
				if( count==0 && ( formItems[id].fieldtype == "dropdown" || formItems[id].fieldtype == "multipleChoice" ) )
				{
					formItems[ currSelElm.id ][ "conditionallogic" ].checks[pos] = {};
					formItems[ currSelElm.id ][ "conditionallogic" ].checks[pos].field = id;
					formItems[ currSelElm.id ][ "conditionallogic" ].checks[pos].condition = "==";
					formItems[ currSelElm.id ][ "conditionallogic" ].checks[pos].option = formItems[id].options[0];
					count++;	
				}
			}
		}
		if( count == 0 ){
			alert("You must have at least one dropdown or multiple choice field to use Conditional Logic.");
		}
	}else{
		//just copy the previous logic item
		if( afterPos == null ){
			formItems[ currSelElm.id ][ "conditionallogic" ].checks[pos] = deepObjCopy( formItems[ currSelElm.id ][ "conditionallogic" ].checks[pos-1] );
		}else{
			var newRow = deepObjCopy( formItems[ currSelElm.id ][ "conditionallogic" ].checks[afterPos] );
			formItems[ currSelElm.id ][ "conditionallogic" ].checks.splice(afterPos,0,newRow);
		}
	}
	
	updateConditionalLogicDisplay();
}
function delConditionalLogicCheck(i){
	if( formItems[ currSelElm.id ][ "conditionallogic" ].checks.length == 1 ) {delAllConditionalLogicChecks(); return;}
	formItems[ currSelElm.id ][ "conditionallogic" ].checks.splice(i,1);
	updateConditionalLogicDisplay();
}
function delAllConditionalLogicChecks(){
	formItems[ currSelElm.id ][ "conditionallogic" ] = null;
	updateConditionalLogicDisplay();
}

function onMouseOverHelp(event){
	Event.stop(event);
	var e = Event.element( event );
	var offXY = Position.cumulativeOffset(e);

	var mouse_x = offXY[0];
	var mouse_y = offXY[1];
	var offX = 16;
	var offY = 5;
	var html = e.getAttribute("rel");
	html = '<div id="QuickItemPopup" class="QuickItemPopup"><div><div class="mid">' + html + '</div></div></div>';
	if( $("QuickItemPopup") ) Element.remove( "QuickItemPopup" );
	new Insertion.Top( $("mainBody"), html );
	
	var eSize = Element.getDimensions(e);
	offY -= eSize.height;
	
	$("QuickItemPopup").style.left = (mouse_x+offX)+"px";
	$("QuickItemPopup").style.top = (mouse_y+offY)+"px";

	
}
function onMouseOutHelp(event){
	if( $("QuickItemPopup") ) Element.remove( "QuickItemPopup" );
}
function onMouseClickHelp(){
	return false;
}
function initHelpLinks()
{
	var helpLinks = $$('.help');//document.getElementsByClassName("help");
	helpLinks.each( function(item, index){ Event.observe( item, 'click', onMouseClickHelp ); } );
	helpLinks.each( function(item, index){ Event.observe( item, 'mouseover', onMouseOverHelp ); } );
	helpLinks.each( function(item, index){ Event.observe( item, 'mouseout', onMouseOutHelp ); } );
}
function init()
{
	//Put all interfaces into the field type dropdown
	var interfaceTypes = Object.keys( interfaces ).sort();
	for( var i=0; i < interfaceTypes.length; i++ )
	{
		var _interface = interfaces[ interfaceTypes[i] ];
		var opt = new Option( _interface.name, interfaceTypes[i] );
		var opts = $("fieldtype").options;
		opts[ opts.length ] = opt;
	}
	
	//Display the no fields message if there are none
	var numFormFields = ( Object.keys( formItems ).length );
	if( numFormFields == 0 ) Effect.Appear( "nofieldsMsg" );
	else $("formButtons").style.display = "block";

	//Default form options

	if( formInfo.desc == null ) formInfo.desc = "Please fill out the form.";
	if( formInfo.submitbuttontext == null ) formInfo.submitbuttontext = "Submit";
	if( formInfo.confirmationOpt == null ) formInfo.confirmationOpt = "Show Text";
	if( formInfo.confirmmsg == null ) formInfo.confirmmsg = "Thank you. Your entry has been successfully submitted.";
	if( formInfo.redirecturl == null ) formInfo.redirecturl = "http://";
	//checkboxes for email
	if( formInfo.formcopyemailcheckbox == null ) formInfo.formcopyemailcheckbox = false;
	if( formInfo.formcopyemailto == null ) formInfo.formcopyemailto = "";
	//checkboxes for email
	if( formInfo.formreceiptcheckbox == null ) formInfo.formreceiptcheckbox = false;
	if( formInfo.formreceiptemailto == null ) formInfo.formreceiptemailto = "";
	if( formInfo.formreceiptemailreplyto == null ) formInfo.formreceiptemailreplyto = "";
	if( formInfo.formreceiptemailmsg == null ) formInfo.formreceiptemailmsg = "";
	//mail settings
	if( formInfo.formmailserver == null ) formInfo.formmailserver = "";
	if( formInfo.formmailsendfrom == null ) formInfo.formmailsendfrom = "";

	//Update the form options
	
	$("formDescription").innerHTML = formInfo.desc;
	$("formDesc").value = formInfo.desc;
	$("formSubmitButtonText").value = formInfo.submitbuttontext;
	//confirmationOpt
	if( formInfo.confirmationtype != "redirect" || formInfo.confirmationtype.redirecturl != "http://" ){
		$("confirmationType_Message").checked = true;
		Element.removeClassName('confirmMsg', 'hide');
	}
	else{
		$("confirmationType_redirect").checked = true;
		Element.removeClassName('formRedirectVal', 'hide');
	}
	$("confirmMsg").value = formInfo.confirmmsg;
	$("formRedirectVal").value = formInfo.redirecturl;
	$("includeOnSubmit").value =  (( formInfo.includeonsubmit != null )?formInfo.includeonsubmit:"");
	if( $("formStyle") ) $("formStyle").value =  (( formInfo.formstyle != null )?formInfo.formstyle:"");
	//email notification options
	$("formCopyEmailCheckbox").checked = formInfo.formcopyemailcheckbox;
	if( formInfo.formcopyemailcheckbox ) $("formCopyEmailCheckboxDiv").removeClassName('hide');
	$("formCopyEmailTo").value = formInfo.formcopyemailto;

	//display all the fields from the database	
	if( formInfo.fieldorder ){
		for( var i=0;i<formInfo.fieldorder.length;i++ ){
			var id = formInfo.fieldorder[i];
			addFieldToLIList( formItems[id], 0, id )
		}
	}
	else{
		for( var id in formItems ){ 
			addFieldToLIList( formItems[id], 0, id )
		}
	}

	//checkboxes for email
	$("formReceiptCheckbox").checked = formInfo.formreceiptcheckbox;
	if( formInfo.formreceiptcheckbox ) $("formReceiptEmailDiv").removeClassName('hide');

	$("formReceiptEmailTo").value = formInfo.formreceiptemailto;//DONE AFTER FIELDS ARE ADDED
	$("formReceiptEmailReplyTo").value = formInfo.formreceiptemailreplyto;
	$("formReceiptEmailMsg").value = formInfo.formreceiptemailmsg;

	//$("formMailServer").value = formInfo.formmailserver;
	//$("formMailSendFrom").value = formInfo.formmailsendfrom;

	initHelpLinks();
}

Event.observe(window, 'load', init);