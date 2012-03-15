--// update_djchart_Default
-- Migration SQL that makes the change goes here.

alter table community.dynamicGridColumns 
add sortable bit default 1;

--//@UNDO
-- SQL to undo the change goes here.


