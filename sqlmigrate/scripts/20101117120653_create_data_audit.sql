--// create data audit
-- Migration SQL that makes the change goes here.


CREATE TABLE statistics.`dataAudit` (
  `id` int(11) NOT NULL auto_increment,
  `fkType` varchar(45) default NULL,
  `fkID` varchar(45) default NULL,
  `dateUpdated` datetime default NULL,
  `visitorID` int(11) default NULL,
  `originalValue` text,
  `newValue` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
ALTER TABLE `statistics`.`dataAudit` ADD COLUMN `field` VARCHAR(45) NULL  AFTER `fkID` ;




--//@UNDO
-- SQL to undo the change goes here.


drop table dataAudit;