--// add map module data
-- Migration SQL that makes the change goes here.
INSERT INTO `community`.`modules`
(`title`,`page`,`file`,`contentType`,`moduleType`,`desc`,`icon`,`active`,`editfile`)
values 
( 'Map', 'any', 'dsp_map', '', 'widget', 'Add a google maps interface', 'map.png', 1, 'frm_editMap');


--//@UNDO
-- SQL to undo the change goes here.

delete from community.modules
where title = 'Map';

