--// watermark position
-- Migration SQL that makes the change goes here.

insert into `community`.`communitysettinglist`
(name, valuelist,defaultValue,settingType,sortOrder,description)
values
('watermarkPosition', 'topLeft,topRight,bottomLeft,bottomRight', 'bottomRight', 'Site', '7', NULL);


--//@UNDO
-- SQL to undo the change goes here.


