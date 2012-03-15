--// oneid_uuid
-- Migration SQL that makes the change goes here.
ALTER TABLE `members`.`one` CHANGE COLUMN `oneID` `oneID` VARCHAR(32) NOT NULL  ;


--//@UNDO
-- SQL to undo the change goes here.


