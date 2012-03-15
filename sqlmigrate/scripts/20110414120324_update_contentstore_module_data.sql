--// update contentstore module data
-- Migration SQL that makes the change goes here.

INSERT INTO `community`.`modules`
(
`title`,
`page`,
`file`,
`contentType`,
`moduleType`,
`desc`,
`icon`,
`active`,
`editfile`,
`defaultTemplate`)
VALUES
(
 'Job', 'job', 'content', 'job_detail', 'content', 'Job Detail', NULL, '1', NULL, 'template_job'

);
INSERT INTO `community`.`modules`
(
`title`,
`page`,
`file`,
`contentType`,
`moduleType`,
`desc`,
`icon`,
`active`,
`editfile`,
`defaultTemplate`)
VALUES
('Blogs', 'Home', 'content', 'blog_detail', 'media', 'Publish content and allow members to comment', 'book.png', '1', 'frm_editContent', NULL),
('Articles', 'Home', 'content', 'article_detail', 'media', 'Publish content and allow members to comment', 'book.png', '1', 'frm_editContent', NULL),
('Photo Galleries', 'Home', 'content', 'gallery_detail', 'media', 'Add photos to your page', 'picture.png', '1', 'frm_editContent', NULL),
('Video', 'Home', 'content', 'video_detail', 'media', 'Add videos to your page', 'webcam.png', '1', 'frm_editContent', NULL),
( 'Events', 'any', 'content', 'Event_detail', 'community', 'Add events to your page', 'calendar.png', '1', 'frm_editContent', NULL),
( 'Knowledgebase', 'any', 'content', 'kb_topic_detail', 'community', 'Create and manage help topics', 'help.png', '1', 'frm_editContent', NULL),
( 'Links', 'any', 'content', 'Link', 'community_detail', 'Display a list of Links', 'link.png', '1', 'frm_editLinks', NULL),
( 'Property Listing', 'any', 'content', 'Property_detail', 'media', 'Display a list of properties for sale', 'coins.png', '1', 'frm_editContent', NULL),
('Documents', 'any', 'content', 'Document_detail', 'media', 'Display a list of uploaded documents', 'folder.png', '1', 'frm_editContent', NULL),
( 'DJ Charts', 'any', 'content', 'DJChart_detail', 'media', 'Top 10 Music Chart', 'cd.png', NULL, 'frm_editGeneric', NULL),
('Restaurants', 'any', 'content', 'restaurant_detail', 'media', 'Add a restaurant listing', 'menu.png', '1', 'frm_editContent', NULL),
( 'Location', 'any', 'content', 'location_detail', 'media', 'Add a location / venue listing', 'building.png', '1', 'frm_editContent', NULL),
('Restaurants', 'any', 'content', 'restaurant_detail', 'media', 'Add a restaurant listing', 'menu.png', '1', 'frm_editContent', NULL),
('Location', 'any', 'content', 'location_detail', 'media', 'Add a location / venue listing', 'building.png', '1', 'frm_editContent', NULL);

UPDATE `community`.`modules` SET `defaultTemplate`='template_detail' WHERE `moduleID`='75';

UPDATE `community`.`modules` SET `defaultTemplate`='template_detail' WHERE `moduleID`='76';

UPDATE `community`.`modules` SET `defaultTemplate`='template_file' WHERE `moduleID`='83';

UPDATE `community`.`modules` SET `defaultTemplate`='template_property' WHERE `moduleID`='82';

UPDATE `community`.`modules` SET `active`=1, `defaultTemplate`='template_djChart' WHERE `moduleID`='84';

UPDATE `community`.`modules` SET `defaultTemplate`='template_eventDetail' WHERE `moduleID`='79';

UPDATE `community`.`modules` SET `defaultTemplate`='template_eventList' WHERE `moduleID`='29';

UPDATE `community`.`modules` SET `defaultTemplate`='template_filelist' WHERE `moduleID`='45';

UPDATE `community`.`modules` SET `defaultTemplate`='template_gallery' WHERE `moduleID`='77';

UPDATE `community`.`modules` SET `defaultTemplate`='template_jobList' WHERE `moduleID`='62';

DELETE FROM `community`.`modules` WHERE `moduleID`='81';

UPDATE `community`.`modules` SET `defaultTemplate`='template_links' WHERE `moduleID`='40';

DELETE FROM `community`.`modules` WHERE `moduleID`='88';

UPDATE `community`.`modules` SET `defaultTemplate`='template_location' WHERE `moduleID`='86';

UPDATE `community`.`modules` SET `defaultTemplate`='template_musicList' WHERE `moduleID`='28';

UPDATE `community`.`modules` SET `defaultTemplate`='template_video' WHERE `moduleID`='78';

UPDATE `community`.`modules` SET `defaultTemplate`='template_preview2UP' WHERE `moduleID`='20';

UPDATE `community`.`modules` SET `defaultTemplate`='template_preview' WHERE `moduleID`='6';

UPDATE `community`.`modules` SET `defaultTemplate`='template_preview' WHERE `moduleID`='7';

UPDATE `community`.`modules` SET `defaultTemplate`='template_locationList' WHERE `moduleID`='54';

UPDATE `community`.`modules` SET `defaultTemplate`='template_propertyList' WHERE `moduleID`='44';

UPDATE `community`.`modules` SET `defaultTemplate`='template_RestaurantList' WHERE `moduleID`='53';

DELETE FROM `community`.`modules` WHERE `moduleID`='59';

UPDATE `community`.`modules` SET `defaultTemplate`='template_RestaurantList' WHERE `moduleID`='60';

UPDATE `community`.`modules` SET `defaultTemplate`='template_restaurant' WHERE `moduleID`='85';

DELETE FROM `community`.`modules` WHERE `moduleID`='87';

UPDATE `community`.`modules` SET `defaultTemplate`='template_thumbnail' WHERE `moduleID`='11';

UPDATE `community`.`modules` SET `defaultTemplate`='template_preview' WHERE `moduleID`='31';

UPDATE `community`.`modules` SET `active`=1, `defaultTemplate`='template_preview' WHERE `moduleID`='50';

UPDATE `community`.`modules` SET `defaultTemplate`='template_detail' WHERE `moduleID`='80';

UPDATE `community`.`modules` SET `icon`='user.png', `editfile`='frm_editContent' WHERE `moduleID`='74';
ALTER TABLE `contentstore`.`UISettings` DROP COLUMN `detailFooter` , DROP COLUMN `mainFooter` , DROP COLUMN `detailTemplate` , DROP COLUMN `mainTemplate` ;

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,72' WHERE `ID`='1';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,72' WHERE `ID`='2';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,72' WHERE `ID`='4';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,72' WHERE `ID`='7';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,72' WHERE `ID`='9';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,72' WHERE `ID`='10';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,72' WHERE `ID`='11';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,72' WHERE `ID`='13';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,72' WHERE `ID`='16';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,72' WHERE `ID`='19';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,71,68,72' WHERE `ID`='3';

DELETE FROM `contentstore`.`UISettings` WHERE `ID`='14';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,66,72' WHERE `ID`='8';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='68,72' WHERE `ID`='20';

UPDATE `contentstore`.`UISettings` SET `detailRightnav`='69,68,72' WHERE `ID`='21';

DELETE FROM `contentstore`.`contenttype` WHERE `contentTypeId`='6';

DELETE FROM `contentstore`.`contenttype` WHERE `contentTypeId`='10';


UPDATE `socialcloudz`.`dynamicGridColumns` SET `width`='25', `label`=' ', `align`='center' WHERE `ID`='375';



--//@UNDO
-- SQL to undo the change goes here.



