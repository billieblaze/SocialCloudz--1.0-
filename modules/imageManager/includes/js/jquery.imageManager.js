
$(document).ready(function() {
 
    //Select all anchor tag with rel set to tooltip
    $('.imageManagerToolTip').mouseover(function(e) {
        var tip = $(this).attr('title');   
        $(this).attr('title','');
        $('body').append('<div id="imgtooltip" class="ui-widget ui-corner-all"><div class="ui-widget-content">' + tip + '</div></div>');    
        $('#imgtooltip').css('top', e.pageY - this.offsetTop+ 10 );
        $('#imgtooltip').css('left', e.pageX - this.offsetLeft + 20 );
        $('#imgtooltip').fadeIn('500');
    }).mousemove(function(e) {
        $('#imgtooltip').css('top', e.pageY+ 10 );
        $('#imgtooltip').css('left', e.pageX + 20 );
    }).mouseout(function() {
        $(this).attr('title',$('#imgtooltip .ui-widget-content').html());
        $('div#imgtooltip').remove();
    });
    
});
				    
(function($) {
	var resizeDiv = '';
	var watermarkDiv = '';
	var cropDiv = '';
	
	var methods = {
		init: function( options ){ 
			var defaults = {  };
			var opts = $.extend(defaults, options);
			var el = this;
			$(this).find('.imgtoolbar').hide();
			$('#'+opts.id).error(	function() {   
				$(this).attr('src', '/modules/imageManager/includes/nothumbnail_icon.png'); 
			});
			
			if (opts.showMosaic == 1){  
				if (opts.width > 60) { 	$(this).find('.mosaic-block').mosaic(); }	
			} 
			if (opts.showColorbox == 1){
				$("#imgLink_" + opts.id).colorbox({ rel: opts.colorboxRel,  maxWidth: '95%', maxHeight: '95%'});
			}
			
			methods.changeImageSize(this,opts);
			
			if (opts.showTools == 1){
				methods.bindToolbar(this);
				methods.bindRotate(this, opts);
				methods.bindThumbnail(this, opts);	
				methods.bindWatermark(this, opts);	
				methods.bindCrop(this, opts);
			}
		},
		changeImageSize: function(element, opts){
			var containerWidth = eval(opts.width);	
			$(element).width(containerWidth);
			$(element).find('.mosaic-block').width(opts.width);
			$(element).find('.mosaic-block').height(opts.height);
			$(element).find('img').height(opts.height);
			$(element).find('img').width(opts.width);
		},
		bindToolbar: function(element){
			$(element).bind('mouseover', function(){   $(element).find('.imgtoolbar').show();	});
			$(element).bind('mouseout', function(){    $(element).find('.imgtoolbar').hide();	});
		}, 
		unbindToolbar: function(element){
			$(element).unbind('mouseover');
			$(element).unbind('mouseout');
			$(element).find('.imgtoolbar').show();			
		},
		bindRotate: function(element, opts){
			$(element).find('.rotateLeft').click(function(){
				$(element).find('img').attr('src', "/index.cfm/imageManager/rotate?image="+opts.image+"&angle=270");
			});
			$(element).find('.rotateRight').click(function(){
				$(element).find('img').attr('src', "/index.cfm/imageManager/rotate?image="+opts.image+"&angle=90");
			});
		},
		bindThumbnail: function(element, opts){
			$(element).find('.resize').click(function(){
				resizeDiv = $('<div align="center">Height: <input type="text" class="height" name="height" size="3"><br>Width: <input type="text" class="width" name="width" size="3"><br><input type="checkbox" class="constrain"> Constrain Proportions</div>');
				$(resizeDiv).dialog( { 
						title: 'Resize Image', 
						draggable: false,
						resizable: false, 
						width: 380,
						autoOpen: true,
						open: function(){ methods.unbindToolbar(element);	},
						close: function(){ 	methods.bindToolbar(element);	},
						buttons: {
									"OK":function(){
										opts.height = $(this).find('.height').val();
										opts.width = $(this).find('.width').val();
										
										constrain = 0; 
										if ($(this).find('.constrain:checked').val()){
											constrain = 1;
										}
										
										myURL = "/index.cfm/imageManager/resize?image="+opts.image+"&height="+opts.height+"&width="+opts.width+"&constrain="+constrain;
										$.get(myURL, function(){
												mySrc = $(element).find('img').attr('src');
												$(element).find('img').attr('src', mySrc);
										});
										
										
										//methods.changeImageSize(element,opts);
										$(this).dialog('close');
									}
								 }
				});
			});
		},
		bindWatermark: function(element,opts){
			$(element).find('.watermark').click(function(){
				watermarkDiv = '<div>Watermark: <input type="text" name="watermarkImage"><br>Orientation: <select class="watermarkOrientation"><option value="topLeft">Top Left</option><option value="topRight">Top Right</option><option value="bottomLeft">Bottom Left</option><option value="bottomRight">Bottom Right</option></select></div>';
				$(watermarkDiv).dialog( { 
					title: 'Watermark Image', 
					resizable: false, 
					draggable: false,
					width: 380,
					autoOpen: true,
					open: function(){ 	methods.unbindToolbar(element);		},
					close: function(){	methods.bindToolbar(element);		},
					buttons: {
								"OK":function(){
										var watermarkImage = $(this).find('input').val();
										var watermarkOrientation = $(this).find('.watermarkOrientation').val();
										
										myURL = "/index.cfm/imageManager/watermark?image="+opts.image+"&watermark="+watermarkImage+"&position="+watermarkOrientation;
										$.get(myURL, function(){
											mySrc = $(element).find('img').attr('src');
											$(element).find('img').attr('src', mySrc);
										});
									
										$(this).dialog('close');
								}
							 }
				});				
			});
		},
		bindCrop: function(element,opts){
			var jcrop_api;
			var cropContainer = '';
			
			$(element).find('.crop').click(function(e) {
				cropContainer  = '<div><label>X1 <input type="text" size="4" name="x1" class="ui-state-disabled" readonly /></label><label>Y1 <input type="text" size="4" name="y1" class="ui-state-disabled" readonly/></label><label>W <input type="text" size="4" name="w"  class="ui-state-disabled" readonly/></label><label>H <input type="text" size="4" name="h"  class="ui-state-disabled"/></label></div>';
				    
				$(cropContainer).dialog( { 
					title: 'Crop Image', 
					resizable: false, 
					draggable: false,
					width: 450,
					autoOpen: true,
					open: function(){
							var thisDialog = this;
							
							jcrop_api = $.Jcrop($(element).find('img'), {
						        onChange:   function (c){
							      $(thisDialog).find('input[name=x1]').val(c.x);
							      $(thisDialog).find('input[name=y1]').val(c.y);
							      $(thisDialog).find('input[name=w]').val(c.w);
							      $(thisDialog).find('input[name=h]').val(c.h);
							    }
						      });
							methods.unbindToolbar(element);
							$(element).find('.mosaic-block').unbind('mouseenter mouseleave');
					},
					close: function(){
							methods.bindToolbar(element);
							jcrop_api.destroy();	
							if (opts.showMosaic == 1){  $(this).find('.mosaic-block').mosaic();	} 
					},	
					buttons: {
							"OK":function(){
								opts.height = $(this).find('input[name=h]').val();
								opts.width = $(this).find('input[name=w]').val();
								x = $(this).find('input[name=x1]').val();
								y = $(this).find('input[name=y1]').val();
								
								myURL = "/index.cfm/imageManager/crop?image="+opts.image+"&height="+opts.height+"&width="+opts.width+'&x='+x+'&y='+y;	
								$.get(myURL, function(){
									$(element).find('img').attr('src', myURL);
								});
							
								//methods.changeImageSize(element,opts);
								$(this).dialog('close');
							}, 
							"Clear": function(){
								 jcrop_api.release();
								 $(this).find('div input').val('');
							}
						 }
				});
			});
		}	
	};
	
	$.fn.imageManager = function( method ) {
		 // Method calling logic
	    if ( methods[method] ) {
	      return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
	    } else if ( typeof method === 'object' || ! method ) {
	      return methods.init.apply( this, arguments );
	    } else {
	      $.error( 'Method ' +  method + ' does not exist on jQuery.tooltip' );
	    }    
	};
})(jQuery);