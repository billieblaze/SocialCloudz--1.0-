--// add job content type
-- Migration SQL that makes the change goes here.

INSERT INTO `contentstore`.`contenttype` (`contentType`, `Description`, `linkID`, `homeLink`, `type`) VALUES ('Job', 'Job Posting', 'contentID', '/index.cfm/content/job/', 'text');
INSERT INTO `contentstore`.`UISettings` (`contentType`, `mainTemplate`, `detailTemplate`, `formTemplate`, `communityID`, `mainFooter`, `detailFooter`, `mainRightNav`, `detailRightnav`, `formRightnav`, `relocateAfterSave`) VALUES ('job', 'template_jobList', 'template_job', 'frm_addJob', '0', 'foot_pagination', 'foot_blank', 'Categories,Map,TagCloud', 'MediaDetails,Map,Share', 'frm_addImage,frm_addLocation,frm_addCategories,frm_addTags,frm_advanced', '/index.cfm/content/job/[contentID]');
INSERT INTO `community`.`menuFeatures` (`name`, `URL`) VALUES ('Jobs', '/index.cfm/content/job/');
INSERT INTO `community`.`communitysettinglist` (`name`, `valuelist`, `defaultvalue`, `settingType`, `sortOrder`, `description`) VALUES ('Job_View', 'Anyone,Members,Admin', 'Anyone', 'Job', '1', 'Who Can View');
INSERT INTO `community`.`communitysettinglist` (`name`, `valuelist`, `defaultvalue`, `settingType`, `sortOrder`, `description`) VALUES ('Job_Post', 'Members,Editor,Admin', 'Members', 'Job', '2', 'Who Can Post');
INSERT INTO `community`.`communitysettinglist` (`name`, `valuelist`, `defaultvalue`, `settingType`, `sortOrder`, `description`) VALUES ('Job_Rate', 'Noone,Anyone,Members', 'Members', 'Job', '3', 'Who Can Rate');
INSERT INTO `community`.`communitysettinglist` (`name`, `valuelist`, `defaultvalue`, `settingType`, `sortOrder`, `description`) VALUES ('Job_Comment', 'Noone,Anyone,Members,Admin', 'Members', 'Job', '4', 'Who Can Comment');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('Title', 'Job Posting', 'Job Posting', 'text', '1', 'job', 'Title', 'General');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('RelatedMedia', '0,1', '1', 'bit', '5', 'job', 'Related Media', 'Modules');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('TagCloud', '0,1', '1', 'bit', '6', 'job', 'Tag Cloud', 'Modules');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('Categories', '0,1', '1', 'bit', '3', 'job', 'Categories', 'Modules');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('Archives', '0,1', '1', 'bit', '4', 'job', 'Archives', 'Modules');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('MediaDetails', '0,1', '1', 'bit', '7', 'job', 'Media Details', 'Modules');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('SortOrder', 'publishdate,title', 'publishdate', 'select', '8', 'job', 'Sort By', 'Sorting');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('SortDirection', 'asc,desc', 'desc', 'select', '9', 'job', 'Direction', 'Sorting');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('Job_Approval', 'Auto,Manual', 'Auto', 'select', '2', 'job', 'Approval', 'General');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('Job_Thumbnail', 'None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175', '100', 'select', '3', 'job', 'Thumbnail Size', 'General');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('RatingType', 'Stars,Thumbs', 'Stars', 'select', '2', 'job', 'Rating Style', 'General');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('DisplayRows', ' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50', '5', 'select', '4', 'job', 'Display', 'General');
UPDATE `community`.`pageSettingList` SET `valueList`=' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50' WHERE `ID`='170';
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('displaySorting', 'Yes,No', '1', 'bit', '5', 'job', 'Display Sorting', 'General');
INSERT INTO `community`.`pageSettingList` (`name`, `valueList`, `defaultValue`, `settingType`, `sortOrder`, `page`, `description`, `settingGroup`) VALUES ('thumbNail_align', 'left,right', 'left', 'select', '8', 'job', 'Thumbnail Align', 'General');
INSERT INTO `community`.`modules` (`title`, `page`, `file`, `contentType`, `moduleType`, `desc`, `icon`, `active`, `editfile`) VALUES ('Job Postings', 'any', 'content', 'job', 'media', 'Add a Job listing', 'user.png', 1, 'frm_editContent');
UPDATE `contentstore`.`UISettings` SET `formRightnav`='frm_addImage,frm_addLocation,frm_advanced' WHERE `ID`='21';
UPDATE `contentstore`.`UISettings` SET `mainRightNav`='68' WHERE `ID`='21';



 


--//@UNDO
-- SQL to undo the change goes here.



