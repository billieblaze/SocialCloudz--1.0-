<cfparam name="rc.tags" default="">
<cfscript>
	labels_1 =  application.content.gateway.getrelated(
												rc.contentType,
												request.page.keywords,
												event.getvalue('categoryid',''));
	</cfscript>
    
<cfquery dbtype="query" name="labels">
        select * from labels_1
        order by newID
        </cfquery>


<style type="text/css">
.xmpl li a {	text-decoration: none !important; padding: 2px 3px ;}
.xmpl li a:hover {text-decoration: underline !important;}
.xmpl li {	z-index: 0 !important; float:left;}
.xmpl li:hover {	z-index: 100 !important;}
ul.xmpl, ol.xmpl {	overflow:visible; width:99%}
</style>
<cfoutput>

      <ul id="tagcloud"  class="xmpl">
        <cfloop query="Labels">
          <li value="#cnt * 10#" title="#labels.label# "><a href="/index.cfm/content/#rc.contenttype#?tag=#label#" title="view related tags">#Labels.label#</a></li>
        </cfloop>
      </ul>
<br style="clear:both">
  
  </cfoutput>

  <script>
$(document).ready(function(){
  var tagcloud_color = $(".listRight div.mod div.bd a").css("color");

$("#tagcloud").tagcloud({type:'list', colormin: tagcloud_color, colormax: tagcloud_color});
});
</script>
