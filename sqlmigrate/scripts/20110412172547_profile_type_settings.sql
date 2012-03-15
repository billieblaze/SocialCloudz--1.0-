--// profile type settings
-- Migration SQL that makes the change goes here.
INSERT INTO `community`.`communitysettinglist` (`name`, `defaultvalue`, `settingType`) VALUES ('profileTypePersonal', 'Personal', 'Site');

INSERT INTO `community`.`communitysettinglist` (`name`, `defaultvalue`, `settingType`) VALUES ('profileTypeBusiness', 'Business', 'Site');

INSERT INTO `community`.`communitysettinglist` (`name`, `defaultvalue`,valueList,`settingType`) VALUES ('profileTypes', '1', '1,0', 'Site');



--//@UNDO
-- SQL to undo the change goes here.



