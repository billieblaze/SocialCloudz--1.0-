--// add facebook api key
-- Migration SQL that makes the change goes here.


INSERT INTO `community`.`communitysettinglist` (`name`, `settingType`, `sortOrder`, `description`) VALUES ('facebookAPI', 'Site', '4', 'Facebook APIKey');


--//@UNDO
-- SQL to undo the change goes here.


delete from community.communitysettinglist where name = 'facebookAPI';
