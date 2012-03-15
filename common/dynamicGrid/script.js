var isAdmin = 0;

function modalAjax(title, url, width, height){
	
	try{
		$("#modalPopup").dialog("destroy");
		$("#modalPopup").html('');
	}  catch(err) {
		
	}
	
	
	var dialogOpts = {
			modal: false,
			bgiframe: false,
			autoOpen: true,
			draggable: true,
			autoResize: true,
			resizable: false,
			position: 'center'
	};

	$( "#modalPopup" ).bind( "dialogopen", function(event, ui) {
		
		$.get(url,function(data){
			$('#modalPopup').html(data);
		});
		
		if ( height != 'undefined'){
			$( "#modalPopup" ).dialog( "option", "height", height );
		}
		
		$( "#modalPopup" ).dialog( "option", "width", width );
		$( "#modalPopup" ).dialog( "option", "title", title );
		$( "#modalPopup" ).dialog( "option", "position", 'center' );
		return false;
	});
	
	$( "#modalPopup" ).bind( "dialogbeforeclose", function(event, ui) {
		$("#modalPopup").html(''); 
		$( "#modalPopup" ).unbind( "dialogopen");
		$( "#modalPopup" ).unbind( "dialogbeforeclose");
		$("#modalPopup").dialog("destroy");
	});
	
	$('#modalPopup').dialog(dialogOpts);
	
	return false;
}

// Close AJAX modal Window
function modalClose(){
	$( "#modalPopup" ).unbind( "dialogopen");
	$( "#modalPopup" ).unbind( "dialogbeforeclose");
	$("#modalPopup").dialog("destroy");
	$("#modalPopup").html('');
}

function finishAjax(id, response) {
$('#'+id+'Loading').hide();
$('#'+id+'Result').html(unescape(response));
$('#'+id+'Result').fadeIn();
} //finishAjax


function checkSuccess(){
	var success = document.saveupdateform.success.value;
	var success_msg = document.saveupdateform.success_msg.value;
	if(success == 0){
		alert(success_msg);
	}else if(success == 1){
		alert(success_msg);
		modalClose();
	}
}

jQuery.extend($.fn.fmatter , {
    yesNoFormat: function(cellvalue, options, rowdata) {
		var returnValue = 'No';
		if(cellvalue==0){
			returnValue = 'No';
		} else {
			returnValue = 'Yes';
		}
		return returnValue
	},
	
	dollarFormat: function(cellvalue, options, rowdata) {
		num = cellvalue.toString().replace(/\$|\,/g,'');
		if(isNaN(num))
			num = "0";
			sign = (num == (num = Math.abs(num)));
			num = Math.floor(num*100+0.50000000001);
			cents = num%100;
			num = Math.floor(num/100).toString();
		if(cents<10)
			cents = "0" + cents;
			for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
			num = num.substring(0,num.length-(4*i+3))+','+
			num.substring(num.length-(4*i+3));
		return (((sign)?'':'-') + '$' + num + '.' + cents);
	},

	personFormat: function(cellvalue, options, rowdata) {
		  link = ('<A href="##" onclick="personDetail( ' +rowdata['PID']+' )">' + cellvalue + '</a>');
		  return link;
	},

	confirm: function(cellvalue, options, rowdata) {
		return cellvalue;
	},
	
	newWindow: function(cellvalue, options, rowdata) {
			return cellvalue;
	},
		
	ajaxDialog: function(cellvalue, options, rowdata) {
		return cellvalue;
	},
	
	link: function(cellvalue, options, rowdata) {
		return cellvalue;
	}
});

function popWinDetail(url,title) {
  var winleft = (screen.width - 1000) / 2;
  var winUp = (screen.height - 700) / 2;
  var url_value = url;
  var title_value = title;
  var windowoptions = "status=yes,scrollbars=yes,width=1000,height=700,resizable=yes,left="+winleft+",top="+winUp;
  sList = window.open(url_value, title_value, windowoptions);
  sList.focus();   
}
// customize the column chooser plugin

