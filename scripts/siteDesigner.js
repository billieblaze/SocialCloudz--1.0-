
var style_data = new Object();
var style_data_JSON = '';
/* Init colorpicker */
	$(document).ready(function() {
	
		$.farbtastic('#colorpicker', function callback(color) {
											changeStyle(color);							
										   });
		$("#layout_file").uploadify({
			'uploader'       : '/flash/uploadify.swf',
			'script'         : '/upload',
			'cancelImg'      : '/images/cancel.png',
			'buttonImg'      : '/images/browse-files.png',
			'wmode'          : 'transparent',
			'width'          : 98,
			'queueID'        : 'fileQueue',
			'auto'           : true,
			'multi'          : false,
			'fileDataName'   : 'fileData',
			'fileDesc'		 : 'Image Files',
			'fileExt'		 : '*.gif;*.jpg;*.png;*.tif;*.tiff',
			'onComplete'  	 : function(event, queueID, fileObj, response, data){
							
								cleanResponse = trim(response);
								uploadResponse(cleanResponse);
								
							},
			'scriptData'	 :	{
									directory:directory,
									communityID: communityid, 
									fkType:'layout',
									procFile: 'util.upload.layout'
								}
		});    					   
	});


	/* setup selectbox click handlers */

	$("#myitem, #myelement, #myproperty").bind("click", function(e){
		changeControls();

	});
	$('#currentValue').bind('keyup', function(event, ui){
		changeStyle($('#currentValue').val());										  
    });

	$('#sizeSlider').bind('slide', function(event, ui) {
		var value1 = $('#sizeSlider').slider('option', 'value');
		var value2 = $('#sizeSliderFine').slider('option', 'value');
		var value = value1 + value2;
		changeStyle(value+'px');
	});
	
	$('#sizeSliderFine').bind('slide', function(event, ui) {
		var value1 = $('#sizeSlider').slider('option', 'value');
		var value2 = $('#sizeSliderFine').slider('option', 'value');
		var value = value1 + value2;
		changeStyle(value+'px');
	});

	$('#fontFamily').bind('change', function(event,ui){ 
		value = $('#fontFamily').val();
		changeStyle(value, 'fontFamily'); 
	});

	$('#fontSize').bind('change', function(event,ui){ 
		value = $('#fontSize').val();
		changeStyle(value, 'fontSize');
	});

	$('#fontWeight').bind('change', function(event,ui){ 
		value = $('#fontWeight').val();
		changeStyle(value, 'fontWeight');
	});

	$('#fontStyle').bind('change', function(event,ui){ 
		value = $('#fontStyle').val();
		changeStyle(value, 'fontStyle');
	});
	
	$('#textAlignment').bind('change', function(event,ui){ 
		value = $('#textAlignment').val();
		changeStyle(value, 'textAlign');
	});

	$('#textDecoration').bind('change', function(event,ui){ 
		value = $('#textDecoration').val();
		changeStyle(value, 'textDecoration');
	});

	$('#textDisplay').bind('change', function(event,ui){ 
		value = $('#textDisplay').val();
		changeStyle(value, 'display');
	});

	$('#backgroundPosition').bind('change', function(event,ui){ 
		value = $('#backgroundPosition').val();
		changeStyle(value, 'backgroundPosition');
	});
	
	$('#backgroundRepeat').bind('change', function(event,ui){ 
		value = $('#backgroundRepeat').val();
		changeStyle(value, 'backgroundRepeat');
	});

	$('#paddingTop').bind('slide', function(event,ui){ 
		var elCombo = $('#myproperty').val(); 
		var elArray = elCombo.split("!");
		var myProperty = elArray[1];	

		var value = $('#paddingTop').slider('option', 'value') + 'px '+$('#paddingRight').slider('option', 'value') + 'px '+$('#paddingBottom').slider('option', 'value') + 'px '+$('#paddingLeft').slider('option', 'value') + 'px ';
		changeStyle(value,myProperty);
		
		$('#currentValue').val(value);

	});

	$('#paddingRight').bind('slide', function(event,ui){ 
		var elCombo = $('#myproperty').val(); 
		var elArray = elCombo.split("!");
		var myProperty = elArray[1];	
			var value = $('#paddingTop').slider('option', 'value') + 'px '+$('#paddingRight').slider('option', 'value') + 'px '+$('#paddingBottom').slider('option', 'value') + 'px '+$('#paddingLeft').slider('option', 'value') + 'px ';
		changeStyle(value,myProperty);
		
		$('#currentValue').val(value);

	});

	$('#paddingBottom').bind('slide', function(event,ui){ 
		var elCombo = $('#myproperty').val(); 
		var elArray = elCombo.split("!");
		var myProperty = elArray[1];	

				var value = $('#paddingTop').slider('option', 'value') + 'px '+$('#paddingRight').slider('option', 'value') + 'px '+$('#paddingBottom').slider('option', 'value') + 'px '+$('#paddingLeft').slider('option', 'value') + 'px ';
		changeStyle(value,myProperty);
		
		$('#currentValue').val(value);
	});

	$('#paddingLeft').bind('slide', function(event,ui){ 
		var elCombo = $('#myproperty').val(); 
		var elArray = elCombo.split("!");
		var myProperty = elArray[1];	
		var value = $('#paddingTop').slider('option', 'value') + 'px '+$('#paddingRight').slider('option', 'value') + 'px '+$('#paddingBottom').slider('option', 'value') + 'px '+$('#paddingLeft').slider('option', 'value') + 'px ';
		changeStyle(value,myProperty);
		
		$('#currentValue').val(value);
	});


