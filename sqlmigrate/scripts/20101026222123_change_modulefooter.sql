--// change modulefooter
-- Migration SQL that makes the change goes here.
ALTER TABLE `contentstore`.`UISettings` 
DROP COLUMN `childFormFooter` , 
DROP COLUMN `formFooter` ;




--//@UNDO
-- SQL to undo the change goes here.


