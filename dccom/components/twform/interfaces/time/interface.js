interfaces["time"] = {
	name : 'Time',
	defaults : {
		},
	options : {
		showDefault: 0,
		showFieldSize: 0
		},
	preview : function(o){
		var html = "";
		
		html += "<div class=\"left sp6\"><div class=\"fakeInput tiny\">&nbsp;</div><div class=\"info\">HH</div></div><div class=\"left sep\">:</div>";
		html += "<div class=\"left sp6\"><div class=\"fakeInput tiny\">&nbsp;</div><div class=\"info\">MM</div></div><div class=\"left sep\"></div>";
		html += "<div class=\"left sp6\"><select name=\"ampm\"><option value=\"AM\">AM</option><option value=\"PM\">PM</option></select><div class=\"info\">AM/PM</div></div>";
		
		return html;
	}
}
