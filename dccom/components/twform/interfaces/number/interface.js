interfaces["number"] = {
	name : 'Number',
	defaults : {
		defaultval: '',
		size: 'medium'
		},
	preview : function(o){
		var html = "<div class=\"fakeInput " + o.size + "\">";
		
		if( o.defaultval == "" ) html += "0123456789"
		else html += o.defaultval;
		
		html += "&nbsp;</div>";
		return html;
	}
}