$('#marginTop').bind('slide', function(event,ui){ 
		var elCombo = $('#myproperty').val(); 
		var elArray = elCombo.split("!");
		var myProperty = elArray[1];	

		var value = $('#marginTop').slider('option', 'value') + 'px '+$('#marginRight').slider('option', 'value') + 'px '+$('#marginBottom').slider('option', 'value') + 'px '+$('#marginLeft').slider('option', 'value') + 'px ';
		changeStyle(value,myProperty);
		
		$('#currentValue').val(value);

	});

	$('#marginRight').bind('slide', function(event,ui){ 
		var elCombo = $('#myproperty').val(); 
		var elArray = elCombo.split("!");
		var myProperty = elArray[1];	
			var value = $('#marginTop').slider('option', 'value') + 'px '+$('#marginRight').slider('option', 'value') + 'px '+$('#marginBottom').slider('option', 'value') + 'px '+$('#marginLeft').slider('option', 'value') + 'px ';

		changeStyle(value,myProperty);
		
		$('#currentValue').val(value);

	});

	$('#marginBottom').bind('slide', function(event,ui){ 
		var elCombo = $('#myproperty').val(); 
		var elArray = elCombo.split("!");
		var myProperty = elArray[1];	

			var value = $('#marginTop').slider('option', 'value') + 'px '+$('#marginRight').slider('option', 'value') + 'px '+$('#marginBottom').slider('option', 'value') + 'px '+$('#marginLeft').slider('option', 'value') + 'px ';

		changeStyle(value,myProperty);
		
		$('#currentValue').val(value);
	});

	$('#marginLeft').bind('slide', function(event,ui){ 
		var elCombo = $('#myproperty').val(); 
		var elArray = elCombo.split("!");
		var myProperty = elArray[1];	
var value = $('#marginTop').slider('option', 'value') + 'px '+$('#marginRight').slider('option', 'value') + 'px '+$('#marginBottom').slider('option', 'value') + 'px '+$('#marginLeft').slider('option', 'value') + 'px ';
		changeStyle(value,myProperty);
		
		$('#currentValue').val(value);
	});





	function changeControls(){
	var elCombo = $('#myproperty').val(); 
		var elArray = elCombo.split("!");
		var myEl = elArray[0];	

		$('#mystyle').html(myEl);
		
	   		var myProperty = $('#myproperty').val();
			var myValue = getMyStyle();


			if (myProperty.indexOf('olor') > -1){ 
				if ($('#colorpicker').is(':hidden')){ 
					hideAllControls();
					$('#colorpicker').show();
				}
				myValue=rgb2hex(myValue);
				$.farbtastic('#colorpicker').setColor(myValue);				
			}
			
			if (myProperty.indexOf('eight') > -1 || myProperty.indexOf('idth') > -1){ 
				if ($('#slider').is(':hidden')){ 
					hideAllControls();
					$('#slider').show();
				}
				
				$('#currentValue').val(myValue);
				myValue = myValue.replace(/px,*\)*/g,"");
				
				coarseValue = Math.round(myValue/10);
				fineValue = Math.round(myValue-coarseValue);
				
				$("#sizeSlider").slider({ value: coarseValue, min: 0, max: 1000, step: 10});
				$("#sizeSliderFine").slider({ value: fineValue, min: 0, max: 10, step: 1});
			}
			
			if (myProperty.indexOf('adding') > -1 ){ 
				
			
				paddingValue = getPadding();
				$('#currentValue').val(paddingValue);
		
				if ($('#padding').is(':hidden')){ 
					hideAllControls();
					$('#padding').show();
				}
				
				$("#paddingTop").slider({ value: topValue, min: 0, max: 500, step: 2, orientation: 'horizontal'});
				$("#paddingRight").slider({ value: rightValue, min: 0, max: 500, step: 2, orientation: 'horizontal'});
				$("#paddingBottom").slider({ value: bottomValue, min: 0, max: 500, step: 2, orientation: 'horizontal'});
				$("#paddingLeft").slider({ value: leftValue, min: 0, max: 500, step: 2, orientation: 'horizontal'});

				

			}
			
		if (myProperty.indexOf('argin') > -1 ){ 
				
			
				marginValue = getMargin();
				$('#currentValue').val(marginValue);
		
				if ($('#margin').is(':hidden')){ 
					hideAllControls();
					$('#margin').show();
				}
				
				$("#marginTop").slider({ value: topValue, min: 0, max: 500, step: 2, orientation: 'horizontal'});
				$("#marginRight").slider({ value: rightValue, min: 0, max: 500, step: 2, orientation: 'horizontal'});
				$("#marginBottom").slider({ value: bottomValue, min: 0, max: 500, step: 2, orientation: 'horizontal'});
				$("#marginLeft").slider({ value: leftValue, min: 0, max: 500, step: 2, orientation: 'horizontal'});

				

			}

			if (myProperty.indexOf('Image') > -1){ 
				var elCombo = $('#myproperty').val(); 

				var elArray = elCombo.split("!");
				var myEl = elArray[0];
				var myProperty = elArray[1];
		
				formField = myEl & '_' & myProperty;	
				
				if ($('#uploader').is(':hidden')){ 
					hideAllControls();
					$('#uploader').show();
				}
			}
			
			if (myProperty.indexOf('font') > -1){ 
				if ($('#text').is(':hidden')){ 
					hideAllControls();
					$('#text').show();
				}
				
				$('#fontFamily').val(getMyStyle('fontFamily'));
				$('#fontSize').val(getMyStyle('fontSize'));
				$('#fontWeight').val(getMyStyle('fontWeight'));
				$('#fontStyle').val(getMyStyle('fontStyle'));
				
				$('#textAlignment').val(getMyStyle('textAlign'));
				$('#textDecoration').val(getMyStyle('textDecoration'));
				$('#textDisplay').val(getMyStyle('display'));
				if($('#myelement').val() == '#ft'){ 
					$('#textDisplay').hide();
					$('#textAlignment').hide();
				} else { 
				$('#textDisplay').show();
					$('#textAlignment').show();
				}
			} 
			
	}
	/* hide all ui control divs */ 
	function hideAllControls(){
		$('#colorpicker').hide();
		$('#uploader').hide();
		$('#text').hide();
		$('#slider').hide();
		$('#padding').hide();
		$('#margin').hide();

	}

	/* change the style! */
	function changeStyle(value, property){
	
		var elCombo = $('#myproperty').val(); 
		var elArray = elCombo.split("!");
		var myEl = elArray[0];	

		if (property == undefined){
			var myProperty = elArray[1];
		} else { 
			var myProperty=property;
		}

		/* Update CSS */ 
		$(myEl).css(myProperty, value);
		
		/* Update Form Field */
		$('#currentValue').val(value);
	

		// Loop the myEL as a list..  use the index of the list and myproperty / value 
var valueArray = myEl.split(",");

for(var i=0; i<valueArray.length; i++){
 

	 	var new_data = '{"' + valueArray[i] +'" : {"' + myProperty +  '" : "'+value+'"}}';
	// TODO: remove YUI3..  this is prob the only reason its still around.. jquery now has these sorts of functions
		YUI({combine: true, timeout: 10000}).use("node", "io", "dump", "json-parse",function (Y) { 
			YUI().use('json', function(Y) {    
	   			thisData = Y.JSON.parse('{"'+myProperty+'":"'+value+'"}');
				   style_data[valueArray[i]] = Y.merge(style_data[valueArray[i] ], thisData) ;
				   style_data_JSON = Y.JSON.stringify(style_data);
			});
		});
}
	}

	/* Retrieve a style */ 
	function getMyStyle( property ){
			var elCombo = $('#myproperty').val(); 
			var elArray = elCombo.split("!");
			var myEl = elArray[0];

			if(property == undefined){
				var myProperty = elArray[1];
			} else { 
				var myProperty = property;
			}

        	var	style = $(myEl).css(myProperty);
			
			return style;
	}


