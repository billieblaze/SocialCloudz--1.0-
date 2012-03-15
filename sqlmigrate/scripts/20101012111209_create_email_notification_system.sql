--// create email notification system
-- Migration SQL that makes the change goes here.


CREATE TABLE community.`emails` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) default NULL,
  `subject` varchar(255) default NULL,
  `body` longtext,
  `note` longtext,
  `communityID` int(11) default '0',
  `editable` bit default b'1',
  PRIMARY KEY  (`id`)
);

CREATE TABLE community.`emailTags` (
  `ID` int(11) NOT NULL auto_increment,
  `emailID` int(11) default NULL,
  `tag` varchar(45) default NULL,
  `description` longtext,
  PRIMARY KEY  (`ID`)
) ;



CREATE TABLE community.`emailLog` (
  `id` int(11) NOT NULL auto_increment,
  `emailID` int(11) default NULL,
  `memberID` int(11) default NULL,
  `dateSent` datetime default NULL,
  `to` varchar(255) default NULL,
  `cc` varchar(255) default NULL,
  `bcc` varchar(255) default NULL,
  `subject` varchar(255) default NULL,
  `body` longtext,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE  TABLE `community`.`emailMapping` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `emailID` INT NULL ,
  `tagID` INT NULL ,
  `value` VARCHAR(255) NULL ,
  PRIMARY KEY (`ID`) );


