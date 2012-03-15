<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/5/2011
Description : 			
 imageManager interceptor

if its imageManager, STOP ALL OTHER EVENTS..   
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.Interceptor" 
			 output="false">
  
   
    <cffunction name="configure" access="public" returntype="void" output="false" hint="Configure your interceptor">
		
	</cffunction>
    
	<cffunction name="preProcess" access="public" output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		
		<cfif event.getCurrentEvent() contains 'imageManager'>
			<Cfreturn true>
		</cfif>
	</cffunction>
	
	<cffunction name="preEvent" access="public"  output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		
		<cfif event.getCurrentEvent() contains 'imageManager'>
			<Cfreturn true>
		</cfif>
	</cffunction>
	
	<cffunction name="preLayout" access="public"  output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		<cfif event.getCurrentEvent() contains 'imageManager'>
			<Cfreturn true>
		</cfif>
	</cffunction>

	<cffunction name="postProcess" access="public"  output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		<cfif event.getCurrentEvent() contains 'imageManager'>
			<Cfreturn true>
		</cfif>
	</cffunction>
	
	<cffunction name="postViewRender" access="public"  output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		<cfif event.getCurrentEvent() contains 'imageManager'>
			<Cfreturn true>
		</cfif>
	</cffunction>
</cfcomponent>