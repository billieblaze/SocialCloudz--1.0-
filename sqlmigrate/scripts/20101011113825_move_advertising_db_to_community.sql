--// move advertising db to community
-- Migration SQL that makes the change goes here.
alter table advertising.adSize rename community.bannerSize;
alter table advertising.banners rename community.banners;
drop database advertising;


--//@UNDO
-- SQL to undo the change goes here.
create database advertising;
alter table community.bannerSize rename advertising.adSize;
alter table community.banners rename advertising.banners;



