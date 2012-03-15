
$('.friends').modalAjax({
	url: '/index.cfm/member/friends/index/r'+Math.random(),
	title: 'Friends',
	width: 500
});

$('.showFriends').modalAjax({
	url: '/index.cfm/members/friends/index/memberid/!rel!',
	title: '!alt!',
	width: 500,
	initTabs: true,
	initCKEditor: true,
	initAjaxForm:true
});