/*!40000 ALTER TABLE  community.`emails` DISABLE KEYS */;
INSERT INTO community.`emails`
 VALUES 
 (13,'invitation','Invitation to join [sitename]','\n[username] has invited you to join [sitename].   <BR><BR>\n\n<A href=\"[siteurl]?t=[inviteID]\">[siteurl]</a>  <BR>\n<BR>\n<BR>\nThanks, <BR>\nThe [sitename] Team<BR>\n<A href=\"[siteurl]\">[siteurl]</a>\n',NULL,0,0),
 (14,'contentApproval','Content Approval Required.','\n\nThere is new content awaiting your approval on <A href=\"[siteurl]\">[siteurl]</a>.  <BR>\n<BR>\n<BR>\nThanks, <BR>\nThe [sitename] Team<BR>\n<A href=\"[siteurl]\">[siteurl]</a>\n',NULL,0,0),
 (15,'forum','[title] has been updated on [sitename]','\nHello,<BR>\n<BR>\nYou are receiving this email because you are watching the topic, \"[title]\" <BR>\nat <A href=\"[siteurl]\">[siteurl]</a>. This topic has received a reply since your last visit. <BR>\n<BR>\nYou can use the following link to view the replies made.<BR>\n<a href=\"[url]\">[url]</a><BR>\n<BR>\n<BR>\nThanks, <BR>\nThe [sitename] Team<BR>\n<A href=\"[siteurl]\">[siteurl]</a>\n',NULL,0,0),
 (16,'message','[sitename]: New Message','\nHello,<BR>\n<BR>\nYou are receiving this email because you received a new private message from <BR>\n[username] on [sitename] at <a href=\"[siteurl]\">[siteurl]</a>.<BR>\n<BR>\nYou can use the following link to view the message:<BR>\n<BR>\n<a href=\"[siteurl]\">[siteurl]</a><BR>\n<BR>\n<BR>\nThanks, <BR>\nThe [sitename] Team<BR>\n<a href=\"[siteurl]\">[siteurl]</a>\n',NULL,0,0),
 (17,'friendRequest','[sitename]: Friend Request','\nHello,<BR>\n<BR>\nYou are receiving this email because you received a friend request from [username] \n at <A href=\"[siteurl]\">[siteurl]</a>.<BR>\n<BR>\nYou can use the following link to view the comment made.<BR>\n<BR>\n<a href=\"[siteurl]\">[siteurl]</a><BR>\n<BR>\n<BR>\nThanks, <BR>\nThe [sitename] Team<BR>\nhttp://[siteurl]\n',NULL,0,0),
 (18,'comment','[sitename]: Comment Notification','\nHello,<BR>\n<BR>\nYou are receiving this email because you received a comment from [username] \n at <A href=\"[siteurl]\">[siteurl]</a>.<BR>\n<BR>\nYou can use the following link to view the comment made.<BR>\n<BR>\n<a href=\"[siteurl][returnURL]\">[siteurl][returnURL]</a><BR>\n<BR>\n<BR>\nThanks, <BR>\nThe [sitename] Team<BR>\nhttp://[siteurl]\n',NULL,0,0),
 (19,'forgotPW','[sitename]: Password Request','\nHello [firstname],<BR>\n<BR>\nYou recently requested your password on [sitename]<BR>\n------------------------------------------------<BR>\n<a href=\"[siteurl]\">[siteurl]</a><BR>\n------------------------------------------------<BR>\n<BR>\nYour SCiD is:<BR>\n------------------------------------------------<BR>\nEmail: [email]<BR>\nPassword: [password]<BR>\n------------------------------------------------<BR>\n<BR>\nSocialCloudz is a community network of websites utilizing the SC CMS/Social Media <BR>\nWeb Builder App for business or pleasure. With SocialCloudz you can easily build <BR>\na website or social networking community within a matter of minutes. <BR>\n<BR>\nFor information about SC websites:<BR>\n------------------------------------------------<BR>\n<a href=\"http://www.socialcloudz.com\">http://www.socialcloudz.com</a><BR>\n------------------------------------------------<BR>\n<BR>\nPlease feel free to send suggestions, questions, feedback of any sort whatsoever <BR>\nto <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a>.<BR>\n<BR>\nThanks,<BR>\nThe [sitename] Staff<BR>\n<a href=\"[siteurl]\">[siteurl]</a>\n',NULL,0,0),
 (20,'invitenewUser','Welcome to [sitename]','\n\nYou have been invited to [sitename]:<BR>\n------------------------------------------------<BR>\n<a href=\"[siteurl]\">[siteurl]</a><BR>\n------------------------------------------------<BR>\n<BR>\nOur site uses what is called a SCiD. With your SCiD you can login/access any site<BR>\nthat is a part of the our network.<BR>\n<BR>\nYour SCiD is:<BR>\n------------------------------------------------<BR>\nEmail: [inviteemail]<BR>\nPassword: [invitepassword]<BR>\n------------------------------------------------<BR>\n<BR>\nSocialCloudz is a community network of websites utilizing the SC CMS/Social Media <BR>\nWeb Builder App for business or pleasure. With SocialCloudz you can easily build <BR>\na website or social networking community within a matter of minutes. <BR>\n<BR>\nFor information about SC websites:<BR>\n------------------------------------------------<BR>\n<a href=\"http://www.socialcloudz.com\">http://www.socialcloudz.com</a><BR>\n------------------------------------------------<BR>\n<BR>\nPlease feel free to send suggestions, questions, feedback of any sort whatsoever <BR>\nto <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a>.<BR>\n<BR>\nThanks,<BR>\nThe [sitename] Staff<BR>\n<a href=\"[siteurl]\">[siteurl]</a>\n',NULL,0,0),
 (21,'owner_newuser','A New User Has Signed Up on [sitename]','\nHello [adminFirstname],<BR>\n<BR>\n[username] has signed up on your site [sitename].  <BR>\nIf your site is set to private, you will have to approve this user before they can access your site.<BR><BR>\nView their profile here:<BR>\n------------------------------------------------<BR>\n<a href=\"[siteurl]/[username]\">[siteurl]/[username]</a><BR>\n------------------------------------------------<BR>\n',NULL,0,0),
 (22,'newUser_privateSite','Welcome to [sitename]','\nHello [firstname],<BR>\n<BR>\nThanks for signing up with [sitename]:<BR>\n------------------------------------------------<BR>\n<a href=\"[siteurl]\">[siteurl]</a><BR>\n------------------------------------------------<BR>\n<BR>\nYour account needs to be approved by an administrator first!\n<BR><BR>\nOur site uses what is called a SCiD. With your SCiD you can login/access any site<BR>\nthat is a part of the our network.<BR>\n<BR>\nYour SCiD is:<BR>\n------------------------------------------------<BR>\nEmail: [email]<BR>\nPassword: [password]<BR>\n------------------------------------------------<BR>\n<BR>\nSocialCloudz is a community network of websites utilizing the SC CMS/Social Media <BR>\nWeb Builder App for business or pleasure. With SocialCloudz you can easily build <BR>\na website or social networking community within a matter of minutes. <BR>\n<BR>\nFor information about SC websites:<BR>\n------------------------------------------------<BR>\n<a href=\"http://www.socialcloudz.com\">http://www.socialcloudz.com</a><BR>\n------------------------------------------------<BR>\n<BR>\nPlease feel free to send suggestions, questions, feedback of any sort whatsoever <BR>\nto <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a>.<BR>\n<BR>\nThanks,<BR>\nThe [sitename] Staff<BR>\n<a href=\"[siteurl]\">[siteurl]</a>\n',NULL,0,0),
 (23,'newUser','Welcome to [sitename]','\nHello [firstname],<BR>\n<BR>\nThanks for signing up with [sitename]:<BR>\n------------------------------------------------<BR>\n<a href=\"[siteurl]\">[siteurl]</a><BR>\n------------------------------------------------<BR>\n<BR>\nOur site uses what is called a SCiD. With your SCiD you can login/access any site<BR>\nthat is a part of the our network.<BR>\n<BR>\nYour SCiD is:<BR>\n------------------------------------------------<BR>\nEmail: [email]<BR>\nPassword: [password]<BR>\n------------------------------------------------<BR>\n<BR>\nSocialCloudz is a community network of websites utilizing the SC CMS/Social Media <BR>\nWeb Builder App for business or pleasure. With SocialCloudz you can easily build <BR>\na website or social networking community within a matter of minutes. <BR>\n<BR>\nFor information about SC websites:<BR>\n------------------------------------------------<BR>\n<a href=\"http://www.socialcloudz.com\">http://www.socialcloudz.com</a><BR>\n------------------------------------------------<BR>\n<BR>\nPlease feel free to send suggestions, questions, feedback of any sort whatsoever <BR>\nto <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a>.<BR>\n<BR>\nThanks,<BR>\nThe [sitename] Staff<BR>\n<a href=\"[siteurl]\">[siteurl]</a>\n',NULL,0,0),
 (24,'newSite','Welcome to SocialCloudz!','\nHello [username],<BR>\n<BR>\nThanks for choosing SocialCloudz to start [siteName]. <BR>\n<BR>\nYour site url is:<BR>\n------------------------------------------------<BR>\n<a href=\"[siteURL]\">[siteURL]</a><BR>\n------------------------------------------------<BR>\n<BR>\nYou can get started building & editing your SC site at any time by going to this address:<BR>\n------------------------------------------------<BR>\n<a href=\"[siteURL]/getstarted\">[siteURL]/getstarted</a><BR>\n------------------------------------------------<BR>\n<BR>\nIf you need help building or editing your site please review our frequently asked questions and tips.<BR>\n------------------------------------------------<BR>\n<a href=\"[siteURL]/faq\">[siteURL]/faq</a><BR>\n------------------------------------------------<BR>\n<BR>\nSocialCloudz uses what is called a SCiD. With your SCiD you can login/access any site<BR>\nthat is a part of the Social Cloudz Network.<BR>\n<BR>\nYour SCiD is:<BR>\n------------------------------------------------<BR>\nEmail: [email]<BR>\nPassword: [password]<BR>\n------------------------------------------------<BR>\n<BR>\nPlease feel free to send suggestions, questions, feedback of any sort whatsoever <BR>\nto <a href=\"mailto: support@socialcloudz.com\">support@socialcloudz.com</a>.<BR>\n<BR>\nThanks,<BR>\nThe SocialCloudz Staff<BR>\n<a href=\"http://www.socialcloudz.com\">http://www.socialcloudz.com</a>',NULL,0,0),
(25, 'userDenied', NULL, NULL, NULL, '0', '1'),
(26, 'banFromSite', NULL, NULL, NULL, '0', '1'),
(27, 'unbanFromSite', NULL, NULL, NULL, '0', '1'),
(28, 'contentApproved', NULL, NULL, NULL, '0', '1'),
(29, 'contentFlagged', NULL, NULL, NULL, '0', '1'),
(30, 'MailingList', NULL, NULL, NULL, '0', '1');
/*!40000 ALTER TABLE community.`emails` ENABLE KEYS */;

alter table community.emails
 add column `to` varchar(255) default NULL;
 
alter table community.emails
 add column  `cc` varchar(255) default NULL;

 alter table community.emails
 add column  `bcc` varchar(255) default NULL;
 
 alter table community.emails
 add column  `action` varchar(255) default NULL;
 
--//@UNDO
-- SQL to undo the change goes here.

CREATE TABLE community.`siteemails` (
  `CommunityID` int(10) default NULL,
  `WelcomeEmail` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


drop table community.emails;
drop table community.emailTags;
drop table community.emailLogs;
