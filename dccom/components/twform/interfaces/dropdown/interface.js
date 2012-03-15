interfaces["dropdown"] = {
	name : 'Drop Down',
	defaults : {
		defaultoption : null,
		size: 'medium',
		options : [ "First Choice", "Second Choice", "Third Choice" ]
		},
	options : {
		showDefault: 0,
		showFieldSize: 1,
		showUnique: 0
		},
	preview : function(o){
		var html = "";
		html += "<select class=\"" + o.size + "\">";
		for( var i=0; i < o.options.length; i++ )
			html += "<option " + (( o.defaultoption == i )?" selected":"") + " value=\"" + HTMLEditFormat( o.options[i] ) + "\">" + HTMLEditFormat( o.options[i] ) + "</option>";
		html += "</select>";
		return html;
	},
	updateOptionsHTML : function(){
		var html = "";
		var o = formItems[ currSelElm.id ];
		
		for( var i=0; i < o.options.length; i++ )
		{
			html += '<li class="clear">';
			html += '<input type=\"text\" class=\"medium left\" name=\"" + o.id + "opts" + i + "\" value=\"' + o.options[i] + '\" onkeyup="interfaces[\'dropdown\'].updateOptions(this.value, '+i+')" onblur="interfaces[\'dropdown\'].updateOptions(this.value, '+i+')">';
			html += '<div class=\"left\">';
			html += '<a href="javascript:interfaces[\'dropdown\'].addOpt(' + i + ')"><img src="images/icons/add.png" width="16" height="16" alt="" border="0"></a>';
			html += '<a href="javascript:interfaces[\'dropdown\'].deleteOpt(' + i + ')"><img src="images/icons/delete.png" width="16" height="16" alt="" border="0"></a>';
			html += '<a href="javascript:interfaces[\'dropdown\'].setDefault(' + i + ')"><img src="images/icons/star';
			html += (( o.defaultoption != i )?"dim":"");
			html += '.gif" width="16" height="16" alt="" border="0"></a>';
			html += '</div></li>';
		}
		$("fieldChoices").innerHTML = html;
	},
	getDefaults : function(o){
		var html = "";
		html += '<li class="clear extra" id="listChoices"><fieldset class="choices"><legend>Choices<a href="#" class="help" title="About Choices" rel="This property shows what predefined options the user can select for that particular field. Use the plus and minus buttons to add and delete choices. Click on the star to make a choice the default selection. Multiple Choice fields will automatically select the first choice as default if none is specified.">(?)</a></legend>';
		html += '<ul id="fieldChoices"></ul>';
		html += '</fieldset></li>';
		new Insertion.After( $("listType"), html );
		this.updateOptionsHTML();
	},
	createNew : function(){
		var o = deepObjCopy( this.defaults );
		//because that was a shallow copy of the defaults, the options array must be slice to be a new entity
		o.options = o.options.slice();
		return o;
	},
	duplicate : function(oToCopy){
		var o = deepObjCopy( oToCopy );
		//because that was a shallow copy of the defaults, the options array must be slice to be a new entity
		o.options = o.options.slice();
		return o;
	},
	extraOptions : function(o){
		var html = "";
		html += '<li class="clear extra" id="listChoices"><fieldset class="choices"><legend>Choices<a href="#" class="help" title="About Choices" rel="This property shows what predefined options the user can select for that particular field. Use the plus and minus buttons to add and delete choices. Click on the star to make a choice the default selection. Multiple Choice fields will automatically select the first choice as default if none is specified.">(?)</a></legend>';
		html += '<ul id="fieldChoices"></ul>';
		html += '</fieldset></li>';
		new Insertion.After( $("listType"), html );
		this.updateOptionsHTML();
	},
	addOpt : function( i ){
		var o = formItems[ currSelElm.id ];
		o.options.splice(i+1,0,"New Option");
		this.updateOptionsHTML();
		updateCurrentFieldPreview();
	},
	deleteOpt : function( i ){
		var o = formItems[ currSelElm.id ];
		if( o.options.length == 1 ) return;
		o.options.splice(i,1);
		this.updateOptionsHTML();
		updateCurrentFieldPreview();
	},
	setDefault : function( i ){
		var o = formItems[ currSelElm.id ];
		if( o.defaultoption == i ) o.defaultoption = null;
		else o.defaultoption = i;
		this.updateOptionsHTML();
		updateCurrentFieldPreview();
	},
	updateOptions : function( val, i)
	{
		var o = formItems[ currSelElm.id ];
		o.options[ i ] = val;
		updateCurrentFieldPreview();
	}
}
