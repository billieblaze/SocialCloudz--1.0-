$('.showLogin').modalAjax({
	url: '/index.cfm/member/auth/index/r/'+Math.random(),
	title: 'Login',
	width: 600,
	initAjaxForm: true,
	initFunction: function(){
		$('#loginDetail').validate();
		$('#email').focus();
	 },
	 ajaxFormTarget: 'void',
	 ajaxFormSuccess: function(data){
		 if (data.status){ 
			 location.href = data.url;
		 } else { 
			$('#loginError').html(data.message);
		 }
	 }
});

$('.forgotPassword').modalAjax({
	url: '/index.cfm/member/forgotpw/index/r/'+Math.random(),
	title: 'Forgot Password',
	width: 600,
	initAjaxForm: true
});

$('.showFriends').modalAjax({
	url: '/index.cfm/members/friends/index/memberid/!rel!',
	title: '!alt!',
	width: 500,
	initTabs: true,
	initCKEditor: true,
	initAjaxForm:true
});