//requiere load multiselect before grid
$.jgrid._multiselect = false;
if($.ui) {
	if ($.ui.multiselect ) {
		if($.ui.multiselect.prototype._setSelected) {
			var setSelected = $.ui.multiselect.prototype._setSelected;
		    $.ui.multiselect.prototype._setSelected = function(item,selected) {
		        var ret = setSelected.call(this,item,selected);
		        if (selected && this.selectedList) {
		            var elt = this.element;
				    this.selectedList.find('li').each(function() {
					    if ($(this).data('optionLink')) {
						    $(this).data('optionLink').remove().appendTo(elt);
					    }
				    });
		        }
		        return ret;
			};
		}

		if($.ui.multiselect.prototype._getOptionNode) {
			var getOptionNode = $.ui.multiselect.prototype._getOptionNode;
		    $.ui.multiselect.prototype._getOptionNode = function(option) {
		    	option = $(option);
		    	if (isAdmin == 1){
		    		var node = $('<li class="ui-state-default ui-element" alt="'+option.attr('alt')+'" title="'+option.text()+'"><span class="ui-icon"/>'+option.text()+'<a href="#" class="actionEdit"><span class="ui-corner-all ui-icon ui-icon-wrench"/></a><a href="#" class="action"><span class="ui-corner-all ui-icon"/></a></li>').hide();
		    	} else { 
		    		var node = $('<li class="ui-state-default ui-element" alt="'+option.attr('alt')+'" title="'+option.text()+'"><span class="ui-icon"/>'+option.text()+'<a href="#" class="action"><span class="ui-corner-all ui-icon"/></a></li>').hide();
		    	}
				node.data('optionLink', option);
				return node;
			};
		}

		if($.ui.multiselect.prototype.destroy) {
			$.ui.multiselect.prototype.destroy = function() {
				this.element.show();
				this.container.remove();
				if ($.Widget === undefined) {
					$.widget.prototype.destroy.apply(this, arguments);
				} else {
					$.Widget.prototype.destroy.apply(this, arguments);
	            }
			};
		}
		$.jgrid._multiselect = true;
	}
}

