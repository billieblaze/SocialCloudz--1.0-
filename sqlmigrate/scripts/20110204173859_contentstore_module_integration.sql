--// contentstore_module_integration
-- Migration SQL that makes the change goes here.
update community.cmsPages
set url = replace(url,'/','');

update community.modulepage
set page = replace(page,'/','');
update community.menu
set cms = replace(cms, '/','');
update `community`.`communitysettings`
set value = '/'
where value = '/index.cfm';

ALTER TABLE `community`.`pageSettingList` CHANGE COLUMN `sortOrder` `sortOrder` INT(10) UNSIGNED NOT NULL DEFAULT 0  ;
ALTER TABLE `community`.`pageSettingList` CHANGE COLUMN `settingGroup` `settingGroup` VARCHAR(45) NULL  ;


DELETE FROM `community`.`pageSettingList` WHERE `ID`='1';
DELETE FROM `community`.`pageSettingList` WHERE `ID`='6';
DELETE FROM `community`.`pageSettingList` WHERE `ID`='11';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='16';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='21';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='26';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='31';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='36';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='41';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='46';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='120';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='131';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='161';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='185';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='194';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='207';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='248';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='249';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='262';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='278';

ALTER TABLE `community`.`modulesettings` ADD COLUMN `sortDirection` VARCHAR(4) NULL DEFAULT 'desc'  AFTER `sort` , ADD COLUMN `displaySorting` BIT(1) NULL DEFAULT b'1'  AFTER `sortDirection` , ADD COLUMN `thumbAlign` VARCHAR(20) NULL DEFAULT 'left'  AFTER `thumbSize` ;


INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `icon`, `active`, `editfile`) VALUES ('Archives', 'any', 'nav_archives', 'content', 'Archives by Year / Month', 'calendar.png', 1, 'frm_editGeneric');

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `active`, `editfile`) VALUES ('Categories', 'any', 'nav_categories', 'content', 'Categories', 1, 'frm_editGeneric');

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `active`, `editfile`) VALUES ('Embed', 'any', 'nav_embed', 'content', 'Embed Code', 1, 'frm_editGeneric');

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `active`, `editfile`) VALUES ('Location Search', 'any', 'nav_locationSearch', 'content', 'Search by Location', 1, 'frm_editGeneric');

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `icon`, `active`, `editfile`) VALUES ('Map', 'any', 'nav_map', 'content', 'Google Map', 'map.png', 1, 'frm_editGeneric');

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `active`, `editfile`) VALUES ('Details', 'any', 'nav_mediaDetails', 'content', 'Media Details ', 1, 'frm_editGeneric');

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `active`, `editfile`) VALUES ('Members', 'group', 'nav_members', 'content', 'Group Members', 1, 'frm_editGeneric');

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `active`, `editfile`) VALUES ('RSVP', 'event', 'nav_rsvp', 'content', 'RSVP to an Event', 1, 'frm_editGeneric');

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `active`, `editfile`) VALUES ('Share', 'any', 'nav_share', 'content', 'Share', 1, 'frm_editGeneric');

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `active`, `editfile`) VALUES ('Tags', 'any', 'nav_tagcloud', 'content', 'Tag Cloud', 1, 'frm_editGeneric');
UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,64,73' WHERE `ID`='1';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,64,73' WHERE `ID`='2';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,64,73' WHERE `ID`='11';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,64,73' WHERE `ID`='13';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65' WHERE `ID`='6';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,67,64' WHERE `ID`='3';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,73' WHERE `ID`='4';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,73' WHERE `ID`='7';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,73' WHERE `ID`='8';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='67,73' WHERE `ID`='10';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,73' WHERE `ID`='12';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,73' WHERE `ID`='14';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='67' WHERE `ID`='16';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,64' WHERE `ID`='19';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='68,67,65,73' WHERE `ID`='20';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='65,68,73' WHERE `ID`='21';
DELETE FROM `community`.`pageSettingList` WHERE `ID`='2';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='3';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='4';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='5';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='7';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='8';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='9';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='10';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='12';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='13';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='14';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='15';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='17';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='19';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='20';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='22';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='23';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='24';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='25';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='27';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='28';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='29';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='30';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='32';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='33';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='34';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='35';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='37';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='38';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='39';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='40';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='42';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='43';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='44';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='45';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='47';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='48';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='49';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='50';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='51';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='52';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='54';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='55';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='56';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='57';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='58';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='113';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='117';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='118';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='119';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='121';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='122';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='123';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='124';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='125';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='132';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='133';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='134';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='135';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='162';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='163';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='164';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='165';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='166';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='186';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='187';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='188';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='195';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='196';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='197';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='198';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='199';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='208';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='209';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='210';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='211';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='212';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='220';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='221';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='222';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='223';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='224';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='225';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='226';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='227';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='228';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='229';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='230';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='231';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='232';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='233';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='234';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='235';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='236';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='237';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='238';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='250';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='251';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='252';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='260';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='263';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='264';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='265';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='266';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='267';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='269';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='271';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='272';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='273';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='274';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='275';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='276';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='279';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='280';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='281';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='282';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='283';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='290';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='6';
DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='44';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='51';
UPDATE `community`.`pageSettingList` SET `name`='Approval', `page`='content' WHERE `ID`='95';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='96';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='97';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='98';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='99';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='100';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='101';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='102';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='128';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='138';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='160';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='191';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='255';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='268';

