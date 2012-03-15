--// consolidate comments db into contentstore db
-- Migration SQL that makes the change goes here.

ALTER TABLE `comments`.`attachments` RENAME TO  `contentstore`.`commentAttachments` ;
ALTER TABLE `comments`.`comments` RENAME TO  `contentstore`.`comments` ;
drop database comments;

ALTER TABLE `rating`.`ratings` RENAME TO  `contentstore`.`ratings` ;

drop database rating;
drop table community.mailingList;
ALTER TABLE `newsletter`.`mailingList` RENAME TO  `community`.`mailingList` ;
ALTER TABLE `newsletter`.`messages` RENAME TO  `community`.`messages` ;
ALTER TABLE `newsletter`.`messageLog` RENAME TO  `community`.`messageLog` ;
drop database newsletter;
ALTER TABLE `poll`.`answers` RENAME TO  `community`.`pollAnswers` ;
ALTER TABLE `poll`.`questions` RENAME TO  `community`.`pollQuestions` ;
ALTER TABLE `poll`.`votes` RENAME TO  `community`.`pollVotes` ;

drop database poll;
drop database shopping; 

--//@UNDO
-- SQL to undo the change goes here.
create database comments;
ALTER TABLE `contentstore`.`attachments` RENAME TO  `comments`.`commentAttachments` ;
ALTER TABLE `contentstore`.`comments` RENAME TO  `comments`.`comments` ;
create database rating;
ALTER TABLE `contentstore`.`ratings` RENAME TO  `rating`.`ratings` ;
create database newsletter
ALTER TABLE `community`.`mailingList` RENAME TO  `newsletter`.`mailingList` ;
ALTER TABLE `community`.`messages` RENAME TO  `newsletter`.`messages` ;
ALTER TABLE `community`.`messageLog` RENAME TO  `newsletter`.`messageLog` ;

create database poll;

ALTER TABLE `community`.`pollAnswers` RENAME TO  `poll`.`answers` ;
ALTER TABLE `community`.`pollQuestions` RENAME TO  `community`.`questions` ;
ALTER TABLE `community`.`pollVotes` RENAME TO  `community`.`votes` ;
