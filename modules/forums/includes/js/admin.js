$('.section').modalAjax({
	title: '!alt! Forum Section',
	url: '/index.cfm/forums:section?id=!rel!',
	initAjaxForm: true,
	ajaxFormSuccess: function(){ 
		window.location.reload();
	},
	ajaxFormClose: true
});

$('.forum').modalAjax({
	title: '!alt! Forum',
	url: '/index.cfm/forums:forum?id=!rel!',
	initAjaxForm: true,
	ajaxFormSuccess: function(){ 
		window.location.reload();
	},
	ajaxFormClose: true
});

$('.Moderator').modalAjax({
	title: 'Manage Moderators',
	url: '/index.cfm/forums:moderator?id=!rel!',
	initAjaxForm: true,
	ajaxFormSuccess: function(){ 
		window.location.reload();
	},
	ajaxFormClose: true
});
