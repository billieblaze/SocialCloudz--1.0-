--// move poll module
-- Migration SQL that makes the change goes here.
update community.modules
set moduleType = 'promote' where moduleID = 19;


--//@UNDO
-- SQL to undo the change goes here.

update community.modules
set moduleType = 'community' where moduleID = 19;

