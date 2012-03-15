
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

// todo: are we using both confirms or what? 
function confirmDelete(message,url){
	if (confirm(message)){
		location.href=url;
	} else { 
		return false;
	}
}

function ajaxConfirmDelete(msg, url, div){
	if (confirm(msg)){
		$(div).fadeOut(1000, function () {
	         $(div).remove();
		   $.get(url);
	     });
	} else { 
		return false;
	}
}

	// apply table striping to a table with a class of "oddEven"
	function stripeTable(){
		$('table.oddEven tbody tr:odd').addClass('odd');		
		$('table.oddEven tbody tr:even').addClass('even');		
		
	}
	
	function unStripeTable(){
		$('table.oddEven tbody tr:odd').removeClass('odd');		
		$('table.oddEven tbody tr:even').removeClass('even');		
		
	}

// FORM WIZARD 
var twFormWizard = {
	LaunchFormWizard:function( instanceId, cmsfile, w, h, bResize, sHandle, bScrollbars, ref )
	{
		if( w == null ) w = 800;
		if( h == null ) h = 600;
		if( bResize == null ) bResize = false;
		if( bScrollbars == null ) bScrollbars = 0;
		if( sHandle == null ) sHandle = "CMSPg" + cmsfile.replace(/(.cfm)/gi,"") + instanceId;
		
		var sLeft=(screen.width-w)/2, sTop=(screen.height-h)/2;
		var params = "height=" + h + ", width=" + w + ", top=" + sTop + ", left=" + sLeft + ", scrollbars=" + (bScrollbars?"yes":"no")+ ", resizable=" + (bResize?"yes":"no");
		var url = "/dccom/components/twform/pageLoader.cfm?instanceId="+instanceId+"&ref="+ref+"&cmsfile="+cmsfile;
		cmsfile = cmsfile.replace(/\./, "_" );
		var z = window.open( url, cmsfile, params );
		z.focus();		
	}

};


/* nav menu */
   	var timeout         = 500;
	var closetimer		= 0;
	var ddmenuitem      = 0;
	
	function jsddm_open()
	{	jsddm_canceltimer();
		jsddm_close();
		ddmenuitem = $(this).find('ul').eq(0).css('visibility', 'visible');}
	
	function jsddm_close()
	{	if(ddmenuitem) ddmenuitem.css('visibility', 'hidden');}
	
	function jsddm_timer()
	{	closetimer = window.setTimeout(jsddm_close, timeout);}
	
	function jsddm_canceltimer()
	{	if(closetimer)
		{	window.clearTimeout(closetimer);
			closetimer = null;}}
	



$(document).ready(function() {
   /* nav menu */
   
		$('div#menuBar > li').bind('mouseover', jsddm_open);
		$('div#menuBar > li').bind('mouseout',  jsddm_timer);
	
	document.onclick = jsddm_close;
	
		/* MEGA menu */
      function addMega(){
        $(this).addClass("hovering");
        }

      function removeMega(){
        $(this).removeClass("hovering");
        }
	   var megaConfig = {
         interval: 250,
         sensitivity: 4,
         over: addMega,
         timeout: 500,
         out: removeMega
    };

	 $("li.mega").hoverIntent(megaConfig);
	 
	 
	 /* Advanced Options Accordion */
	$(".toggle_container").hide();

	$("h2.trigger").toggle(function(){
		$(this).addClass("active"); 
		}, function () {
		$(this).removeClass("active");
	});
	
	$("h2.trigger").click(function(){
		$(this).next(".toggle_container").slideToggle("slow,");
	});


	// tooltips
		
	$('.tTip').betterTooltip({speed: 150, delay: 300});
	$('.contentTT').betterTooltip({speed: 150, delay: 100});
			
	$("#tabs").tabs();
});
   function beforeUnloadAdd(){}
   function afterShowAdd(){}
function showMyDialog(){}
