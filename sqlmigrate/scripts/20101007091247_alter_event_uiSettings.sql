--// alter event uiSettings
-- Migration SQL that makes the change goes here.
update contentstore.UISettings
set submitPreFuseaction = 'contentstore.importEvent'
where contentType = 'Event';


--//@UNDO
-- SQL to undo the change goes here.
update contentstore.UISettings
set submitPreFuseaction = ''
where contentType = 'Event';
