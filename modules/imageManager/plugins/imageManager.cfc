<cfcomponent extends="coldbox.system.plugin">

  <!------------------------------------------- CONSTRUCTOR ------------------------------------------->

  <cffunction name="init" access="public" output="false">
        <cfargument name="controller" type="any" required="true">
        <cfset super.Init(arguments.controller) />
        <cfset setpluginName("My Security Plugin")>
        <cfset setpluginVersion("1.0")>
        <cfset setpluginDescription("A Very cool security plugin.")>

        <!--- My Custom Constructor code goes here --->

        <!--- Return instance --->
        <cfreturn this>
  </cffunction>

  <cffunction name="displayImage" access="public" output="false">
		<cfargument name="image">
		<cfargument name="link">
		<cfargument name="size" default="150">
		<cfargument name="title" defualt="">
		<cfargument name="subtitle" default="">
		<cfargument name="showTools" default="0">
		<cfargument name="showMosaic" default="0">
		<cfargument name="align" default="left">
		<cfargument name="imgClass" default="">
		<cfargument name="containerClass" default="">
		<cfargument name="showColorbox" default="0">
		<cfargument name="colorboxRel" default="general">
		
		<cfargument name="id" default="#randRange(0,100000)#">
		
		<cfset var results = ''>

		<cfif arguments.size eq '100%'>
			<cfset arguments.thumbnail = arguments.image>
		<cfelse>
			<cfif arguments.image contains 'http:'>
				<cfset filenamenoExt = listLast(arguments.image,'/')>
				<cfset filenameNoExt = listFirst(filenameNoExt, '.')>
				<cfset fileExt = listLast(arguments.image,'.')>
				<cfset fileurl = replace(arguments.image, '#filenameNoExt#.#fileExt#', '')>
				<cfset arguments.thumbnail = '/cache/#fileurl##fileNameNoExt#.resize_to.#arguments.size#x#arguments.size#.#fileExt#'>
			<cfelse>
				<cfset filenameNoExt = listFirst(arguments.image,'.')>
				<cfset fileExt = listLast(arguments.image,'.')>
				<cfset arguments.thumbnail = '/cache/#fileNameNoExt#.resize_to.#arguments.size#x#arguments.size#.#fileExt#'>
			</cfif>
		</cfif>
		
		<cfif arguments.showmosaic eq 1 and arguments.size lt 60>
			<cfset arguments.imgClass = arguments.imgClass & ' imageManagerToolTip'>
		</cfif>
		
		<cfif arguments.size neq 'none'>
			<cfsavecontent variable="results">
				<cfinclude template="displayImage.cfm">			
			</cfsavecontent>
		</cfif>
				
        <cfreturn results>
  </cffunction>
</cfcomponent>