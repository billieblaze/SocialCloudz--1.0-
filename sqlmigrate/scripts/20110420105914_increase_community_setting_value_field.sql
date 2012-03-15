--// increase community setting value field
-- Migration SQL that makes the change goes here.
ALTER TABLE `community`.`communitysettings` CHANGE COLUMN `value` `value` VARCHAR(512) NULL DEFAULT NULL  ;




--//@UNDO
-- SQL to undo the change goes here.



