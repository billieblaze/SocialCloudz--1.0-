--// update_djchart_Default
-- Migration SQL that makes the change goes here.


UPDATE `community`.`modules` SET `defaultTemplate`='template_djchart' WHERE `moduleID`='50';


--//@UNDO
-- SQL to undo the change goes here.


