--// contentstore ses
-- Migration SQL that makes the change goes here.

UPDATE `community`.`menuFeatures` SET `URL`='/content/blog/' WHERE `ID`='1';

UPDATE `community`.`menuFeatures` SET `URL`='/content/music/' WHERE `ID`='2';

UPDATE `community`.`menuFeatures` SET `URL`='/content/video/' WHERE `ID`='3';

UPDATE `community`.`menuFeatures` SET `URL`='/content/gallery/' WHERE `ID`='4';

UPDATE `community`.`menuFeatures` SET `URL`='/content/article/' WHERE `ID`='5';

UPDATE `community`.`menuFeatures` SET `URL`='/content/event/' WHERE `ID`='6';

UPDATE `community`.`menuFeatures` SET `URL`='/content/knowledgebase/' WHERE `ID`='8';

UPDATE `community`.`menuFeatures` SET `URL`='/forum/' WHERE `ID`='9';

UPDATE `community`.`menuFeatures` SET `URL`='/content/link/' WHERE `ID`='10';

UPDATE `community`.`menuFeatures` SET `URL`='/member/util/list' WHERE `ID`='11';

UPDATE `community`.`menuFeatures` SET `URL`='/content/property/' WHERE `ID`='12';

UPDATE `community`.`menuFeatures` SET `URL`='/content/group/' WHERE `ID`='13';

UPDATE `community`.`menuFeatures` SET `URL`='/content/document/' WHERE `ID`='14';

UPDATE `community`.`menuFeatures` SET `URL`='/content/location/' WHERE `ID`='15';

UPDATE `community`.`menuFeatures` SET `URL`='/content/djchart/' WHERE `ID`='16';

UPDATE `community`.`menuFeatures` SET `URL`='/content/restaurant/' WHERE `ID`='17';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/link/' WHERE `contentType`='Link';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/article/' WHERE `contentType`='Article';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/blog/' WHERE `contentType`='Blog';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/djchart/' WHERE `contentType`='DJChart';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/document/' WHERE `contentType`='Document';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/domestic/' WHERE `contentType`='domestic';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/event/' WHERE `contentType`='Event';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/gallery/' WHERE `contentType`='gallery';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/gallery/' WHERE `contentType`='Photo';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/group/' WHERE `contentType`='Group';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/international/' WHERE `contentType`='international';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/knowledgebase/' WHERE `contentType`='knowledgebase';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/location/' WHERE `contentType`='Location';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/music/' WHERE `contentType`='Music';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/music/' WHERE `contentType`='Song';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/property/' WHERE `contentType`='Property';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/property/' WHERE `contentType`='PropertyThumbnail';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/restaurant/' WHERE `contentType`='Restaurant';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/content/video/' WHERE `contentType`='Video';

ALTER TABLE `contentstore`.`contenttype` DROP COLUMN `link` ;

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/article/[contentID]' WHERE `ID`='1';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/blog/[contentID]' WHERE `ID`='2';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/event/[contentID]' WHERE `ID`='3';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/form/gallery/[contentID]#tabs-2' WHERE `ID`='4';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/link/' WHERE `ID`='6';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/video?memberID=[memberID]' WHERE `ID`='8';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/form/music/[contentID]#tabs-2' WHERE `ID`='7';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/form/property/[contentID]' WHERE `ID`='10';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/knowledgebase/[contentID]' WHERE `ID`='11';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/group/[contentID]' WHERE `ID`='12';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/document/[contentID]' WHERE `ID`='13';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/video/?memberID=[memberID]' WHERE `ID`='14';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/video/?memberID=[memberID]' WHERE `ID`='15';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/location/[contentID]' WHERE `ID`='16';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/domestic/[contentID]' WHERE `ID`='17';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/international/[contentID]' WHERE `ID`='18';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/djchart/[contentID]' WHERE `ID`='19';

UPDATE `contentstore`.`UISettings` SET `relocateAfterSave`='/index.cfm/content/restaurant/[contentID]' WHERE `ID`='20';



UPDATE `community`.`startPageList` SET `value`='/' WHERE `Id`='2';

UPDATE `community`.`startPageList` SET `value`='/index.cfm/member/profile/index' WHERE `Id`='3';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='Categories,Archives,TagCloud', `detailRightnav`='MediaDetails,Share' WHERE `ID`='1';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='Categories,Archives,TagCloud', `detailRightnav`='MediaDetails,Share' WHERE `ID`='2';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='Categories,Tagcloud', `detailRightnav`='MediaDetails,Share' WHERE `ID`='4';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='LocationSearch,TagCloud', `detailRightnav`='MediaDetails,Share' WHERE `ID`='10';

UPDATE `contentstore`.`UISettings` SET `mainRightNav`='Categories,Archives,TagCloud', `detailRightnav`='MediaDetails,Share' WHERE `ID`='11';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,Share' WHERE `ID`='7';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,EmbedVideo,Share' WHERE `ID`='8';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,EmbedPhoto,Share' WHERE `ID`='9';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,EmbedVideo,Share' WHERE `ID`='14';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,Share' WHERE `ID`='13';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,EmbedVideo,Share' WHERE `ID`='15';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,Share' WHERE `ID`='16';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,Share' WHERE `ID`='17';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,Share' WHERE `ID`='18';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='MediaDetails,Share' WHERE `ID`='19';
UPDATE `contentstore`.`UISettings` SET `submitPreFuseaction`='content.import.event' WHERE `ID`='3';

UPDATE `contentstore`.`UISettings` SET `submitPreFuseaction`='content.import.heywatch' WHERE `ID`='8';

UPDATE `contentstore`.`UISettings` SET `submitPreFuseaction`='content.import.heywatch' WHERE `ID`='14';

UPDATE `contentstore`.`UISettings` SET `submitPreFuseaction`='content.import.heywatch' WHERE `ID`='15';

UPDATE `contentstore`.`UISettings` SET `submitPreFuseaction`='content.import.fileTypeIcon' WHERE `ID`='13'; 

UPDATE `contentstore`.`UISettings` SET `submitPostFuseaction`='content.import.recurEvent' WHERE `ID`='3';

UPDATE `contentstore`.`UISettings` SET `submitPostFuseaction`='member.groups.create' WHERE `ID`='12';

UPDATE `community`.`menuFeatures` SET `URL`='/forum/display/index/' WHERE `ID`='9';
UPDATE `community`.`menuFeatures` SET `URL`='/' WHERE `ID`='7';


--//@UNDO
-- SQL to undo the change goes here.


