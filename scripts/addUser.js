 
   	$('#usernameLoading').hide();

  


	$('#username').keyup(function(){
	  $('#usernameLoading').show();
      $.post("/index.cfm?event=member.signup.checkUsername", {
        username: $('#username').val()
      }, function(response){
        $('#usernameResult').fadeOut();
        setTimeout("finishAjax('username', '"+escape(response)+"')", 400);
      });
    	return false;
	});
