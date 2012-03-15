interfaces["phone"] = {
	name : 'Phone',
	defaults : {
		phoneformat: 'international',
		title: 'Phone'		
		},
	options : {
		showDefault: 0,
		showFieldSize: 0
		},
	preview : function(o){
		var html = "";
		
		html += '<div class=\"left phoneIcon\">&nbsp;</div>';
		if( o.phoneformat == 'international' )
		{
			html += "<div class=\"left\"><div class=\"fakeInput medium\">&nbsp;</div></div>";
		}
		else{
			html += "<div class=\"left\"><div class=\"fakeInput small\">&nbsp;</div><div class=\"info\">(###)</div></div><div class=\"left sep\">-</div>";
			html += "<div class=\"left\"><div class=\"fakeInput small\">&nbsp;</div><div class=\"info\">###</div></div><div class=\"left sep\">-</div>";
			html += "<div class=\"left\"><div class=\"fakeInput small\">&nbsp;</div><div class=\"info\">####</div></div>";
		}
		
		return html;
	},
	extraOptions : function(o){
		var html = '<li class="right half extra" id="listPhoneFormat"><label class="desc" for="fieldSize">Phone Format<a href="#" class="help" title="About Phone Format" rel="Choose between American and International Phone Formats">(?)</a></label>';
		html += '<select class="select full" id="fieldSize" autocomplete="off" onchange="updateProps($F(this), \'phoneformat\')" >';
		html += '<option id="fieldPhoneInt" value="international"' + (( o.phoneformat == 'international' )?" selected":"") + '>international</option>';
		html += '<option id="fieldPhoneUS" value="usphone"' + (( o.phoneformat == 'usphone' )?" selected":"") + '>(###) ### - #####</option>';
		html += '</select></li>';
		new Insertion.After( $("listType"), html );
	}
}
