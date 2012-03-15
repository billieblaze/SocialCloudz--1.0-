--// add middle module css
-- Migration SQL that makes the change goes here.
INSERT INTO `community`.`styleItemList` (`description`, `simple`, `advanced`) VALUES ('Middle Modules', b'0', b'1');
INSERT INTO `community`.`styleElementList` (`itemID`, `item`, `description`, `simple`, `advanced`) VALUES ('13', '.listMiddle div.mod div.hd', 'Header', b'1', b'1');
INSERT INTO `community`.`styleElementList` (`itemID`, `item`, `description`, `simple`, `advanced`) VALUES ('13', '.listMiddle div.mod div.bd', 'Body', b'1', b'1');
INSERT INTO `community`.`styleElementList` (`itemID`, `item`, `description`, `simple`, `advanced`) VALUES ('13', '.listMiddle div.mod div.bd a', 'Links', b'1', b'1');
INSERT INTO `community`.`styleElementList` (`itemID`, `item`, `description`, `simple`, `advanced`) VALUES ('13', '.listMiddle div.mod div.ft', 'Footer', b'1', b'1');
INSERT INTO `community`.`styleElementList` (`itemID`, `item`, `description`, `simple`, `advanced`) VALUES ('13', '.listMiddle .odd', 'Odd Row', b'1', b'1');
INSERT INTO `community`.`styleElementList` (`itemID`, `item`, `description`, `simple`, `advanced`) VALUES ('13', '.listMiddle .even', 'Even Row', b'1', b'1');
INSERT INTO `community`.`styleElementList` (`itemID`, `item`, `description`, `simple`, `advanced`) VALUES ('13', '.listMiddle .mod', 'Module', b'1', b'1');
INSERT INTO `community`.`styleElementList` (`itemID`, `item`, `description`, `simple`, `advanced`) VALUES ('13', '.listMiddle div.mod div.hd a', 'Header Links', b'1', b'1');


INSERT INTO `community`.`stylePropertyList`
(`property`,
`description`,
`elementID`,
`selector`,
`simple`,
`advanced`)
VALUES

('backgroundColor', 'Background Color', '78', '.listMiddle div.mod div.hd', b'1', b'1'),
('backgroundImage', 'Background Image', '78', '.listMiddle div.mod div.hd', b'1', b'1'),
('color', 'Text Color', '78', '.listMiddle div.mod div.hd', b'1', b'1'),
('height', 'Height', '78', '.listMiddle div.mod div.hd', b'1', b'1'),
('padding', 'Padding', '78', '.listMiddle div.mod div.hd', b'0', b'1'),
('borderColor', 'Border Color', '78', '.listMiddle div.mod div.hd', b'0', b'1'),
('borderWidth', 'Border Width', '78', '.listMiddle div.mod div.hd', b'0', b'1'),
('font', 'Font', '78', '.listMiddle div.mod div.hd', b'0', b'1'),
('color', 'Content Title', '79', '.listMiddle div.mod div.bd H1, .listMiddle div.mod div.bd h2, .listMiddle div.mod div.bd h3 a', b'0', b'1'),
('font', 'Content Title Font', '79', '.listMiddle div.mod div.bd H1, .listMiddle div.mod div.bd h2, .listMiddle div.mod div.bd h3 a', b'0', b'1'),
('backgroundColor', 'Background Color', '79', '.listMiddle div.mod div.bd', b'0', b'1'),
('backgroundImage', 'Background Image', '79', '.listMiddle div.mod div.bd', b'0', b'1'),
('color', 'Text Color', '79', '.listMiddle div.mod div.bd', b'0', b'1'),
('padding', 'Padding', '79', '.listMiddle div.mod div.bd', b'0', b'1'),
('borderColor', 'Border Color', '79', '.listMiddle div.mod div.bd', b'0', b'1'),
('borderWidth', 'Border Width', '79', '.listMiddle div.mod div.bd', b'0', b'1'),
('font', 'Font', '79', '.listMiddle div.mod div.bd', b'0', b'1'),
('font', 'Font', '80', '.listMiddle div.mod div.bd a', b'0', b'1'),
('color', 'Color', '80', '.listMiddle div.mod div.bd a', b'0', b'1'),
('color', 'Hover - Color', '80', '.listMiddle div.mod div.bd a:hover', b'0', b'1'),
('backgroundColor', 'Background Color', '81', '.listMiddle div.mod div.ft', b'0', b'1'),
('backgroundImage', 'Background Image', '81', '.listMiddle div.mod div.ft', b'0', b'1'),
('height', 'Height', '81', '.listMiddle div.mod div.ft', b'0', b'1'),
('borderColor', 'Border Color', '81', '.listMiddle div.mod div.ft', b'0', b'1'),
('borderWidth', 'Border Width', '81', '.listMiddle div.mod div.ft', b'0', b'1'),
('color', 'Text Color', '82', '.listMiddle div.mod .odd', b'0', b'1'),
('backgroundColor', 'Background Color', '82', '.listMiddle div.mod .odd', b'0', b'1'),
('color', 'Link Color', '82', '.listMiddle div.mod .odd a', b'0', b'1'),
('color', 'Text Color', '83', '.listMiddle div.mod .even', b'0', b'1'),
('backgroundColor', 'Background Color', '83', '.listMiddle div.mod .even', b'0', b'1'),
('color', 'Link Color', '83', '.listMiddle div.mod .even a', b'0', b'1'),
('borderColor', 'Border Color', '84', '.listMiddle .mod', b'0', b'1'),
('borderWidth', 'Border Width', '84', '.listMiddle .mod', b'0', b'1'),
('padding', 'Padding', '84', '.listMiddle .mod', b'0', b'1'),
('color', 'Color', '85', '.listMiddle div.mod div.hd', b'0', b'1'),
('font', 'Font', '85', '.listMiddle div.mod div.hd', b'0', b'1'),
('padding', 'Padding', '85', '.listMiddle div.mod div.hd', b'0', b'1');




--//@UNDO
-- SQL to undo the change goes here.



