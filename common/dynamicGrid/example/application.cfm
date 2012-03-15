<Cfapplication name="jqGridExample" sessionmanagement="true"> 
<cfparam name="url.datasource" default="config">
<cfif isdefined('form.datasource')><cfset url.datasource = form.datasource></cfif>
<cfset application.dynamicGrid = createobject('component','common.dynamicGrid.model.gridService').init(datasource="#url.datasource#")>
<cfset application.utils = createObject('component', 'common.udf.utils').init()>

<!--- Example Code  --->
<Cfset application.person = createobject('component', 'ramses.model.person.personService').init(datasource='unc', gateway='/ramses/model/person/personGateway')>
<Cfset application.department = createobject('component', 'ramses.model.department.departmentService').init(datasource='unc', gateway='/ramses/model/department/departmentGateway')>
<Cfset application.awardproject = createobject('component', 'ramses.model.award.awardprojectService').init(datasource='ramses', gateway='/ramses/model/award/awardprojectGateway')>
<Cfset application.award= createobject('component', 'ramses.model.award.awardService').init(datasource='ramses', gateway='/ramses/model/award/awardGateway')>