--// update contentstore uisettings uploadurl
-- Migration SQL that makes the change goes here.
UPDATE `contentstore`.`UISettings` 
SET `submitChildPostURL`='util.upload.galleryPhoto' 
WHERE `ID`='4'; 
UPDATE `contentstore`.`UISettings` 
SET `submitChildPostURL`='util.upload.albumSong' 
WHERE `ID`='7'; 
UPDATE `contentstore`.`UISettings` 
SET `submitChildPostURL`='util.upload.propertyPhoto' 
WHERE `ID`='10'; 
UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,Share' WHERE `ID`='9';
DELETE FROM `contentstore`.`UISettings` WHERE `ID`='17';
DELETE FROM `contentstore`.`UISettings` WHERE `ID`='18';
DELETE FROM `contentstore`.`UISettings` WHERE `ID`='15';
ALTER TABLE `statistics`.`files` CHANGE COLUMN `formfield` `formfield` VARCHAR(50) NULL  ;
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('knowledgebase_thumbnail', 'None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175', '100', 'select', '4', 'knowledgebase', 'Thumbnail Size', 'General');
UPDATE `contentstore`.`UISettings` SET `detailRightnav`='Map,Share' WHERE `ID`='20';
UPDATE `contentstore`.`UISettings` SET `formRightnav`='frm_addImage,frm_addLocation,frm_addCategories,frm_advanced' WHERE `ID`='20';
UPDATE `contentstore`.`UISettings` SET `formRightnav`='frm_addImage,frm_addLocation,frm_addCategories,frm_advanced' WHERE `ID`='16';




--//@UNDO
-- SQL to undo the change goes here.

UPDATE `contentstore`.`UISettings` SET `submitChildPostURL`='uploadGalleryPhoto.cfm' WHERE `ID`='4'; UPDATE `contentstore`.`UISettings` SET `submitChildPostURL`='uploadAlbumSong.cfm' WHERE `ID`='7'; UPDATE `contentstore`.`UISettings` SET `submitChildPostURL`='uploadPropertyPhoto.cfm' WHERE `ID`='10'; 
