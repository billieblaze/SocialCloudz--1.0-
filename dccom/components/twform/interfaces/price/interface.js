interfaces["price"] = {
	name : 'Price',
	defaults : {
		defaultval : "",
		currency : "dollars"
		},
	options : {
		showDefault: 1,
		showFieldSize: 0
		},
	preview : function(o){
		var html = "";
		var symbol = "$", notesName = "Dollars", centName = "Cent";//Default - Dollars
		switch( o.currency )
		{
			case 'euro':
				symbol = "&euro;";
				notesName = "Euros";
				centName = "Cent";
				break;
			case 'pounds':
				symbol = "&#163;";
				notesName = "Pounds";
				centName = "Pence";
				break;		
			case 'yen':
				symbol = "&#165;";
				notesName = "Yen";
				break;//xxx
		}		
		html += "<div class=\"left sep\">" + symbol + "</div>";
		html += "<div class=\"left\"><div class=\"fakeInput small\">&nbsp;</div><div class=\"info\">" + notesName + "</div></div>";
		if( o.currency != "yen" )
		{
			html += "<div class=\"left sep\">.</div>";
			html += "<div class=\"left\"><div class=\"fakeInput tiny\">&nbsp;</div><div class=\"info\">" + centName + "</div></div>";
		}
		return html;
	},
	extraOptions : function(o){
		var html = "";
		html += '<li class="right half extra" id="listMoneyFormat"><label class="desc" for="fieldCurrency">Currency</label>';
		html += '<select class="select full" id="fieldCurrency" autocomplete="off" onchange="updateProps($F(this), \'currency\')" >';
		html += '<option id="fieldMoneyAmerican" value="">&#36; Dollars</option>';
		html += '<option id="fieldMoneyEuro" value="euro">&#8364; Euros</option>';
		html += '<option id="fieldMoneyPound" value="pounds">&#163; Pounds</option>';
		html += '<option id="fieldMoneyYen" value="yen">&#165; Yen</option>';
		html += '</select></li>';
		new Insertion.After( $("listType"), html );
		$("fieldCurrency").value = o.currency;
	}
}
