--// convert images from int to filename
-- Migration SQL that makes the change goes here.
update members.membersaccount set image = '' where image = '/images/user_icon.png';

update members.membersaccount
set image = (select cdnurl & '/' & file as image from statistics.files where id = members.membersaccount.image)
where image != '' and image REGEXP '^[\-\+]?[[:digit:]]*\.?[[:digit:]]*$'; 

update contentstore.standardattribs
set image = (select cdnurl & '/' & file as image from statistics.files where id = contentstore.standardattribs.image)
where image REGEXP '^[\-\+]?[[:digit:]]*\.?[[:digit:]]*$'; 
--//@UNDO
-- SQL to undo the change goes here.


