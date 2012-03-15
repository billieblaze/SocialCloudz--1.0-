--// add related sites module
-- Migration SQL that makes the change goes here.

UPDATE `community`.`modules` SET `file`='dsp_search' WHERE `moduleID`='46';

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `icon`, `active`, `editfile`) VALUES ('Sites In My Network', 'any', 'dsp_sites', 'community', 'Display other related sites in the network', 'group_link.png', 1, 'frm_editGeneric');
UPDATE `community`.`modules` SET `file`='content' WHERE `file`='dsp_content';




--//@UNDO
-- SQL to undo the change goes here.