function getPadding(){
			var elCombo = $('#myproperty').val(); 
			var elArray = elCombo.split("!");
			var myProperty = elArray[1];

			topVal = getMyStyle(myProperty + 'Top');
				topValue = topVal.replace(/px,*\)*/g,"");
				rightVal = getMyStyle(myProperty + 'Right');
				rightValue = rightVal.replace(/px,*\)*/g,"");
				bottomVal = getMyStyle(myProperty + 'Bottom');
				bottomValue = bottomVal.replace(/px,*\)*/g,"");
				leftVal = getMyStyle(myProperty + 'Left') ;
				leftValue = leftVal.replace(/px,*\)*/g,"");

				paddingValue = topVal + ' ' + rightVal + ' ' + bottomVal + ' ' + leftVal;
				return paddingValue;
}
function getMargin(){
			var elCombo = $('#myproperty').val(); 
			var elArray = elCombo.split("!");
			var myProperty = elArray[1];

			topVal = getMyStyle(myProperty + 'Top');
				topValue = topVal.replace(/px,*\)*/g,"");
				rightVal = getMyStyle(myProperty + 'Right');
				rightValue = rightVal.replace(/px,*\)*/g,"");
				bottomVal = getMyStyle(myProperty + 'Bottom');
				bottomValue = bottomVal.replace(/px,*\)*/g,"");
				leftVal = getMyStyle(myProperty + 'Left') ;
				leftValue = leftVal.replace(/px,*\)*/g,"");

				marginValue = topVal + ' ' + rightVal + ' ' + bottomVal + ' ' + leftVal;
				return marginValue;
}
	
	
function fill_dependentStyle(field1, field2, url){

	var cid = $('#'+field1).val();						
	var mytext = $('#'+field1 + ' option:selected').text();						

	cid = escape(cid);
	mytext = escape(mytext);
	var vURL =url + cid + '/text/' + mytext;

	var handleSuccess = function(o){
		/* Rebuild the select boxes */
		var objElmt = document.getElementById(field2);
		var objResponse = request.responseText;
		var trimmed = objResponse.replace(/^\s+|\s+$/g, '') ;
		var objArray = trimmed.split("|");
		objElmt.length = objArray.length ;
		var cnt = 0;

		if(trimmed == ''){
			objElmt.length = 0 ;
			objElmt[0].value = '';
			objElmt[0].text =  '';	
		} else{
			for (o = 0; o < objArray.length; o++){   		
				var objIdValue = objArray[o].split("~");
				objValue = objIdValue[0];
				objText = objIdValue[1];
				objElmt[cnt].value = objValue;
				objElmt[cnt].text =  objText;	
				cnt++;
			}
			objElmt.selectedIndex = 0;
		}	

		if (field1 == 'myitem'){
			updateStyleSelect2();
		}

}

	var request = $.ajax({
						 	url: vURL, 
						 	success: handleSuccess
						 });

}

