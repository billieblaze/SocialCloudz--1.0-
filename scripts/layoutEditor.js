$("#twoColumn").hide('fast');
$("#threeColumn").hide('fast');
$("#templateContainer").hide('fast');
$("#rightContainer").hide('fast');
clearAll();
function layoutCustomWidth(){

	if ($('#pagewidth').val() == 'custom-doc'){
		$('#page_widthCustom').show('slow');
	} else { 
		$('#page_widthCustom').hide();
	}
}
function changeColumns(value){
	if (value == '1'){
	      $("#twoColumn").hide('fast');
	      $("#threeColumn").hide('fast');	     
              $("#templateContainer").hide('fast');
              $("#rightContainer").hide('fast');
	      $("#oneColumn").show('slow');
	} 

	if (value == '2'){
	      $("#oneColumn").hide('fast');
	      $("#threeColumn").hide('fast');
	      $("#rightContainer").hide('fast');
	      $("#twoColumn").show('slow');
     	      $("#templateContainer").show('slow');
	}
	
	if (value == '3'){
	      $("#oneColumn").hide('fast');
	      $("#twoColumn").hide('fast');
	      $("#threeColumn").show('slow');
     	      $("#templateContainer").show('slow');
	      $("#rightContainer").show('slow');
	}
}

function changeTemplate(value){
	if (value == '1' || value == '2' || value =='3'){
		 $(".layoutPreviewLeft").removeClass('threeQuarter');
		 $(".layoutPreviewLeft").addClass('quarter');
		 $(".layoutPreviewCenter").removeClass('quarter');
		 $(".layoutPreviewCenter").addClass('threeQuarter');
	}

	if (value == '4' || value == '5' || value =='6'){
		 $(".layoutPreviewLeft").removeClass('quarter');
		 $(".layoutPreviewLeft").addClass('threeQuarter');
		 $(".layoutPreviewCenter").removeClass('threeQuarter');
		 $(".layoutPreviewCenter").addClass('quarter');
	}
}

function changeThird(value){
	columnConfig = $("#template").attr("value");
	
	//if left-160/180px
	if(columnConfig == '1' || columnConfig == '2'){
	
		 if (value == ''){//if 1/2 - 1/2
			clearAll();
			$(".layoutPreviewLeft").addClass('third');
			$(".layoutPreviewCenter").addClass('third');
			$(".layoutPreviewRight").addClass('third');
		 }
		 else if (value == 'c'){//if 2/3 - 1/3
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarterTwoThird');
			$(".layoutPreviewRight").addClass('quarterOneThird');
		 }
		 else if (value == 'd'){ //if 1/3 - 2/3
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarterOneThird');
			$(".layoutPreviewRight").addClass('quarterTwoThird');
		 }
		 else if (value == 'e'){// if 3/4 - 1/4
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('half');
			$(".layoutPreviewRight").addClass('quarter');
	 	 }
		 else if (value == 'f'){//1/4 - 3/4
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarter');
			$(".layoutPreviewRight").addClass('half');
		 }
	}
	//if left-300px
	else if(columnConfig == '3'){
	
		 if (value == ''){//if 1/2 - 1/2
			clearAll();
			$(".layoutPreviewLeft").addClass('third');
			$(".layoutPreviewCenter").addClass('third');
			$(".layoutPreviewRight").addClass('third');
		 }
		 else if (value == 'c'){//if 2/3 - 1/3
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarterTwoThird');
			$(".layoutPreviewRight").addClass('quarterOneThird');
		 }
		 else if (value == 'd'){ //if 1/3 - 2/3
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarterOneThird');
			$(".layoutPreviewRight").addClass('quarterTwoThird');
		 }
		 else if (value == 'e'){// if 3/4 - 1/4
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarterHalf');
			$(".layoutPreviewRight").addClass('quarter');
	 	 }
		 else if (value == 'f'){//1/4 - 3/4
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarter');
			$(".layoutPreviewRight").addClass('quarterHalf');
		 }
	}

	//if right-180px
	else if(columnConfig == '4'){
		 if (value == ''){//if 1/2 - 1/2
			clearAll();
			$(".layoutPreviewLeft").addClass('third');
			$(".layoutPreviewCenter").addClass('third');
			$(".layoutPreviewRight").addClass('third');
		 }
		 else if (value == 'c'){//if 2/3 - 1/3
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarterTwoThird');
			$(".layoutPreviewRight").addClass('quarterOneThird');
		 }
		 else if (value == 'd'){ //if 1/3 - 2/3
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarterOneThird');
		 }
		 else if (value == 'e'){// if 3/4 - 1/4
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('half');
			$(".layoutPreviewRight").addClass('quarter');
	 	 }
		 else if (value == 'f'){//1/4 - 3/4
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarter');
			$(".layoutPreviewRight").addClass('half');
		 }
	}
	
	//if right-240/300px
	else if(columnConfig == '5' || columnConfig == '6'){
		 if (value == ''){//if 1/2 - 1/2
			clearAll();
			$(".layoutPreviewLeft").addClass('third');
			$(".layoutPreviewCenter").addClass('third');
			$(".layoutPreviewRight").addClass('third');
		 }
		 else if (value == 'c'){//if 2/3 - 1/3
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarterTwoThird');
			$(".layoutPreviewRight").addClass('quarterOneThird');
	
		 }
		 else if (value == 'd'){ //if 1/3 - 2/3
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarterOneThird');
			$(".layoutPreviewRight").addClass('quarterTwoThird');
		 }
		 else if (value == 'e'){// if 3/4 - 1/4
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('half');
			$(".layoutPreviewRight").addClass('quarter');
	 	 }
		 else if (value == 'f'){//1/4 - 3/4
			clearAll();
			$(".layoutPreviewLeft").addClass('quarter');
			$(".layoutPreviewCenter").addClass('quarter');
			$(".layoutPreviewRight").addClass('half');
		 }
	}
} 


function clearAll(){
		$(".layoutPreviewLeft").removeClass('quarterTwoThird');
		$(".layoutPreviewLeft").removeClass('quarterThird');
		$(".layoutPreviewLeft").removeClass('quarter');
		$(".layoutPreviewLeft").removeClass('threeQuarter');
		$(".layoutPreviewLeft").removeClass('quarterHalf');
		$(".layoutPreviewLeft").removeClass('half');
		$(".layoutPreviewLeft").removeClass('third');
		$(".layoutPreviewLeft").removeClass('twoThird');

		$(".layoutPreviewCenter").removeClass('quarterHalf');
		$(".layoutPreviewCenter").removeClass('quarterTwoThird');
		$(".layoutPreviewCenter").removeClass('quarterThird');
		$(".layoutPreviewCenter").removeClass('quarter');
		$(".layoutPreviewCenter").removeClass('threeQuarter');
		$(".layoutPreviewCenter").removeClass('half');
		$(".layoutPreviewCenter").removeClass('third');
		$(".layoutPreviewCenter").removeClass('twoThird');
		
		$(".layoutPreviewRight").removeClass('quarterHalf');
		$(".layoutPreviewRight").removeClass('quarterTwoThird');
		$(".layoutPreviewRight").removeClass('quarterThird');
		$(".layoutPreviewRight").removeClass('quarter');
		$(".layoutPreviewRight").removeClass('threeQuarter');
		$(".layoutPreviewRight").removeClass('half');
		$(".layoutPreviewRight").removeClass('third');
		$(".layoutPreviewRight").removeClass('twoThird');
}

changeColumns($('#columns').val());
changeTemplate($('#template').val());
changeThird($('#right').val());