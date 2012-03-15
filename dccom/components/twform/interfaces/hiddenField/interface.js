interfaces["hiddenField"] = {
	name : 'Hidden Field',
	defaults : {
		defaultval: '',
		varname:''
		},
	options : {
		showDefault: 1,
		showFieldSize: 0,
		showInstructions: 0
		},
	preview : function(o){
		var html = "<div class=\"fakeHidden " + o.size + "\"><span style='color:#385;font-size:9px;'>HIDDEN FIELD</span> ";
		
		html += o.defaultval;
		html += (o.varname == "")?"":" (or variable "+o.varname+")";
		
		html += "&nbsp;</div>";
		return html;
	}
}
