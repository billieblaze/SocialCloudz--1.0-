<cfif ARGUMENTS.fieldInfo.isrequired>
	<cfsavecontent variable="vali"><cfoutput>
	{
		var selValue = null;
		for (i=0;i<f.#fieldName#.length;i++)
		{
			if (f.#fieldName#[i].checked) selValue = f.#fieldName#[i].value;
		}
		if( selValue == null ){
			errMsg += "\nPlease choose an option for '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'.";
		}
	}	
	</cfoutput></cfsavecontent>
</cfif>