interfaces["date"] = {
	name : 'Date',
	defaults : {
		dateFormat: 'usdate'
		},
	options : {
		showDefault: 0,
		showFieldSize: 0
		},
	preview : function(o){
		var html = "";
		
		if( o.dateformat == 'usdate' )
		{
			html += "<div class=\"left sp6\"><div class=\"fakeInput tiny\">&nbsp;</div><div class=\"info\">MM</div></div><div class=\"left sep\">/</div>";
			html += "<div class=\"left sp6\"><div class=\"fakeInput tiny\">&nbsp;</div><div class=\"info\">DD</div></div><div class=\"left sep\">/</div>";
		}
		else{
			html += "<div class=\"left sp6\"><div class=\"fakeInput tiny\">&nbsp;</div><div class=\"info\">DD</div></div><div class=\"left sep\">/</div>";
			html += "<div class=\"left sp6\"><div class=\"fakeInput tiny\">&nbsp;</div><div class=\"info\">MM</div></div><div class=\"left sep\">/</div>";
		}
		html += "<div class=\"left sp6\"><div class=\"fakeInput small\">&nbsp;</div><div class=\"info\">YYYY</div></div><div class=\"left sep\"></div>";
		
		return html;
	},
	extraOptions : function(o){
		var html = '<li class="right half extra" id="listDateFormat"><label class="desc" for="fieldSize">Date Format<a href="#" class="help" title="About Date Format" rel="Choose between American and European Date Formats">(?)</a></label>';
		html += '<select class="select full" id="fieldSize" autocomplete="off" onchange="updateProps($F(this), \'dateFormat\')" >';
		html += '<option id="fieldDateAmerican" value="usdate"' + (( o.dateformat == 'usdate' )?" selected":"") + '>MM / DD / YYYY</option>';
		html += '<option id="fieldDateEuro" value="eurodate"' + (( o.dateformat == 'eurodate' )?" selected":"") + '>DD / MM / YYYY</option>';
		html += '</select></li>';
		new Insertion.After( $("listType"), html );
	}
}
