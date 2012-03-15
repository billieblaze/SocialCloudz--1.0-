--// watermark position
-- Migration SQL that makes the change goes here.
update contentstore.standardattribs
set image = replace(image, '//', '/');

update contentstore.attribs
set keyValue = replace(keyValue, '//', '/')
where keyValue like '%/content%';

update contentstore.standardattribs
set image = replace(image, '/content', 'http://c264119.r19.cf1.rackcdn.com/content')
where image not like '%rackcdn%';


update contentstore.attribs
set keyvalue = replace(keyvalue, '/content', 'http://c264119.r19.cf1.rackcdn.com/content')
where keyvalue not like '%rackcdn%';


update members.membersaccount set image = replace(image, '//', '/');

update members.membersaccount
set image = replace(image, '/content', 'http://c264119.r19.cf1.rackcdn.com/content')
where image not like '%rackcdn%';

update community.module_html
set html = replace(html, 'http://assets.socialcloudz.com/', 'http://c264119.r19.cf1.rackcdn.com/')
where html like '%assets%' ;


--//@UNDO
-- SQL to undo the change goes here.


