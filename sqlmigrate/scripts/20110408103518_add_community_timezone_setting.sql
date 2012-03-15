--// add community timezone setting
-- Migration SQL that makes the change goes here.
INSERT INTO `community`.`communitysettinglist` (`name`, `valuelist`, `defaultvalue`, `settingType`, `description`) VALUES ('timezone', 'America/New_York', 'America/New_York', 'Site', 'Timezone');




--//@UNDO
-- SQL to undo the change goes here.



