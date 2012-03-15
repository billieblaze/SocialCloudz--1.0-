--// add profile question multiple and fieldset
-- Migration SQL that makes the change goes here.
    alter table `members`.`profileQuestions` ADD Column `multiple` BIT NULL DEFAULT 0;
    ALTER TABLE `members`.`profileQuestions` ADD COLUMN `groupID` INT NULL DEFAULT 0;

ALTER TABLE `members`.`profileQuestions` add COLUMN `valueList`  LONGTEXT NULL DEFAULT NULL  ;

ALTER TABLE `members`.`profileQuestions` ADD COLUMN `description` TEXT NULL  AFTER `valueList` ;



--//@UNDO
-- SQL to undo the change goes here.



