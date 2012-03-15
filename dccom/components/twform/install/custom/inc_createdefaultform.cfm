<!--- Given an interfaceId, will setup a blank form --->
<cfinclude template="inc_getDefaultDateString.cfm">
<cfquery name="" datasource="#ATTRIBUTES.datasource#">
INSERT INTO dccom_twform_forms( instanceId, formTitle,  formCreationDate, formCreatedByUserId, formLastUpdatedDate, formLastUpdatedByUserId )
VALUES ( #instanceId#, 'Untitled Form',  #REQUEST.defaultDateString#, #request.session.memberID#, #REQUEST.defaultDateString#, #request.session.memberID# );
</cfquery>