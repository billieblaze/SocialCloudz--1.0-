<Cfsetting showdebugoutput="false">
<cfsetting enablecfoutputonly="true">
<Cfhttp url="#url.shoutcastfeed#/7" userAgent = "Mozilla/5.0 (X11; Linux x86_64; rv:2.0b4) Gecko/20100818 Firefox/4.0b4"  >
<Cfset rVal = cfhttp.filecontent>
<Cfset rVal = replace(rVal, '<HTML><meta http-equiv="Pragma" content="no-cache"></head><body>', '')>
<Cfset rVal = replace(rVal, '</body></html>', '')>
<Cfoutput>#rval#</Cfoutput>  