--// add profile types
-- Migration SQL that makes the change goes here.

USE `members`;

    CREATE  TABLE `members`.`profileTypes` (    
      `typeID` INT NOT NULL AUTO_INCREMENT ,
      `communityID` INT NULL ,
      `name` VARCHAR(45) NULL ,
    PRIMARY KEY (`typeID`) );
    INSERT INTO `members`.`profileTypes` ( `communityID`, `name`) VALUES ( '0', 'Global');
    ALTER TABLE `members`.`profileSections` ADD COLUMN `typeID` INT(10) NULL DEFAULT 0  AFTER `sortorder` ;
    ALTER TABLE `members`.`membersaccount` ADD COLUMN `profileType` INT(10) NULL DEFAULT 1  AFTER `featured` ;
 alter table community.modulesettings add column displayRecordCount bit(1) default b'1';
 alter table community.modulesettings add column displayProfileType int(10) default 0;
 
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`) VALUES ('canViewProfileType', 'Anyone,Consumer,Business', 'Anyone', 'select', '0', 'any', 'Which Profile Types can View');

ALTER TABLE `community`.`menu` ADD COLUMN `visibleToProfileType` INT NULL  AFTER `cms` , CHANGE COLUMN `visibleTo` `visibleTo` INT(10) NULL DEFAULT NULL  ;
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`) VALUES ('canPostProfileType', 'Anyone,Consumer,Business', 'Anyone', 'select', '0', 'content', 'Which Profile Types can Post');
UPDATE `community`.`pageSettingList` SET `sortOrder`='1' WHERE `ID`='291';

UPDATE `community`.`pageSettingList` SET `sortOrder`='2' WHERE `ID`='295';

UPDATE `community`.`pageSettingList` SET `sortOrder`='4' WHERE `ID`='292';

UPDATE `community`.`pageSettingList` SET `sortOrder`='3' WHERE `ID`='294';

UPDATE `community`.`pageSettingList` SET `sortOrder`='4' WHERE `ID`='298';

UPDATE `community`.`pageSettingList` SET `sortOrder`='5' WHERE `ID`='296';

UPDATE `community`.`pageSettingList` SET `sortOrder`='7' WHERE `ID`='293';

UPDATE `community`.`pageSettingList` SET `sortOrder`='8' WHERE `ID`='297';
UPDATE `community`.`pageSettingList` SET `description`='Which Access Levels can View' WHERE `ID`='291';
UPDATE `community`.`pageSettingList` SET `description`='Which Access Levels can Post' WHERE `ID`='294';




--//@UNDO
-- SQL to undo the change goes here.
drop table members.profileTypes;



