--// drop location table
-- Migration SQL that makes the change goes here.

drop table location.location;
drop table location.ips;
alter table location.Country rename community.Country;
alter table location.cellprovider rename community.cellprovider;
alter table location.countrycode rename community.countrycode;
alter table location.state rename community.state;
drop database location;
--//@UNDO
-- SQL to undo the change goes here.



