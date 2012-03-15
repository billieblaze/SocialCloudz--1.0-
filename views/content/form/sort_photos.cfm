<cfscript>
	q_content = event.getvalue('q_content');
	q_childContent = event.getvalue('q_childContent'); 
</cfscript>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<script type="text/javascript" src="/scripts/script.js"></script>
	<link type="text/css" href="/css/style.css" rel="stylesheet" />	
</head>
<style type="text/css">
body {background-color: white;}
</style>
<body>
	<cfoutput> 
   	<form action="#event.buildLink('content.form.saveOrder')#" method="post" id="photoOrderForm">
		<input type="hidden" name="contentType" value="#q_childcontent.contentType#" />
	    <input type="hidden" name="parentID" value="#q_content.contentID#" />
	    <input type="hidden" name="contentID" value="#q_content.contentID#" />
	    <input type="hidden" name="myOrder" id="myOrder" value="" />
      
		<ul id="sortable">
        	<cfloop query="q_childContent">
				<li class="ui-state-default" id="p_#q_childContent.contentID#">
					#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
						image=q_childcontent.image, 
						size=125)#
				</li>
            </cfloop>
	    </ul>
        <br style="clear:both" />
        <div align="center"> <input type="submit" id="showButton" value="Save" /><input type="button" value="Cancel" onclick="history.back();" class="button" /></div>
    </form>

    </cfoutput>
	
	<style type="text/css">
	#sortable { list-style-type: none; margin: 0; padding: 0; }
	#sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 125px; height: 125px; font-size: 4em; text-align: center; }
	</style>

	<script type="text/javascript">
	$(function() {
		$("#sortable").sortable({ stop: function(){ 
        	 var out = '';
              $("#sortable li").each(function(){
                out += $(this).attr('id').split("_")[1] + " ";
    		 });
           	$('#myOrder').val(out);
        }});
		$("#sortable").disableSelection();
	});
	</script>    
</body>