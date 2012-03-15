<!------------------------------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------------------------
 
Application:	Any
Project:		Any
Filename:		exec.cfm
Programmers:	Peter Coppinger <peter@digital-crew.com>
				
Purpose:		Includes the dcComponent for execution or the sets-up the parameters of the attribute

CHANGE LOG:
09 May 2002		TOP	Document Created
01 Dec 2005		TOP	Fixed definePaths being included twice per dcCom component request

 ----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------>



<!--- If this flag is set, is is an instruction from the worker file tag to SKIP processing of this tags INNER data --->
<cfif isdefined("dcCom_SkipTagContent")>
	<cfsetting enablecfoutputonly="No">
	<cfexit method="EXITTAG">
</cfif>