function updateStyleSelect1(){
	fill_dependentStyle('myitem', 'myelement', '/index.cfm/cms/style/elements/itemID/');
}
function updateStyleSelect2(){
	fill_dependentStyle('myelement', 'myproperty', '/index.cfm/cms/style/properties/element/');

}


function rgb2hex(rgbString) {
	//generates the hex-digits for a colour.
var parts = rgbString
        .match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/)
;
// parts now should be ["rgb(0, 70, 255", "0", "70", "255"]

delete (parts[0]);
for (var i = 1; i <= 3; ++i) {
    parts[i] = parseInt(parts[i]).toString(16);
    if (parts[i].length == 1) parts[i] = '0' + parts[i];
}
var hexString = parts.join(''); // "0070ff"

return '#' + hexString;
} 



		function trim(str, chars) {
		    return ltrim(rtrim(str, chars), chars);
		}
		
		function ltrim(str, chars) {
		    chars = chars || "\\s";
		    return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
		}
		
		function rtrim(str, chars) {
		    chars = chars || "\\s";
		    return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
		}

		

	
	

			
		
			fileID = null;

	
	// Do something when data is received back from the server.
	function uploadResponse(response) {
		var responseArray = response.split('|');
		var str = "url("+responseArray[1]+")";
		
		changeStyle(str);
	}

	function resetColor(){
		changeStyle('transparent','backgroundColor');
	}
				
				
	function resetImage(){ 
		changeStyle('url()','backgroundImage');
	}

function saveDesign(){
$.post("/index.cfm/cms/style/save", { 
	data:style_data_JSON,
	templateid: $('#templateID').val(),
	extracss: $('#extraCSS').val(),
	designtype: $('#designtype').val()
	   
	   },
  function(data){

  		location.href=document.getElementById('lastPage').value ;
  });
	
}


/* Do the initial get of the Select boxes */
updateStyleSelect1(displaytype);






