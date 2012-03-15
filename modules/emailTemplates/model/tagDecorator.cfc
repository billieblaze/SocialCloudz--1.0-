<Cfcomponent>
	<Cffunction name="init">
		<cfargument name="data" default="">
		<cfset this.data = structNew()>
		<cfif not isSimpleValue(data)>
			<cfset this.data = arguments.data>
		</cfif>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getTags">
		<Cfargument name="content">
		
		<cfscript>
		var result = this.data;
		
		// APPLICATION
		if(isdefined('request.returnURL')){
			result.returnURL=request.returnURL;
		}

		// user
		result.session = request.session;
		result.nowDate = dateformat(now(), 'mm-dd-yyyy');
		result.nowTime = timeformat(now(), 'hh:mm:ss');
		
		result.community  = request.community;
		
		return result;
		</cfscript>
	</cffunction>
</cfcomponent>