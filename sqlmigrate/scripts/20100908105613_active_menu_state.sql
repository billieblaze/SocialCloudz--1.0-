--// active menu state
-- Migration SQL that makes the change goes here.
insert into community.styleElementList
(itemID,item,description,simple,advanced)
values
(3, '#menuBar ul li.active a', 'Menu Tab - Active', b'0',b'1'),
(3, '#menuBar ul li.active a:hover', 'Menu Tab - Active Hover', b'0',b'1');

insert into community.stylePropertyList
(property, description, elementID, selector,simple,advanced)
values
('backgroundColor', 'Background Color', '76', '#menuBar ul li.active a', b'0', b'1'),
('backgroundImage', 'Background Image', '76', '#menuBar ul li.active a', b'0', b'1'),
('backgroundColor', 'Background Color', '77', '#menuBar ul li.active a:hover', b'0', b'1'),
('backgroundImage', 'Background Image', '77', '#menuBar ul li.active a:hover', b'0', b'1'),
('color', 'Text', '76', '#menuBar ul li.active a', b'0', b'1'),
('color', 'Text', '77', '#menuBar ul li.active a:hover', b'0', b'1'),
('font', 'Font', '76', '#menuBar ul li.active a', b'0', b'1');

update community.modulepage set page = 'members' where page = 'MemberList';
update community.pageSettingList set page = 'members'where page = 'memberlist';
update community.pageSettings set page = 'members' where page = 'memberlist';
update community.layout set page = 'members' where page = 'memberlist';

--//@UNDO
-- SQL to undo the change goes here.
delete from community.styleElementList where item in ('#menuBar ul li.active a', '#menuBar ul li.active a:hover');
delete from community.stylePropertyList where elementID in (76,77);

update community.modulepage set page = 'MemberList' where page = 'members';
update community.pageSettingList set page = 'MemberList'where page = 'members';
update community.pageSettings set page = 'MemberList' where page = 'members';
update community.layout set page = 'MemberList' where page = 'members';