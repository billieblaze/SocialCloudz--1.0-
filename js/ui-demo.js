
$(function(){
	// Accordion
	$("#accordion").accordion({ header: "h3" });
	// Autocomplete
	$("#autocomplete").autocomplete({
		source: ["c++", "java", "php", "coldfusion", "javascript", "asp", "ruby", "python", "c", "scala", "groovy", "haskell", "perl"]
	});
	// Button
	$("#button").button();
	$("#radioset").buttonset();
	// Tabs
	$('#tabs').tabs();
	// Dialog			
	$('#dialog').dialog({
		autoOpen: false,
		width: 600,
		buttons: {
			"Ok": function() { 
				$(this).dialog("close"); 
			}, 
			"Cancel": function() { 
				$(this).dialog("close"); 
			} 
		}
	});
	// Dialog Link
	$('#dialog_link').click(function(){
		$('#dialog').dialog('open');
		return false;
	});
	// Datepicker
	$('#datepicker').datepicker({
		inline: true
	});
	// Slider
	$('#slider').slider({
		range: true,
		values: [17, 67]
	});
	// Progressbar
	$("#progressbar").progressbar({
		value: 20 
	});
	//hover states on the static widgets
	$('#dialog_link, ul#icons li').hover(
		function() { $(this).addClass('ui-state-hover'); }, 
		function() { $(this).removeClass('ui-state-hover'); }
	);
    $('#orbitDemo').orbit({
         animation: 'horizontal-push'
     });
    $('#buttonForModal').click(function() {
        $('#myModal').reveal();
});
    
	$( ".column" ).sortable({
		connectWith: ".column"
	});

	$( ".portlet" ).addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
		.find( ".portlet-header" )
			.addClass( "ui-widget-header ui-corner-all" )
			.prepend( "<span class='ui-icon ui-icon-minusthick'></span>")
			.end()
		.find( ".portlet-content" );

	$( ".portlet-header .ui-icon" ).click(function() {
		$( this ).toggleClass( "ui-icon-minusthick" ).toggleClass( "ui-icon-plusthick" );
		$( this ).parents( ".portlet:first" ).find( ".portlet-content" ).toggle();
	});

	$( ".column" ).disableSelection();
	
	
	$( "#resizable" ).resizable({
		grid: 50
	});

	
	var myOptions = {
	          center: new google.maps.LatLng(-34.397, 150.644),
	          zoom: 8,
	          mapTypeId: google.maps.MapTypeId.ROADMAP
	        };
	        var map = new google.maps.Map(document.getElementById("map_canvas"),
	            myOptions);

	        
	        $("#jquery_jplayer_1").jPlayer({
	    		ready: function () {
	    			$(this).jPlayer("setMedia", {
	    				m4v: "http://www.jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v",
	    				ogv: "http://www.jplayer.org/video/ogv/Big_Buck_Bunny_Trailer.ogv",
	    				webmv: "http://www.jplayer.org/video/webm/Big_Buck_Bunny_Trailer.webm",
	    				poster: "http://www.jplayer.org/video/poster/Big_Buck_Bunny_Trailer_480x270.png"
	    			});
	    		},
	    		swfPath: "js/jQuery.jPlayer.2.1.0",
	    		supplied: "webmv, ogv, m4v",
	    		size: {
	    			width: "640px",
	    			height: "360px",
	    			cssClass: "jp-video-360p"
	    		}
	    	});


	    	$("#jplayer_inspector").jPlayerInspector({jPlayer:$("#jquery_jplayer_1")});

	    	$("#jquery_jplayer_2").jPlayer({
	    		ready: function (event) {
	    			$(this).jPlayer("setMedia", {
	    				m4a:"http://www.jplayer.org/audio/m4a/TSP-01-Cro_magnon_man.m4a",
	    				oga:"http://www.jplayer.org/audio/ogg/TSP-01-Cro_magnon_man.ogg"
	    			});
	    		},
	    		swfPath: "js/jQuery.jPlayer.2.1.0",
	    		supplied: "m4a, oga",
	    		wmode: "window"
	    	});

	    	$("#jplayer_inspector2").jPlayerInspector({jPlayer:$("#jquery_jplayer_2")});
	    	
			$('#default').raty();

			$('#fixed').raty({
				readOnly:	true,
				start:		2
			});

			$('#start').raty({
			    start: function() {
			        return $(this).attr('data-rating');
			    }
			});

			$('#anyone').raty({
				readOnly:	true,
				noRatedMsg:	'anyone rated this product yet!'
			});

			$('#number').raty({
				scoreName:	'entity.score',
				number:		10
			});

			$('#click').raty({
				click: function(score, evt) {
					alert('ID: ' + $(this).attr('id') + '\nscore: ' + score + '\nevent: ' + evt);
				}
			});

			$('#cancel').raty({
				cancel: true
			});

			$('#cancel-custom').raty({
				cancel:			true,
				cancelHint:		'remove my rating!',
				cancelPlace:	'right',
				click: function(score, evt) {
					alert('score: ' + score);
				}
			});

			$('#half').raty({
				half: true,
				start: 3.3
			});

			$('#round').raty({
				start: 1.26,
				round: { down: .25, full: .6, up: .76 }
			});

			$('#icon').raty({
				hintList:	['a', '', null, 'd', '5'],
			   	starOn:		'medal-on.png',
			   	starOff:	'medal-off.png'
			});

			$('#range').raty({
				iconRange: [
					{ range: 2, on: 'face-a.png', off: 'face-a-off.png' },
					{ range: 3, on: 'face-b.png', off: 'face-b-off.png' },
					{ range: 4, on: 'face-c.png', off: 'face-c-off.png' },
					{ range: 5, on: 'face-d.png', off: 'face-d-off.png' }
				]
			});

			$('#big').raty({
				cancel:		true,
				cancelOff:	'cancel-off-big.png',
				cancelOn:	'cancel-on-big.png',
				half:		true,
				size:		24,
				starOff:	'star-off-big.png',
				starOn:		'star-on-big.png',
				starHalf:	'star-half-big.png'
			});

			$('.group').raty();

			$('#target').raty({
				cancel:		true,
				cancelHint:	'none',
				target:		'#hint'
			});

			$('#format').raty({
				cancel:			true,
				cancelHint:		'Sure?',
				target:			'#hint-format',
				targetFormat:	 'your score: {score}',
				targetKeep:		true,
				targetText:		'none'
			});

			$('#target-number').raty({
				cancel:		true,
				target:		'#score',
				targetKeep:	true,
				targetType:	'number'
			});

			$('#target-out').raty({
				target:		'#hint-out',
				targetText:	'--'
			});

			$('#precision').raty({
				half:		true,
				precision:	true,
				size:		24,
				starOff:	'star-off-big.png',
				starOn:		'star-on-big.png',
				starHalf:	'star-half-big.png',
				target:		'#precision-target',
				targetType:	'number'
			});

			$('#space').raty({
				space: false
			});

			$('#single').raty({
				single: true
			});

			var $result = $('#result').raty();

			$('.action').raty({
				click: function(score, evt) {
					$(this).raty('cancel');
					$result.raty('start', score);
				}
			});

			$('#function').raty({
				cancel:			true,
				cancelHint:		'Boring!',
				click:	function(score, evt) {
					$(this).fadeOut(function() { $(this).fadeIn(); });
				},
				targetKeep:	true,
				start:		2,
				target:		'#hint-function',
				targetText:	'--'
			});

			$('.start').click(function() {
				$('#function').raty('start', this.title);
			});

			$('.click').click(function() {
				$('#function').raty('click', this.title);
			});

			$('.readOnly').click(function() {
				$('#function').raty('readOnly', (this.title == 'true') ? true : false);
			});

			$('.cancel').click(function() {
				$('#function').raty('cancel', (this.title == 'true') ? true : false);
			});

			$('#switcher').themeswitcher();
});