function viewFull( submissionId )
{
	Element.hide("listTable");
	$("detailView").innerHTML = "<div id='ajaxLoader'>loading</div>";
	Element.show("detailView");
	var url = document.location.href + "&view=submission&submissionId="+submissionId;
	new Ajax.Request( url, {asynchronous:true, evalScripts:false, onSuccess:OnViewFull_onSuccess, onFailure:errFunc});
}
function OnViewFull_onSuccess(t)
{
	//z = parseJSON( t.responseText );
	$("detailView").innerHTML = t.responseText;
}
function returnToList()
{
	Element.show("listTable");
	Element.hide("detailView");
}
function delSubmission( submissionId )
{
	if( !confirm( "Delete?" ) ) return;
	$("detailView").innerHTML = "<div id='ajaxLoader'>deleting</div>";
	if( $( "s"+submissionId ) ) Element.remove( "s"+submissionId );
	var url = document.location.href + "&action=deletesubmission&submissionId="+submissionId;
	new Ajax.Request( url, {asynchronous:true, evalScripts:false, onSuccess:OnDelSubmission_onSuccess, onFailure:errFunc});
}
function OnDelSubmission_onSuccess()
{
	returnToList();
}

function errFunc(t)
{
	var win = window.open("", "win", "width=1024,height=700,resizable=yes,scrollbars=yes,status=no"); // a window object
	win.document.open("text/html", "replace");
	win.document.write( "<html><body style='margin:0'><div style='border-bottom:1px solid #222;background:#666;padding:10px;'><h1 style='color:#FFF;margin:0;padding:0;'>Teamwork Ajax Error</h1></div><div style='padding:10px;'>"+t.responseText.replace(/^\s+|\s+$/, '') + "</div></body></html>" );
	win.document.close();
}
function parseJSON( json ){
	var o = eval('(' + json + ')');
	if( o.redirectURL )
	{
		document.location = o.redirectURL;
		return;
	}
	return o;
}