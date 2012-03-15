--// add one table
-- Migration SQL that makes the change goes here.
CREATE  TABLE `members`.`one` (
  `oneID` varchar(45) not null PRIMARY KEY ,
  `provider` VARCHAR(45) NULL ,
  `userid` VARCHAR(45) NULL,
      `authKey` VARCHAR(45) NULL ,
  `context` VARCHAR(45) NULL ,
  `role` VARCHAR(45) NULL ,
  `privacy` BIT NULL DEFAULT b'0' ,
  `category` VARCHAR(45) NULL );

  INSERT INTO `community`.`community` (`communityID`, `adminID`, `site`, `tagline`, `subdomain`, `removed`, `private`, `featured`, `directory`, `domainID`, `bandwidth`, `storage`, `active`, `planID`, `parentID`, `notifications`) VALUES ('7', '1', 'facebook', 'facebook dummy site', 'facebook', 0, 0, 0, 1, '1', '1073741824', '536870912', 1, '1', '2', 1);
  INSERT INTO `community`.`community` (`communityID`, `adminID`, `site`, `tagline`, `subdomain`, `removed`, `private`, `featured`, `directory`, `domainID`, `bandwidth`, `storage`, `active`, `planID`, `parentID`, `notifications`) VALUES ('8', '1', 'linkedin', 'linkedin dummy site', 'linkedin', 0, 0, 0, 1, '1', '1073741824', '536870912', 1, '1', '2', 1);


--//@UNDO
-- SQL to undo the change goes here.
drop table members.one;