DELETE FROM `community`.`pageSettingList` WHERE `ID`='286';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='8';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='9';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='10';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='11';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='12';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='13';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='14';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='15';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='16';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='17';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='18';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='19';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='20';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='21';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='22';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='23';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='24';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='25';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='26';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='27';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='31';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='32';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='33';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='34';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='36';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='37';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='39';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='40';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='48';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='49';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='52';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='53';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='54';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='55';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='56';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='57';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='58';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='59';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='60';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='61';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='62';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='63';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='64';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='65';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='66';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='67';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='68';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='69';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='70';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='71';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='72';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='73';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='74';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='75';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='76';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='77';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='78';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='79';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='80';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='81';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='82';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='86';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='87';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='88';

DELETE FROM `community`.`communitysettinglist` WHERE `settingID`='89';




INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `page`, `description`) VALUES ('canView', 'Anyone,Members,Editors,Owners', 'Anyone', 'select', 'any', 'Who can View');

INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `page`, `description`) VALUES ('canComment', 'Anyone,Members,Editors,Owners', 'Members', 'select', 'content', 'Who can Comment');

INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `page`, `description`) VALUES ('canRate', 'Anyone,Members,Editors,Owners', 'Members', 'select', 'content', 'Who can Rate');

INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `page`, `description`) VALUES ('canPost', 'Members,Editors,Owners', 'Members', 'select', 'content', 'Who can Post');

ALTER TABLE `community`.`modulesettings` ADD COLUMN `isContent` BIT(1) NULL DEFAULT b'1' ;


UPDATE `community`.`modules` SET `file`='content' WHERE `moduleID`='36';

UPDATE `community`.`modules` SET `file`='content' WHERE `moduleID`='34';

UPDATE `community`.`modules` SET `file`='content' WHERE `moduleID`='48';

UPDATE `community`.`modules` SET `file`='content' WHERE `moduleID`='29';

update community.modulesettings set iscontent = 0;

update community.modulesettings
set displayTemplate = 'template_list'
where displayTemplate = 'list'
and moduleID in (6,7,11,20,28,29,31,34,26,40,44,45,48);

update community.modulesettings
set displayTemplate = 'template_thumbnail'
where displayTemplate = 'thumbnail'
and moduleID in (6,7,11,20,28,29,31,34,26,40,44,45,48);

update community.modulesettings
set displayTemplate = 'template_title'
where displayTemplate = 'title'
and moduleID in (6,7,11,20,28,29,31,34,26,40,44,45,48);

update community.modulesettings
set displayTemplate = 'template_preview'
where displayTemplate = 'preview'
and moduleID in (6,7,11,20,28,29,31,34,26,40,44,45,48);


update community.modulesettings
set displayTemplate = 'template_detail'
where displayTemplate = 'detail'
and moduleID in (6,11);

update community.modulesettings
set displayTemplate = 'template_eventDetail'
where displayTemplate = 'Detail'
and moduleID in (29);
delete from community.modulepage where page in (select contentType from contentstore.contenttype);
INSERT INTO `community`.`modules` (`moduleID`, `title`, `page`, `file`, `contentType`, `moduleType`, `desc`, `active`, `editfile`) VALUES ('65', 'Restaurants', 'any', 'content', 'restaurant', 'media', 'Restaurant', 1, 'frm_editContent');


--//@UNDO
-- SQL to undo the change goes here.



