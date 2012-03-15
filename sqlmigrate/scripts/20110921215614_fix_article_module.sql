--// fix article module
-- Migration SQL that makes the change goes here.
INSERT INTO `community`.`modules` (`title`, `page`, `file`, `contentType`, `moduleType`, `desc`, `icon`, `active`, `editfile`, `defaultTemplate`) VALUES ('Articles', 'any', 'content', 'article_detail', 'media', 'Display articles and allow members to comment', 'book.png', 1, 'frm_editContent', 'template_detail');




--//@UNDO
-- SQL to undo the change goes here.


