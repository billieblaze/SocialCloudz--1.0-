--// add profile question multiple and fieldset
-- Migration SQL that makes the change goes here.
	alter table `members`.`profileQuestions` ADD Column `multiple` BIT NULL DEFAULT 0;
	ALTER TABLE `members`.`profileQuestions` ADD COLUMN `groupID` INT NULL DEFAULT 0;

ALTER TABLE `members`.`profileQuestions` ADD COLUMN `valueList` VARCHAR(1024) NULL  AFTER `groupID` ; 

--//@UNDO
-- SQL to undo the change goes here.


