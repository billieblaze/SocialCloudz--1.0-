<Cfset attributes.location = ''>
<cfoutput>

	<cfif (attributes.city eq '' and attributes.state eq '')>
   		<cfset attributes.location = ''>
	<cfelseif (attributes.city neq '' and attributes.state eq '')>
		<cfset attributes.location = '#attributes.city#'>
	<cfelse>
		<cfset attributes.location = '#attributes.city#, #attributes.state#'>
	</cfif>

	<input id="locationSuggest" type="text" name="location" value="#attributes.location#" style="width:200px;">
	<input type="hidden" name="city" id="city" value="#attributes.city#">
    <input type="hidden" name="state" id="state" value="#attributes.state#">
	<input type="hidden" name="country" id="country" value="#attributes.country#">
    <input type="hidden" name="latitude" id="latitude" value="#attributes.latitude#">
    <input type="hidden" name="longitude" id="longitude" value="#attributes.longitude#">

</cfoutput>
 	<script>
	
		$( "#locationSuggest" ).autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: "http://ws.geonames.org/searchJSON",
					dataType: "jsonp",
					data: {
						featureClass: "P",
						style: "full",
						maxRows: 12,
						name_startsWith: request.term
					},
					success: function( data ) {
						response( $.map( data.geonames, function( item ) {
							return {
								label: item.name + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName,
								value: item.name,
								latitude: item.lat,
								longitude: item.lng, 
								city: item.name, 
								state: item.adminCode1, 
								country: item.countryName
							}
						}));
					}
				});
			},
			minLength: 2,
			select: function( event, ui ) {
				$('input#city').val(ui.item.city);
				$('input#state').val(ui.item.state);
				$('input#country').val(ui.item.country);
				$('input#latitude').val(ui.item.latitude);
				$('input#longitude').val(ui.item.longitude);
				$('input#locationSuggest').val(ui.item.label);
			},
			open: function() {
				$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
			},
			close: function() {
				$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
			}
		});
	</script>
