interfaces["name"] = {
	name : 'Name',
	defaults : {
		defaultval: '',
		format: 'normal',
		title: 'Your Name'
		},
	options : {
		showDefault: 0,
		showFieldSize: 0
		},
	preview : function(o){
		var html = "";
		
		if( o.format != "extended" )
		{
			html += "<div class=\"left sp2\"><div class=\"fakeInput medium\">&nbsp;</div><div class=\"info\">First Name</div></div>";
			html += "<div class=\"left sp2\"><div class=\"fakeInput medium\">&nbsp;</div><div class=\"info\">Last Name</div></div>";
		}
		else{
			html += "<div class=\"left sp2\"><div class=\"fakeInput tiny\">&nbsp;</div><div class=\"info\">Title</div></div>";
			html += "<div class=\"left sp2\"><div class=\"fakeInput medium\">&nbsp;</div><div class=\"info\">First Name</div></div>";
			html += "<div class=\"left sp2\"><div class=\"fakeInput medium\">&nbsp;</div><div class=\"info\">Last Name</div></div>";
			html += "<div class=\"left sp2\"><div class=\"fakeInput tiny\">&nbsp;</div><div class=\"info\">Suffix</div></div>";
		}
		
		return html;
	},
	extraOptions : function(o){
		var html = '<li class="right half extra" id="listNameFormat"><label class="desc" for="nameFormat">Name Format<a href="#" class="help" title="About Name Format"rel="Choose between a normal name field, or an extended name field with title and suffix.">(?)</a></label>';
		html += '<select class="select full" id="nameFormat" autocomplete="off" onchange="updateProps($F(this), \'format\')" >';
		html += '<option id="fieldNameNormal" value="normal"' + ((o.format != "extended")?' selected="selected"':'') + '>Normal</option>';
		html += '<option id="fieldNameExtended" value="extended"' + ((o.format == "extended")?' selected="selected"':'') + '>Extended</option></select>';
		html += '</li>';
		new Insertion.After( $("listType"), html );
	}
}
