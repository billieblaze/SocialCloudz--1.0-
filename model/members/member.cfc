<cfcomponent persistent='true' output="false"	accessors="true" hint="" extends="/model/baseBean">
   	<cfproperty name="memberID" generator="increment" default="0"/>
 	<cfproperty name="username"  default=""/>
 	<cfproperty name="usernameOriginal"  default=""/>
  	<cfproperty name="email"  default=""/>
	<cfproperty name="password"  default=""/>
   	<cfproperty name="firstName"  default=""/>
	<cfproperty name="lastName"  default=""/>
    <cfproperty name="city"  default=""/>
    <cfproperty name="state"  default=""/>
    <cfproperty name="country"  default=""/>
	<cfproperty name="latitude"	type="string" default=""/>
	<cfproperty name="longitude"  default=""/>
    <cfproperty name="gender"  default="0"/>
	<cfproperty name="birthMonth"  default="01"/>
	<cfproperty name="birthDay"  default="01"/>
	<cfproperty name="birthYear"  default="1970"/>
	<cfproperty name="cellPhone"  default=""/>
	<cfproperty name="cellProvider"	type="string" default=""/>
    <cfproperty name="signupComplete" default="0"/>
    <cfproperty name="globalAdmin" type="bit" default="0"/>
	<cfproperty name="heardabout" 	 default=""/>
	<cfproperty name="identity"	type="string" default=""/>
	<cfproperty name="mailBounce" type="integer" default="0"/>
	<cfproperty name="key"  default="0"/>
	<cfproperty name="keyHash"  default="0"/>
	<cfproperty name="profileType"  default="0"/>
	<cfproperty name="invisible"  default="0"/>
			
	<cffunction name="getBirthDate">
		<cfreturn createDate(getBirthYear(),getBirthMonth(),getBirthDay())>
	</cffunction>

	<cffunction name="validateSpecialChars">
		<cfscript>
			if(REFind ("[[:punct:][:cntrl:][:space:]]", getUsername()) gt 0	){ 
				return false;
			}
			return true;
		</cfscript>
	</cffunction>
	
	<cffunction name="validateBadLanguage">
		<Cfargument name="username">
		<cfscript>
			if(application.processtext.badLanguage(getUsername()) neq 'Clean'	){ 
				return false;
			}
			return true;
		</cfscript>
	</cffunction>
	
	<cffunction name="validateForbiddenWords">
		<Cfargument name="username">
		<cfscript>
			if( application.processtext.forbiddenWords(getUsername()) neq 'Clean'	){ 
				return false;
			}
			return true;
		</cfscript>
	</cffunction>
	
	<cffunction name="validateUsernameExists">
		<Cfargument name="username">
		<cfscript>
			var checkUser = '';
				
			checkuser = application.members.gateway.get(username=getUsername(), communityID = '');
			if(checkuser.recordcount eq 1){
				return false;					
			}
			return true;
		</cfscript>
	</cffunction>

	<cffunction name="validateEmailExists">
		<Cfargument name="username">
		<cfscript>
			var checkUser = '';
				
			checkuser = application.members.gateway.get(email=this.getEmail(), communityID = '');
			if(checkuser.recordcount eq 1){
				return false;					
			}
			return true;
		</cfscript>
	</cffunction>
	
	<cffunction name="validateChangeUsername">
		<cfscript>
			if (getUsername() neq getUsernameOriginal() and application.members.gateway.get(username=getUsername(), communityID = '').recordcount neq 0 ){
				return false;
			}
			return true;
		</cfscript>
	</cffunction>
</cfcomponent>
