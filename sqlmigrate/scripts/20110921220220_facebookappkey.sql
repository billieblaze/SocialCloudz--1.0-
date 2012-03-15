--// facebookappkey
-- Migration SQL that makes the change goes here.

insert into community.communitysettinglist
(`name`,valuelist,defaultvalue,settingType,sortOrder,description)
values
( 'facebookAppSecret', NULL, NULL, 'Site', '5', 'Facebook App Secret'),
( 'facebookLogin', '', '0', 'Site', '6', NULL);


--//@UNDO
-- SQL to undo the change goes here.


