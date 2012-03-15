INSERT INTO `community`.`modules` (`title`, `page`, `file`, `contentType`, `moduleType`, `desc`, `icon`, `active`, `editfile`, `defaultTemplate`) VALUES ('Event', 'any', 'content', 'event_detail', 'media', 'Add Events', 'calendar.png', 1, 'frm_editContent', 'template_eventDetail');

DELETE FROM `community`.`modules` WHERE `moduleID`='76';

DELETE FROM `community`.`modules` WHERE `moduleID`='77';

UPDATE `community`.`modules` SET `defaultTemplate`='template_gallery' WHERE `moduleID`='79';

UPDATE `community`.`modules` SET `defaultTemplate`='template_video' WHERE `moduleID`='80';

UPDATE `community`.`modules` SET `defaultTemplate`='template_location' WHERE `moduleID`='90';

UPDATE `community`.`modules` SET `defaultTemplate`='template_property' WHERE `moduleID`='84';

UPDATE `community`.`modules` SET `defaultTemplate`='template_kb' WHERE `moduleID`='82';

UPDATE `community`.`modules` SET `defaultTemplate`='template_restaurant' WHERE `moduleID`='89';

