<cfif thisTag.ExecutionMode EQ "start">
<cfparam name="attributes.memberID" default="#request.session.memberID#">
<cfparam name="attributes.loggedin" default="#request.session.login#">
<cfparam name="attributes.canRate" default="1">

<cfparam name="attributes.fkID" default="">
<cfparam name="attributes.fkType" default="">
<cfparam name="attributes.ratingvalue" default="#application.content.rating.average( attributes.fkId, attributes.fktype)#">
<cfparam name="attributes.hasRated" default="#application.content.rating.checkVote(attributes.memberid, attributes.fkId, attributes.fktype)#">



<cfoutput>
<input name="#attributes.fkType#_#attributes.fkID#"  type="radio" class="star" value="1" <cfif attributes.ratingValue eq '1'>checked</cfif>/> 
<input name="#attributes.fkType#_#attributes.fkID#"  type="radio" class="star" value="2" <cfif attributes.ratingValue eq '2'>checked</cfif>/> 
<input name="#attributes.fkType#_#attributes.fkID#"  type="radio" class="star" value="3" <cfif attributes.ratingValue eq '3'>checked</cfif>/> 
<input name="#attributes.fkType#_#attributes.fkID#"  type="radio" class="star" value="4" <cfif attributes.ratingValue eq '4'>checked</cfif>/> 
<input name="#attributes.fkType#_#attributes.fkID#"  type="radio" class="star" value="5" <cfif attributes.ratingValue eq '5'>checked</cfif>/> 



<script>

$('.star').rating({ required: true, starWidth: 18,
	callback: function(value, link){ 
		<cfoutput>
		$.get('/index.cfm/content/util/rating', {	 
			fkID:"#attributes.fkID#", 
			fkType:"#attributes.fkType#", 
			memberID: "#attributes.memberID#", 
			rating: value});
		</cfoutput>
		$('input[name$=#attributes.fkType#_#attributes.fkID#]').rating('disable');

	} 
});



<cfif attributes.hasrated eq 1 or attributes.canrate eq 0>
		$('input[name$=#attributes.fkType#_#attributes.fkID#]').rating('disable');
</cfif>


</script>
</cfoutput>
</cfif>