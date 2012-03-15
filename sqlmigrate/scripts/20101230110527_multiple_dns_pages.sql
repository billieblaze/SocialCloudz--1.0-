--// multiple dns pages
-- Migration SQL that makes the change goes here.

alter table community.community drop column fullurl;
alter table community.community drop column dnsmask;
drop table community.cname;
CREATE  TABLE `community`.`dnsMask` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `communityID` INT NULL ,
 `subdomain` VARCHAR(255) NULL ,
  `domain` VARCHAR(255) NULL ,
  `startpage` VARCHAR(255) NULL ,
  `verified` BIT  DEFAULT b'0',
  PRIMARY KEY (`id`) );
  
DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='85';
INSERT INTO `community`.`modules` (`title`, `page`, `file`, `contentType`, `moduleType`, `desc`, `icon`, `active`, `editfile`) VALUES ('Restaurants', 'any', 'dsp_content', 'restaurant', 'media', 'Add a restaurant listing', 'menu.png', 1, 'frm_editContent');
INSERT INTO `community`.`modules` (`title`, `page`, `file`, `contentType`, `moduleType`, `desc`, `icon`, `active`, `editfile`) VALUES ('Location', 'any', 'dsp_content', 'location', 'media', 'Add a location / venue listing', 'building.png', 1, 'frm_editContent');
ALTER TABLE `community`.`dnsMask` ADD COLUMN `subdomain` VARCHAR(255) NULL  AFTER `communityID` ;
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/blog/' WHERE `ID`='1';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/music/' WHERE `ID`='2';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/video/' WHERE `ID`='3';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/gallery/' WHERE `ID`='4';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/article/' WHERE `ID`='5';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/event/' WHERE `ID`='6';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/knowledgebase/' WHERE `ID`='8';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/forum/display/index/' WHERE `ID`='9';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/restaurant/' WHERE `ID`='17';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/djchart/' WHERE `ID`='16';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/location/' WHERE `ID`='15';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/document/' WHERE `ID`='14';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/group/' WHERE `ID`='13';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/property/' WHERE `ID`='12';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/member/util/list' WHERE `ID`='11';
UPDATE `community`.`menuFeatures` SET `URL`='/index.cfm/content/link/' WHERE `ID`='10';

--//@UNDO
-- SQL to undo the change goes here.
drop table community.dnsMask;
alter table community.community add fullurl varchar(255);
alter table community.community add dnsmask varchar(255);
