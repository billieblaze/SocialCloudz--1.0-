--// extend setting lenght
-- Migration SQL that makes the change goes here.

ALTER TABLE `community`.`communitysettings` CHANGE COLUMN `value` `value` VARCHAR(1024) NULL DEFAULT NULL  ; 

--//@UNDO
-- SQL to undo the change goes here.


