interfaces["email"] = {
	name : 'Email',
	defaults : {
		defaultval: '',
		size: 'medium',
		title: 'Your Email'
		},
	preview : function(o){
		var html = "";
		
		html += '<div class=\"left emailIcon\">&nbsp;</div>';
		html += "<div class=\"fakeInput " + o.size + "\">";
		
		if( o.defaultval.length ) html += o.defaultval;
		else html += "@";
		
		html += "&nbsp;</div>";
		return html;
	}
}
