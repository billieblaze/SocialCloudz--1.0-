--// cloud files
-- Migration SQL that makes the change goes here.
ALTER TABLE `statistics`.`files` 
DROP COLUMN `total` ;

ALTER TABLE `statistics`.`files` 
ADD COLUMN `container` VARCHAR(45) NULL ,
ADD COLUMN `memberID` INT NULL   , 
CHANGE COLUMN `directory` `cdnURL` VARCHAR(255) NULL DEFAULT NULL  , 
CHANGE COLUMN `formfield` `fkType` VARCHAR(50) NULL DEFAULT NULL;
ALTER TABLE `statistics`.`files` ADD COLUMN `originalName` VARCHAR(255) NULL  AFTER `dateEntered` ;



--//@UNDO
-- SQL to undo the change goes here.



