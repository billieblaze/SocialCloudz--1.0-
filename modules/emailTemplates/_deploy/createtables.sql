ALTER TABLE `community`.`emailTags` RENAME TO  `community`.`emailTag` ; 
alter table emailTag drop column emailID;
ALTER TABLE `community`.`emails` RENAME TO  `community`.`emailTemplates` ; 