<cfsetting showdebugoutput=false enablecfoutputonly=true>

<cfscript>
	
	myRegEx = '<th[^>]*(?=display: none)[^>]*>(.*?)(</th>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');

	myRegEx = '<th[^>]*(?=DISPLAY: none)[^>]*>(.*?)(</th>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');
	
	myRegEx = '<th[^>]*(?=DISPLAY:none)[^>]*>(.*?)(</th>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');
	
	myRegEx = '<th[^>]*(?=display:none)[^>]*>(.*?)(</th>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');
	
	myRegEx = '<TH[^>]*(?=display:none)[^>]*>(.*?)(</TH>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');
	
	myRegEx = '<TH[^>]*(?=display: none)[^>]*>(.*?)(</TH>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');

	myRegEx = '<TH[^>]*(?=DISPLAY: none)[^>]*>(.*?)(</TH>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');


	myRegEx = '<td[^>]*(?=display: none)[^>]*>(.*?)(</td>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');

	myRegEx = '<td[^>]*(?=DISPLAY: none)[^>]*>(.*?)(</td>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');
	
	myRegEx = '<td[^>]*(?=DISPLAY: none)[^>]*>(.*?)(</td>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');
	
	myRegEx = '<td[^>]*(?=DISPLAY:none)[^>]*>(.*?)(</td>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');

	myRegEx = '<td[^>]*(?=display:none)[^>]*>(.*?)(</td>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');
	
	myRegEx = '<TD[^>]*(?=display:none)[^>]*>(.*?)(</TD>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');

	myRegEx = '<TD[^>]*(?=display: none)[^>]*>(.*?)(</TD>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');

	myRegEx = '<TD[^>]*(?=DISPLAY: none)[^>]*>(.*?)(</TD>)';
	form.excelContent = reReplace(form.excelContent,myRegEx,'','all');
</cfscript>
<cfcontent type="application/unknown">
<cfheader name="Content-Disposition" value="attachment; filename=#form.gridname#.xls">
<cfoutput>#form.excelContent#</cfoutput>