interfaces["password"] = {
	name : 'Password',
	defaults : {
		defaultval: '',
		size: 'medium'
		},
	preview : function(o){
		var html = "<div class=\"fakeInput " + o.size + "\">******";
		html += "&nbsp;</div>";
		return html;
	}
}
