interfaces["paragraphText"] = {
	name : 'Paragraph Text',
	defaults : {
		defaultval: '',
		size: 'medium',
		title: 'Your Message'
		},
	preview : function(o){
		var html = "<div class=\"fakeTextarea " + o.size + "\">";
		
		html += o.defaultval.replace(/\n/g, "<br/>");
		
		html += "&nbsp;</div>";
		return html;
	}
}
