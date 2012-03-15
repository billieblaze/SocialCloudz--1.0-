
	<cfset ATTRIBUTES.relStylePath = "/dccom/components/" & ATTRIBUTES.component & "/styles/default/">

<cfparam name="REQUEST.relStylePath" default="#ATTRIBUTES.relStylePath#">
<cfsavecontent variable="REQUEST.cCSS"><cfoutput><link rel="stylesheet" type="text/css" href="#REQUEST.relStylePath#style.css"></cfoutput></cfsavecontent>
<cfhtmlhead text="#REQUEST.cCSS#">

