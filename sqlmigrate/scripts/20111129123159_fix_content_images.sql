--// remove announcements
-- Migration SQL that makes the change goes here.
update contentstore.standardattribs sa 
set image = (select distinct concat(cdnurl, '/', file)  as image from statistics.files f where f.contentID = sa.contentID and f.fktype='image' limit 1)
where sa.image  not like '%.jpg' and sa.image  not like '%.png' and sa.image  not like '%.gif';


--//@UNDO
-- SQL to undo the change goes here.


