// modalAjax Plugin by bill berzinskas

(function($) {
    $.modalAjax = function(element, options) {

        var defaults = {
	    		url: '', 
	    		title: '',
	    		width: '',
				height: '',
				initFunction: function(){},
				destroyFunction: function(){},
				autoOpen: false,
				ajaxFormTarget: '',
				ajaxFormSuccess: function(){},
				ajaxFormClose: false,
				validateData: {}
        }

        var plugin = this;
        plugin.settings = {};

        var $element = $(element),  element = element; 
        var thisDialog = '';

        var init = function(el, opts) {
            plugin.settings = $.extend({}, defaults, options);
            
            // TODO: this should really be livequery, but that stopped working..
            $(element).bind('click', function(e){   show(e);   	});	
	    	if (options.autoOpen == true){ 	$(document).ready(function(e){  show(this); });	}
				
			return this;
        }

        // private methods
        var showLoading = function(){
        	$(thisDialog).parent().find('.ui-dialog-title').after('<img src="/images/progress.gif" class="loading">');
        }
        
        var hideLoading = function(){
        	$(thisDialog).parent().find('.loading').remove();
        }
        
        var updateSize = function(){
       	 if ( plugin.settings.height != 'undefined' && plugin.settings.height != ''){	
 		 	$(thisDialog).dialog( "option", "height", plugin.settings.height );
	 	 }
		
	 	 if ( plugin.settings.width != 'undefined' && plugin.settings.width != ''){	
	 		 	$(thisDialog).dialog( "option", "width", plugin.settings.width );  
	 	  } 		
		};

		var updateContent = function(content){
   		 	$(thisDialog).hide().html(content).slideDown('slow');	    
		}; 

		var show = function(el){ 
    		var el = element;
    		try{ destroy(); } catch (err){}
    		var dialogOpts = {
    					modal: false, 
    					bgiframe: false,
    					draggable: true,
    					autoOpen: true,
    					autoResize: true,
    					resizable: false,
    					hide: 'explode',
    					show: 'fade',
    					position: 'center center',
    					title: plugin.settings.title,
    					open: function(event, ui){	
    						 var url = '';
    			        	 var title = '';
    			    		 
    			        	 showLoading();

    			        	 title = plugin.settings.title.replace("!alt!", $(el).attr('alt'));
    			        	 title = title.replace("!rel!", $(el).attr('rel'));
    			        	 title = title.replace("!title!", $(el).attr('title'));
    			        	 $(thisDialog).dialog('option', 'title', title);	

    			        	 url = plugin.settings.url.replace("!rel!", $(el).attr('rel'));
    			        	 url = url.replace("!alt!", $(el).attr('alt'));
    			        	 url = url.replace("!title!", $(el).attr('title'));

    			        	 $.ajax({ 
    			        		 url: url,
    			        		 cache: false,
    			        		 success: function(data){  
    			        			
	    			        		 updateSize();
	    			        		 updateContent(data);
	    			        		 
	        			        	 $(thisDialog).dialog('option', 'position', 'center');	
	    							
	        			        	 plugin.settings.initFunction();
	        			        	 hideLoading();
    			        	 	}, 
    			        	 	error: function(jqXHR,textStatus,errorThrown){
    			        	 		var dlg = $(thisDialog).parents(".ui-dialog:first");    			        		
	 				        		
    			        	 		updateSize();
    			        	 		updateContent('<div class="error ui-corner-all"><p><span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-alert"></span><strong>Error:</strong>'+errorThrown+'</p></div>');

    			        	 		$(thisDialog).dialog('option', 'position', 'center');	
    			        	 	}
    			        	 });
    		 			},
    					beforeClose: function(event,ui){ plugin.settings.destroyFunction();	},
    					close: function(event,ui){	destroy();  }
    			};
    			
    			thisDialog =  $('<div></div>').dialog(dialogOpts).fadeIn();	

    			// load "ajax" links in the current element
    			$(thisDialog).find('a.ajax').livequery('click', function() {
    				showLoading();
    	      		$(thisDialog).load(this.href,'',function(){	hideLoading(); });
    	      		return false;
    	  		});
    			
    			// start tabs!	
    			$(thisDialog).find('.tabs').livequery( function(){		$(thisDialog).find('.tabs').tabs();			});	
    		
    			initAJAXForm(el);
				initCKEditor(el);
    		}; 

    		
    		var initAJAXForm = function(el){
				if (plugin.settings.ajaxFormTarget == ''){
					ajaxFormTarget = $(thisDialog);
				} else { 
					ajaxFormTarget = plugin.settings.ajaxFormTarget;
					ajaxFormTarget = ajaxFormTarget.replace("!alt!", $(el).attr('alt'));		
					ajaxFormTarget = ajaxFormTarget.replace("!rel!", $(el).attr('rel'));
				}

				$(thisDialog).find('.ajaxform').livequery( function(){
					var formoptions = { 
							beforeSubmit: function(arr, form, opts){
								showLoading();
								var validation = $(form).valid();    			        		//todo: integrate the validation messaging scheme
								hideLoading();
								return validation;
							},
					        success:	function(responseText, statusText, xhr, $form)  { 
								$(ajaxFormTarget).html(responseText)
								plugin.settings.ajaxFormSuccess(responseText, statusText, xhr, $form);
								hideLoading();
								if (plugin.settings.ajaxFormClose == true){  destroy(plugin.settings);		}
							}, 
					        type:      'post'
					}; 
					$(thisDialog).find('.ajaxform').ajaxForm(formoptions);
					
					var localValidateData = {	
							errorClass:'errorField',
							errorElement:'div',
							errorPlacement:function(error, element) {
								error.prependTo(element.parents('div.ctrlHolder')).append('<span class="ui-icon ui-icon-alert"></span>').addClass('ui-widget-content').addClass('ui-state-error').addClass('ui-corner-all');
							},
							highlight: function(input) {	$(input).parents('div.ctrlHolder').addClass('error');	},
							unhighlight: function(input) {	$(input).parents('div.ctrlHolder').addClass('error');	}
					};
					
					
					var validateData  = $.extend( localValidateData, plugin.settings.validateData);
					$(thisDialog).find('.ajaxform').validate( validateData );	
				});
	
    		};
    		
    		var initCKEditor = function(){ 
    			$(thisDialog).find('.ckeditor').livequery( function(){
					$(thisDialog).find('.ckeditor').ckeditor( function() { 
		 				 editor = $(thisDialog).find('.ckeditor').ckeditorGet(); 
		 		 	},{
						filebrowserBrowseUrl : '/cffm/cffm.cfm?editorType=cke&EDITOR_RESOURCE_TYPE=file',
						filebrowserImageBrowseUrl : '/cffm/cffm.cfm?editorType=cke&EDITOR_RESOURCE_TYPE=image',
						filebrowserFlashBrowseUrl : '/cffm/cffm.cfm?editorType=cke&EDITOR_RESOURCE_TYPE=flash',
						filebrowserUploadUrl : '/cffm/cffm.cfm?action=QuickUpload&editorType=cke&EDITOR_RESOURCE_TYPE=file',
						filebrowserImageUploadUrl : '/cffm/cffm.cfm?action=QuickUpload&editorType=cke&EDITOR_RESOURCE_TYPE=image',
						filebrowserFlashUploadUrl : '/cffm/cffm.cfm?action=QuickUpload&editorType=cke&EDITOR_RESOURCE_TYPE=flash'
					 });
				});    			
    		};
    		
    		var destroy = function( ){ 
            	plugin.settings.destroyFunction();
            	$(thisDialog).find('.tabs' ).tabs('destroy');
				try { 
					editor = $(thisDialog).find('textarea.ckeditor');
					if (editor.length){
						$.each( editor, function(index, value){
							var editorID = $(this).attr("id");
							$('#'+editorID).ckeditorGet().destroy();
						}); 
					}
				} catch(err) { }  
    			$(thisDialog).dialog("close");
    			$(thisDialog).html(''); 
    			$(thisDialog).dialog("destroy");
            };
    	
    	// public methods
        plugin.open = function(){  	show(this);    }
        plugin.close = function(){ 	destroy();     }
        plugin.update = function(){ 	
        	showLoading();
        	$(thisDialog).html(data);     
        	hideLoading();
        }
        
        init();
    }

    // add the plugin to the jQuery.fn object
    $.fn.modalAjax = function(options) {
    	 return $(this).each(function() {
    		 if (undefined == $(this).data('modalAjax')) {
                var plugin = new $.modalAjax(this, options);
                $(this).data( 'modalAjax', plugin );
            }
    	 });
	 }
})(jQuery);