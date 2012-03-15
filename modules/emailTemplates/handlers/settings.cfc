<!-----------------------------------------------------------------------
Author 	 :	
Date     :	10/14/2010
Description : 			
 
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setvalue('preferences', application.emailTemplates.preference.list(rc.memberID));
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
    <cffunction name="submit">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
			var i = 0;
			var datastruct = structnew();
			for(i=1; i lte listlen(rc.fieldnames); i = i + 1){
				if(listgetat(rc.fieldnames,i) neq 'fieldnames' and listgetat(rc.fieldnames,i) neq 'memberid'){
					datastruct = structnew();
					datastruct.memberID = rc.memberID;
					datastruct.preferenceid = application.emailTemplates.preference.getID(listgetat(rc.fieldnames,i));
					datastruct.value = evaluate('rc.#listgetat(rc.fieldnames,i)#');
					application.emailTemplates.preference.save(dataStruct);
				}
			}
			setNextEvent('members.account', 'tab=settings&memberid=#rc.memberid#');
		</cfscript>
    </cffunction>
</cfcomponent>