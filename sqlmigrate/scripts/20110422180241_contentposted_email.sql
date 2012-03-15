--// contentposted email
-- Migration SQL that makes the change goes here.
INSERT INTO `community`.`emails` (`name`, `communityID`, `editable`) VALUES ('contentPosted', '0', 1);

ALTER TABLE `community`.`emailLog` CHANGE COLUMN `to` `to` VARCHAR(1024) NULL DEFAULT NULL  , CHANGE COLUMN `cc` `cc` VARCHAR(1024) NULL DEFAULT NULL  , CHANGE COLUMN `bcc` `bcc` VARCHAR(1024) NULL DEFAULT NULL  ;




--//@UNDO
-- SQL to undo the change goes here.


