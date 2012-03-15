--// add photo detail module
-- Migration SQL that makes the change goes here.

INSERT INTO `community`.`modules` (`title`, `page`, `file`, `contentType`, `moduleType`, `desc`, `icon`, `active`, `editfile`, `defaultTemplate`) VALUES ('Photo', 'any', 'content', 'photo_detail', 'media', 'Add photos to your page', 'picture.png', 1, 'frm_editContent', 'template_photo');



--//@UNDO
-- SQL to undo the change goes here.


