--// change plans
-- Migration SQL that makes the change goes here.

DELETE FROM `socialcloudz`.`products` WHERE `ID`='19';
DELETE FROM `socialcloudz`.`products` WHERE `ID`='1';
UPDATE `socialcloudz`.`products` SET `cost`='9.99', `planID`='1' WHERE `ID`='3';
UPDATE `socialcloudz`.`products` SET `cost`='19.99', `planID`='2' WHERE `ID`='5';
UPDATE `socialcloudz`.`plans` SET `title`='Social' WHERE `planID`='1';
UPDATE `socialcloudz`.`plans` SET `title`='Business' WHERE `planID`='2';
DELETE FROM `socialcloudz`.`plans` WHERE `planID`='3';
DELETE FROM `socialcloudz`.`plans` WHERE `planID`='4';
UPDATE `socialcloudz`.`products` SET `cost`='4.99' WHERE `ID`='3';
UPDATE `socialcloudz`.`products` SET `cost`='14.99' WHERE `ID`='5';


--//@UNDO
-- SQL to undo the change goes here.


