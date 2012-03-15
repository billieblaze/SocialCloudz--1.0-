--// created contenttype nestedsets table
-- Migration SQL that makes the change goes here.

CREATE TABLE contentstore.nestedsets (
  nestedSetId int(11) NOT NULL AUTO_INCREMENT,
  nodeId int (11) NOT NULL,
  type varchar(45) NOT NULL,
  lft int(11) NOT NULL,
  rgt int(11) NOT NULL,
  PRIMARY KEY (nestedSetId)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert contentstore.nestedsets (nodeId, type, lft, rgt) values (1, 'contentType', 1, 2); 

--//@UNDO
-- SQL to undo the change goes here.

drop table contentstore.nestedsets;
