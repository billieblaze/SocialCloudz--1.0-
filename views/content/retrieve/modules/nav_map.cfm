<cfoutput>
	<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
	<script type="text/javascript">
	  var geocoder;
	  var map;
	  var latlng;
	  function initialize() {
		geocoder = new google.maps.Geocoder();
		<cfif isdefined('request.session.location')>
			geocoder.geocode( { 'address': '#request.session.location.cityName#, #request.session.location.regionName#'}, function(results, status) {
	       		latlng = results[0].geometry.location;
	    })
	   	</cfif>    	
	
	    var myOptions = {
	      zoom: 11,
	      center: latlng,
	      mapTypeId: google.maps.MapTypeId.ROADMAP
	    };
	    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
	  }
	
	function codeAddress(title, address) {
	    if (geocoder) {
	      geocoder.geocode( { 'address': address}, function(results, status) {
	        if (status == google.maps.GeocoderStatus.OK) {
	          map.setCenter(results[0].geometry.location);
	          var marker = new google.maps.Marker({
	              map: map, 
	              position: results[0].geometry.location,
	              title: title
	          });
	        } else {
	          //alert("Geocode was not successful for the following reason: " + status);
	          $('div##event_map.mod').hide();
	        }
	      });
	    }
	  }
	
	$(document).ready(function(){
		initialize();
		<cfif arrayLen(request.addressArray)>
			<cfloop from="1" to="#arrayLen(request.addressArray)#" index="i">
			codeAddress('#urlEncodedFormat(request.addressArray[i][1])#','#request.addressArray[i][2]#');
			</cfloop>
		</cfif>
	});
</script>

		  <div id="map_canvas" style="width:100%; height:300px; position: inherit"></div>

</cfoutput>
