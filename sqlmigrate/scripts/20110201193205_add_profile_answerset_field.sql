--// add profile answerset field
-- Migration SQL that makes the change goes here.

ALTER TABLE `members`.`profileAnswers` ADD COLUMN `answerSet` INT NULL DEFAULT 0  AFTER `value` ;
ALTER TABLE `members`.`profileAnswers` CHANGE COLUMN `answerSet` `answerSet` INT(11) NOT NULL DEFAULT '0'  ;

USE `members`;

CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `profile` AS 
select `pq`.`Question` AS `question`,
`pa`.`questionID` AS `questionID`,
`pa`.`value` AS `value`,
`pq`.`type` AS `type`,
`pa`.`memberID` AS `memberid`,
`pa`.`answerSet` AS `answerSet`,
`ps`.`communityID` AS `communityID`,
`pq`.`sectionID` AS `sectionID`
from ((`profileSections` `ps` join `profileQuestions` `pq` on((`ps`.`ID` = `pq`.`sectionID`))) join `profileAnswers` `pa` on((`pa`.`questionID` = `pq`.`ID`)));

INSERT INTO `community`.`communitysettinglist` (`name`, `valuelist`, `defaultvalue`, `settingType`, `sortOrder`) VALUES ('friends', 'On,Off', '1', 'general', '6');




--//@UNDO
-- SQL to undo the change goes here.

ALTER TABLE `members`.`profileAnswers` DROP COLUMN `answerSet`;

USE `members`;

CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `profile` AS 
select `pq`.`Question` AS `question`,
`pa`.`questionID` AS `questionID`,
`pa`.`value` AS `value`,
`pq`.`type` AS `type`,
`pa`.`memberID` AS `memberid`,
`ps`.`communityID` AS `communityID`,
`pq`.`sectionID` AS `sectionID`
    from ((`profileSections` `ps` join `profileQuestions` `pq` on((`ps`.`ID` = `pq`.`sectionID`))) join `profileAnswers` `pa` on((`pa`.`questionID` = `pq`.`ID`)));



