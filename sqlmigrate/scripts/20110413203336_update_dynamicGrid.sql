--// update dynamicGrid
-- Migration SQL that makes the change goes here.

alter table socialcloudz.dynamicGridColumns 
add editable bit default b'0';

alter table socialcloudz.dynamicGridColumns
add editType varchar(255);

alter table socialcloudz.dynamicGridColumns
add editOptions text; 

alter table  socialcloudz.dynamicGridColumns
add search bit default b'0';

alter table  socialcloudz.dynamicGridColumns
add summaryType varchar(55);

alter table  socialcloudz.dynamicGridColumns
add summaryTpl varchar(500);
--//@UNDO
-- SQL to undo the change goes here.



