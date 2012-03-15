--// convert images from int to filename
-- Migration SQL that makes the change goes here.
update contentstore.UISettings
set mainRightNav = '68,67', detailRightNav = '68,69,72'
where contentType = 'location';

--//@UNDO
-- SQL to undo the change goes here.


