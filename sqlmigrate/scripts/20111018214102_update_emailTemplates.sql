--// watermark position
-- Migration SQL that makes the change goes here.
ALTER TABLE `community`.`emailTags` RENAME TO  `community`.`emailTag` ; 
alter table emailTag drop column emailID;
ALTER TABLE `community`.`emails` RENAME TO  `community`.`emailTemplate` ; 

update community.emailTemplate
set body = replace(body, '[sitename]', '[community.site]');

update community.emailTemplate
set body = replace(body, '[siteurl]', '[community.baseurl]');

update community.emailTemplate
set subject = replace(subject, '[sitename]', '[community.site]');

update community.emailTemplate
set subject = replace(subject, '[siteurl]', '[community.baseurl]');


--//@UNDO
-- SQL to undo the change goes here.


