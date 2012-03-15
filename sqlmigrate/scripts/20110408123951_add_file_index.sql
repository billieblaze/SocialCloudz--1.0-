--// add file index
-- Migration SQL that makes the change goes here.

ALTER TABLE statistics.files ADD INDEX(container, file);

--//@UNDO
-- SQL to undo the change goes here.



