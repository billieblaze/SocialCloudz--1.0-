--// extend setting lenght
-- Migration SQL that makes the change goes here.
ALTER TABLE `members`.`one` MODIFY COLUMN `provider` VARCHAR(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
 MODIFY COLUMN `memberID` INT(11) NOT NULL,
 DROP PRIMARY KEY,
 ADD PRIMARY KEY (`oneID`, `provider`, `context`, `role`, `category`);

--//@UNDO
-- SQL to undo the change goes here.


