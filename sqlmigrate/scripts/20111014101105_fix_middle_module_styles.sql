--// fix middle module styles
-- Migration SQL that makes the change goes here.
ALTER TABLE `community`.`styleElementList` CHANGE COLUMN `item` `item` VARCHAR(1024) NOT NULL  ;


UPDATE `community`.`styleElementList` SET `item`='.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd, .listMiddle div.mod div.hd' WHERE `ID`='68';

UPDATE `community`.`styleElementList` SET `item`='.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd, .listMiddle div.mod div.bd' WHERE `ID`='69';

UPDATE `community`.`styleElementList` SET `item`='.listLeft div.mod div.ft, .lisRight div.mod div.ft, .listSingle div.mod div.ft, .listMiddle div.mod div.ft' WHERE `ID`='70';

UPDATE `community`.`styleElementList` SET `item`='.listLeft div.mod div.hd a, .listRightt div.mod div.hd a, .listSingle div.mod div.hd a, .listMiddle div.mod div.hd a' WHERE `ID`='71';

UPDATE `community`.`styleElementList` SET `item`='.listLeft div.mod div.bd a, .listRight div.mod div.bd a, .listSingle div.mod div.bd a, .listMiddle div.mod div.bd a' WHERE `ID`='72';

UPDATE `community`.`styleElementList` SET `item`='.listLeft div.mod, .listRight div.mod, .listSingle div.mod, .listMiddle div.mod' WHERE `ID`='73';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.hd,.listRight div.mod div.hd,.listSingle div.mod div.hd,.listMiddle div.mod div.hd' WHERE `ID`='242';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd,.listMiddle div.mod div.hd' WHERE `ID`='243';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd,.listMiddle div.mod div.hd' WHERE `ID`='246';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd,.listMiddle div.mod div.hd' WHERE `ID`='247';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd,.listMiddle div.mod div.hd' WHERE `ID`='248';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd,.listMiddle div.mod div.hd' WHERE `ID`='249';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd,.listMiddle div.mod div.bd' WHERE `ID`='250';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd,.listMiddle div.mod div.bd' WHERE `ID`='253';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd,.listMiddle div.mod div.bd' WHERE `ID`='254';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd,.listMiddle div.mod div.bd' WHERE `ID`='255';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd,.listMiddle div.mod div.bd' WHERE `ID`='256';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.bd a, .listRight div.mod div.bd a, .listSingle div.mod div.bd a,.listMiddle div.mod div.bd a' WHERE `ID`='257';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.bd a, .listRight div.mod div.bd a, .listSingle div.mod div.bd a,.listMiddle div.mod div.bd a' WHERE `ID`='258';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.ft, .listRight div.mod div.ft, .listSingle div.mod div.ft,.listMiddle div.mod div.ft' WHERE `ID`='261';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.ft, .listRight div.mod div.ft, .listSingle div.mod div.ft,.listMiddle div.mod div.ft' WHERE `ID`='262';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.ft, .listRight div.mod div.ft, .listSingle div.mod div.ft,.listMiddle div.mod div.ft' WHERE `ID`='263';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.hd a, .listRight div.mod div.hd a, .listSingle div.mod div.hd a,.listMiddle div.mod div.hd a' WHERE `ID`='264';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.hd a, .listRight div.mod div.hd a, .listSingle div.mod div.hd a,.listMiddle div.mod div.hd a' WHERE `ID`='265';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.hd a, .listRight div.mod div.hd a, .listSingle div.mod div.hd a,.listMiddle div.mod div.hd a' WHERE `ID`='266';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.bd a:hover, .listRight div.mod div.bd a:hover, .listSingle div.mod div.bd a:hover,.listMiddle div.mod div.bd a:hover' WHERE `ID`='267';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod, .listRight div.mod, .listSingle div.mod,.listMiddle div.mod' WHERE `ID`='268';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod, .listRight div.mod, .listSingle div.mod,.listMiddle div.mod' WHERE `ID`='269';

UPDATE `community`.`stylePropertyList` SET `selector`='.listSingle div.mod div.bd h1, .listSingle div.mod div.bd h2, .listSingle div.mod div.bd h3 a' WHERE `ID`='280';

