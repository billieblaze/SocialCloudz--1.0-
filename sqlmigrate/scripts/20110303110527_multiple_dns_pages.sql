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


UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='240';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='218';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='217';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='216';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='185';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='180';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='179';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='166';

UPDATE `community`.`community` SET `parentID`=226 WHERE `communityID`='159';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='46';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='44';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='37';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='5';

UPDATE `community`.`community` SET `parentID`='226' WHERE `communityID`='4';

UPDATE `community`.`community` SET `parentID`='0' WHERE `communityID`='2';

UPDATE `community`.`community` SET `parentID`='0' WHERE `communityID`='226';



--//@UNDO
-- SQL to undo the change goes here.
drop table community.dnsMask;
alter table community.community add fullurl varchar(255);
alter table community.community add dnsmask varchar(255);