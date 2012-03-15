<cfscript>
	getModule = qGetModules;
	if (getmodule.thumbSize contains 'x'){
		xpos = find('x', getmodule.thumbSize);
		width=left(getmodule.thumbsize, xpos-1);
		height=right(getmodule.thumbsize,len(getmodule.thumbsize)-xpos);
		writeoutput('<div align="center" id="adcontainer_#attributes.id#" style="height:#height#px; width:#width#px;">');
	
		for(i=1; i lte getmodule.displayrows; i=i+1){
			if(getmodule.displayTemplate eq 'horizontal'){
				writeoutput('  <div style="float:left; padding:5px" >');
			} 
			
			if(request.session.accesslevel lt 10){
			application.advertising.showBanner(width,height,'module');
			}
			if(getmodule.displayTemplate eq 'horizontal'){		
				writeoutput('</div>');
			}
		}
	}
</cfscript>
</div>
<cfif request.session.accesslevel gte 10>
	<cfoutput>
	<script language="javascript">
	$('##adunit_#attributes.id#').ready(function () {
		if($('##adunit_#attributes.id# ins ins').find()){
			$('##adunit_#attributes.id# ins ins').appendTo('##adcontainer_#attributes.id#');
		} else { 
			$('##adunit_#attributes.id# ').appendTo('##adcontainer_#attributes.id#');
		}
	});
	</script>
	</cfoutput>
</cfif>