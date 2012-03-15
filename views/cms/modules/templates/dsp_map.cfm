<cfscript>	
	getModule = qGetModules;
	address = getModule.displayTag;
</cfscript>
<cfif address eq '' and request.session.accesslevel gte 10>
	<BR><BR>Please enter an address 
<cfelse>
	<script type="text/javascript"  src="http://maps.google.com/maps/api/js?sensor=true"></script>
	
	<script type="text/javascript">
		var geocoder;
	  	var map;
		var latlng;
	  
	  	function initialize() {
		  	geocoder = new google.maps.Geocoder();
		    latlng = new google.maps.LatLng(-34.397, 150.644);
		    	     
		    var myOptions = {
		      zoom: 11,
		      center: latlng,
		      mapTypeId: google.maps.MapTypeId.ROADMAP
		    };
		    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
		  }
	
		  function codeAddress(address) {
		    geocoder.geocode( { 'address': address}, function(results, status) {
		      if (status == google.maps.GeocoderStatus.OK) {
		        map.setCenter(results[0].geometry.location);
		        var marker = new google.maps.Marker({
		            map: map, 
		            position: results[0].geometry.location
		        });
		      } else {
		        alert("Geocode was not successful for the following reason: " + status);
		      }
		    });
		  }
		  
		  
		function getDirections(){
			var address = '';
			
			address = $('#mapaddress').val() + ',' + $('#mapcity').val()+ ','+ $('#mapstate').val()+ ',' +$('#mapzipcode').val();
			window.open ("http://maps.google.com/maps?saddr="+address+"&daddr=<cfoutput>#address#</cfoutput>&hl=en","mywindow"); 
		}
		
		$(document).ready(function(){
			initialize();	
			codeAddress('<cfoutput>#address#</cfoutput>');
		});
	</script>
	
	<Cfoutput>
		<div id="map_canvas" style="width:100%; height:#getModule.thumbsize#px; position: inherit"></div>
		<BR><BR>
			
		<a href="##" onclick="$('##directionBox').toggle();">Get Directions</a><br>
		<div style="display:none" id="directionBox">
			<form action="" method="get" target="blank">
				<table>
				
				<TR><TD>
				Address: </td><TD><input type="text" name="address" id="mapaddress">
				</TD></TR>			
				<TR><TD>
				City:</td><TD> <input type="input" name="city" id="mapcity">
				</TD></TR>			
				<TR><TD>
				State: </td><TD><input type="input" name="state" id="mapstate" size="3">
				</TD></TR>			
				<TR><TD>
				Zipcode: </td><TD><input type="input" name="zipcode" id="mapzipcode" size="5"></td>
				</tr>
				</table>
				<BR>
				<div align="center"><input type="button" onclick="getDirections();" value="Go" class="button" /></div>
				<input type="hidden" name="daddr" value="#address#" />
				<input type="hidden" name="hl" value="en" />
			</form>
		</div>
	</Cfoutput>
</cfif> 