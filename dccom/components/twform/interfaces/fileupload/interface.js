interfaces["fileupload"] = {
	name : 'File Upload',
	defaults : {
		defaultval: ''
		},
	options : {
		showDefault: 0
		},
	preview : function(o){
		var html = "";
		html += '<div class=\"left emailIcon\">&nbsp;</div>';
		html += "<div>";
		html += '<input type="file" size="40" class="fileupload">';
		html += "</div>";
		return html;
	}
}
