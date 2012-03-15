interfaces["singleLineText"] = {
	name : 'Single Line Text',
	defaults : {
		defaultval: '',
		size: 'medium'
		},
	preview : function(o){
		var html = "<div class=\"fakeInput " + o.size + "\">";
		
		html += o.defaultval;
		
		html += "&nbsp;</div>";
		return html;
	}
}
