--// cleanup statistics db
-- Migration SQL that makes the change goes here.

drop table statistics.server;
alter table formManager.dcCom_Instances
rename community.dcCom_Instances;

alter table formManager.dccom_twform_forms
rename community.dccom_twform_forms;

alter table formManager.dccom_twform_formsubmissions
rename community.dccom_twform_formsubmissions;

drop database formManager;

drop table `forums`.`ban`;
drop table forums.smiles;
drop table forums.vulgarity;

alter table forums.forums
rename community.forums;
alter table forums.moderators
rename community.forumModerators;
alter table forums.posts
rename community.forumPosts;
alter table forums.sections
rename community.forumSections;
alter table forums.subscriptions
rename community.forumSubscriptions;

delimiter $$


CREATE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `community`.`lastpost` AS select distinct `community`.`forumPosts`.`forumID` AS `forumID`,max(`community`.`forumPosts`.`ID`) AS `Top_Id` from `community`.`forumPosts` where (ifnull(`community`.`forumPosts`.`forumID`,_utf8'') <> _utf8'') group by `community`.`forumPosts`.`forumID`$$
CREATE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `community`.`forum_list` AS select `flp`.`Top_Id` AS `Top_Id`,`f`.`ID` AS `ID`,`fp`.`Title` AS `Title`,`fp`.`postDate` AS `postDate`,`fp`.`memberID` AS `memberID`,`fp`.`postID` AS `postID`,`f`.`communityID` AS `communityID`,`f`.`forum` AS `forum`,`f`.`forum_desc` AS `forum_desc`,`fp`.`postID` AS `Expr1`,`f`.`sortOrder` AS `sortorder`,(select count(`fp`.`ID`) AS `Expr1` from `community`.`forumPosts` `fp` where ((`fp`.`forumID` = `f`.`ID`) and (`fp`.`postID` = 0))) AS `topicCount`,(select count(`fp`.`ID`) AS `Expr1` from `community`.`forumPosts` `fp` where (`fp`.`forumID` = `f`.`ID`)) AS `postCount`,`f`.`sectionID` AS `sectionID` from ((`community`.`forums` `f` left join `community`.`lastpost` `flp` on((`f`.`ID` = `flp`.`forumID`))) left join `community`.`forumPosts` `fp` on((`fp`.`ID` = `flp`.`Top_Id`)))$$
CREATE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `community`.`maxPost` AS select max(`community`.`forumPosts`.`ID`) AS `top_ID`,(case `community`.`forumPosts`.`postID` when 0 then `community`.`forumPosts`.`ID` else `community`.`forumPosts`.`postID` end) AS `postID` from `community`.`forumPosts` group by (case `community`.`forumPosts`.`postID` when 0 then `community`.`forumPosts`.`ID` else `community`.`forumPosts`.`postID` end)$$
CREATE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `community`.`postlist` AS select `fp2`.`Title` AS `Title`,`mp`.`postID` AS `ID`,`fp`.`memberID` AS `postMember`,`fp2`.`memberID` AS `memberID`,`fp2`.`forumID` AS `forumID`,`fp2`.`views` AS `views`,`fp`.`postDate` AS `maxdate`,`fp`.`locked` AS `locked`,(select count(`fp3`.`postID`) AS `postID` from `community`.`forumPosts` `fp3` where (`fp3`.`postID` = `fp2`.`ID`)) AS `replyCount`,`fp2`.`sticky` AS `sticky` from ((`community`.`maxPost` `mp` join `community`.`forumPosts` `fp` on((`fp`.`ID` = `mp`.`top_ID`))) join `community`.`forumPosts` `fp2` on((`fp2`.`ID` = `mp`.`postID`)))$$

drop database forums;

alter table socialcloudz.CHANGELOG 
rename community.CHANGELOG;
alter table socialcloudz.accounts
rename community.accounts;
alter table socialcloudz.dynamicGrid
rename community.dynamicGrid;
alter table socialcloudz.dynamicGridColumns
rename community.dynamicGridColumns;
alter table socialcloudz.help
rename community.help;
alter table socialcloudz.helpSections
rename community.helpSections;
alter table socialcloudz.helpTopics
rename community.helpTopics;
alter table socialcloudz.list
rename community.list;
alter table socialcloudz.plans
rename community.plans;
alter table socialcloudz.products
rename community.products;
alter table socialcloudz.recurringCharges
rename community.recurringCharges;
alter table socialcloudz.support
rename community.support;
alter table socialcloudz.transaction
rename community.transaction;
alter table socialcloudz.transactionProduct
rename community.transactionProduct;
drop database socialcloudz;
drop table members.one;

CREATE TABLE members.`one` (
  `provider` varchar(45) DEFAULT NULL,
  `userid` varchar(45) DEFAULT NULL,
  `authKey` varchar(45) DEFAULT NULL,
  `context` varchar(45) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `privacy` bit(1) DEFAULT b'0',
  `category` varchar(45) DEFAULT NULL,
  `oneID` int(11) NOT NULL auto_increment key
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


ALTER TABLE `members`.`one` ADD COLUMN `memberID` INT(11) NULL  AFTER `oneID` ;




--//@UNDO
-- SQL to undo the change goes here.