$.jgrid.extend({
    columnChooser : function(opts) {
    var self = this;
	if($("#colchooser_"+self[0].p.id).length ) { return; }
    var selector = $('<div id="colchooser_'+self[0].p.id+'" style="position:relative;overflow:hidden"><div><select multiple="multiple"></select></div></div>');
    var select = $('select', selector);

    opts = $.extend({
        "width" : 420,
        "height" : 240,
        "classname" : null,
        "done" : function(perm) { if (perm) { self.jqGrid("remapColumns", perm, true); } },
        /* msel is either the name of a ui widget class that
           extends a multiselect, or a function that supports
           creating a multiselect object (with no argument,
           or when passed an object), and destroying it (when
           passed the string "destroy"). */
        "msel" : "multiselect",
        /* "msel_opts" : {}, */

        /* dlog is either the name of a ui widget class that 
           behaves in a dialog-like way, or a function, that
           supports creating a dialog (when passed dlog_opts)
           or destroying a dialog (when passed the string
           "destroy")
           */
        "dlog" : "dialog",

        /* dlog_opts is either an option object to be passed 
           to "dlog", or (more likely) a function that creates
           the options object.
           The default produces a suitable options object for
           ui.dialog */
        "dlog_opts" : function(opts) {
            var buttons = {};
            buttons[opts.bSubmit] = function() {
                opts.apply_perm();
                opts.cleanup(false);
                
                launchManage(grid);
            };
            buttons[opts.bCancel] = function() {
                opts.cleanup(true);
            };
            return {
                "buttons": buttons,
                "close": function() {
                    opts.cleanup(true);
                },
				"modal" : false,
                "resizable": false,
                "width": opts.width+20
            };
        },
        /* Function to get the permutation array, and pass it to the
           "done" function */
        "apply_perm" : function() {
            $('option',select).each(function(i) {
                if (this.selected) {
                    self.jqGrid("showCol", colModel[this.value].name);
                } else {
                    self.jqGrid("hideCol", colModel[this.value].name);
                }
            });
            
            var perm = [];
			//fixedCols.slice(0);
            $('option[selected]',select).each(function() { perm.push(parseInt(this.value,10)); });
            $.each(perm, function() { delete colMap[colModel[parseInt(this,10)].name]; });
            $.each(colMap, function() {
				var ti = parseInt(this,10);
				perm = insert(perm,ti,ti);
			});
            if (opts.done) {
                opts.done.call(self, perm);
            }
        },
        /* Function to cleanup the dialog, and select. Also calls the
           done function with no permutation (to indicate that the
           columnChooser was aborted */
        "cleanup" : function(calldone) {
            call(opts.dlog, selector, 'destroy');
            call(opts.msel, select, 'destroy');
            selector.remove();
            if (calldone && opts.done) {
                opts.done.call(self);
            }
        },
		"msel_opts" : {}
    }, $.jgrid.col, opts || {});
	if($.ui) {
		if ($.ui.multiselect ) {
			if(opts.msel == "multiselect") {
				if(!$.jgrid._multiselect) {
					// should be in language file
					alert("Multiselect plugin loaded after jqGrid. Please load the plugin before the jqGrid!");
					return;
				}
				opts.msel_opts = $.extend($.ui.multiselect.defaults,opts.msel_opts);
			}
		}
	}
    if (opts.caption) {
        selector.attr("title", opts.caption);
    }
    if (opts.classname) {
        selector.addClass(opts.classname);
        select.addClass(opts.classname);
    }
    if (opts.width) {
        $(">div",selector).css({"width": opts.width,"margin":"0 auto"});
        select.css("width", opts.width);
    }
    if (opts.height) {
        $(">div",selector).css("height", opts.height);
        select.css("height", opts.height - 10);
    }
    var colModel = self.jqGrid("getGridParam", "colModel");
    var colNames = self.jqGrid("getGridParam", "colNames");
    var colMap = {}, fixedCols = [];

    select.empty();
    $.each(colModel, function(i) {
        colMap[this.name] = i;
        if (this.hidedlg) {
            if (!this.hidden) {
                fixedCols.push(i);
            }
            return;
        }
        select.append("<option alt='"+colModel[i].name+"' value='"+i+"' "+
                      (this.hidden?"":"selected='selected'")+">"+colNames[i]+"</option>");
    });
	function insert(perm,i,v) {
		if(i>=0){
			var a = perm.slice();
			var b = a.splice(i,Math.max(perm.length-i,i));
			if(i>perm.length) { i = perm.length; }
			a[i] = v;
			return a.concat(b);
		}
	}
    function call(fn, obj) {
        if (!fn) { return; }
        if (typeof fn == 'string') {
            if ($.fn[fn]) {
                $.fn[fn].apply(obj, $.makeArray(arguments).slice(2));
            }
        } else if ($.isFunction(fn)) {
            fn.apply(obj, $.makeArray(arguments).slice(2));
        }
    }

    var dopts = $.isFunction(opts.dlog_opts) ? opts.dlog_opts.call(self, opts) : opts.dlog_opts;
    call(opts.dlog, selector, dopts);
    var mopts = $.isFunction(opts.msel_opts) ? opts.msel_opts.call(self, opts) : opts.msel_opts;
    call(opts.msel, select, mopts);
}
});

$('.actionEdit').live('click',function(e){
	var fieldName = $(this).parent().attr('alt');
	modalAjax('Edit Field Info', '/common/dynamicGrid/views/editField.cfm?field='+fieldName+'&grid='+grid+'&pid=&view='+view+'&datasource='+ datasource);
});