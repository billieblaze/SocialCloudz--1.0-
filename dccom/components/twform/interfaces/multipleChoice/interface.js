interfaces["multipleChoice"] = {
	name : 'Multiple Choice',
	defaults : {
		defaultoption : null,
		options : [ "First Choice", "Second Choice", "Third Choice" ]
		},
	options : {
		showDefault: 0,
		showFieldSize: 0,
		showUnique: 0
		},
	preview : function(o){
		var html = "";
		for( var i=0; i < o.options.length; i++ )
			html += "<div class=\"option\"><input type=\"radio\" name=\"pv" + o.id + "opts" + i + "\"" + (( o.defaultoption == i )?" checked":"") + "><label for=\"pv" + o.id + "opts" + i + "\">" + HTMLEditFormat( o.options[i] ) + "</label></div>";
		return html;
	},
	updateOptionsHTML : function(){
		var html = "";
		var o = formItems[ currSelElm.id ];
		
		for( var i=0; i < o.options.length; i++ )
		{
			html += '<li class="clear">';
			html += '<input type=\"text\" class=\"medium left\" name=\"" + o.id + "opts" + i + "\" value=\"' + o.options[i] + '\" onkeyup="interfaces[\'multipleChoice\'].updateOptions(this.value, '+i+')" onblur="interfaces[\'multipleChoice\'].updateOptions(this.value, '+i+')">';
			html += '<div class=\"left\">';
			html += '<a href="javascript:interfaces[\'multipleChoice\'].addOpt(' + i + ')"><img src="images/icons/add.png" width="16" height="16" alt="" border="0"></a>';
			html += '<a href="javascript:interfaces[\'multipleChoice\'].deleteOpt(' + i + ')"><img src="images/icons/delete.png" width="16" height="16" alt="" border="0"></a>';
			html += '<a href="javascript:interfaces[\'multipleChoice\'].setDefault(' + i + ')"><img src="images/icons/star';
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