UPDATE `community`.`stylePropertyList` SET `selector`='.listLeft div.mod div.bd h1, .listRight div.mod div.bd h1, .listSingle div.mod div.bd h1, .listLeft div.mod div.bd h2, .listRight div.mod div.bd h2, .listSingle div.mod div.bd h2, .listLeft div.mod div.bd h3 a, .listRight div.mod div.bd h3 a, .listSingle div..mod div.bd h3 a,.listMiddle div.mod div.bd h1,  .listMiddle div.mod div.bd h2,  .listMiddle div.mod div.bd h3 a' WHERE `ID`='285';

UPDATE `community`.`stylePropertyList` SET `elementID`=80 WHERE `ID`='302';

UPDATE `community`.`stylePropertyList` SET `elementID`=80 WHERE `ID`='303';

UPDATE `community`.`stylePropertyList` SET `elementID`=80 WHERE `ID`='304';

UPDATE `community`.`stylePropertyList` SET `elementID`=80 WHERE `ID`='305';

UPDATE `community`.`stylePropertyList` SET `elementID`=80 WHERE `ID`='306';

UPDATE `community`.`stylePropertyList` SET `elementID`=80 WHERE `ID`='307';

UPDATE `community`.`stylePropertyList` SET `elementID`=80 WHERE `ID`='308';

UPDATE `community`.`stylePropertyList` SET `elementID`=80 WHERE `ID`='309';

UPDATE `community`.`stylePropertyList` SET `elementID`=81 WHERE `ID`='310';

UPDATE `community`.`stylePropertyList` SET `elementID`=81 WHERE `ID`='311';

UPDATE `community`.`stylePropertyList` SET `elementID`=81 WHERE `ID`='312';

UPDATE `community`.`stylePropertyList` SET `elementID`=81 WHERE `ID`='313';

UPDATE `community`.`stylePropertyList` SET `elementID`=81 WHERE `ID`='314';

UPDATE `community`.`stylePropertyList` SET `elementID`=81 WHERE `ID`='315';

UPDATE `community`.`stylePropertyList` SET `elementID`=81 WHERE `ID`='316';

UPDATE `community`.`stylePropertyList` SET `elementID`=81 WHERE `ID`='317';

UPDATE `community`.`stylePropertyList` SET `elementID`=81 WHERE `ID`='318';

UPDATE `community`.`stylePropertyList` SET `elementID`=82 WHERE `ID`='319';

UPDATE `community`.`stylePropertyList` SET `elementID`=82 WHERE `ID`='320';

UPDATE `community`.`stylePropertyList` SET `elementID`=82 WHERE `ID`='321';

UPDATE `community`.`stylePropertyList` SET `elementID`=83 WHERE `ID`='322';

UPDATE `community`.`stylePropertyList` SET `elementID`=83 WHERE `ID`='323';

UPDATE `community`.`stylePropertyList` SET `elementID`=83 WHERE `ID`='324';

UPDATE `community`.`stylePropertyList` SET `elementID`=83 WHERE `ID`='325';

UPDATE `community`.`stylePropertyList` SET `elementID`=83 WHERE `ID`='326';

UPDATE `community`.`stylePropertyList` SET `elementID`=84 WHERE `ID`='327';

UPDATE `community`.`stylePropertyList` SET `elementID`=84 WHERE `ID`='328';

UPDATE `community`.`stylePropertyList` SET `elementID`=84 WHERE `ID`='329';

UPDATE `community`.`stylePropertyList` SET `elementID`=85 WHERE `ID`='330';

UPDATE `community`.`stylePropertyList` SET `elementID`=85 WHERE `ID`='331';

UPDATE `community`.`stylePropertyList` SET `elementID`=85 WHERE `ID`='332';

UPDATE `community`.`stylePropertyList` SET `elementID`=86 WHERE `ID`='333';

UPDATE `community`.`stylePropertyList` SET `elementID`=86 WHERE `ID`='334';

UPDATE `community`.`stylePropertyList` SET `elementID`=86 WHERE `ID`='335';

UPDATE `community`.`stylePropertyList` SET `elementID`=87, `selector`='.listMiddle div.mod div.hd a' WHERE `ID`='336';

UPDATE `community`.`stylePropertyList` SET `elementID`=87, `selector`='.listMiddle div.mod div.hd a' WHERE `ID`='337';

UPDATE `community`.`stylePropertyList` SET `elementID`=87, `selector`='.listMiddle div.mod div.hd a' WHERE `ID`='338';




--//@UNDO
-- SQL to undo the change goes here.


