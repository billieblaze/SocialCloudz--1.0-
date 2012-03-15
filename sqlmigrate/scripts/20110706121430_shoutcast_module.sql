--// update_djchart_Default
-- Migration SQL that makes the change goes here.


INSERT INTO `community`.`modules` (`title`, `page`, `file`, `moduleType`, `desc`, `icon`, `active`, `editfile`) VALUES ('Shoutcast', 'any', 'dsp_shoutcast', 'widget', 'Play a shoutcast stream', 'cd.png', 1, 'frm_editHTML');



--//@UNDO
-- SQL to undo the change goes here.


