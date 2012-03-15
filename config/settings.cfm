<cfscript>
	directory = '';
	application.directory = directory;

	application.versionnumber = 1.5;
	application.revisionNumber = 1234 ;
	 
	// App Settings 
	application.cdn.fam  = '/images/fam/';
	application.cdn.js  = '/scripts/';
	application.cdn.css  = '/css/';
	
	application.secureserver = 'http://secure.socialcloudz.com';

	application.badLanguage = 'murder,cock,pussy,fuck,cunt,cum,rape';
	application.forbiddenwords = 'support,admin,owner';
	
	application.heywatchftp = 'dev.socialcloudz.com';
	application.heyWatchKey = 'c28f03814125c310faa84b6e0023484c';
	application.privateKey = '|_socialCloudz_or_stfu_|';
	application.thumbalizerKey = '857924296191770012aa508c090f6fc0';

	application.MOSSO_USER = "billieblaze";
	application.MOSSO_KEY = "314af5d560829397773543e88570956f";

	application.ipInfoDBKey = '8ce445c43490ed51e081a3c2bdf802288b527ec773764274b89c0dcf0fc3c7da';

	application.smtpuser = 'noreply@socialcloudz.com';
	application.adminEmail = 'bill@socialcloudz.com';
	application.sendEmail = 'no';
	
	application.monthlist = 'January,February,March,April,May,June,July,August,September,October,November,December';
	application.accesslevels = '0,1,10,20,100';

	application.memcachedServer = '127.0.0.1';
	application.filestore = '/mnt/content';
	application.tempUpload = '/tmp/getUpload';
	
	application.lastInit=Now();
</cfscript>

