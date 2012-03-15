interfaces["website"] = {
	name : 'Website',
	defaults : {
		defaultval: '',
		size: 'medium'
		},
	preview : function(o){
		var html = "";
		
		html += '<div class=\"left websiteIcon\">&nbsp;</div>';
		html += "<div class=\"fakeInput " + o.size + "\">";
		
		if( o.defaultval.length ) html += o.defaultval;
		else html += "http://";
		
		html += "&nbsp;</div>";
		return html;
	}
}
