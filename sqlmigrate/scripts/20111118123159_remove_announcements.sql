--// remove announcements
-- Migration SQL that makes the change goes here.
drop table community.announcements; 
delete from community.modules where file = 'dsp_bulletin';


--//@UNDO
-- SQL to undo the change goes here.


