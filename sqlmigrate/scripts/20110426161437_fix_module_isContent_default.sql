--// fix module isContent default
-- Migration SQL that makes the change goes here.

ALTER TABLE `community`.`modulesettings` CHANGE COLUMN `isContent` `isContent` BIT(1) NULL DEFAULT b'0'  ;

ALTER TABLE `statistics`.`files` ADD COLUMN `isDeleted` BIT(1) NULL default b'0' AFTER `memberID`;

update statistics.files set isdeleted = 0;
alter table members.membersaccount drop column newsletter;
alter table members.membersaccount drop column htmlMail;

ALTER TABLE `community`.`pageSettings` DROP COLUMN `ID`,
 DROP PRIMARY KEY,
 ADD PRIMARY KEY  USING BTREE(`communityID`, `settingID`, `page`);

--//@UNDO
-- SQL to undo the change goes here.



