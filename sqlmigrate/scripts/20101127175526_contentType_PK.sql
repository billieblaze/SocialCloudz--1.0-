--// contentType PK
-- Migration SQL that makes the change goes here.
truncate contentstore.contenttype;

ALTER TABLE `contentstore`.`contenttype` 
ADD COLUMN `contentTypeId` INT(11) AUTO_INCREMENT NOT NULL AFTER `communityID` , 
ADD UNIQUE INDEX `contentType_UNIQUE` (`contentType` ASC) , DROP PRIMARY KEY , ADD PRIMARY KEY (`contentTypeId`) ;

INSERT INTO contentstore.`contenttype` 
(`contentType`,
`Description`,
`linkID`,
`homeLink`,
`type`,
`parentContentType`,
`communityID`)
VALUES 
('Root','Root Node','','','','',0),
('Article','Article','contentID','/content/article/','text','',0),
('Blog','Blog','contentID','/content/blog/','text','',0),
('DJChart','DJCharts','contentID','/content/djchart/','chart',NULL,0),
('Document','Document','contentID','/content/document/','file',NULL,0),
('domestic','US Ministries','contentID','/content/domestic/','text',NULL,133),
('Event','Event','contentID','/content/event/','calendar','',0),
('gallery','Gallery','contentID','/content/gallery/','image','',0),
('Group','Groups','contentID','/content/group/','text','',0),
('international','International Ministries','contentID','/content/international/','text',NULL,133),
('knowledgebase','KnowledgeBase','parentID','/content/knowledgebase/','text','',0),
('Link','Link','attribute_link','/content/link/','text','',0),
('Location','Location','contentID','/content/location/','text','',0),
('Music','Album','contentID','/content/music/','image','',0),
('Photo','Photo','contentID','/content/gallery/','image','gallery',0),
('Property','Properties','contentID','/content/property/','image','',0),
('PropertyThumbnail','Property Thumbnail','contentID','/content/property/','image','Property',0),
('Restaurant','Restaurant','contentID','/content/restaurant/','text',NULL,0),
('Song','Song','parentID','/content/music/','image','music',0),
('Video','Video','contentID','/content/video/','image','',0);
UPDATE `contentstore`.`contenttype` SET `linkID`='contentID', `homeLink`='/index.cfm/content/knowledgebase/' WHERE `contentTypeId`='11';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/article/' WHERE `contentTypeId`='2';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/blog/' WHERE `contentTypeId`='3';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/djchart/' WHERE `contentTypeId`='4';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/document/' WHERE `contentTypeId`='5';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/domestic/' WHERE `contentTypeId`='6';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/event/' WHERE `contentTypeId`='7';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/gallery/' WHERE `contentTypeId`='8';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/group/' WHERE `contentTypeId`='9';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/international/' WHERE `contentTypeId`='10';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/link/' WHERE `contentTypeId`='12';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/location/' WHERE `contentTypeId`='13';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/music/' WHERE `contentTypeId`='14';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/gallery/' WHERE `contentTypeId`='15';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/property/' WHERE `contentTypeId`='16';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/property/' WHERE `contentTypeId`='17';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/restaurant/' WHERE `contentTypeId`='18';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/music/' WHERE `contentTypeId`='19';

UPDATE `contentstore`.`contenttype` SET `homeLink`='/index.cfm/content/video/' WHERE `contentTypeId`='20';


--//@UNDO
-- SQL to undo the change goes here.


