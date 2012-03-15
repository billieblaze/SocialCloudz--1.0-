--// Bootstrap.sql

-- This is the only SQL script file that is NOT
-- a valid migration and will not be run or tracked
-- in the changelog.  There is no @UNDO section.

--// Do I need this file?

-- New projects likely won't need this file.
-- Existing projects will likely need this file.
-- It's unlikely that this bootstrap should be run
-- in the production environment.

--// Purpose

-- The purpose of this file is to provide a facility
-- to initialize the database to a state before MyBatis
-- SQL migrations were applied.  If you already have
-- a database in production, then you probably have
-- a script that you run on your developer machine
-- to initialize the database.  That script can now
-- be put in this bootstrap file (but does not have
-- to be if you are comfortable with your current process.

--// Running

-- The bootstrap SQL is run with the "migrate bootstrap"
-- command.  It must be run manually, it's never run as
-- part of the regular migration process and will never
-- be undone. Variables (e.g. ${variable}) are still
-- parsed in the bootstrap SQL.

-- After the boostrap SQL has been run, you can then
-- use the migrations and the changelog for all future
-- database change management.

CREATE DATABASE  IF NOT EXISTS `advertising` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `advertising`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: advertising
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `adSize`
--

DROP TABLE IF EXISTS `adSize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adSize` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `width` int(10) unsigned NOT NULL,
  `placement` varchar(45) default NULL,
  `height` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`width`,`height`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banners` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `code` text,
  `weight` int(10) unsigned default NULL,
  `weightScaled` int(10) unsigned default NULL,
  `views` int(10) unsigned zerofill default '0000000000',
  `clicks` int(10) unsigned default '0',
  `active` bit(1) default b'1',
  `adsize` int(10) unsigned default NULL,
  `communityID` int(10) unsigned default NULL,
  `global` bit(1) default NULL,
  `placement` varchar(45) NOT NULL,
  `siteCategory` varchar(128) default NULL,
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`active`,`communityID`,`placement`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'advertising'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:18:05
CREATE DATABASE  IF NOT EXISTS `comments` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `comments`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: comments
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachments` (
  `commentID` int(10) unsigned NOT NULL,
  `attachmentType` varchar(45) NOT NULL,
  `attachmenttitle` varchar(255) default NULL,
  `attachmentdescription` text,
  `attachmenturl` varchar(2048) default NULL,
  `attachmentcode` text,
  `converted` bit(1) default b'1',
  `convertError` bit(1) default b'0',
  PRIMARY KEY  (`commentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `fkType` varchar(45) NOT NULL,
  `fkID` int(10) unsigned NOT NULL,
  `memberID` int(10) unsigned NOT NULL,
  `communityID` int(10) unsigned NOT NULL,
  `title` varchar(255) default NULL,
  `comment` text,
  `guestName` varchar(45) default NULL,
  `guestEmail` varchar(45) default NULL,
  `dateEntered` datetime default NULL,
  `parentID` int(10) unsigned default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=449 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'comments'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:18:07
CREATE DATABASE  IF NOT EXISTS `community` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `community`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: community
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `templateData`
--

DROP TABLE IF EXISTS `templateData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templateData` (
  `templateID` int(10) unsigned NOT NULL,
  `selector` varchar(255) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `ID` int(10) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1113 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `module_rss`
--

DROP TABLE IF EXISTS `module_rss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_rss` (
  `ID` int(10) NOT NULL,
  `feed` varchar(1024) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mailingList`
--

DROP TABLE IF EXISTS `mailingList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailingList` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `communityID` int(10) unsigned NOT NULL,
  `dateEntered` datetime NOT NULL,
  `email` varchar(512) NOT NULL,
  `isDeleted` bit(1) default b'0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `styleElementList`
--

DROP TABLE IF EXISTS `styleElementList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `styleElementList` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `itemID` int(10) unsigned NOT NULL,
  `item` varchar(100) NOT NULL,
  `description` varchar(45) NOT NULL,
  `simple` bit(1) NOT NULL default b'0',
  `advanced` bit(1) NOT NULL default b'1',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `module_html`
--

DROP TABLE IF EXISTS `module_html`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_html` (
  `ID` int(10) NOT NULL,
  `html` longtext,
  `page` varchar(128) default NULL,
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`page`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `community`
--

DROP TABLE IF EXISTS `community`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `community` (
  `communityID` int(10) NOT NULL auto_increment,
  `adminID` int(10) default NULL,
  `site` varchar(50) default NULL,
  `tagline` varchar(200) default NULL,
  `subdomain` varchar(50) default NULL,
  `categoryID` int(10) default NULL,
  `keywords` varchar(500) default NULL,
  `description` longtext,
  `dateCreated` timestamp NULL default CURRENT_TIMESTAMP,
  `heardAbout` varchar(50) default NULL,
  `dateformat` varchar(50) default 'mm/dd/yyyy',
  `dateUpdated` datetime default NULL,
  `removed` bit(1) default b'0',
  `private` bit(1) default b'0',
  `featured` bit(1) default b'0',
  `directory` bit(1) default b'0',
  `google` text,
  `questionSections` varchar(1000) default NULL,
  `dnsMask` varchar(512) default NULL,
  `fullurl` varchar(200) default NULL,
  `domainID` decimal(10,0) default NULL,
  `bandwidth` decimal(20,0) default NULL,
  `storage` decimal(20,0) default NULL,
  `active` bit(1) default b'1',
  `paypalProfile` varchar(45) default NULL,
  `planID` int(10) unsigned default NULL,
  `microsoft` varchar(45) default NULL,
  `logo` varchar(1024) default NULL,
  `parentID` int(10) unsigned NOT NULL default '0',
  `notifications` bit(1) default b'1',
  PRIMARY KEY  (`communityID`),
  KEY `FK_community_communityCategories` (`categoryID`),
  KEY `ix_url_domainID` USING BTREE (`subdomain`),
  KEY `dns` (`dnsMask`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menuFeatures`
--

DROP TABLE IF EXISTS `menuFeatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menuFeatures` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `URL` varchar(512) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stylePropertyList`
--

DROP TABLE IF EXISTS `stylePropertyList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stylePropertyList` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `property` varchar(45) default NULL,
  `description` varchar(45) NOT NULL,
  `elementID` int(10) unsigned NOT NULL,
  `selector` varchar(1024) NOT NULL,
  `simple` bit(1) NOT NULL default b'0',
  `advanced` bit(1) NOT NULL default b'1',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `communitysettings`
--

DROP TABLE IF EXISTS `communitysettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communitysettings` (
  `communityID` int(11) NOT NULL,
  `settingID` int(11) NOT NULL,
  `value` varchar(50) default NULL,
  PRIMARY KEY  (`communityID`,`settingID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modulesettings`
--

DROP TABLE IF EXISTS `modulesettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulesettings` (
  `ID` int(10) NOT NULL auto_increment,
  `moduleID` int(10) default NULL,
  `title` varchar(100) default NULL,
  `sort` varchar(50) default NULL,
  `displayRows` int(10) default NULL,
  `displayMember` int(10) default NULL,
  `displayTemplate` varchar(100) default NULL,
  `communityID` int(11) default NULL,
  `thumbSize` varchar(20) default '75',
  `displaycontentid` int(11) unsigned zerofill default NULL,
  `accesslevel` int(10) unsigned default NULL,
  `displayTag` varchar(255) default NULL,
  `displayCategoryID` int(10) unsigned default NULL,
  `displayLayout` bit(1) default b'1',
  `headerImg` varchar(255) default NULL,
  `featured` bit(1) default b'0',
  `active` bit(1) default b'0',
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`moduleID`),
  KEY `Index_3` (`ID`,`moduleID`)
) ENGINE=InnoDB AUTO_INCREMENT=3360 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `siteemails`
--

DROP TABLE IF EXISTS `siteemails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `siteemails` (
  `CommunityID` int(10) default NULL,
  `WelcomeEmail` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `style`
--

DROP TABLE IF EXISTS `style`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `style` (
  `communityID` int(10) unsigned NOT NULL,
  `selector` varchar(767) NOT NULL,
  `attribute` varchar(767) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY  (`communityID`,`selector`,`attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `layout`
--

DROP TABLE IF EXISTS `layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layout` (
  `page` varchar(50) NOT NULL,
  `columns` int(10) default NULL,
  `template` varchar(50) default NULL,
  `right` varchar(50) default NULL,
  `menu` varchar(50) default NULL,
  `communityID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`communityID`,`page`),
  KEY `Index_1` (`page`,`communityID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `communitysettinglist`
--

DROP TABLE IF EXISTS `communitysettinglist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communitysettinglist` (
  `settingID` int(10) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `valuelist` varchar(50) default NULL,
  `defaultvalue` varchar(50) default NULL,
  `settingType` varchar(50) default NULL,
  `sortOrder` int(10) unsigned default NULL,
  `description` varchar(45) default NULL,
  PRIMARY KEY  (`settingID`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `startPageList`
--

DROP TABLE IF EXISTS `startPageList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `startPageList` (
  `Id` int(10) unsigned NOT NULL auto_increment,
  `value` varchar(45) NOT NULL,
  `label` varchar(45) NOT NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `Title` varchar(45) default NULL,
  `sortOrder` int(10) unsigned NOT NULL,
  `communityID` int(10) unsigned NOT NULL,
  `type` varchar(45) default NULL,
  `url` varchar(1024) default NULL,
  `newWindow` bit(1) default NULL,
  `visibleTo` int(10) unsigned default NULL,
  `feature` int(10) unsigned default NULL,
  `cms` varchar(100) default NULL,
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`sortOrder`,`communityID`),
  KEY `Index_3` (`communityID`)
) ENGINE=InnoDB AUTO_INCREMENT=5930 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modulepage`
--

DROP TABLE IF EXISTS `modulepage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulepage` (
  `modulesettingID` int(10) NOT NULL,
  `sortOrder` int(10) default NULL,
  `list` int(10) default NULL,
  `page` varchar(50) NOT NULL default ' ',
  `communityID` int(10) NOT NULL default '0',
  PRIMARY KEY  USING BTREE (`modulesettingID`,`page`,`communityID`),
  KEY `Index_2` (`list`,`page`,`communityID`),
  KEY `Index_3` (`sortOrder`,`list`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `moduleID` int(10) NOT NULL auto_increment,
  `title` varchar(50) default NULL,
  `page` char(10) default NULL,
  `file` varchar(50) default NULL,
  `contentType` varchar(50) default NULL,
  `moduleType` varchar(50) default NULL,
  `desc` varchar(200) default NULL,
  `icon` varchar(50) default NULL,
  `active` bit(1) default NULL,
  `editfile` varchar(50) default NULL,
  PRIMARY KEY  (`moduleID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pageSettingList`
--

DROP TABLE IF EXISTS `pageSettingList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageSettingList` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `valueList` varchar(1024) default NULL,
  `defaultValue` varchar(255) NOT NULL,
  `settingType` varchar(45) NOT NULL,
  `sortOrder` int(10) unsigned NOT NULL,
  `page` varchar(45) NOT NULL,
  `description` varchar(255) NOT NULL,
  `settingGroup` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cname`
--

DROP TABLE IF EXISTS `cname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cname` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `domainname` varchar(255) NOT NULL,
  PRIMARY KEY  USING BTREE (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmsPages`
--

DROP TABLE IF EXISTS `cmsPages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmsPages` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `description` text,
  `keywords` text,
  `url` varchar(255) character set utf8 NOT NULL,
  `communityID` int(10) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`url`,`communityID`)
) ENGINE=InnoDB AUTO_INCREMENT=703 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `thumbnail` varchar(255) default NULL,
  `width` int(10) unsigned default NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `styleExtra`
--

DROP TABLE IF EXISTS `styleExtra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `styleExtra` (
  `communityID` int(10) unsigned NOT NULL,
  `extracss` text,
  PRIMARY KEY  (`communityID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domains`
--

DROP TABLE IF EXISTS `domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domains` (
  `domainID` int(10) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `private` tinyint(4) default NULL,
  PRIMARY KEY  (`domainID`),
  KEY `ix_domainname` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `dateEntered` datetime NOT NULL,
  `dateExpires` datetime default NULL,
  `communityID` int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `display` int(10) default NULL,
  `showFrequency` varchar(255) default NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`dateEntered`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `styleItemList`
--

DROP TABLE IF EXISTS `styleItemList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `styleItemList` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `description` varchar(45) NOT NULL,
  `simple` bit(1) NOT NULL default b'1',
  `advanced` bit(1) NOT NULL default b'1',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `communitycategories`
--

DROP TABLE IF EXISTS `communitycategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communitycategories` (
  `id` int(10) NOT NULL auto_increment,
  `category` varchar(128) default NULL,
  `domain` int(10) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pageSettings`
--

DROP TABLE IF EXISTS `pageSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pageSettings` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `communityID` int(10) unsigned NOT NULL,
  `settingID` int(10) unsigned NOT NULL,
  `value` varchar(255) NOT NULL,
  `page` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`page`)
) ENGINE=InnoDB AUTO_INCREMENT=1508 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'community'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:18:27
CREATE DATABASE  IF NOT EXISTS `contentstore` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `contentstore`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: contentstore
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `attribs`
--

DROP TABLE IF EXISTS `attribs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribs` (
  `contentID` int(10) NOT NULL,
  `keyname` varchar(50) NOT NULL,
  `keyvalue` varchar(1000) default NULL,
  KEY `contentID_keyname` (`contentID`,`keyname`),
  CONSTRAINT `FK_attribs_1` FOREIGN KEY (`contentID`) REFERENCES `content` (`contentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `category` varchar(128) NOT NULL,
  `communityID` int(10) unsigned NOT NULL,
  `memberID` int(10) unsigned default NULL,
  `contentType` varchar(128) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contenttype`
--

DROP TABLE IF EXISTS `contenttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contenttype` (
  `contentType` varchar(20) NOT NULL,
  `Description` varchar(255) default NULL,
  `link` varchar(255) default NULL,
  `linkID` varchar(20) default NULL,
  `homeLink` varchar(255) default NULL,
  `type` varchar(45) default NULL,
  `parentContentType` varchar(20) default NULL,
  `communityID` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`contentType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `UISettings`
--

DROP TABLE IF EXISTS `UISettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UISettings` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `contentType` varchar(45) default NULL,
  `mainTemplate` varchar(45) default NULL,
  `detailTemplate` varchar(45) default NULL,
  `formTemplate` varchar(45) default NULL,
  `communityID` int(10) unsigned default '0',
  `mainFooter` varchar(45) default NULL,
  `detailFooter` varchar(45) default NULL,
  `formFooter` varchar(45) default NULL,
  `mainRightNav` varchar(255) default NULL,
  `detailRightnav` varchar(255) default NULL,
  `formRightnav` varchar(255) default NULL,
  `childFormTemplate` varchar(255) default NULL,
  `childFormFooter` varchar(255) default NULL,
  `childFormRightnav` varchar(255) default NULL,
  `submitPreFuseaction` varchar(255) default NULL,
  `submitPostFuseaction` varchar(255) default NULL,
  `submitChildPostURL` varchar(255) default NULL,
  `relocateAfterSave` varchar(255) default NULL,
  `sortOrderTemplate` varchar(255) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `ID` int(10) NOT NULL auto_increment,
  `contentID` int(10) NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `contentID` (`contentID`),
  CONSTRAINT `FK_tags_1` FOREIGN KEY (`contentID`) REFERENCES `content` (`contentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7053 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `community`
--

DROP TABLE IF EXISTS `community`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `community` (
  `ID` int(10) NOT NULL auto_increment,
  `contentID` int(10) NOT NULL,
  `communityID` int(10) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `communityContent` (`contentID`,`communityID`),
  CONSTRAINT `FK_community_1` FOREIGN KEY (`contentID`) REFERENCES `content` (`contentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20578 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `outputTemplates`
--

DROP TABLE IF EXISTS `outputTemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outputTemplates` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `template` varchar(45) NOT NULL,
  `description` varchar(255) default NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access` (
  `contentID` int(10) unsigned NOT NULL,
  `view` bit(1) NOT NULL default b'1',
  `comment` bit(1) NOT NULL default b'1',
  `rate` bit(1) NOT NULL default b'1',
  `group` varchar(10) NOT NULL,
  PRIMARY KEY  USING BTREE (`contentID`,`group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contentcategory`
--

DROP TABLE IF EXISTS `contentcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contentcategory` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `contentID` int(10) unsigned NOT NULL,
  `categoryID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4286 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `contentID` int(10) unsigned NOT NULL,
  `city` varchar(45) default NULL,
  `state` varchar(45) default NULL,
  `country` varchar(45) default NULL,
  `latitude` varchar(45) default NULL,
  `longitude` varchar(45) default NULL,
  `zipcode` varchar(45) default NULL,
  `phone` varchar(45) default NULL,
  `address` varchar(256) default NULL,
  `venue` varchar(255) default NULL,
  PRIMARY KEY  (`contentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `contentID` int(10) default NULL,
  `contentType` varchar(20) default NULL,
  `memberID` int(10) default NULL,
  `ID` int(10) NOT NULL auto_increment,
  `level` int(11) NOT NULL default '1',
  PRIMARY KEY  (`ID`),
  KEY `contentID_memberID` (`contentID`,`memberID`),
  KEY `Index_3` (`contentID`,`level`),
  CONSTRAINT `FK_favorites_1` FOREIGN KEY (`contentID`) REFERENCES `content` (`contentID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `import`
--

DROP TABLE IF EXISTS `import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import` (
  `area` varchar(255) character set utf8 default NULL,
  `name` varchar(255) character set utf8 default NULL,
  `address` varchar(255) character set utf8 default NULL,
  `City` varchar(255) character set utf8 default NULL,
  `State` varchar(255) character set utf8 default NULL,
  `Zip` varchar(255) character set utf8 default NULL,
  `phone` varchar(255) character set utf8 default NULL,
  `star` double default NULL,
  `price` varchar(255) character set utf8 default NULL,
  `outside_tables` double default NULL,
  `sun` varchar(255) character set utf8 default NULL,
  `umbrella` varchar(255) character set utf8 default NULL,
  `shade` varchar(255) character set utf8 default NULL,
  `under_cover` varchar(255) character set utf8 default NULL,
  `lunch` varchar(255) character set utf8 default NULL,
  `dinner` varchar(255) character set utf8 default NULL,
  `brunch` varchar(255) character set utf8 default NULL,
  `pets` varchar(255) character set utf8 default NULL,
  `website` varchar(255) character set utf8 default NULL,
  `yelp` varchar(255) character set utf8 default NULL,
  `type_food` varchar(255) character set utf8 default NULL,
  `F22` varchar(255) character set utf8 default NULL,
  `F23` varchar(255) character set utf8 default NULL,
  `F24` varchar(255) character set utf8 default NULL,
  `F25` varchar(255) character set utf8 default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `contentID` int(10) NOT NULL auto_increment,
  `contentType` varchar(20) NOT NULL,
  `MemberID` int(10) NOT NULL,
  `dateCreated` datetime default NULL,
  `dateUpdated` datetime default NULL,
  `private` bit(1) default b'0',
  `download` bit(1) default b'1',
  `comments` bit(1) default b'1',
  `rating` bit(1) default b'1',
  `explicit` bit(1) default b'0',
  `flagged` bit(1) default b'0',
  `approved` bit(1) default b'1',
  `parentID` int(10) default '0',
  `isDeleted` bit(1) default b'0',
  `featured` bit(1) default b'0',
  `views` int(10) default '0',
  `groupid` int(10) default '0',
  `publishDate` datetime default NULL,
  `ratingAverage` decimal(10,0) default '3',
  `commentCount` int(10) unsigned default '0',
  PRIMARY KEY  (`contentID`),
  KEY `contentIDcontentType` (`contentID`,`contentType`,`isDeleted`,`private`),
  KEY `parentid` (`parentID`),
  KEY `FK_content_contentType` (`contentType`),
  KEY `contentID_contentType_approved_private` (`contentID`,`contentType`,`approved`,`private`),
  KEY `isdeleted` (`isDeleted`),
  KEY `Index_7` (`contentType`,`isDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=16419 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `ID` int(10) NOT NULL auto_increment,
  `contentID` int(10) default NULL,
  `memberID` int(10) default NULL,
  `directory` varchar(255) default NULL,
  `file` varchar(255) default NULL,
  `filesize` decimal(18,0) default NULL,
  `dateEntered` datetime default NULL,
  PRIMARY KEY  (`ID`),
  KEY `FK_files_content` (`contentID`),
  CONSTRAINT `FK_files_1` FOREIGN KEY (`contentID`) REFERENCES `content` (`contentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2719 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `standardattribs`
--

DROP TABLE IF EXISTS `standardattribs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `standardattribs` (
  `contentID` int(10) NOT NULL,
  `title` varchar(255) default NULL,
  `desc` longtext,
  `creator` varchar(255) default NULL,
  `groupID` int(10) default NULL,
  `image` varchar(255) default NULL,
  `sortOrder` int(10) unsigned default NULL,
  `startdate` datetime default '1970-01-01 00:00:00',
  `enddate` datetime default NULL,
  `categoryID` int(10) unsigned default NULL,
  `subTitle` varchar(255) default NULL,
  PRIMARY KEY  (`contentID`),
  KEY `creator` (`creator`),
  KEY `categoryID` (`categoryID`),
  CONSTRAINT `FK_standardattribs_1` FOREIGN KEY (`contentID`) REFERENCES `content` (`contentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'contentstore'
--
/*!50003 DROP FUNCTION IF EXISTS `attributesByContentID` */;
--
-- WARNING: old server version. The following dump may be incomplete.
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
-- --DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`ds`@`%`*/ /*!50003 FUNCTION `attributesByContentID`(in_contentID int) RETURNS text CHARSET latin1
BEGIN        declare rval text;        declare tmpKeyName varchar(100);        declare tmpKeyValue text;        DECLARE done INT DEFAULT 0;        DECLARE cur1 CURSOR FOR                 SELECT 	keyname, ifnull(keyvalue,'') as keyvalue 		FROM 	attribs 		WHERE 	ContentId = in_contentID;        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;               set rval = ''; OPEN cur1;  WHILE NOT done DO   FETCH cur1 INTO tmpKeyName, tmpKeyValue;        IF done = 0  THEN               SET rval = CONCAT(rval, '<', tmpKeyName,'><![CDATA[',tmpKeyValue,']]></',tmpKeyName,'>');         end if; END WHILE; set rval = concat('<?xml version="1.0" encoding="utf-8"?><attributes>', rval, '</attributes>');  close cur1;   RETURN rval; END */;;
----DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 DROP FUNCTION IF EXISTS `categoriesByContentID` */;
--
-- WARNING: old server version. The following dump may be incomplete.
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
-- --DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`ds`@`%`*/ /*!50003 FUNCTION `categoriesByContentID`(in_contentID int) RETURNS text CHARSET utf8
BEGIN        declare rval text;        declare tmpvar varchar(100);         DECLARE done INT DEFAULT 0;        DECLARE cur1 CURSOR FOR                 SELECT         category 		FROM 	category    c                 inner join contentcategory cc on cc.categoryID = c.id  		WHERE 	ContentId = in_ContentId  ;        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;       OPEN cur1;  WHILE NOT done DO   FETCH cur1 INTO tmpvar;        IF done = 0  THEN                set rval = concat_ws(',', rval, tmpvar);        end if; END WHILE;  close cur1;   RETURN rval; END */;;
----DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 DROP FUNCTION IF EXISTS `childCountByContentID` */;
--
-- WARNING: old server version. The following dump may be incomplete.
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
----DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`ds`@`%`*/ /*!50003 FUNCTION `childCountByContentID`( in_contentID int) RETURNS int(11)
BEGIN         declare rval int;      	SELECT 	count(contentID)    into rval 		FROM 	content 		WHERE 	ParentId = in_contentId                 and isdeleted = 0;                 RETURN rval;  END */;;
----DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 DROP FUNCTION IF EXISTS `GetDistance` */;
--
-- WARNING: old server version. The following dump may be incomplete.
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
----DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`ds`@`%`*/ /*!50003 FUNCTION `GetDistance`(  lat1  numeric (9,6),  lon1  numeric (9,6),  lat2  numeric (9,6),  lon2  numeric (9,6) ) RETURNS decimal(10,5)
BEGIN   DECLARE  x  decimal (20,10);   DECLARE  pi  decimal (21,20);   SET  pi = 3.14159265358979323846;   SET  x = sin( lat1 * pi/180 ) * sin( lat2 * pi/180  ) + cos(  lat1 *pi/180 ) * cos( lat2 * pi/180 ) * cos(  abs( (lon2 * pi/180) -  (lon1 *pi/180) ) );   SET  x = atan( ( sqrt( 1- power( x, 2 ) ) ) / x );   RETURN  ( 1.852 * 60.0 * ((x/pi)*180) ) / 1.609344; END */;;
----DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 DROP FUNCTION IF EXISTS `ratingAverage` */;
--
-- WARNING: old server version. The following dump may be incomplete.
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
----DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`ds`@`%`*/ /*!50003 FUNCTION `ratingAverage`(in_contentID int) RETURNS int(11)
BEGIN          declare rval int;  	 SELECT ifnull(avg(rating),3) into rval          from ratings          where (contentid = in_contentid );             RETURN rval;   END */;;
--DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 DROP FUNCTION IF EXISTS `tagsByContentID` */;
--
-- WARNING: old server version. The following dump may be incomplete.
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
--DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`ds`@`%`*/ /*!50003 FUNCTION `tagsByContentID`(in_contentID int) RETURNS text CHARSET utf8
BEGIN        declare rval text;        declare tmpvar varchar(100);         DECLARE done INT DEFAULT 0;        DECLARE cur1 CURSOR FOR                 SELECT         value 		FROM 	tags 		WHERE 	ContentId = in_ContentId  ;        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;       OPEN cur1;  WHILE NOT done DO   FETCH cur1 INTO tmpvar;        IF done = 0  THEN                set rval = concat_ws(',', rval, tmpvar);        end if; END WHILE;  close cur1;   RETURN rval; END */;;
--DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 DROP PROCEDURE IF EXISTS `countContent` */;
--
-- WARNING: old server version. The following dump may be incomplete.
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
--DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`ds`@`%`*/ /*!50003 PROCEDURE `countContent`(IN communityID INTEGER)
BEGIN   DECLARE done INT DEFAULT 0;   DECLARE a VARCHAR(20);   DECLARE stmt TEXT;   DECLARE cur1 CURSOR for SELECT CONTENTTYPE FROM `contentstore`.`contenttype`;   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;     set @stmt = 'select ';    OPEN cur1;    REPEAT           FETCH cur1 INTO a;            IF NOT done THEN              SET @stmt := concat(@stmt, '(select count(content.contentID) from content inner join community on community.contentID = content.contentID where communityid = ', communityID, ' and contenttype = ''', a, ''') as `', a, '`,');           END IF;   UNTIL done END REPEAT;    CLOSE cur1;    SET @stmt := concat(@stmt, '0 as test');   prepare pStmt from @stmt;   execute pStmt;     END */;;
--DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:18:39
CREATE DATABASE  IF NOT EXISTS `formManager` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `formManager`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: formManager
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `dcCom_Instances`
--

DROP TABLE IF EXISTS `dcCom_Instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dcCom_Instances` (
  `instanceId` int(10) unsigned NOT NULL auto_increment,
  `dcComComponent` varchar(30) NOT NULL,
  `instance` varchar(30) NOT NULL,
  `instancePosition` enum('Top','Bottom','Hidden') NOT NULL default 'Bottom',
  PRIMARY KEY  (`instanceId`)
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dccom_twform_formsubmissions`
--

DROP TABLE IF EXISTS `dccom_twform_formsubmissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dccom_twform_formsubmissions` (
  `submissionId` int(10) unsigned NOT NULL auto_increment,
  `instanceId` int(10) unsigned NOT NULL,
  `submissionDate` datetime NOT NULL,
  `submissionUserIP` varchar(15) NOT NULL,
  `submissionPostWDDX` text NOT NULL,
  PRIMARY KEY  (`submissionId`),
  KEY `instanceId` (`instanceId`)
) ENGINE=InnoDB AUTO_INCREMENT=413 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dccom_twform_forms`
--

DROP TABLE IF EXISTS `dccom_twform_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dccom_twform_forms` (
  `instanceId` int(10) unsigned NOT NULL,
  `formTitle` varchar(255) NOT NULL,
  `formCreationDate` datetime NOT NULL,
  `formCreatedByUserId` int(10) unsigned default NULL,
  `formLastUpdatedDate` datetime NOT NULL,
  `formLastUpdatedByUserId` int(10) unsigned default NULL,
  `formDesignWDDX` text,
  PRIMARY KEY  (`instanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'formManager'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:18:42
CREATE DATABASE  IF NOT EXISTS `forums` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `forums`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: forums
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `smiles`
--

DROP TABLE IF EXISTS `smiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smiles` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `communityID` int(10) unsigned NOT NULL,
  `filename` varchar(255) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptions` (
  `ID` int(10) NOT NULL auto_increment,
  `topicID` int(10) default NULL,
  `memberID` int(10) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forums`
--

DROP TABLE IF EXISTS `forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forums` (
  `ID` int(10) NOT NULL auto_increment,
  `forum` varchar(255) character set utf8 default NULL,
  `forum_desc` longtext,
  `communityID` int(10) default NULL,
  `sortOrder` int(10) default NULL,
  `sectionID` int(10) default '0',
  PRIMARY KEY  (`ID`),
  KEY `communityID` (`communityID`),
  KEY `forumsI` (`ID`,`communityID`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vulgarity`
--

DROP TABLE IF EXISTS `vulgarity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vulgarity` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `communityID` int(10) unsigned NOT NULL,
  `word` varchar(50) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `ID` int(10) NOT NULL auto_increment,
  `Title` varchar(255) character set utf8 default NULL,
  `postDate` datetime default NULL,
  `memberID` int(10) default NULL,
  `content` longtext,
  `forumID` int(10) default NULL,
  `sticky` bit(1) default b'0',
  `views` int(10) default '0',
  `pollID` int(10) default '0',
  `locked` bit(1) default b'0',
  `postID` int(10) unsigned default '0',
  PRIMARY KEY  (`ID`),
  KEY `forumID` (`forumID`),
  KEY `postdate` (`postDate`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `moderators`
--

DROP TABLE IF EXISTS `moderators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moderators` (
  `forumID` int(10) unsigned NOT NULL,
  `memberID` int(10) unsigned NOT NULL,
  `ID` int(10) unsigned NOT NULL auto_increment,
  PRIMARY KEY  USING BTREE (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ban`
--

DROP TABLE IF EXISTS `ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ban` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `memberID` int(10) unsigned NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `reason` varchar(255) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `ID` int(10) NOT NULL auto_increment,
  `section` varchar(255) character set utf8 default NULL,
  `communityID` int(10) default NULL,
  `sortOrder` int(10) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `forum_list`
--

DROP TABLE IF EXISTS `forum_list`;
/*!50001 DROP VIEW IF EXISTS `forum_list`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `forum_list` (
  `Top_Id` int(10),
  `ID` int(10),
  `Title` varchar(255),
  `postDate` datetime,
  `memberID` int(10),
  `postID` int(10) unsigned,
  `communityID` int(10),
  `forum` varchar(255),
  `forum_desc` longtext,
  `Expr1` int(10) unsigned,
  `sortorder` int(10),
  `topicCount` bigint(21),
  `postCount` bigint(21),
  `sectionID` int(10)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `lastpost`
--

DROP TABLE IF EXISTS `lastpost`;
/*!50001 DROP VIEW IF EXISTS `lastpost`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `lastpost` (
  `forumID` int(10),
  `Top_Id` int(10)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `maxPost`
--

DROP TABLE IF EXISTS `maxPost`;
/*!50001 DROP VIEW IF EXISTS `maxPost`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `maxPost` (
  `top_ID` int(10),
  `postID` decimal(11,0)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `postlist`
--

DROP TABLE IF EXISTS `postlist`;
/*!50001 DROP VIEW IF EXISTS `postlist`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `postlist` (
  `Title` varchar(255),
  `ID` decimal(11,0),
  `postMember` int(10),
  `memberID` int(10),
  `forumID` int(10),
  `views` int(10),
  `maxdate` datetime,
  `locked` bit(1),
  `replyCount` bigint(21),
  `sticky` bit(1)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `forum_list`
--

/*!50001 DROP TABLE IF EXISTS `forum_list`*/;
/*!50001 DROP VIEW IF EXISTS `forum_list`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `forum_list` AS select `flp`.`Top_Id` AS `Top_Id`,`f`.`ID` AS `ID`,`fp`.`Title` AS `Title`,`fp`.`postDate` AS `postDate`,`fp`.`memberID` AS `memberID`,`fp`.`postID` AS `postID`,`f`.`communityID` AS `communityID`,`f`.`forum` AS `forum`,`f`.`forum_desc` AS `forum_desc`,`fp`.`postID` AS `Expr1`,`f`.`sortOrder` AS `sortorder`,(select count(`fp`.`ID`) AS `Expr1` from `posts` `fp` where ((`fp`.`forumID` = `f`.`ID`) and (`fp`.`postID` = 0))) AS `topicCount`,(select count(`fp`.`ID`) AS `Expr1` from `posts` `fp` where (`fp`.`forumID` = `f`.`ID`)) AS `postCount`,`f`.`sectionID` AS `sectionID` from ((`forums` `f` left join `lastpost` `flp` on((`f`.`ID` = `flp`.`forumID`))) left join `posts` `fp` on((`fp`.`ID` = `flp`.`Top_Id`))) */;

--
-- Final view structure for view `lastpost`
--

/*!50001 DROP TABLE IF EXISTS `lastpost`*/;
/*!50001 DROP VIEW IF EXISTS `lastpost`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `lastpost` AS select distinct `posts`.`forumID` AS `forumID`,max(`posts`.`ID`) AS `Top_Id` from `posts` where (ifnull(`posts`.`forumID`,_utf8'') <> _utf8'') group by `posts`.`forumID` */;

--
-- Final view structure for view `maxPost`
--

/*!50001 DROP TABLE IF EXISTS `maxPost`*/;
/*!50001 DROP VIEW IF EXISTS `maxPost`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `maxPost` AS select max(`posts`.`ID`) AS `top_ID`,(case `posts`.`postID` when 0 then `posts`.`ID` else `posts`.`postID` end) AS `postID` from `posts` group by (case `posts`.`postID` when 0 then `posts`.`ID` else `posts`.`postID` end) */;

--
-- Final view structure for view `postlist`
--

/*!50001 DROP TABLE IF EXISTS `postlist`*/;
/*!50001 DROP VIEW IF EXISTS `postlist`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `postlist` AS select `fp2`.`Title` AS `Title`,`mp`.`postID` AS `ID`,`fp`.`memberID` AS `postMember`,`fp2`.`memberID` AS `memberID`,`fp2`.`forumID` AS `forumID`,`fp2`.`views` AS `views`,`fp`.`postDate` AS `maxdate`,`fp`.`locked` AS `locked`,(select count(`fp3`.`postID`) AS `postID` from `posts` `fp3` where (`fp3`.`postID` = `fp2`.`ID`)) AS `replyCount`,`fp2`.`sticky` AS `sticky` from ((`maxPost` `mp` join `posts` `fp` on((`fp`.`ID` = `mp`.`top_ID`))) join `posts` `fp2` on((`fp2`.`ID` = `mp`.`postID`))) */;

--
-- Dumping routines for database 'forums'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:18:54
CREATE DATABASE  IF NOT EXISTS `location` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `location`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: location
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `ips`
--

DROP TABLE IF EXISTS `ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ips` (
  `fromIp` bigint(20) default NULL,
  `toIp` bigint(20) default NULL,
  `CountryCode` varchar(10) character set utf8 default NULL,
  `countryName` varchar(50) character set utf8 default NULL,
  `region` varchar(50) character set utf8 default NULL,
  `city` varchar(50) character set utf8 default NULL,
  KEY `countryCode_City` (`CountryCode`,`city`),
  KEY `iprange` USING BTREE (`toIp`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='InnoDB free: 651264 kB';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `id` int(11) NOT NULL auto_increment,
  `state` varchar(32) default NULL,
  `abbr` varchar(2) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `countryCode` varchar(2) character set utf8 default NULL,
  `asciiName` varchar(255) character set utf8 default NULL,
  `city` varchar(255) character set utf8 default NULL,
  `state` char(2) character set utf8 default NULL,
  `latitude` varchar(50) character set utf8 default NULL,
  `longitude` varchar(50) character set utf8 default NULL,
  `population` bigint(20) unsigned default NULL,
  KEY `population` (`population`),
  FULLTEXT KEY `asciiname` (`asciiName`),
  FULLTEXT KEY `City` (`city`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countrycode`
--

DROP TABLE IF EXISTS `countrycode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countrycode` (
  `countryCode` varchar(2) character set utf8 default NULL,
  `countryName` varchar(100) character set utf8 default NULL,
  KEY `countryCode` (`countryCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Country`
--

DROP TABLE IF EXISTS `Country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Country` (
  `ID` int(11) NOT NULL,
  `Country` varchar(150) character set utf8 default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cellprovider`
--

DROP TABLE IF EXISTS `cellprovider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cellprovider` (
  `ID` int(11) NOT NULL auto_increment,
  `company` varchar(50) character set utf8 default NULL,
  `emailaddress` varchar(255) character set utf8 default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'location'
--
/*!50003 DROP FUNCTION IF EXISTS `getDistance` */;
--
-- WARNING: old server version. The following dump may be incomplete.
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
--DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 FUNCTION `getDistance`( lat1  numeric (9,6),  lon1  numeric (9,6),  lat2  numeric (9,6),  lon2  numeric (9,6) ) RETURNS decimal(10,5)
BEGIN   DECLARE  x  decimal (20,10);   DECLARE  pi  decimal (21,20);   SET  pi = 3.14159265358979323846;   SET  x = sin( lat1 * pi/180 ) * sin( lat2 * pi/180  ) + cos(  lat1 *pi/180 ) * cos( lat2 * pi/180 ) * cos(  abs ( (lon2 * pi/180) -  (lon1 *pi/180) ) );   SET  x = atan( ( sqrt( 1- power( x, 2 ) ) ) / x );   RETURN  ( 1.852 * 60.0 * ((x/pi)*180) ) / 1.609344;  END */;;
--DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:18:59
CREATE DATABASE  IF NOT EXISTS `mail` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mail`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: mail
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `folders`
--

DROP TABLE IF EXISTS `folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folders` (
  `folderID` int(10) unsigned NOT NULL auto_increment,
  `folderName` varchar(45) NOT NULL,
  `memberID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`folderID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `sourceID` int(10) unsigned NOT NULL,
  `targetID` int(10) unsigned NOT NULL,
  `subject` varchar(512) NOT NULL,
  `message` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateRead` datetime default '1970-01-01 00:00:00',
  `sourceDelete` bit(1) default b'0',
  `targetDelete` bit(1) default b'0',
  `folder` int(10) unsigned NOT NULL default '1',
  `parentID` int(10) unsigned NOT NULL default '0',
  `read` bit(1) NOT NULL default b'0',
  `replied` bit(1) NOT NULL default b'0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'mail'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:19:01
CREATE DATABASE  IF NOT EXISTS `members` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `members`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: members
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `profileSections`
--

DROP TABLE IF EXISTS `profileSections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profileSections` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(128) NOT NULL,
  `communityID` int(10) unsigned NOT NULL,
  `sortorder` int(10) unsigned default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profileAnswers`
--

DROP TABLE IF EXISTS `profileAnswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profileAnswers` (
  `questionID` int(10) unsigned NOT NULL,
  `memberID` int(10) unsigned NOT NULL,
  `value` text,
  PRIMARY KEY  USING BTREE (`questionID`,`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocks` (
  `sourceID` int(10) NOT NULL,
  `targetID` int(10) NOT NULL,
  `dateEntered` datetime default NULL,
  PRIMARY KEY  (`sourceID`,`targetID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `desc` text,
  `active` bit(1) default b'1',
  `isVisible` bit(1) default b'1',
  `dateCreated` datetime default NULL,
  `communityID` int(10) unsigned NOT NULL,
  `type` varchar(15) default NULL,
  `memberID` int(10) unsigned NOT NULL,
  `contentID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invitationTracking`
--

DROP TABLE IF EXISTS `invitationTracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitationTracking` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `dateEntered` datetime NOT NULL,
  `memberid` int(10) unsigned default NULL,
  `visitorID` int(10) unsigned NOT NULL,
  `invitationID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groupMember`
--

DROP TABLE IF EXISTS `groupMember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupMember` (
  `groupid` int(10) unsigned NOT NULL auto_increment,
  `memberid` int(10) unsigned NOT NULL,
  `dateEntered` datetime NOT NULL,
  `admin` bit(1) NOT NULL default b'0',
  PRIMARY KEY  USING BTREE (`groupid`,`memberid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `memberID` int(10) unsigned NOT NULL,
  `viewed` bit(1) NOT NULL default b'0',
  `dateEntered` datetime NOT NULL,
  `linkURL` varchar(512) NOT NULL,
  `type` varchar(45) NOT NULL,
  `message` varchar(1024) NOT NULL,
  `communityID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`memberID`,`viewed`,`communityID`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members` (
  `memberID` int(10) NOT NULL auto_increment,
  `username` varchar(50) default NULL,
  `email` varchar(255) default NULL,
  `password` varchar(50) default NULL,
  `firstname` varchar(100) default NULL,
  `lastname` varchar(255) default NULL,
  `city` varchar(80) default NULL,
  `state` varchar(30) default NULL,
  `zip` varchar(50) default NULL,
  `country` varchar(50) default NULL,
  `latitude` varchar(50) default NULL,
  `longitude` varchar(50) default NULL,
  `gender` int(10) default NULL,
  `birthDate` date default NULL,
  `cellPhone` varchar(50) default NULL,
  `cellProvider` varchar(50) default NULL,
  `timezone` decimal(18,0) default NULL,
  `signupComplete` bit(1) default b'0',
  `heardabout` varchar(50) default NULL,
  `globalAdmin` bit(1) default b'0',
  `mailBounce` int(10) unsigned default '0',
  PRIMARY KEY  (`memberID`),
  UNIQUE KEY `email` (`email`),
  KEY `displayname` (`username`),
  KEY `emailPassword` (`email`,`password`)
) ENGINE=InnoDB AUTO_INCREMENT=1064 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `membersaccount`
--

DROP TABLE IF EXISTS `membersaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membersaccount` (
  `communityID` int(10) NOT NULL,
  `memberID` int(10) NOT NULL,
  `dateEntered` datetime default NULL,
  `invisible` bit(1) default b'0',
  `online` bit(1) default b'0',
  `idle` bit(1) default b'0',
  `lastClick` datetime default NULL,
  `status` varchar(255) default NULL,
  `flagged` bit(1) default b'0',
  `approved` bit(1) default b'0',
  `removed` bit(1) default b'0',
  `image` varchar(512) default NULL,
  `numlogins` int(10) unsigned NOT NULL default '0',
  `profileViews` int(10) unsigned NOT NULL default '0',
  `newsletter` bit(1) NOT NULL default b'1',
  `htmlMail` bit(1) NOT NULL default b'1',
  `featured` bit(1) default b'0',
  PRIMARY KEY  (`communityID`,`memberID`),
  KEY `FK_membersAccount_members` (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preferences`
--

DROP TABLE IF EXISTS `preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferences` (
  `preferenceID` int(10) NOT NULL,
  `memberID` int(10) NOT NULL,
  `value` int(10) default NULL,
  PRIMARY KEY  (`preferenceID`,`memberID`),
  KEY `FK_preferences_members` (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profileQuestions`
--

DROP TABLE IF EXISTS `profileQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profileQuestions` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `Question` varchar(500) default NULL,
  `sectionID` int(10) unsigned NOT NULL,
  `type` varchar(45) default NULL,
  `sortorder` int(10) unsigned default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invitationCode`
--

DROP TABLE IF EXISTS `invitationCode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitationCode` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `idString` varchar(45) NOT NULL,
  `memberid` int(10) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `sourceID` int(10) NOT NULL,
  `targetID` int(10) NOT NULL,
  `approved` decimal(10,0) default NULL,
  `dateEntered` datetime default NULL,
  PRIMARY KEY  (`sourceID`,`targetID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preferencelist`
--

DROP TABLE IF EXISTS `preferencelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferencelist` (
  `ID` int(10) NOT NULL auto_increment,
  `displayName` varchar(255) default NULL,
  `name` varchar(128) default NULL,
  `answers` varchar(50) default NULL,
  `defaultValue` int(10) default NULL,
  `sortOrder` int(10) default NULL,
  `section` varchar(20) default NULL,
  `username` varchar(255) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access` (
  `memberID` int(10) NOT NULL,
  `communityID` int(10) NOT NULL,
  `accessLevel` int(10) default NULL,
  PRIMARY KEY  (`memberID`,`communityID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invitation`
--

DROP TABLE IF EXISTS `invitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitation` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `memberid` int(10) unsigned NOT NULL,
  `dateEntered` datetime NOT NULL,
  `invitationCode` int(10) unsigned default NULL,
  `email` varchar(255) default NULL,
  `campaign` varchar(255) default NULL,
  `communityID` int(10) unsigned NOT NULL,
  `landingPage` varchar(1024) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ban`
--

DROP TABLE IF EXISTS `ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ban` (
  `communityID` int(10) NOT NULL,
  `memberID` int(10) NOT NULL,
  `dateEntered` datetime default NULL,
  `dateExpires` datetime default NULL,
  `item` varchar(50) default NULL,
  PRIMARY KEY  (`communityID`,`memberID`),
  KEY `FK_ban_members` (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!50001 DROP VIEW IF EXISTS `profile`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `profile` (
  `question` varchar(500),
  `questionID` int(10) unsigned,
  `value` text,
  `type` varchar(45),
  `memberid` int(10) unsigned,
  `communityID` int(10) unsigned,
  `sectionID` int(10) unsigned
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `profile`
--

/*!50001 DROP TABLE IF EXISTS `profile`*/;
/*!50001 DROP VIEW IF EXISTS `profile`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ds`@`%` SQL SECURITY DEFINER VIEW `profile` AS select `pq`.`Question` AS `question`,`pa`.`questionID` AS `questionID`,`pa`.`value` AS `value`,`pq`.`type` AS `type`,`pa`.`memberID` AS `memberid`,`ps`.`communityID` AS `communityID`,`pq`.`sectionID` AS `sectionID` from ((`profileSections` `ps` join `profileQuestions` `pq` on((`ps`.`ID` = `pq`.`sectionID`))) join `profileAnswers` `pa` on((`pa`.`questionID` = `pq`.`ID`))) */;

--
-- Dumping routines for database 'members'
--
/*!50003 DROP FUNCTION IF EXISTS `GetDistance` */;
--
-- WARNING: old server version. The following dump may be incomplete.
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
--DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`%`*/ /*!50003 FUNCTION `GetDistance`(  lat1  numeric (9,6),  lon1  numeric (9,6),  lat2  numeric (9,6),  lon2  numeric (9,6) ) RETURNS decimal(10,5)
BEGIN   DECLARE  x  decimal (20,10);   DECLARE  pi  decimal (21,20);   SET  pi = 3.14159265358979323846;   SET  x = sin( lat1 * pi/180 ) * sin( lat2 * pi/180  ) + cos(  lat1 *pi/180 ) * cos( lat2 * pi/180 ) * cos(  abs( (lon2 * pi/180) -  (lon1 *pi/180) ) );   SET  x = atan( ( sqrt( 1- power( x, 2 ) ) ) / x );   RETURN  ( 1.852 * 60.0 * ((x/pi)*180) ) / 1.609344; END */;;
--DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:19:17
CREATE DATABASE  IF NOT EXISTS `newsletter` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `newsletter`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: newsletter
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `mailingList`
--

DROP TABLE IF EXISTS `mailingList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailingList` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `communityID` int(10) unsigned NOT NULL,
  `dateEntered` datetime NOT NULL,
  `email` varchar(512) NOT NULL,
  `isDeleted` bit(1) default b'0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `messageID` int(10) unsigned NOT NULL auto_increment,
  `message` text,
  `createdOn` datetime default NULL,
  `memberID` int(10) unsigned default NULL,
  `communityID` int(10) unsigned default NULL,
  `subject` varchar(255) default NULL,
  PRIMARY KEY  (`messageID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messageLog`
--

DROP TABLE IF EXISTS `messageLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messageLog` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `memberID` int(10) unsigned default NULL,
  `messageID` int(10) unsigned default NULL,
  `dateSent` int(10) unsigned default NULL,
  `dateRead` int(10) unsigned default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'newsletter'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:19:21
CREATE DATABASE  IF NOT EXISTS `poll` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `poll`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: poll
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votes` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `memberID` int(10) unsigned NOT NULL,
  `questionID` int(10) unsigned NOT NULL,
  `answerID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `questionID` int(10) unsigned NOT NULL,
  `Answer` varchar(255) NOT NULL,
  `votes` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  USING BTREE (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `Question` varchar(300) NOT NULL,
  `Active` bit(1) NOT NULL default b'1',
  `communityID` int(10) unsigned NOT NULL,
  `type` varchar(45) NOT NULL,
  `memberID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'poll'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:19:24
CREATE DATABASE  IF NOT EXISTS `rating` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `rating`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: rating
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `ID` int(10) NOT NULL auto_increment,
  `FKID` int(10) default NULL,
  `memberID` int(10) default NULL,
  `rating` int(10) default NULL,
  `dateEntered` datetime default NULL,
  `FKType` varchar(20) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'rating'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:19:26
CREATE DATABASE  IF NOT EXISTS `shopping` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `shopping`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: shopping
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `SellingAreas`
--

DROP TABLE IF EXISTS `SellingAreas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SellingAreas` (
  `RegionID` int(10) NOT NULL auto_increment,
  `Countries` longtext,
  `CountryCodes` longtext,
  `States` longtext,
  `StateCodes` longtext,
  `SelectedCountries` longtext,
  `SelectedCCodes` longtext,
  `SelectedStates` longtext,
  `SelectedSCodes` longtext,
  PRIMARY KEY  (`RegionID`),
  KEY `CountryCode` (`CountryCodes`(45)),
  KEY `RegionID` (`RegionID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Products` (
  `ItemID` int(10) NOT NULL auto_increment,
  `ProductID` varchar(50) default NULL,
  `ProductName` varchar(50) default NULL,
  `BriefDescription` longtext,
  `Price` varchar(50) default NULL,
  `ImageURL` longtext,
  `Category` varchar(50) default NULL,
  `Details` longtext,
  `ShippingCosts` varchar(50) default NULL,
  `ShowQuantity` varchar(50) default NULL,
  PRIMARY KEY  (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Categories` (
  `CategoryID` int(10) NOT NULL auto_increment,
  `CategoryName` varchar(50) default NULL,
  `communityID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`CategoryID`),
  KEY `CategoryID` (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orders` (
  `OrderID` int(10) NOT NULL auto_increment,
  `OrderNumber` varchar(50) default NULL,
  `CustomerID` int(10) default NULL,
  `CrtItemID` longtext,
  `CrtProductID` longtext,
  `CrtProductName` longtext,
  `CrtPrice` longtext,
  `CrtQuantity` longtext,
  `Notes` longtext,
  `QuotedShipping` varchar(50) default NULL,
  `FiguredTax` varchar(50) default NULL,
  `OrderStatus` varchar(50) default NULL,
  `DateOfOrder` datetime default NULL,
  `TrackingNumber` longtext,
  `PaymentMethod` varchar(50) default NULL,
  `OrderCompleted` varchar(50) default NULL,
  `ShippingMethod` varchar(50) default NULL,
  `OrderTotal` varchar(50) default NULL,
  `ShippedTo` longtext,
  `ShipDate` varchar(50) default NULL,
  `Memo` longtext,
  `CreditCardType` varchar(50) default NULL,
  `CreditCardNumber` varchar(50) default NULL,
  `CreditCardExpire` varchar(50) default NULL,
  `CCConfirmationNumber` varchar(50) default NULL,
  PRIMARY KEY  (`OrderID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `ItemID` (`CrtItemID`(45)),
  KEY `ProductID1` (`CrtProductID`(45))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Taxes`
--

DROP TABLE IF EXISTS `Taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Taxes` (
  `TaxID` int(10) NOT NULL auto_increment,
  `Region` varchar(50) default NULL,
  `Country` varchar(50) default NULL,
  `ZipCode` varchar(50) default NULL,
  `TaxRate` varchar(50) default NULL,
  PRIMARY KEY  (`TaxID`),
  KEY `TaxStateID` (`TaxID`),
  KEY `ZipCode` (`ZipCode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CustomerHistory`
--

DROP TABLE IF EXISTS `CustomerHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerHistory` (
  `CustomerID` int(10) NOT NULL auto_increment,
  `FirstName` varchar(50) default NULL,
  `LastName` varchar(50) default NULL,
  `BusinessName` varchar(50) default NULL,
  `Address` longtext,
  `Address2` longtext,
  `City` varchar(50) default NULL,
  `State` varchar(50) default NULL,
  `Country` longtext,
  `ZipCode` varchar(50) default NULL,
  `PhoneNumber` varchar(50) default NULL,
  `EmailAddress` varchar(50) default NULL,
  `CreditCardType` varchar(50) default NULL,
  `CreditCardNumber` varchar(50) default NULL,
  `CreditCardExpire` varchar(50) default NULL,
  `CCConfirmationNumber` varchar(50) default NULL,
  `ShippingMethod` varchar(50) default NULL,
  `Txn_id` varchar(50) default NULL,
  `Payment_status` varchar(50) default NULL,
  `Pending_reason` varchar(50) default NULL,
  `PayPalFee` varchar(50) default NULL,
  `First_name` varchar(50) default NULL,
  `Last_name` varchar(50) default NULL,
  `Address_status` varchar(50) default NULL,
  `Receiver_email` varchar(50) default NULL,
  `Payer_status` varchar(50) default NULL,
  `Payment_type` varchar(50) default NULL,
  `For_auction` varchar(50) default NULL,
  `Invoice` varchar(50) default NULL,
  `Custom` varchar(50) default NULL,
  `Memo` longtext,
  `ShipFirstName` varchar(50) default NULL,
  `ShipLastName` varchar(50) default NULL,
  `ShipBusinessName` varchar(50) default NULL,
  `ShipAddress` longtext,
  `ShipAddress2` longtext,
  `ShipCity` varchar(50) default NULL,
  `ShipState` varchar(50) default NULL,
  `ShipZip` varchar(50) default NULL,
  `ShipCountry` varchar(50) default NULL,
  `Password` varchar(50) default NULL,
  PRIMARY KEY  (`CustomerID`),
  KEY `CustomerName` (`FirstName`),
  KEY `IDNumber` (`CustomerID`),
  KEY `txn_id` (`Txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'shopping'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:19:31
CREATE DATABASE  IF NOT EXISTS `socialcloudz` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `socialcloudz`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: socialcloudz
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `help`
--

DROP TABLE IF EXISTS `help`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `linkID` varchar(45) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `dateEntered` datetime NOT NULL,
  `ipaddress` varchar(45) default NULL,
  `memberid` int(10) unsigned NOT NULL,
  `response` text,
  `product` text,
  `total` decimal(10,0) default NULL,
  `accountID` int(10) unsigned NOT NULL,
  `communityID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plans` (
  `planID` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(45) NOT NULL,
  `bandwidth` bigint(20) NOT NULL,
  `storage` bigint(20) NOT NULL,
  `domain` bit(1) NOT NULL default b'1',
  `advertising` bit(1) NOT NULL default b'0',
  `branding` bit(1) NOT NULL default b'1',
  `support` bit(1) NOT NULL default b'1',
  PRIMARY KEY  (`planID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `helpTopics`
--

DROP TABLE IF EXISTS `helpTopics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpTopics` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `sectionID` int(10) unsigned default NULL,
  `description` text,
  `views` int(10) unsigned default '0',
  `dateCreated` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `helpSections`
--

DROP TABLE IF EXISTS `helpSections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helpSections` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `sortOrder` int(10) unsigned default NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support`
--

DROP TABLE IF EXISTS `support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `support` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `dateEntered` datetime NOT NULL,
  `memberID` int(10) unsigned NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `Index_2` (`dateEntered`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurringCharges`
--

DROP TABLE IF EXISTS `recurringCharges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurringCharges` (
  `id` int(11) NOT NULL auto_increment,
  `accountID` int(11) default NULL,
  `productID` int(11) default NULL,
  `recurringFrequency` int(11) default NULL,
  `dateEntered` datetime default NULL,
  `lastBilled` datetime default NULL,
  `attempts` int(11) default '0',
  `lastResponse` varchar(45) default NULL,
  `communityID` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `list`
--

DROP TABLE IF EXISTS `list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `formname` varchar(45) NOT NULL,
  `formfield` varchar(45) NOT NULL,
  `value` varchar(255) NOT NULL,
  `parentID` int(10) unsigned default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `firstname` varchar(45) default NULL,
  `address` varchar(255) default NULL,
  `city` varchar(45) default NULL,
  `state` varchar(45) default NULL,
  `zip` varchar(45) default NULL,
  `country` varchar(45) default NULL,
  `ccNumber` varchar(45) default NULL,
  `ccExpMo` int(10) unsigned default NULL,
  `ccExpYr` int(10) unsigned default NULL,
  `ccCVV2` int(10) unsigned default NULL,
  `memberID` int(10) unsigned default NULL,
  `communityID` int(10) unsigned default NULL,
  `lastname` varchar(45) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `Name` varchar(45) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `planID` int(10) unsigned NOT NULL,
  `type` varchar(45) NOT NULL,
  `modifier` varchar(45) default NULL,
  `modifierAmount` bigint(20) unsigned default NULL,
  `recurringFrequency` int(10) unsigned default NULL COMMENT 'Months',
  `trialPeriod` int(10) unsigned default '0' COMMENT 'Months',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionProduct`
--

DROP TABLE IF EXISTS `transactionProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionProduct` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `transactionID` int(10) unsigned NOT NULL,
  `productID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'socialcloudz'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:19:39
CREATE DATABASE  IF NOT EXISTS `statistics` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `statistics`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: db.socialcloudz.com    Database: statistics
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `ID` int(10) NOT NULL auto_increment,
  `communityID` int(10) default NULL,
  `directory` varchar(255) default NULL,
  `file` varchar(255) default NULL,
  `filesize` decimal(18,0) default NULL,
  `dateEntered` datetime default NULL,
  `total` int(11) default NULL,
  `formname` varchar(50) NOT NULL,
  `formfield` varchar(50) NOT NULL,
  `contentID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12706 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activityAction`
--

DROP TABLE IF EXISTS `activityAction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activityAction` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `activityType` int(10) unsigned NOT NULL,
  `action` varchar(45) NOT NULL,
  `displayInRecentActivity` bit(1) NOT NULL default b'1',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `ip` varchar(45) NOT NULL,
  `dateEntered` datetime NOT NULL,
  `browser` varchar(1024) NOT NULL,
  `file` varchar(1024) NOT NULL,
  `size` int(10) unsigned NOT NULL default '0',
  `host` varchar(255) NOT NULL,
  `referrer` varchar(1024) default NULL,
  `calculated` bit(1) NOT NULL default b'0',
  PRIMARY KEY  (`ID`),
  KEY `calculated` (`calculated`)
) ENGINE=MyISAM AUTO_INCREMENT=13870468 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `views`
--

DROP TABLE IF EXISTS `views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views` (
  `ID` int(10) NOT NULL auto_increment,
  `dateEntered` datetime default NULL,
  `visitorID` int(10) default NULL,
  `querystring` varchar(1024) default NULL,
  `referer` varchar(1024) default NULL,
  PRIMARY KEY  (`ID`),
  KEY `FK_Views_Visitor` (`visitorID`)
) ENGINE=InnoDB AUTO_INCREMENT=2601490 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visitor`
--

DROP TABLE IF EXISTS `visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitor` (
  `visitorID` int(10) NOT NULL auto_increment,
  `dateEntered` datetime default NULL,
  `ipAddress` varchar(20) default NULL,
  `browser` varchar(1024) default NULL,
  `referer` varchar(1024) default NULL,
  `location` varchar(255) default NULL,
  `token` varchar(36) default NULL,
  `communityID` int(10) default NULL,
  `memberID` int(10) default NULL,
  `startPage` varchar(1024) default NULL,
  `exitPage` varchar(50) default NULL,
  `city` varchar(255) default NULL,
  `region` varchar(255) default NULL,
  `countrycode` char(2) default NULL,
  `dateUpdated` datetime default NULL,
  `isBot` bit(1) default b'0',
  PRIMARY KEY  (`visitorID`),
  KEY `communityID` (`communityID`),
  KEY `visitorID` (`visitorID`),
  KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=1905900 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activityType`
--

DROP TABLE IF EXISTS `activityType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activityType` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `activityType` varchar(45) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 1287168 kB';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server`
--

DROP TABLE IF EXISTS `server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server` (
  `ID` int(10) NOT NULL auto_increment,
  `IPAddress` varchar(50) default NULL,
  `dateEntered` datetime default NULL,
  `status` varchar(20) default NULL,
  `response` longtext,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1682799 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaigns` (
  `ID` int(10) NOT NULL auto_increment,
  `dateEntered` datetime default NULL,
  `name` varchar(255) default NULL,
  `source` varchar(255) default NULL,
  `communityID` int(10) default NULL,
  `memberID` int(11) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bandwidth`
--

DROP TABLE IF EXISTS `bandwidth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bandwidth` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `communityID` int(10) unsigned NOT NULL,
  `dateEntered` datetime NOT NULL,
  `total` int(10) unsigned NOT NULL,
  `hits` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15327 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
  `ID` int(10) NOT NULL auto_increment,
  `dateEntered` datetime default NULL,
  `activityType` varchar(50) default NULL,
  `visitorID` int(10) default NULL,
  `contentID` int(10) default NULL,
  `viewID` int(10) default NULL,
  `activityAction` varchar(45) default NULL,
  `communityID` int(10) unsigned default NULL,
  `memberid` int(10) unsigned default '0',
  `contentType` varchar(45) default NULL,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `PK_ID` (`ID`),
  KEY `activity_visitor` (`activityType`,`visitorID`),
  KEY `FK_activity_Visitor` (`visitorID`)
) ENGINE=InnoDB AUTO_INCREMENT=2243406 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bots`
--

DROP TABLE IF EXISTS `bots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bots` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `dateEntered` datetime NOT NULL,
  `useragent` varchar(255) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'statistics'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-08-28 21:19:48




use advertising;
/*!40000 ALTER TABLE `adSize` DISABLE KEYS */;
INSERT INTO `adSize` VALUES (1,728,' ',90),(2,468,' ',60),(3,234,' ',60),(4,120,' ',600),(5,160,' ',600),(6,120,' ',240),(7,336,'',280),(8,300,' ',250),(9,250,'',250),(10,200,'',200),(11,180,' ',150),(12,125,' ',125);
/*!40000 ALTER TABLE `adSize` ENABLE KEYS */;



use community;

/*!40000 ALTER TABLE `cmsPages` DISABLE KEYS */;
INSERT INTO `cmsPages` VALUES (3,NULL,NULL,NULL,'/pricing.cfm',2,'2009-03-27 00:00:00','2009-03-27 00:00:00'),(4,NULL,NULL,NULL,'/features.cfm',2,'2009-03-27 00:00:00','2009-03-27 00:00:00'),(5,NULL,NULL,NULL,'/what_overview.cfm',2,'2009-03-27 00:00:00','2009-03-27 00:00:00'),(6,NULL,NULL,NULL,'/custom.cfm',2,'2009-03-27 00:00:00','2009-03-27 00:00:00'),(7,NULL,NULL,NULL,'/team.cfm',2,'2009-03-27 00:00:00','2009-03-27 00:00:00'),(8,NULL,NULL,NULL,'/how_overview.cfm',2,'2009-03-27 00:00:00','2009-03-27 00:00:00'),(9,NULL,NULL,NULL,'/technology.cfm',2,'2009-03-27 00:00:00','2009-03-27 00:00:00'),(10,NULL,NULL,NULL,'/cms.cfm',2,'2009-03-27 00:00:00','2009-03-27 00:00:00'),(11,NULL,NULL,NULL,'/business.cfm',2,'2009-03-27 00:00:00','2009-03-27 00:00:00'),(12,NULL,NULL,NULL,'/socialmedia.cfm',2,'2009-03-27 00:00:00','2009-03-27 00:00:00'),(85,'Page 1',NULL,NULL,'/Page_1.cfm',66,'2009-04-17 09:46:53','2009-04-17 09:46:53'),(86,'Page 2',NULL,NULL,'/Page_2.cfm',66,'2009-04-17 09:46:59','2009-04-17 09:46:59'),(87,'Page 3',NULL,NULL,'/Page_3.cfm',66,'2009-04-17 09:47:06','2009-04-17 09:47:06'),(88,'About Us',NULL,NULL,'/About_Us.cfm',66,'2009-04-17 09:47:12','2009-04-17 09:47:12'),(92,'About Me',NULL,NULL,'/about.cfm',2,'2009-04-20 12:00:09','2009-04-22 10:15:02'),(167,'Tour',NULL,NULL,'/Tour.cfm',2,'2009-05-21 10:16:11','2009-05-21 10:16:11'),(168,'Jobs',NULL,NULL,'/Jobs.cfm',2,'2009-05-21 10:25:52','2009-05-21 10:25:52'),(169,'Contact',NULL,NULL,'/Contact.cfm',2,'2009-05-21 10:28:36','2009-05-21 10:28:36'),(185,'Compare Plans',NULL,NULL,'/compareplans.cfm',2,'2009-06-02 20:34:15','2009-06-02 20:34:41'),(326,'test12311',NULL,'test','/test12311.cfm',3,'2009-07-01 00:38:41','2009-09-18 13:46:01'),(335,'test','test','test','/test.cfm',3,'2009-07-02 09:23:46','2009-07-02 09:23:46'),(336,'About Us',NULL,NULL,'/About_Us.cfm',2,'2009-07-02 10:52:40','2009-07-02 10:52:40'),(362,'test','test','test','/test.cfm',3,'2009-07-15 18:25:03','2009-07-15 18:25:03'),(368,'Advertise',NULL,NULL,'/Advertise.cfm',2,'2009-07-22 13:52:19','2009-07-22 13:52:19'),(426,'test','test','test','/test.cfm',3,'2009-09-01 08:54:35','2009-09-01 08:54:35'),(630,'What is CrazyLove',NULL,NULL,'/What_is_CrazyLove.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(631,'Tour',NULL,NULL,'/Tour.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(632,'The Least, The Lost, and The Last',NULL,NULL,'/The_Least__The_Lost__and_The_Last.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(633,'Contact',NULL,NULL,'/Contact.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(634,'Shop',NULL,NULL,'/Shop.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(635,'Crazy Love Tour Blog',NULL,NULL,'/Crazy_Love_Tour_Blog.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(636,'tour pictures',NULL,NULL,'/tour_pictures.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(637,'tour visit request',NULL,NULL,'/tour_visit_request.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(638,'Your Neighbor',NULL,NULL,'/Your_Neighbor.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(639,'the bus',NULL,NULL,'/the_bus.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(640,'the toad',NULL,NULL,'/the_toad.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(641,'the family',NULL,NULL,'/the_family.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(642,'the video',NULL,NULL,'/the_video.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(643,'on the road',NULL,NULL,'/on_the_road.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(644,'the route',NULL,NULL,'/the_route.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(645,'press',NULL,NULL,'/press.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(646,'donate',NULL,NULL,'/donate.cfm',202,'2010-08-18 21:46:56','2010-08-18 21:46:56'),(647,'About Us',NULL,'about horror movies','/About_Us.cfm',203,'2010-08-18 21:48:13','2010-08-18 21:48:13'),(648,'Channel of Terror','Streaming Horror Video Trailers','Streaming Horror Video','/Channel_of_Terror.cfm',203,'2010-08-18 21:48:13','2010-08-18 21:48:13'),(649,'Trailers','Horror Movie Trailers','Horror Movie Trailers','/Trailers.cfm',203,'2010-08-18 21:48:13','2010-08-18 21:48:13'),(650,'Tomb of Trailers','The best in horror trailers from across the years, from Hammer Classics and Universal Monsters, to Godzilla Toho, to Current and Upcoming Horror Movies','Horror,Trailers,Hammer,Universal,1970s,1960s,1980s,Current,Upcoming','/Tomb_of_Trailers.cfm',203,'2010-08-18 21:48:13','2010-08-18 21:48:13'),(651,'About','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Zachary Leacox, Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal','/About.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(652,'Practice Areas','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal, Zachary Leacox','/Practice_Areas.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(653,'FAQs','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal, Zachary Leacox','/FAQs.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(654,'Contact','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal, Zachary Leacox','/Contact.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(655,'Auto Truck Litigation','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal, Zachary Leacox','/Auto_Truck_Litigation.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(656,'Premises Liability','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal, Zachary Leacox','/Premises_Liability.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(657,'Insurance Coverage','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal, Zachary Leacox','/Insurance_Coverage.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(658,'Products Liability','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal, Zachary Leacox','/Products_Liability.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(659,'Dog Bites','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal, Zachary Leacox','/Dog_Bites.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(660,'Personal Injury','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal, Zachary Leacox','/Personal_Injury.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(661,'Appointment','Zachary Leacox Attorney at law. Mr Leacox practices throughout Central Florida specializing in personal injury and business litigation.  Mr. Leacox has trial experience in both the State and Federal Courts throughout Florida. Please browse the areas of practice and the articles to get more information about the types of services he offers.','Personal Injury Attorney, Orlando Personal Injury, Orlando Defense Attorney, Florida Attorney, Orlando Attorney, Orlando Commercial Litigation, Orlando Products Liability, Orlando Premises Liability, Orlando car accident Attorney, orlando accident Injury Lawyer, Florida Attorney, Florida auto accident Lawyer, Florida Car Accident Lawyer, Florida Injury Lawyer Personal, Zachary Leacox','/Appointment.cfm',204,'2010-08-18 21:49:46','2010-08-18 21:49:46'),(662,'Forums','Progressive Electronic Dance Music\r\n',NULL,'/Forums.cfm',205,'2010-08-18 21:51:28','2010-08-18 21:51:28'),(663,'Events','\r\n\r\n',NULL,'/Events.cfm',205,'2010-08-18 21:51:28','2010-08-18 21:51:28'),(664,'Photos',NULL,NULL,'/Photos.cfm',205,'2010-08-18 21:51:28','2010-08-18 21:51:28'),(665,'News',NULL,NULL,'/News.cfm',205,'2010-08-18 21:51:28','2010-08-18 21:51:28'),(666,'Links/Resources',NULL,NULL,'/Links_Resources.cfm',205,'2010-08-18 21:51:28','2010-08-18 21:51:28'),(667,'Artists','Comprehensive listing of International and National Artists',NULL,'/artists.cfm',205,'2010-08-18 21:51:28','2010-08-18 21:51:28'),(668,'about us',NULL,NULL,'/about_us.cfm',205,'2010-08-18 21:51:28','2010-08-18 21:51:28'),(669,'new page',NULL,NULL,'/new_page.cfm',205,'2010-08-18 21:51:28','2010-08-18 21:51:28'),(670,'Links','Diffuse Audio Links page ','Diffuse,Audio,Links,Techno,Record,Label,Schranz','/Links.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(671,'Billie Blaze',NULL,NULL,'/Billie_Blaze.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(672,'J-star',NULL,NULL,'/J_star.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(673,'James Fusion',NULL,NULL,'/James_Fusion.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(674,'K-Rox',NULL,NULL,'/K_Rox.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(675,'Bobby C',NULL,NULL,'/Bobby_C.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(676,'Lil Saint Dee',NULL,NULL,'/Lil_Saint_Dee.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(677,'Jinx',NULL,NULL,'/Jinx.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(678,'Mokolai',NULL,NULL,'/Mokolai.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(679,'Contact Us',NULL,NULL,'/Contact_Us.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(680,'Radop','Diffuse.Audio radio bringing the best in underground EDM','diffuse audio, techno, edm, radio, shoutcast','/Radop.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(681,'sundaze.sessions','TUNE IN this Sunday from 4pm until midnight (or later) to WWW.DIFFUSERADIO.COM for this week\'s Sundaze Session!\n\nLINEUP:\n\nBillie Blaze (Diffuse Audio)\nJ-star (Diffuse Audio)\nKRox (Vinyl Rules / Diffuse Audio)\nBrianSD (Diffuse Audio / Illegal Leopard','diffuse.audio, techno, edm, shoutcast, live','/sundaze_sessions.cfm',206,'2010-08-18 21:53:53','2010-08-18 21:53:53'),(682,'About',NULL,NULL,'/About.cfm',207,'2010-08-18 21:57:09','2010-08-18 21:57:09'),(683,'contact',NULL,NULL,'/contact.cfm',207,'2010-08-18 21:57:09','2010-08-18 21:57:09'),(684,'sponsorship',NULL,NULL,'/sponsorship.cfm',207,'2010-08-18 21:57:09','2010-08-18 21:57:09'),(685,'Contact Us',NULL,NULL,'/Contact_Us.cfm',208,'2010-08-18 21:58:29','2010-08-18 21:58:29'),(686,'Page 2',NULL,NULL,'/Page_2.cfm',208,'2010-08-18 21:58:29','2010-08-18 21:58:29'),(687,'Page 3',NULL,NULL,'/Page_3.cfm',208,'2010-08-18 21:58:29','2010-08-18 21:58:29'),(688,'About Us',NULL,NULL,'/About_Us.cfm',208,'2010-08-18 21:58:29','2010-08-18 21:58:29'),(689,'splash',NULL,NULL,'/splash.cfm',208,'2010-08-18 21:58:29','2010-08-18 21:58:29'),(690,'new page',NULL,NULL,'/new_page.cfm',208,'2010-08-18 21:58:29','2010-08-18 21:58:29'),(691,'still life live',NULL,NULL,'/still_life_live.cfm',208,'2010-08-18 21:58:29','2010-08-18 21:58:29'),(694,'About',NULL,NULL,'/About.cfm',213,'2010-08-18 22:32:04','2010-08-18 22:32:04'),(695,'Menus',NULL,NULL,'/Menus.cfm',213,'2010-08-18 22:32:04','2010-08-18 22:32:04'),(696,'Events',NULL,NULL,'/Events.cfm',213,'2010-08-18 22:32:04','2010-08-18 22:32:04'),(697,'Contact Us',NULL,NULL,'/Contact_Us.cfm',213,'2010-08-18 22:32:04','2010-08-18 22:32:04'),(698,'Gift Cards',NULL,NULL,'/Gift_Cards.cfm',213,'2010-08-18 22:32:04','2010-08-18 22:32:04'),(699,'Page 1',NULL,NULL,'/Page_1.cfm',214,'2010-08-18 22:33:29','2010-08-18 22:33:29'),(700,'Coming-soon',NULL,NULL,'/Coming_soon.cfm',214,'2010-08-18 22:33:29','2010-08-18 22:33:29'),(701,'Page 3',NULL,NULL,'/Page_3.cfm',214,'2010-08-18 22:33:29','2010-08-18 22:33:29'),(702,'About Us',NULL,NULL,'/About_Us.cfm',214,'2010-08-18 22:33:29','2010-08-18 22:33:29');
/*!40000 ALTER TABLE `cmsPages` ENABLE KEYS */;

/*!40000 ALTER TABLE `communitycategories` DISABLE KEYS */;
INSERT INTO `communitycategories` VALUES (17,'Music & Bands',13),(21,'Personal Websites',13),(22,'Religion & Spirituality',13),(24,'Social Networking',13),(25,'Sports & Teams',13),(34,'Arts & Entertainment',13),(35,'Automotive',13),(36,'Business & Finance',13),(37,'Computers & Technology',13),(40,'Family & Parenting',13),(41,'Food & Restaurants',13),(43,'Government & Politics',13),(44,'Health & Wellness',13),(47,'Movies & TV',13),(48,'News',13),(49,'Non-Profit',13),(50,'Products',13),(51,'Real Estate',13),(52,'Schools & Alumni',13),(56,'Support Group',13),(58,'Travel',13),(60,'Home & Garden',13),(61,'Webdesign & Developer',13),(62,'Education &  Development',13),(64,'Events',13);
/*!40000 ALTER TABLE `communitycategories` ENABLE KEYS */;

/*!40000 ALTER TABLE `communitysettinglist` DISABLE KEYS */;
INSERT INTO `communitysettinglist` VALUES (1,'Blogs','0,1','0','feature',2,''),(2,'Music','0,1','0','feature',3,''),(3,'Signup','0,1','1','general',0,''),(4,'Video','0,1','0','feature',5,''),(5,'Photos','0,1','0','feature',4,''),(6,'EventDisplay','List,Calendar','0','setting',0,''),(7,'Article','0,1','0','feature',1,''),(8,'Article_View','Anyone,Members,Admin','Anyone','Article',1,'Who Can View'),(9,'Article_Post','Members,Editor,Admin','Members','Article',2,'Who Can Post'),(10,'Article_Rate','Noone,Anyone,Members','Members','Article',3,'Who Can Rate'),(11,'Article_Comment','Noone,Anyone,Members,Admin','Members','Article',4,'Who Can Comment'),(12,'Blog_View','Anyone,Members,Admin','Anyone','Blog',1,'Who Can View'),(13,'Blog_Post','Members,Editor,Admin','Members','Blog',2,'Who Can Post'),(14,'Blog_Rate','Noone,Anyone,Members','Members','Blog',3,'Who Can Rate'),(15,'Blog_Comment','Noone,Anyone,Members,Admin','Members','Blog',4,'Who Can Comment'),(16,'Music_View','Anyone,Members,Admin','Anyone','Music',1,'Who Can View'),(17,'Music_Post','Members,Editor,Admin','Members','Music',2,'Who Can Post'),(18,'Music_Rate','Noone,Anyone,Members','Members','Music',3,'Who Can Rate'),(19,'Music_Comment','Noone,Anyone,Members,Admin','Members','Music',4,'Who Can Comment'),(20,'Gallery_View','Anyone,Members,Admin','Anyone','Gallery',1,'Who Can View'),(21,'Gallery_Post','Members,Editor,Admin','Members','Gallery',2,'Who Can Post'),(22,'Gallery_Rate','Noone,Anyone,Members','Members','Gallery',3,'Who Can Rate'),(23,'Gallery_Comment','Noone,Anyone,Members,Admin','Members','Gallery',4,'Who Can Comment'),(24,'Video_View','Anyone,Members,Admin','Anyone','Video',1,'Who Can View'),(25,'Video_Post','Members,Editor,Admin','Members','Video',2,'Who Can Post'),(26,'Video_Rate','Noone,Anyone,Members','Members','Video',3,'Who Can Rate'),(27,'Video_Comment','Noone,Anyone,Members,Admin','Members','Video',4,'Who Can Comment'),(28,'Branding','On,Off','0','Premium',1,''),(29,'Ads','On,Off','0','Premium',2,''),(30,'Event','0,1','0','feature',1,''),(31,'Event_View','Anyone,Members,Admin','Anyone','Event',1,'Who Can View'),(32,'Event_Post','Members,Editor,Admin','Members','Event',2,'Who Can Post'),(33,'Event_Rate','Noone,Anyone,Members','Members','Event',3,'Who Can Rate'),(34,'Event_Comment','Noone,Anyone,Members,Admin','Members','Event',4,'Who Can Comment'),(35,'KnowledgeBase','On,Off','0','feature',1,''),(36,'KnowledgeBase_View','Anyone,Members,Admin','Anyone','KnowledgeBase',1,'Who Can View'),(37,'KnowledgeBase_Post','Members,Admin','Admin','KnowledgeBase',2,'Who Can Post'),(38,'Forums','On,Off','0','feature',1,''),(39,'Forums_View','Anyone,Members,Admin','Anyone','forums',1,'Who Can View'),(40,'Forums_Post','Members,Editor,Admin','Members','forums',1,'Who Can Post'),(41,'menu_position','Above,Below,Side','Below','layout',1,''),(42,'page_width',NULL,'custom-doc','layout',1,''),(43,'page_widthCustom',NULL,'950','layout',2,''),(44,'contentApproval','0,1','1','content',1,''),(45,'startPage','','lastpage','Site',1,''),(46,'massMail','0,1','0','Site',2,''),(47,'nameFormat','0,1,2,3,4,5','0','Site',3,''),(48,'Link_View','Anyone,Members,Admin','Anyone','Link',1,'Who Can View'),(49,'Link_Post','Members,Editor,Admin','Members','Link',2,'Who Can Post'),(51,'display_clock','Yes,No','0','layout',4,''),(52,'Property_View','Anyone,Members,Admin','Anyone','Property',1,'Who Can View'),(53,'Property_Post','Members,Editor,Admin','Members','Property',2,'Who Can Post'),(54,'Property_Rate','Noone,Anyone,Members','Members','Property',3,'Who Can Rate'),(55,'Property_Comment','Noone,Anyone,Members,Admin','Members','Property',4,'Who Can Comment'),(56,'Document_View','Anyone,Members,Admin','Anyone','Document',1,'Who Can View'),(57,'Document_Post','Members,Editor,Admin','Members','Document',2,'Who Can Post'),(58,'Group_View','Anyone,Members,Admin','Anyone','Group',1,'Who Can View'),(59,'Group_Post','Members,Editor,Admin','Members','Group',2,'Who Can Post'),(60,'Group_Comment','Noone,Anyone,Members,Admin','Members','Group',3,'Who Can Comment'),(61,'Link_Rate','Noone,Anyone,Members','Members','Link',3,'Who Can Rate'),(62,'Location_View','Anyone,Members,Admin','Anyone','Location',1,'Who can view'),(63,'Location_Post','Members,Editor,Admin','Members','Location',2,'Who can post'),(64,'Location_Rate','Noone,Anyone,Members','Members','Location',3,'Who can rate'),(65,'Location_Comment','Noone,Anyone,Members,Admin','Members','Location',4,'Who can comment'),(66,'domestic_View','Anyone,Members,Admin','Anyone','domestic',1,'Who Can View'),(67,'domestic_Post','Members,Editor,Admin','Members','domestic',2,'Who Can Post'),(68,'domestic_Rate','Noone,Anyone,Members','Members','domestic',3,'Who Can Rate'),(69,'domestic_Comment','Noone,Anyone,Members,Admin','Members','domestic',4,'Who Can Comment'),(70,'international_View','Anyone,Members,Admin','Anyone','international',1,'Who Can View'),(71,'international_Post','Members,Editor,Admin','Members','international',2,'Who Can Post'),(72,'international_Rate','Noone,Anyone,Members','Members','international',3,'Who Can Rate'),(73,'international_Comment','Noone,Anyone,Members,Admin','Members','international',4,'Who Can Comment'),(74,'Document_Comment','Noone,Anyone,Members,Admin','Members','Document',4,'Who Can Comment'),(75,'djchart_View','Anyone,Members,Admin','Anyone','djchart',1,'Who Can View'),(76,'djchart_Post','Members,Editor,Admin','Members','djchart',2,'Who Can Post'),(77,'djchart_Rate','Noone,Anyone,Members','Members','djchart',3,'Who Can Rate'),(78,'djchart_Comment','Noone,Anyone,Members,Admin','Members','djchart',4,'Who Can Comment'),(79,'Restaurant_View','Anyone,Members,Admin','Anyone','Restaurant',1,'Who can view'),(80,'Restaurant_Post','Members,Editor,Admin','Members','Restaurant',2,'Who can post'),(81,'Restaurant_Rate','Noone,Anyone,Members','Members','Restaurant',3,'Who can rate'),(82,'Restaurant_Comment','Noone,Anyone,Members,Admin','Members','Restaurant',4,'Who can comment'),(83,'WatermarkImages','0,1','0','general',0,''),(84,'firstpage','home,splash','home','Site',2,''),(85,'dnsVerified','0,1','0','Site',3,NULL);
/*!40000 ALTER TABLE `communitysettinglist` ENABLE KEYS */;

/*!40000 ALTER TABLE `community` DISABLE KEYS */;
INSERT INTO `community` VALUES (2,1,'SocialCloudZ','social.cms.for.business.or.pleasure','www',34,'social, media, cms, business, personal','SocialCloudz is a cutting edge solution to a standard problem faced by many people seeking a presence on the web. By fusing social media technologies with an innovative content management system, users can easily create and customize their site to suit their needs. By leveraging cloud computing technologies, we simplify the age old problem of scalability by allowing the application to dynamically control resources. From the ground up, SocialCloudz is built for monetization! With in-depth statistics and resource metering, we make it easy for our clients to turn their web idea into cash!','2008-12-03 19:03:17',NULL,'mm-dd-yyyy','2010-05-30 10:47:52','\0','\0','\0','','UA-5302928-26',NULL,'www.scdevsite.com',NULL,'1','10737418240','5368709120','','',1,NULL,NULL,0,''),(3,1,'SocialCloudZ','development zone','test',37,'socialcloudz RIA CMS Social Media Cloud Computing','Socialcloudz provides a unique \"Social CMS\" which leverages cutting edge RIA technologies and runs on a unique high performance infrastructure \"in the cloud\".','2008-12-03 19:34:59',NULL,'mmm dd, yyyy','2010-06-23 10:09:23','\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','536870912','536870912','','',1,'B4E7ACD27ED94776B4123B38DC647C50 ','/content/community/3/graphics logo print trans.gif',2,''),(64,1,'Social Network','Socialcloudz Demo Site','social',NULL,NULL,NULL,'2009-04-16 19:14:47',NULL,'mm-dd-yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,'',NULL,2,''),(66,1,'Basic Informational','Socialcloudz Demo Site','basic',NULL,NULL,NULL,'2009-04-16 19:15:38',NULL,'mm-dd-yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,'',NULL,2,''),(202,1,'church','socialcloudz.demo.site','church',22,'..','...','2010-08-18 17:47:07',NULL,'mm/dd/yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,NULL,NULL,2,''),(203,1,'fansite','socialcloudz.demo.site','fan',34,'..','..','2010-08-18 17:48:25',NULL,'mm/dd/yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,NULL,NULL,2,''),(204,1,'lawyer','socialcloudz.demo.site','lawyer',48,'..','..','2010-08-18 17:49:58',NULL,'mm/dd/yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,NULL,NULL,2,''),(205,1,'mediasharing','socialcloudz.demo.site','media',17,'..','..','2010-08-18 17:51:40',NULL,'mm/dd/yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,NULL,NULL,2,''),(206,1,'music','socialcloudz.demo.site','music',17,'..','..','2010-08-18 17:54:05',NULL,'mm/dd/yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,NULL,NULL,2,''),(207,1,'networking','socialcloudz.demo.site','networking',36,'..','..','2010-08-18 17:57:20',NULL,'mm/dd/yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,NULL,NULL,2,''),(208,1,'nightclub','socialcloudz.demo.site','nightclub',34,'..','..','2010-08-18 17:58:40',NULL,'mm/dd/yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,NULL,NULL,2,''),(213,1,'restaurant','socialcloudz.demo.site','restaurant',41,'..','..','2010-08-18 18:32:15',NULL,'mm/dd/yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,NULL,NULL,2,''),(214,1,'venue listing','socialcloudz.demo.site','venue',34,'..','..','2010-08-18 18:33:41',NULL,'mm/dd/yyyy',NULL,'\0','\0','\0','\0',NULL,NULL,NULL,NULL,'1','1073741824','536870912','',NULL,1,NULL,NULL,2,'');
/*!40000 ALTER TABLE `community` ENABLE KEYS */;

/*!40000 ALTER TABLE `domains` DISABLE KEYS */;
INSERT INTO `domains` VALUES (1,'scdevsite.com',NULL),(2,'syntiant.com',0);
/*!40000 ALTER TABLE `domains` ENABLE KEYS */;

/*!40000 ALTER TABLE `layout` DISABLE KEYS */;
INSERT INTO `layout` VALUES ('',3,'3','',NULL,0),('/aboutus.cfm',2,'5','',NULL,0),('/business.cfm',2,'6','',NULL,0),('/cms.cfm',2,'6','',NULL,0),('/contactus.cfm',2,'5','',NULL,0),('/content1.cfm',2,'2','',NULL,0),('/custom.cfm',2,'6','',NULL,0),('/expogirls.cfm',2,'6','',NULL,0),('/features.cfm',2,'6','',NULL,0),('/how_overview.cfm',2,'6','',NULL,0),('/portfolio.cfm',2,'5','',NULL,0),('/pricing.cfm',2,'6','',NULL,0),('/resume.cfm',1,'3','',NULL,0),('/rssfeeds.cfm',2,'6','',NULL,0),('/services.cfm',2,'5','',NULL,0),('/socialmedia.cfm',2,'6','',NULL,0),('/team.cfm',2,'6','',NULL,0),('/technology.cfm',2,'6','',NULL,0),('/test.cfm',3,'5','',NULL,0),('/what_overview.cfm',2,'6','',NULL,0),('home',2,'6','',NULL,0),('test.cfm  ',2,'3         ','          ',NULL,0),('undefined',3,'3','',NULL,0),('',2,'5','',NULL,2),('/aboutus.cfm',2,'6','',NULL,2),('/About_Us.cfm',2,'6','',NULL,2),('/business.cfm',2,'6','',NULL,2),('/cms.cfm',2,'6','',NULL,2),('/contact.cfm',2,'6','',NULL,2),('/custom.cfm',2,'6','',NULL,2),('/features.cfm',1,'5','',NULL,2),('/how_overview.cfm',2,'6','',NULL,2),('/jobs.cfm',2,'6','',NULL,2),('/pricing.cfm',2,'3','',NULL,2),('/socialmedia.cfm',2,'6','',NULL,2),('/team.cfm',2,'6','',NULL,2),('/technology.cfm',2,'6','',NULL,2),('/tour.cfm',2,'6','',NULL,2),('/what_overview.cfm',2,'6','',NULL,2),('article',2,'6','',NULL,2),('blog',2,'6','',NULL,2),('details',2,'6','',NULL,2),('Directory',2,'6','',NULL,2),('features',2,'6','',NULL,2),('Forum',1,'3','',NULL,2),('forumThread',1,'3','',NULL,2),('forumTopics',1,'3','',NULL,2),('help',2,'6','',NULL,2),('home',1,'6','',NULL,2),('knowledgebase',1,'5','',NULL,2),('payment',2,'6','',NULL,2),('plans',2,'6','',NULL,2),('',2,'4','',NULL,3),('/3_column.cfm',3,'2','',NULL,3),('/My_First_Page.cfm',2,'4','',NULL,3),('/Page_2.cfm',3,'3','c',NULL,3),('/test12311.cfm',3,'3','',NULL,3),('admin',2,'1','',NULL,3),('article',2,'5','c',NULL,3),('blog',2,'5','e',NULL,3),('event',2,'5','e',NULL,3),('home',2,'5','d',NULL,3),('music',2,'5','',NULL,3),('photo',2,'3','',NULL,3),('restaurant',2,'6','',NULL,3),('Upgrade',2,'3','',NULL,3),('Video',2,'2','e',NULL,3),('/Contact_Us.cfm',2,'5','',NULL,4),('/Links.cfm',2,'6','',NULL,4),('/sundaze_sessions.cfm',2,'5','',NULL,4),('blog',2,'5','',NULL,4),('djchart',2,'5','',NULL,4),('event',2,'5','',NULL,4),('gallery',2,'5','',NULL,4),('group',2,'5','',NULL,4),('home',3,'5','c',NULL,4),('link',2,'5','',NULL,4),('music',2,'5','',NULL,4),('Photo',2,'5','',NULL,4),('profile',2,'5','',NULL,4),('video',2,'5','',NULL,4),('/Links.cfm',2,'6','',NULL,5),('event',1,'3','',NULL,5),('home',2,'5','',NULL,5),('music',1,'3','',NULL,5),('photo',1,'3','',NULL,5),('video',1,'3','',NULL,5),('gallery',1,'3','',NULL,6),('home',2,'6','',NULL,6),('photo',1,'3','',NULL,6),('video',1,'3','',NULL,6),('',2,'4','',NULL,34),('.cfm',2,'6','',NULL,34),('/aboutus.cfm',2,'4','d',NULL,34),('/apply_online.cfm',2,'4','',NULL,34),('/bullshit.cfm',3,'2','',NULL,34),('/clientform.cfm',2,'4','',NULL,34),('/clients.cfm',2,'4','',NULL,34),('/contactus.cfm',2,'4','',NULL,34),('/elements.cfm',1,'3','',NULL,34),('/email_signup.cfm',2,'4','',NULL,34),('/email_unsubscribe.cfm',2,'4','',NULL,34),('/faqs.cfm',2,'4','',NULL,34),('/feedbackform.cfm',2,'4','',NULL,34),('/Identity_Branding_Portfolio.cfm',2,'4','',NULL,34),('/media.cfm',2,'5','',NULL,34),('/nfh.cfm',1,'4','',NULL,34),('/portfolio.cfm',2,'4','d',NULL,34),('/portfolio_advertorials.cfm',2,'4','c',NULL,34),('/portfolio_photog.cfm',2,'4','c',NULL,34),('/portfolio_print.cfm',2,'4','c',NULL,34),('/portfolio_web.cfm',2,'4','c',NULL,34),('/products.cfm',2,'4','',NULL,34),('/recent_projects.cfm',2,'4','',NULL,34),('/request_a_quote.cfm',2,'4','',NULL,34),('/Resume.cfm',2,'4','',NULL,34),('/SEO.cfm',3,'5','',NULL,34),('/services.cfm',2,'4','',NULL,34),('/tbplf.cfm',2,'4','',NULL,34),('/Terms_Of_Service.cfm',2,'4','',NULL,34),('/upload.cfm',2,'4','',NULL,34),('/Your_New_Website.cfm',2,'4','',NULL,34),('admin',2,'2','',NULL,34),('article',2,'4','',NULL,34),('blog',2,'4','',NULL,34),('document',2,'4','',NULL,34),('gallery',2,'5','',NULL,34),('help',2,'5','',NULL,34),('home',2,'4','d',NULL,34),('link',2,'4','',NULL,34),('Photo',2,'5','',NULL,34),('profile_21',2,'4','',NULL,34),('Video',2,'4','',NULL,34),('/about.cfm',2,'5','',NULL,35),('/contact.cfm',2,'5','',NULL,35),('/directions.cfm',2,'5','',NULL,35),('/golf.cfm',2,'5','',NULL,35),('/i',2,'5','',NULL,35),('/rentals.cfm',2,'5','',NULL,35),('/rental_list.cfm',2,'5','',NULL,35),('/reservations.cfm',2,'5','',NULL,35),('/sales.cfm',2,'5','',NULL,35),('/specials.cfm',2,'5','',NULL,35),('/things_to_do.cfm',2,'5','',NULL,35),('blog',2,'5','',NULL,35),('gallery',2,'5','',NULL,35),('home',2,'5','',NULL,35),('link',2,'5','',NULL,35),('location',2,'5','',NULL,35),('/ads.cfm',2,'5','',NULL,36),('/area_practice.cfm',2,'2','',NULL,36),('/biography.cfm',2,'2','',NULL,36),('/contactus.cfm',2,'2','',NULL,36),('/links.cfm',2,'2','',NULL,36),('home',2,'2','',NULL,36),('/resume.cfm',1,'1','',NULL,37),('/rssfeeds.cfm',2,'6','',NULL,37),('/studio.cfm',2,'5','',NULL,37),('home',2,'5','',NULL,37),('music',1,'3','',NULL,37),('photo',1,'3','',NULL,37),('home',2,'3','',NULL,38),('home',2,'3','',NULL,40),('music',1,'1','',NULL,40),('/about.cfm',1,'1','',NULL,41),('/contact.cfm',1,'1','',NULL,41),('/links.cfm',1,'1','',NULL,41),('home',2,'6','',NULL,41),('/classes.cfm',1,'1','',NULL,42),('/contact.cfm',1,'1','',NULL,42),('/stores.cfm',1,'1','',NULL,42),('home',1,'1','',NULL,42),('',2,'4','',NULL,43),('/biography.cfm',2,'5','',NULL,43),('/contact.cfm',1,'3','',NULL,43),('/portfolio.cfm',2,'5','',NULL,43),('/port_architectural.cfm',2,'5','',NULL,43),('/port_events.cfm',2,'5','',NULL,43),('/port_fetish.cfm',2,'5','',NULL,43),('/port_glamour.cfm',2,'5','',NULL,43),('/port_headshots.cfm',2,'5','',NULL,43),('/port_lingerie.cfm',2,'5','',NULL,43),('/port_nature.cfm',2,'5','',NULL,43),('/port_outdoor_nudes.cfm',2,'5','',NULL,43),('/port_scapes.cfm',2,'5','',NULL,43),('/port_swimwear.cfm',2,'5','',NULL,43),('/Services.cfm',2,'5','',NULL,43),('admin',2,'2','',NULL,43),('gallery',1,'5','',NULL,43),('home',2,'5','',NULL,43),('Photo',1,'5','',NULL,43),('',2,'5','',NULL,44),('/about_us.cfm',2,'5','',NULL,44),('/artists.cfm',2,'2','',NULL,44),('/clubs.cfm',2,'2','',NULL,44),('/Events.cfm',2,'5','',NULL,44),('/Forums.cfm',1,'1','',NULL,44),('/Links_Resources.cfm',2,'2','',NULL,44),('article',2,'5','',NULL,44),('blog',2,'5','',NULL,44),('event',2,'5','',NULL,44),('Forum',1,'3','',NULL,44),('forumThread',1,'3','',NULL,44),('forumTopics',1,'3','',NULL,44),('gallery',2,'5','',NULL,44),('help',2,'5','',NULL,44),('home',2,'5','',NULL,44),('link',2,'5','',NULL,44),('music',2,'5','c',NULL,44),('photo',2,'5','',NULL,44),('profile',2,'5','',NULL,44),('profile_21',2,'2','',NULL,44),('profile_648',2,'4','',NULL,44),('video',2,'5','',NULL,44),('/about.cfm',2,'5','d',NULL,45),('/clients.cfm',3,'5','c',NULL,45),('/contact_us.cfm',2,'5','c',NULL,45),('/directions.cfm',2,'5','',NULL,45),('/info_center.cfm',2,'5','',NULL,45),('/links.cfm',2,'5','',NULL,45),('/payments.cfm',2,'5','',NULL,45),('/relief.cfm',2,'5','',NULL,45),('/services.cfm',2,'5','c',NULL,45),('/Service_Agreement.cfm',2,'5','',NULL,45),('/typesofservices.cfm',2,'4','',NULL,45),('/Upload_Docs.cfm',2,'5','',NULL,45),('article',2,'5','',NULL,45),('home',2,'5','d',NULL,45),('link',2,'5','',NULL,45),('',2,'5','',NULL,46),('/aboutus.cfm',1,'1','',NULL,46),('/contact.cfm',1,'1','',NULL,46),('/production.cfm',1,'1','',NULL,46),('blog',2,'3','',NULL,46),('home',1,'4','',NULL,46),('link',1,'3','',NULL,46),('music',1,'5','',NULL,46),('profile',2,'2','',NULL,46),('/aboutus.cfm',2,'2','',NULL,48),('/blog.cfm',2,'2','c',NULL,48),('/contact.cfm',2,'2','',NULL,48),('/events.cfm',2,'2','',NULL,48),('/links.cfm',3,'4','d',NULL,48),('/news.cfm',2,'2','',NULL,48),('admin',2,'2','',NULL,48),('article',2,'2','',NULL,48),('blog',2,'2','',NULL,48),('event',2,'2','',NULL,48),('Forum',1,'3','',NULL,48),('gallery',2,'2','',NULL,48),('home',2,'2','c',NULL,48),('link',2,'2','',NULL,48),('photo',2,'2','',NULL,48),('profile_21',2,'2','',NULL,48),('home',2,'6','',NULL,49),('',1,'2','',NULL,51),('blog',1,'3','',NULL,51),('Forum',1,'3','',NULL,51),('gallery',1,'3','',NULL,51),('home',1,'1','',NULL,51),('',2,'1','',NULL,54),('/About_DJ_Animal.cfm',1,'1','',NULL,54),('home',2,'6','',NULL,54),('profile_54',3,'2','c',NULL,54),('/About_Me.cfm',1,'1','',NULL,56),('home',2,'5','',NULL,56),('home',2,'5','',NULL,57),('/About_Me.cfm',1,'1','',NULL,58),('home',2,'5','',NULL,58),('/About_Us.cfm',1,'1','',NULL,59),('home',2,'5','',NULL,59),('/About.cfm',1,'1','',NULL,60),('home',2,'5','',NULL,60),('home',2,'5','',NULL,62),('/About.cfm',1,'1','',NULL,63),('home',2,'5','',NULL,63),('error',2,'3','',NULL,64),('home',3,'4','d',NULL,64),('/About_Us.cfm',2,'5','',NULL,66),('/Page_1.cfm',1,'1','',NULL,66),('/Page_2.cfm',1,'1','',NULL,66),('/Page_3.cfm',1,'1','',NULL,66),('home',2,'5','',NULL,66),('home',1,'1','',NULL,73),('home',1,'1','',NULL,74),('',2,'2','',NULL,77),('/aboutus.cfm',2,'6','',NULL,77),('/About_Me.cfm',1,'1','',NULL,77),('/About_Us.cfm',2,'5','',NULL,77),('/business.cfm',2,'6','',NULL,77),('/cms.cfm',2,'6','',NULL,77),('/custom.cfm',2,'6','',NULL,77),('/features.cfm',2,'6','',NULL,77),('/how_overview.cfm',2,'6','',NULL,77),('/Page_1.cfm',1,'1','',NULL,77),('/Page_2.cfm',1,'1','',NULL,77),('/Page_3.cfm',1,'1','',NULL,77),('/pricing.cfm',2,'6','',NULL,77),('/socialmedia.cfm',2,'6','',NULL,77),('/team.cfm',2,'6','',NULL,77),('/technology.cfm',2,'6','',NULL,77),('/what_overview.cfm',2,'6','',NULL,77),('home',2,'5','',NULL,77),('home',2,'5','',NULL,78),('/About_Us.cfm',2,'5','',NULL,79),('/Page_1.cfm',1,'1','',NULL,79),('/Page_2.cfm',1,'1','',NULL,79),('/Page_3.cfm',1,'1','',NULL,79),('home',2,'5','',NULL,79),('home',2,'5','',NULL,80),('home',3,'4','c',NULL,81),('',2,'5','c',NULL,82),('blog',3,'1','',NULL,82),('home',3,'4','c',NULL,82),('/About_Us.cfm',2,'5','',NULL,83),('/Page_1.cfm',1,'1','',NULL,83),('/Page_2.cfm',1,'1','',NULL,83),('/Page_3.cfm',1,'1','',NULL,83),('home',2,'5','',NULL,83),('home',2,'5','',NULL,85),('/About_Me.cfm',1,'1','',NULL,86),('home',2,'5','',NULL,86),('home',2,'5','',NULL,87),('home',2,'5','',NULL,88),('home',2,'5','',NULL,89),('/About_Us.cfm',2,'5','',NULL,90),('/Page_1.cfm',1,'1','',NULL,90),('/Page_2.cfm',1,'1','',NULL,90),('/Page_3.cfm',1,'1','',NULL,90),('home',2,'5','',NULL,90),('home',3,'4','c',NULL,91),('home',2,'2','c',NULL,92),('home',2,'5','',NULL,93),('home',3,'4','c',NULL,94),('home',3,'4','c',NULL,95),('/About_Me.cfm',1,'1','',NULL,96),('home',2,'5','',NULL,96),('/About.cfm',1,'1','',NULL,97),('home',2,'5','',NULL,97),('home',3,'4','c',NULL,98),('',2,'2','c',NULL,99),('/about.cfm',3,'2','c',NULL,99),('/contact.cfm',3,'2','c',NULL,99),('/life_as_art.cfm',2,'5','',NULL,99),('/wealth_creation.cfm',3,'2','c',NULL,99),('home',3,'2','c',NULL,99),('home',2,'5','c',NULL,100),('/About_Us.cfm',2,'5','',NULL,101),('/Page_1.cfm',1,'1','',NULL,101),('/Page_2.cfm',1,'1','',NULL,101),('/Page_3.cfm',1,'1','',NULL,101),('home',2,'5','',NULL,101),('',2,'3','',NULL,103),('/about_us.cfm',2,'6','',NULL,103),('/contact_us.cfm',2,'6','',NULL,103),('/downloads.cfm',2,'6','',NULL,103),('/faq.cfm',2,'5','',NULL,103),('/financing.cfm',2,'6','',NULL,103),('/location.cfm',2,'6','',NULL,103),('/Page_1.cfm',2,'3','',NULL,103),('/Page_2.cfm',1,'1','',NULL,103),('/Page_3.cfm',1,'1','',NULL,103),('/partners.cfm',2,'6','',NULL,103),('/property.cfm',2,'6','',NULL,103),('/services.cfm',2,'6','',NULL,103),('article',2,'6','',NULL,103),('blog',2,'6','',NULL,103),('document',2,'6','',NULL,103),('event',2,'6','',NULL,103),('gallery',2,'6','',NULL,103),('help',2,'6','',NULL,103),('home',2,'6','',NULL,103),('photo',2,'6','',NULL,103),('profile',2,'6','',NULL,103),('property',2,'6','',NULL,103),('video',2,'6','',NULL,103),('/About_Us.cfm',2,'5','',NULL,104),('/Page_1.cfm',1,'1','',NULL,104),('/Page_2.cfm',1,'1','',NULL,104),('/Page_3.cfm',1,'1','',NULL,104),('home',2,'5','',NULL,104),('/About_Us.cfm',2,'5','',NULL,105),('/Page_1.cfm',1,'1','',NULL,105),('/Page_2.cfm',1,'1','',NULL,105),('/Page_3.cfm',1,'1','',NULL,105),('home',2,'5','',NULL,105),('/About_Us.cfm',2,'5','',NULL,106),('/Page_1.cfm',1,'1','',NULL,106),('/Page_2.cfm',1,'1','',NULL,106),('/Page_3.cfm',1,'1','',NULL,106),('home',2,'5','',NULL,106),('home',2,'5','',NULL,107),('',3,'3','',NULL,108),('/aboutus.cfm',2,'5','',NULL,108),('/business.cfm',2,'6','',NULL,108),('/cms.cfm',2,'6','',NULL,108),('/contactus.cfm',2,'5','',NULL,108),('/content1.cfm',2,'2','',NULL,108),('/custom.cfm',2,'6','',NULL,108),('/expogirls.cfm',2,'6','',NULL,108),('/features.cfm',2,'6','',NULL,108),('/how_overview.cfm',2,'6','',NULL,108),('/portfolio.cfm',2,'5','',NULL,108),('/pricing.cfm',2,'6','',NULL,108),('/resume.cfm',1,'3','',NULL,108),('/rssfeeds.cfm',2,'6','',NULL,108),('/services.cfm',2,'5','',NULL,108),('/socialmedia.cfm',2,'6','',NULL,108),('/team.cfm',2,'6','',NULL,108),('/technology.cfm',2,'6','',NULL,108),('/test.cfm',3,'5','',NULL,108),('/what_overview.cfm',2,'6','',NULL,108),('home',2,'6','',NULL,108),('test.cfm  ',2,'3         ','          ',NULL,108),('undefined',3,'3','',NULL,108),('home',3,'4','c',NULL,109),('home',3,'4','c',NULL,110),('home',3,'4','c',NULL,111),('home',3,'4','c',NULL,112),('home',3,'4','c',NULL,113),('home',2,'5','',NULL,114),('home',2,'5','',NULL,115),('',2,'4','c',NULL,116),('home',2,'6','c',NULL,116),('home',3,'4','c',NULL,117),('/About_Me.cfm',1,'1','',NULL,118),('home',2,'5','',NULL,118),('home',2,'5','',NULL,119),('/About_Us.cfm',2,'5','',NULL,120),('/Page_1.cfm',1,'1','',NULL,120),('/Page_2.cfm',1,'1','',NULL,120),('/Page_3.cfm',1,'1','',NULL,120),('home',2,'5','',NULL,120),('',2,'6','',NULL,121),('/7_reasons_to_subscibe.cfm',2,'6','',NULL,121),('/abortion.cfm',2,'6','',NULL,121),('/About_Us.cfm',2,'6','',NULL,121),('/Adoption.cfm',2,'6','',NULL,121),('/Ask_Lynly.cfm',2,'6','',NULL,121),('/contact_us.cfm',2,'6','',NULL,121),('/family_finder.cfm',2,'6','',NULL,121),('/is_adoption_for_me.cfm',2,'6','',NULL,121),('/Page_1.cfm',1,'1','',NULL,121),('/Page_2.cfm',1,'1','',NULL,121),('/Page_3.cfm',1,'1','',NULL,121),('/parenting.cfm',2,'6','',NULL,121),('/whats_next.cfm',2,'6','',NULL,121),('article',2,'6','',NULL,121),('blog',2,'6','',NULL,121),('home',2,'6','',NULL,121),('link',2,'6','',NULL,121),('profile_21',2,'6','',NULL,121),('profile_592',2,'6','',NULL,121),('/About_Us.cfm',2,'6','',NULL,122),('/Page_1.cfm',2,'6','',NULL,122),('/Page_2.cfm',2,'6','',NULL,122),('/Page_3.cfm',1,'1','',NULL,122),('/Submit_Link.cfm',2,'6','',NULL,122),('article',2,'6','',NULL,122),('home',2,'6','',NULL,122),('link',2,'6','',NULL,122),('/About_Me.cfm',1,'1','',NULL,123),('home',2,'5','',NULL,123),('',2,'2','',NULL,124),('home',3,'2','',NULL,124),('/About.cfm',1,'1','',NULL,125),('home',2,'5','',NULL,125),('home',2,'5','',NULL,126),('/About_Me.cfm',1,'1','',NULL,127),('home',2,'5','',NULL,127),('home',2,'5','',NULL,128),('/About_Us.cfm',2,'6','',NULL,129),('/Contact_Us.cfm',2,'6','',NULL,129),('/Page_1.cfm',1,'1','',NULL,129),('/Page_2.cfm',2,'6','',NULL,129),('/Page_3.cfm',1,'1','',NULL,129),('/Press.cfm',2,'6','',NULL,129),('article',2,'6','',NULL,129),('blog',2,'6','',NULL,129),('home',2,'6','',NULL,129),('link',2,'6','',NULL,129),('profile_21',2,'6','',NULL,129),('/About_Us.cfm',2,'5','',NULL,130),('/Page_1.cfm',1,'1','',NULL,130),('/Page_2.cfm',1,'1','',NULL,130),('/Page_3.cfm',1,'1','',NULL,130),('home',2,'5','',NULL,130),('/About_Me.cfm',1,'1','',NULL,131),('home',2,'5','',NULL,131),('',2,'5','',NULL,132),('/About_Us.cfm',2,'5','',NULL,132),('/contact_us.cfm',2,'5','',NULL,132),('/Page_1.cfm',1,'1','',NULL,132),('/Page_2.cfm',1,'1','',NULL,132),('/Page_3.cfm',1,'1','',NULL,132),('article',2,'5','',NULL,132),('blog',2,'5','',NULL,132),('home',3,'5','',NULL,132),('',2,'2','',NULL,133),('/Contact.cfm',2,'2','',NULL,133),('/Crazy_Love_Tour_Blog.cfm',2,'2','',NULL,133),('/donate.cfm',2,'2','',NULL,133),('/press.cfm',2,'2','',NULL,133),('/the_bus.cfm',2,'2','',NULL,133),('/the_family.cfm',2,'2','',NULL,133),('/The_Least__The_Lost__and_The_Last.cfm',2,'2','',NULL,133),('/the_route.cfm',2,'2','',NULL,133),('/the_toad.cfm',2,'2','',NULL,133),('/the_video.cfm',2,'2','',NULL,133),('/Tour.cfm',2,'2','',NULL,133),('/tour_pictures.cfm',2,'2','',NULL,133),('/Tour_visit_request.cfm',2,'2','',NULL,133),('/What_is_CrazyLove.cfm',2,'2','',NULL,133),('/your_neighbor.cfm',2,'2','',NULL,133),('article',2,'2','',NULL,133),('blog',2,'2','',NULL,133),('domestic',2,'2','',NULL,133),('gallery',2,'2','',NULL,133),('group',2,'2','',NULL,133),('home',3,'5','d',NULL,133),('international',2,'2','',NULL,133),('location',2,'2','',NULL,133),('MemberList',2,'2','',NULL,133),('Photo',2,'2','',NULL,133),('profile_1',2,'2','d',NULL,133),('profile_21',2,'2','',NULL,133),('profile_550',2,'2','',NULL,133),('profile_587',2,'2','',NULL,133),('video',2,'2','',NULL,133),('home',2,'4','',NULL,134),('home',2,'5','',NULL,135),('/About_Us.cfm',2,'5','',NULL,141),('/Page_1.cfm',1,'1','',NULL,141),('/Page_2.cfm',1,'1','',NULL,141),('/Page_3.cfm',1,'1','',NULL,141),('home',2,'5','',NULL,141),('/About_Us.cfm',2,'5','',NULL,142),('/Page_1.cfm',2,'2','',NULL,142),('/Page_2.cfm',1,'1','',NULL,142),('/Page_3.cfm',1,'1','',NULL,142),('home',3,'4','f',NULL,142),('/About_Us.cfm',2,'5','',NULL,143),('/Page_1.cfm',1,'1','',NULL,143),('/Page_2.cfm',1,'1','',NULL,143),('/Page_3.cfm',1,'1','',NULL,143),('home',2,'5','',NULL,143),('',2,'4','',NULL,144),('home',2,'4','',NULL,144),('/About_Me.cfm',1,'1','',NULL,145),('blog',2,'5','',NULL,145),('home',2,'5','',NULL,145),('home',2,'5','',NULL,146),('/About_Us.cfm',2,'5','',NULL,147),('/downloads.cfm',2,'5','',NULL,147),('/Page_1.cfm',1,'1','',NULL,147),('/Page_2.cfm',1,'1','',NULL,147),('/Page_3.cfm',1,'1','',NULL,147),('article',2,'5','',NULL,147),('blog',2,'5','',NULL,147),('gallery',2,'5','',NULL,147),('help',2,'5','',NULL,147),('home',2,'5','',NULL,147),('link',2,'5','',NULL,147),('music',2,'5','',NULL,147),('Photo',2,'5','',NULL,147),('profile',2,'5','',NULL,147),('profile_21',2,'5','',NULL,147),('video',2,'5','',NULL,147),('/About_Me.cfm',1,'1','',NULL,149),('home',2,'5','',NULL,149),('/About_Me.cfm',1,'1','',NULL,150),('home',2,'5','',NULL,150),('/About_Me.cfm',1,'1','',NULL,151),('home',2,'5','',NULL,151),('/About_Me.cfm',2,'5','',NULL,152),('/Contact_Us.cfm',2,'5','',NULL,152),('blog',2,'5','',NULL,152),('home',2,'5','',NULL,152),('home',2,'5','',NULL,153),('home',2,'5','',NULL,154),('/About.cfm',2,'6','',NULL,155),('/About_Us.cfm',2,'5','',NULL,155),('/Appointment.cfm',2,'6','',NULL,155),('/Auto_Truck_Litigation.cfm',2,'6','',NULL,155),('/Contact.cfm',2,'6','',NULL,155),('/Dog_Bites.cfm',2,'6','',NULL,155),('/FAQs.cfm',2,'6','',NULL,155),('/Insurance_Coverage.cfm',2,'6','',NULL,155),('/Page_1.cfm',1,'1','',NULL,155),('/Page_2.cfm',1,'1','',NULL,155),('/Page_3.cfm',1,'1','',NULL,155),('/Personal_Injury.cfm',2,'6','',NULL,155),('/Practice_Areas.cfm',2,'6','',NULL,155),('/Premises_Liability.cfm',2,'6','',NULL,155),('/Products_Liability.cfm',2,'6','',NULL,155),('article',2,'6','',NULL,155),('home',2,'6','',NULL,155),('link',2,'6','',NULL,155),('profile_21',2,'6','',NULL,155),('/About_Us.cfm',2,'5','',NULL,156),('/affiliates.cfm',1,'3','',NULL,156),('/contact.cfm',1,'3','',NULL,156),('/Page_1.cfm',1,'1','',NULL,156),('/Page_2.cfm',1,'1','',NULL,156),('/Page_3.cfm',1,'1','',NULL,156),('/testimonials.cfm',1,'3','',NULL,156),('help',2,'5','',NULL,156),('home',2,'5','',NULL,156),('privacy',1,'3','',NULL,156),('terms',1,'3','',NULL,156),('',3,'2','e',NULL,157),('/About.cfm',3,'2','e',NULL,157),('/contact.cfm',3,'2','e',NULL,157),('/sponsorship.cfm',3,'2','e',NULL,157),('article',2,'6','',NULL,157),('blog',2,'5','',NULL,157),('error',3,'2','e',NULL,157),('event',3,'2','e',NULL,157),('gallery',3,'2','e',NULL,157),('home',3,'2','e',NULL,157),('link',3,'2','e',NULL,157),('MemberList',3,'2','e',NULL,157),('profile_656',2,'2','',NULL,157),('video',3,'2','e',NULL,157),('/About_Me.cfm',1,'1','',NULL,158),('home',2,'5','',NULL,158),('/About_Us.cfm',2,'5','',NULL,159),('/Page_1.cfm',1,'1','',NULL,159),('/Page_2.cfm',1,'1','',NULL,159),('/Page_3.cfm',1,'1','',NULL,159),('home',1,'5','',NULL,159),('/About_Us.cfm',2,'5','',NULL,160),('/Page_1.cfm',1,'1','',NULL,160),('/Page_2.cfm',1,'1','',NULL,160),('/Page_3.cfm',1,'1','',NULL,160),('home',2,'6','',NULL,160),('/About_Us.cfm',2,'5','',NULL,161),('/attorney_profiles.cfm',2,'2','',NULL,161),('/contact_us.cfm',2,'5','',NULL,161),('/overview.cfm',2,'2','',NULL,161),('/Page_1.cfm',1,'1','',NULL,161),('/Page_2.cfm',1,'1','',NULL,161),('/Page_3.cfm',1,'1','',NULL,161),('/practice_areas.cfm',2,'2','',NULL,161),('/whats_new.cfm',2,'5','',NULL,161),('article',2,'2','',NULL,161),('home',2,'2','',NULL,161),('link',2,'2','',NULL,161),('error',2,'3','',NULL,162),('home',2,'6','d',NULL,162),('/About_Us.cfm',3,'5','d',NULL,163),('/appointments.cfm',2,'5','',NULL,163),('/car_wash_services.cfm',3,'5','d',NULL,163),('/car_wax_n_polish.cfm',3,'5','d',NULL,163),('/clay_bar.cfm',3,'5','d',NULL,163),('/Contact_Us.cfm',3,'5','d',NULL,163),('/Details.cfm',3,'5','d',NULL,163),('/engine_cleaning.cfm',3,'5','d',NULL,163),('/Gallery.cfm',3,'5','d',NULL,163),('/headlight_restoration.cfm',3,'5','d',NULL,163),('/interior_shampoo.cfm',3,'5','d',NULL,163),('/interior_super_clean.cfm',3,'5','d',NULL,163),('/leather_cleaning.cfm',3,'5','d',NULL,163),('/mobile_truck_wash.cfm',3,'5','d',NULL,163),('/Page_1.cfm',2,'5','',NULL,163),('/Page_2.cfm',1,'1','',NULL,163),('/Page_3.cfm',1,'1','',NULL,163),('/premier_detail.cfm',3,'5','d',NULL,163),('/Products.cfm',2,'5','',NULL,163),('/rubbing_compound.cfm',3,'5','d',NULL,163),('/rv_cleaning.cfm',3,'5','d',NULL,163),('/scratch_removal.cfm',3,'5','d',NULL,163),('/specials.cfm',2,'5','',NULL,163),('/swirl_removal.cfm',3,'5','d',NULL,163),('/Testimonials.cfm',3,'5','d',NULL,163),('article',2,'5','',NULL,163),('gallery',3,'5','d',NULL,163),('help',2,'5','',NULL,163),('home',3,'5','d',NULL,163),('link',3,'5','d',NULL,163),('Photo',3,'5','d',NULL,163),('profile_21',2,'5','',NULL,163),('video',3,'5','d',NULL,163),('/About_Us.cfm',2,'5','',NULL,164),('/Page_1.cfm',2,'3','',NULL,164),('/Page_2.cfm',1,'1','',NULL,164),('/Page_3.cfm',1,'1','',NULL,164),('article',2,'3','',NULL,164),('home',2,'3','',NULL,164),('',2,'6','',NULL,165),('/About_Us.cfm',2,'6','',NULL,165),('/Channel_of_Terror.cfm',2,'6','',NULL,165),('/Tomb_of_Trailers.cfm',1,'3','',NULL,165),('/trailers.cfm',2,'6','',NULL,165),('article',2,'5','',NULL,165),('blog',2,'6','',NULL,165),('error',2,'3','',NULL,165),('event',2,'6','',NULL,165),('Forum',2,'6','',NULL,165),('forumThread',2,'5','',NULL,165),('forumTopics',1,'3','',NULL,165),('gallery',2,'6','',NULL,165),('group',2,'6','',NULL,165),('home',2,'6','',NULL,165),('link',2,'6','',NULL,165),('MemberList',2,'6','',NULL,165),('profile_651',2,'6','',NULL,165),('profile_663',2,'6','',NULL,165),('/About_Me.cfm',1,'1','',NULL,166),('blog',2,'5','',NULL,166),('home',2,'5','c',NULL,166),('music',2,'5','',NULL,166),('/About_Us.cfm',2,'5','',NULL,167),('/Page_1.cfm',1,'1','',NULL,167),('/Page_2.cfm',1,'1','',NULL,167),('/Page_3.cfm',1,'1','',NULL,167),('article',2,'5','',NULL,167),('blog',2,'5','',NULL,167),('help',2,'5','',NULL,167),('home',2,'5','',NULL,167),('link',2,'5','',NULL,167),('members',2,'5','',NULL,167),('profile_21',2,'5','',NULL,167),('/about_us.cfm',2,'5','',NULL,168),('/contact_us.cfm',2,'5','',NULL,168),('/convertibles.cfm',2,'5','',NULL,168),('/motoryachts.cfm',2,'5','',NULL,168),('article',2,'5','',NULL,168),('help',2,'5','',NULL,168),('home',2,'5','',NULL,168),('link',2,'5','',NULL,168),('/About_Us.cfm',2,'5','',NULL,169),('/Page_1.cfm',1,'1','',NULL,169),('/Page_2.cfm',1,'1','',NULL,169),('/Page_3.cfm',1,'1','',NULL,169),('home',2,'5','',NULL,169),('/About_Me.cfm',1,'1','',NULL,170),('home',2,'5','',NULL,170),('error',2,'3','',NULL,171),('home',3,'4','d',NULL,171),('/About_Me.cfm',2,'5','',NULL,172),('blog',2,'5','',NULL,172),('home',2,'5','',NULL,172),('link',2,'5','',NULL,172),('error',2,'3','',NULL,173),('home',3,'4','d',NULL,173),('error',2,'3','',NULL,174),('home',3,'4','d',NULL,174),('error',2,'3','',NULL,175),('home',3,'4','d',NULL,175),('error',2,'3','',NULL,176),('home',3,'4','d',NULL,176),('/About_Us.cfm',2,'6','',NULL,177),('/Coming_soon.cfm',2,'6','',NULL,177),('/Page_1.cfm',1,'1','',NULL,177),('/Page_3.cfm',2,'6','',NULL,177),('article',2,'6','',NULL,177),('blog',2,'6','',NULL,177),('event',2,'6','',NULL,177),('help',2,'6','',NULL,177),('home',2,'6','',NULL,177),('link',2,'6','',NULL,177),('location',2,'6','',NULL,177),('profile',2,'5','',NULL,177),('restaurant',2,'6','',NULL,177),('error',2,'3','',NULL,178),('home',3,'4','d',NULL,178),('/About.cfm',1,'1','',NULL,179),('home',2,'5','',NULL,179),('music',3,'2','e',NULL,179),('/About_Us.cfm',2,'5','',NULL,180),('/contact_us.cfm',2,'6','',NULL,180),('/Page_2.cfm',1,'1','',NULL,180),('/Page_3.cfm',1,'1','',NULL,180),('article',2,'6','',NULL,180),('event',2,'6','',NULL,180),('gallery',2,'6','',NULL,180),('home',2,'6','',NULL,180),('photo',2,'6','',NULL,180),('/About_Us.cfm',2,'3','',NULL,181),('/Contact_Us.cfm',2,'6','',NULL,181),('/meet_the_experts.cfm',2,'3','',NULL,181),('/Page_3.cfm',1,'1','',NULL,181),('article',2,'3','',NULL,181),('blog',2,'3','',NULL,181),('home',2,'3','',NULL,181),('link',2,'3','',NULL,181),('video',2,'3','',NULL,181),('error',2,'3','',NULL,182),('home',2,'6','d',NULL,182),('blog',3,'1','c',NULL,183),('error',2,'3','',NULL,183),('home',3,'4','d',NULL,183),('/About_The_Practice.cfm',2,'6','',NULL,184),('/Contact_Us.cfm',2,'6','',NULL,184),('/Medical_Staff.cfm',2,'6','',NULL,184),('/new_patients.cfm',2,'6','',NULL,184),('/Pain_Management.cfm',2,'6','',NULL,184),('/Procedures.cfm',2,'6','',NULL,184),('document',2,'6','',NULL,184),('home',2,'6','',NULL,184),('/About_Us.cfm',2,'5','',NULL,185),('/Contact_Us.cfm',2,'6','',NULL,185),('/page_2.cfm',2,'6','',NULL,185),('/Page_3.cfm',1,'1','',NULL,185),('/splash.cfm',1,'3','',NULL,185),('/still_life_live.cfm',2,'3','',NULL,185),('article',2,'6','',NULL,185),('document',2,'5','',NULL,185),('event',2,'6','',NULL,185),('Gallery',2,'6','',NULL,185),('help',2,'6','',NULL,185),('home',2,'6','',NULL,185),('Photo',2,'6','',NULL,185),('profile',2,'6','',NULL,185),('/About_Us.cfm',2,'5','',NULL,186),('/Page_1.cfm',1,'1','',NULL,186),('/Page_2.cfm',1,'1','',NULL,186),('/Page_3.cfm',1,'1','',NULL,186),('home',2,'5','',NULL,186),('error',2,'3','',NULL,187),('home',3,'4','d',NULL,187),('/About_Us.cfm',2,'5','',NULL,188),('/Page_1.cfm',1,'1','',NULL,188),('/Page_2.cfm',1,'1','',NULL,188),('/Page_3.cfm',1,'1','',NULL,188),('home',2,'5','',NULL,188),('error',2,'3','',NULL,189),('home',3,'4','d',NULL,189),('error',2,'3','',NULL,190),('home',3,'4','d',NULL,190),('/About.cfm',1,'1','',NULL,191),('home',2,'5','',NULL,191),('/About_Me.cfm',1,'1','',NULL,192),('home',2,'5','',NULL,192),('/About_Us.cfm',2,'5','',NULL,193),('/Page_1.cfm',1,'1','',NULL,193),('/Page_2.cfm',1,'1','',NULL,193),('/Page_3.cfm',1,'1','',NULL,193),('home',3,'5','',NULL,193),('/About_Me.cfm',2,'3','',NULL,194),('/Contact_Us.cfm',2,'3','',NULL,194),('gallery',2,'3','',NULL,194),('home',2,'3','',NULL,194),('link',2,'2','',NULL,194),('photo',2,'2','',NULL,194),('/About_Us.cfm',2,'5','',NULL,196),('/Page_1.cfm',2,'5','',NULL,196),('/Page_2.cfm',2,'5','',NULL,196),('/Page_3.cfm',2,'5','',NULL,196),('/Request_An_Appointment.cfm',2,'5','',NULL,196),('/setup_landing_page.cfm',1,'3','',NULL,196),('home',2,'5','',NULL,196),('link',2,'5','',NULL,196),('profile',2,'5','',NULL,196),('/About.cfm',2,'6','',NULL,197),('/About_Us.cfm',2,'5','',NULL,197),('/Contact_Us.cfm',2,'6','',NULL,197),('/Gift_Cards.cfm',2,'6','',NULL,197),('/Menus.cfm',2,'6','',NULL,197),('/Page_1.cfm',1,'1','',NULL,197),('/Page_2.cfm',1,'1','',NULL,197),('/Page_3.cfm',1,'1','',NULL,197),('article',2,'6','',NULL,197),('event',2,'6','',NULL,197),('home',2,'6','',NULL,197),('/About_Me.cfm',1,'1','',NULL,198),('home',2,'5','',NULL,198),('/About_Me.cfm',1,'1','',NULL,199),('home',2,'5','',NULL,199),('',2,'6','',NULL,200),('/About_Us.cfm',2,'6','',NULL,200),('/Channel_of_Terror.cfm',2,'6','',NULL,200),('/Contact.cfm',2,'2','',NULL,200),('/Crazy_Love_Tour_Blog.cfm',2,'2','',NULL,200),('/donate.cfm',2,'2','',NULL,200),('/press.cfm',2,'2','',NULL,200),('/the_bus.cfm',2,'2','',NULL,200),('/the_family.cfm',2,'2','',NULL,200),('/The_Least__The_Lost__and_The_Last.cfm',2,'2','',NULL,200),('/the_route.cfm',2,'2','',NULL,200),('/the_toad.cfm',2,'2','',NULL,200),('/the_video.cfm',2,'2','',NULL,200),('/Tomb_of_Trailers.cfm',1,'3','',NULL,200),('/Tour.cfm',2,'2','',NULL,200),('/tour_pictures.cfm',2,'2','',NULL,200),('/Tour_visit_request.cfm',2,'2','',NULL,200),('/trailers.cfm',2,'6','',NULL,200),('/What_is_CrazyLove.cfm',2,'2','',NULL,200),('/your_neighbor.cfm',2,'2','',NULL,200),('article',2,'5','',NULL,200),('blog',2,'6','',NULL,200),('domestic',2,'2','',NULL,200),('error',2,'3','',NULL,200),('event',2,'6','',NULL,200),('Forum',2,'6','',NULL,200),('forumThread',2,'5','',NULL,200),('forumTopics',1,'3','',NULL,200),('gallery',2,'6','',NULL,200),('group',2,'6','',NULL,200),('home',2,'6','',NULL,200),('international',2,'2','',NULL,200),('link',2,'6','',NULL,200),('location',2,'2','',NULL,200),('MemberList',2,'6','',NULL,200),('Photo',2,'2','',NULL,200),('profile_1',2,'2','d',NULL,200),('profile_21',2,'2','',NULL,200),('profile_550',2,'2','',NULL,200),('profile_587',2,'2','',NULL,200),('profile_651',2,'6','',NULL,200),('profile_663',2,'6','',NULL,200),('video',2,'2','',NULL,200),('',2,'2','',NULL,201),('/About_Us.cfm',2,'6','',NULL,201),('/Channel_of_Terror.cfm',2,'6','',NULL,201),('/Contact.cfm',2,'2','',NULL,201),('/Crazy_Love_Tour_Blog.cfm',2,'2','',NULL,201),('/donate.cfm',2,'2','',NULL,201),('/press.cfm',2,'2','',NULL,201),('/the_bus.cfm',2,'2','',NULL,201),('/the_family.cfm',2,'2','',NULL,201),('/The_Least__The_Lost__and_The_Last.cfm',2,'2','',NULL,201),('/the_route.cfm',2,'2','',NULL,201),('/the_toad.cfm',2,'2','',NULL,201),('/the_video.cfm',2,'2','',NULL,201),('/Tomb_of_Trailers.cfm',1,'3','',NULL,201),('/Tour.cfm',2,'2','',NULL,201),('/tour_pictures.cfm',2,'2','',NULL,201),('/Tour_visit_request.cfm',2,'2','',NULL,201),('/trailers.cfm',2,'6','',NULL,201),('/What_is_CrazyLove.cfm',2,'2','',NULL,201),('/your_neighbor.cfm',2,'2','',NULL,201),('article',2,'2','',NULL,201),('blog',2,'2','',NULL,201),('domestic',2,'2','',NULL,201),('error',2,'3','',NULL,201),('event',2,'6','',NULL,201),('Forum',2,'6','',NULL,201),('forumThread',2,'5','',NULL,201),('forumTopics',1,'3','',NULL,201),('gallery',2,'2','',NULL,201),('group',2,'2','',NULL,201),('home',3,'5','d',NULL,201),('international',2,'2','',NULL,201),('link',2,'6','',NULL,201),('location',2,'2','',NULL,201),('MemberList',2,'2','',NULL,201),('Photo',2,'2','',NULL,201),('profile_1',2,'2','d',NULL,201),('profile_21',2,'2','',NULL,201),('profile_550',2,'2','',NULL,201),('profile_587',2,'2','',NULL,201),('profile_651',2,'6','',NULL,201),('profile_663',2,'6','',NULL,201),('video',2,'2','',NULL,201),('',2,'2','',NULL,202),('/Contact.cfm',2,'2','',NULL,202),('/Crazy_Love_Tour_Blog.cfm',2,'2','',NULL,202),('/donate.cfm',2,'2','',NULL,202),('/press.cfm',2,'2','',NULL,202),('/the_bus.cfm',2,'2','',NULL,202),('/the_family.cfm',2,'2','',NULL,202),('/The_Least__The_Lost__and_The_Last.cfm',2,'2','',NULL,202),('/the_route.cfm',2,'2','',NULL,202),('/the_toad.cfm',2,'2','',NULL,202),('/the_video.cfm',2,'2','',NULL,202),('/Tour.cfm',2,'2','',NULL,202),('/tour_pictures.cfm',2,'2','',NULL,202),('/Tour_visit_request.cfm',2,'2','',NULL,202),('/What_is_CrazyLove.cfm',2,'2','',NULL,202),('/your_neighbor.cfm',2,'2','',NULL,202),('article',2,'2','',NULL,202),('blog',2,'2','',NULL,202),('domestic',2,'2','',NULL,202),('gallery',2,'2','',NULL,202),('group',2,'2','',NULL,202),('home',3,'5','d',NULL,202),('international',2,'2','',NULL,202),('location',2,'2','',NULL,202),('MemberList',2,'2','',NULL,202),('Photo',2,'2','',NULL,202),('profile_1',2,'2','d',NULL,202),('profile_21',2,'2','',NULL,202),('profile_550',2,'2','',NULL,202),('profile_587',2,'2','',NULL,202),('video',2,'2','',NULL,202),('',2,'6','',NULL,203),('/About_Us.cfm',2,'6','',NULL,203),('/Channel_of_Terror.cfm',2,'6','',NULL,203),('/Tomb_of_Trailers.cfm',1,'3','',NULL,203),('/trailers.cfm',2,'6','',NULL,203),('article',2,'5','',NULL,203),('blog',2,'6','',NULL,203),('error',2,'3','',NULL,203),('event',2,'6','',NULL,203),('Forum',2,'6','',NULL,203),('forumThread',2,'5','',NULL,203),('forumTopics',1,'3','',NULL,203),('gallery',2,'6','',NULL,203),('group',2,'6','',NULL,203),('home',2,'6','',NULL,203),('link',2,'6','',NULL,203),('MemberList',2,'6','',NULL,203),('profile_651',2,'6','',NULL,203),('profile_663',2,'6','',NULL,203),('/About.cfm',2,'6','',NULL,204),('/About_Us.cfm',2,'5','',NULL,204),('/Appointment.cfm',2,'6','',NULL,204),('/Auto_Truck_Litigation.cfm',2,'6','',NULL,204),('/Contact.cfm',2,'6','',NULL,204),('/Dog_Bites.cfm',2,'6','',NULL,204),('/FAQs.cfm',2,'6','',NULL,204),('/Insurance_Coverage.cfm',2,'6','',NULL,204),('/Page_1.cfm',1,'1','',NULL,204),('/Page_2.cfm',1,'1','',NULL,204),('/Page_3.cfm',1,'1','',NULL,204),('/Personal_Injury.cfm',2,'6','',NULL,204),('/Practice_Areas.cfm',2,'6','',NULL,204),('/Premises_Liability.cfm',2,'6','',NULL,204),('/Products_Liability.cfm',2,'6','',NULL,204),('article',2,'6','',NULL,204),('home',2,'6','',NULL,204),('link',2,'6','',NULL,204),('profile_21',2,'6','',NULL,204),('',2,'5','',NULL,205),('/about_us.cfm',2,'5','',NULL,205),('/artists.cfm',2,'2','',NULL,205),('/clubs.cfm',2,'2','',NULL,205),('/Events.cfm',2,'5','',NULL,205),('/Forums.cfm',1,'1','',NULL,205),('/Links_Resources.cfm',2,'2','',NULL,205),('article',2,'5','',NULL,205),('blog',2,'5','',NULL,205),('event',2,'5','',NULL,205),('Forum',1,'3','',NULL,205),('forumThread',1,'3','',NULL,205),('forumTopics',1,'3','',NULL,205),('gallery',2,'5','',NULL,205),('help',2,'5','',NULL,205),('home',2,'5','',NULL,205),('link',2,'5','',NULL,205),('music',2,'5','c',NULL,205),('photo',2,'5','',NULL,205),('profile',2,'5','',NULL,205),('profile_21',2,'2','',NULL,205),('profile_648',2,'4','',NULL,205),('video',2,'5','',NULL,205),('/Contact_Us.cfm',2,'5','',NULL,206),('/Links.cfm',2,'6','',NULL,206),('/sundaze_sessions.cfm',2,'5','',NULL,206),('blog',2,'5','',NULL,206),('djchart',2,'5','',NULL,206),('event',2,'5','',NULL,206),('gallery',2,'5','',NULL,206),('group',2,'5','',NULL,206),('home',3,'5','c',NULL,206),('link',2,'5','',NULL,206),('music',2,'5','',NULL,206),('Photo',2,'5','',NULL,206),('profile',2,'5','',NULL,206),('video',2,'5','',NULL,206),('',3,'2','e',NULL,207),('/About.cfm',3,'2','e',NULL,207),('/contact.cfm',3,'2','e',NULL,207),('/sponsorship.cfm',3,'2','e',NULL,207),('article',2,'6','',NULL,207),('blog',2,'5','',NULL,207),('error',3,'2','e',NULL,207),('event',3,'2','e',NULL,207),('gallery',3,'2','e',NULL,207),('home',3,'2','e',NULL,207),('link',3,'2','e',NULL,207),('MemberList',3,'2','e',NULL,207),('profile_656',2,'2','',NULL,207),('video',3,'2','e',NULL,207),('/About_Us.cfm',2,'5','',NULL,208),('/Contact_Us.cfm',2,'6','',NULL,208),('/page_2.cfm',2,'6','',NULL,208),('/Page_3.cfm',1,'1','',NULL,208),('/splash.cfm',1,'3','',NULL,208),('/still_life_live.cfm',2,'3','',NULL,208),('article',2,'6','',NULL,208),('document',2,'5','',NULL,208),('event',2,'6','',NULL,208),('Gallery',2,'6','',NULL,208),('help',2,'6','',NULL,208),('home',2,'6','',NULL,208),('Photo',2,'6','',NULL,208),('profile',2,'6','',NULL,208),('/About.cfm',2,'6','',NULL,213),('/About_Us.cfm',2,'5','',NULL,213),('/Contact_Us.cfm',2,'6','',NULL,213),('/Gift_Cards.cfm',2,'6','',NULL,213),('/Menus.cfm',2,'6','',NULL,213),('/Page_1.cfm',1,'1','',NULL,213),('/Page_2.cfm',1,'1','',NULL,213),('/Page_3.cfm',1,'1','',NULL,213),('event',2,'6','',NULL,213),('home',2,'6','',NULL,213),('/About_Us.cfm',2,'6','',NULL,214),('/Coming_soon.cfm',2,'6','',NULL,214),('/Page_1.cfm',1,'1','',NULL,214),('/Page_3.cfm',2,'6','',NULL,214),('article',2,'6','',NULL,214),('blog',2,'6','',NULL,214),('event',2,'6','',NULL,214),('help',2,'6','',NULL,214),('home',2,'6','',NULL,214),('link',2,'6','',NULL,214),('location',2,'6','',NULL,214),('profile',2,'5','',NULL,214),('restaurant',2,'6','',NULL,214);
/*!40000 ALTER TABLE `layout` ENABLE KEYS */;

/*!40000 ALTER TABLE `menuFeatures` DISABLE KEYS */;
INSERT INTO `menuFeatures` VALUES (1,'Blogs','/blog/main'),(2,'Music','/music/main'),(3,'Video','/video/main'),(4,'Photo','/gallery/main'),(5,'Articles','/article/main'),(6,'Events','/event/main'),(7,'Homepage','/index.cfm'),(8,'Knowledgebase','/knowledgebase/main'),(9,'Forums','/forum/main'),(10,'Links','/link/main'),(11,'Members','/members/list'),(12,'Properties','/property/main'),(13,'Groups','/group/main'),(14,'Documents','/document/main'),(15,'Location','/location/main'),(16,'DJ Charts','/djchart/main'),(17,'Restaurant','/restaurant/main');
/*!40000 ALTER TABLE `menuFeatures` ENABLE KEYS */;

/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1818,'Home',1,64,'2',NULL,'\0',0,7,'0'),(1819,'Blogs',2,64,'2',NULL,'\0',0,1,'0'),(1820,'Events',3,64,'2',NULL,'\0',0,6,'0'),(1821,'Forums',4,64,'2',NULL,'\0',0,9,'0'),(1822,'Music',5,64,'2',NULL,'\0',0,2,'0'),(1823,'Photos',6,64,'2',NULL,'\0',0,4,'0'),(1824,'Videos',7,64,'2',NULL,'\0',0,3,'0'),(1835,'Home',1,66,'2',NULL,'\0',0,7,'0'),(1836,'Page 1',2,66,'0',NULL,'\0',0,7,'/Page_1.cfm'),(1837,'Page 2',3,66,'0',NULL,'\0',0,7,'/Page_2.cfm'),(1838,'Page 3',4,66,'0',NULL,'\0',0,7,'/Page_3.cfm'),(1839,'About Us',5,66,'0',NULL,'\0',0,7,'/About_Us.cfm'),(4092,'Home',1,2,'2',NULL,'\0',0,7,'0'),(4093,'Features',2,2,'1','/socialcloudz/features','\0',0,0,'/features.cfm'),(4094,'Signup',3,2,'1','/create/plans','\0',0,0,'0'),(4095,'About',4,2,'0','/create/plans','\0',0,0,'/About_Us.cfm'),(5292,'groups',1,3,'2',NULL,'\0',0,13,'0'),(5293,'members',2,3,'2',NULL,'\0',0,11,'0'),(5294,'events',3,3,'2',NULL,'\0',0,6,'0'),(5295,'restaurant',4,3,'2',NULL,'\0',0,17,'0'),(5296,'music',5,3,'2',NULL,'\0',0,2,'0'),(5297,'blogs',6,3,'2',NULL,'\0',0,1,'0'),(5298,'photos',7,3,'2',NULL,'\0',0,4,'0'),(5299,'video',8,3,'2',NULL,'\0',0,3,'0'),(5300,'foo',9,3,'1','/blog/main?categoryid=123','\0',0,0,'0'),(5301,'Forums',10,3,'2',NULL,'\0',0,9,'0'),(5811,'Home',1,202,'2',NULL,'\0',0,7,'0'),(5812,'My Page',2,202,'1','/index.cfm?fuseaction=members.profile','\0',1,0,'0'),(5813,'What Is CrazyLove',3,202,'0',NULL,'\0',0,0,'/What_is_CrazyLove.cfm'),(5814,'Stories of the Obsessed',4,202,'1','http://crazylove.socialcloudz.com/video/main?categoryID=197','\0',0,0,'0'),(5815,'Community Blog',5,202,'2',NULL,'\0',0,1,'0'),(5816,'Tour',6,202,'0',NULL,'\0',0,0,'/Tour.cfm'),(5817,'Least Lost Last',7,202,'0',NULL,'\0',0,0,'/The_Least__The_Lost__and_The_Last.cfm'),(5818,'Members',8,202,'2',NULL,'\0',0,11,'0'),(5819,'Shop',9,202,'0',NULL,'\0',0,0,'/Shop.cfm'),(5820,'Contact',10,202,'0',NULL,'\0',0,0,'/Contact.cfm'),(5821,'Home',1,203,'2',NULL,'\0',0,7,'0'),(5822,'Reviews',2,203,'1','/blog/main?categoryID=245','\0',0,1,'0'),(5823,'Headines',3,203,'1','/blog/main?categoryID=241','\0',0,5,'0'),(5824,'Tomb of Trailers',4,203,'0','/article/main?categoryid=256','\0',0,0,'/Tomb_of_Trailers.cfm'),(5825,'Channel of Terror',5,203,'0',NULL,'\0',0,11,'/Channel_of_Terror.cfm'),(5826,'Events of Evil',6,203,'2',NULL,'\0',0,6,'0'),(5827,'Forum of Fear',7,203,'2',NULL,'\0',0,9,'0'),(5828,'Links of Doom',8,203,'2',NULL,'\0',0,10,'0'),(5829,'Crypt Keepers',9,203,'2',NULL,'\0',0,11,'0'),(5830,'About Us',10,203,'0',NULL,'\0',0,11,'/About_Us.cfm'),(5831,'Home',1,204,'2',NULL,'\0',0,7,'0'),(5832,'About Zachary',2,204,'0',NULL,'\0',0,0,'/about.cfm'),(5833,'Practice Areas',3,204,'0',NULL,'\0',0,0,'/practice_areas.cfm'),(5834,'FAQs',4,204,'0',NULL,'\0',0,0,'/faqs.cfm'),(5835,'Articles',5,204,'2',NULL,'\0',0,5,'0'),(5836,'Contact',6,204,'0',NULL,'\0',0,0,'/contact.cfm'),(5837,'Links',7,204,'2',NULL,'\0',0,10,'0'),(5838,'Home',1,205,'2',NULL,'\0',0,7,'0'),(5839,'Live Mix Sets',2,205,'2',NULL,'\0',0,2,'0'),(5840,'Events',3,205,'0','events.cfm','\0',0,1,'/Events.cfm'),(5841,'Music News',4,205,'2',NULL,'\0',0,5,'0'),(5842,'Audio Habitat News',5,205,'2',NULL,'\0',0,1,'0'),(5843,'Links',6,205,'2',NULL,'\0',0,10,'0'),(5844,'home',1,206,'2',NULL,'\0',0,7,'0'),(5845,'radio',2,206,'0',NULL,'\0',0,0,'/sundaze_sessions.cfm'),(5846,'archives',3,206,'2',NULL,'\0',0,3,'0'),(5847,'music',4,206,'2',NULL,'\0',0,2,'0'),(5848,'events',5,206,'2',NULL,'\0',0,6,'0'),(5849,'charts',6,206,'2',NULL,'\0',0,16,'0'),(5850,'photos',7,206,'2',NULL,'\0',0,4,'0'),(5851,'links',8,206,'2',NULL,'\0',0,10,'/Links.cfm'),(5852,'contact',9,206,'0',NULL,'\0',0,0,'/Contact_Us.cfm'),(5853,'Home',1,207,'2',NULL,'\0',0,7,'0'),(5854,'About',2,207,'0',NULL,'\0',0,4,'/About.cfm'),(5855,'Events',3,207,'2',NULL,'\0',0,6,'0'),(5856,'Photos',4,207,'2',NULL,'\0',0,4,'0'),(5857,'Videos',5,207,'2',NULL,'\0',0,3,'0'),(5858,'Members',6,207,'2',NULL,'\0',0,11,'0'),(5859,'Sponsorship',7,207,'0',NULL,'\0',0,0,'/sponsorship.cfm'),(5860,'Links',8,207,'2',NULL,'\0',0,10,'0'),(5861,'Contact',9,207,'0',NULL,'\0',0,0,'/contact.cfm'),(5862,'HOME',1,208,'2',NULL,'\0',0,7,'0'),(5863,'PHOTOS',2,208,'2',NULL,'\0',0,4,'0'),(5864,'EVENTS',3,208,'2',NULL,'\0',0,6,'0'),(5865,'CONTACT',4,208,'0',NULL,'\0',0,6,'/Contact_Us.cfm'),(5866,'FACEBOOK',5,208,'1','http://www.facebook.com/group.php?gid=313440506992&v=wall&ref=ts','',0,0,'0'),(5867,'BUY TICKETS',6,208,'1','http://www.wantickets.com/default.aspx','',0,0,'0'),(5868,'LIVE VIDEO',7,208,'0',NULL,'\0',0,0,'/still_life_live.cfm'),(5881,'Home',1,213,'2',NULL,'\0',0,7,'0'),(5882,'About',2,213,'0',NULL,'\0',0,7,'/About.cfm'),(5883,'Menu',3,213,'0',NULL,'\0',0,7,'/Menus.cfm'),(5884,'Events',4,213,'0',NULL,'\0',0,7,'/Events.cfm'),(5885,'Contact',5,213,'0',NULL,'\0',0,7,'/Contact_Us.cfm'),(5886,'Gift Cards',6,213,'0',NULL,'\0',0,7,'/Gift_Cards.cfm'),(5887,'Home',1,214,'2',NULL,'\0',0,7,'0'),(5888,'Events',2,214,'2',NULL,'\0',0,6,'0'),(5889,'Restaurants',3,214,'2',NULL,'\0',0,17,'0'),(5890,'Reviews',4,214,'2',NULL,'\0',0,5,'/Page_1.cfm'),(5891,'About',5,214,'0',NULL,'\0',0,0,'/About_Us.cfm'),(5892,'Contact Us',6,214,'0',NULL,'\0',0,0,'/Page_3.cfm'),(5893,'Links',7,214,'2',NULL,'\0',0,10,'0');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;

/*!40000 ALTER TABLE `modulepage` DISABLE KEYS */;
INSERT INTO `modulepage` VALUES (69,1,1,'/test.cfm',2),(123,1,1,'/aboutus.cfm',2),(125,1,1,'/pricing.cfm',2),(147,1,1,'/what_overview.cfm',2),(148,1,1,'/custom.cfm',2),(149,1,1,'/team.cfm',2),(152,1,1,'/how_overview.cfm',2),(156,1,1,'/cms.cfm',2),(158,1,1,'/business.cfm',2),(161,1,1,'/socialmedia.cfm',2),(650,1,1,'/technology.cfm',2),(803,1,1,'home',64),(805,1,1,'home',66),(807,1,1,'/Page_1.cfm',66),(808,1,1,'/Page_2.cfm',66),(809,1,1,'/Page_3.cfm',66),(810,1,1,'/About_Us.cfm',66),(1218,1,1,'home',2),(1262,1,1,'/Page_2.cfm',3),(1268,1,1,'/jobs.cfm',2),(1279,1,1,'/tour.cfm',2),(1280,1,1,'/features.cfm',2),(1365,1,1,'profile_1',3),(1396,1,1,'/contact.cfm',2),(1684,1,1,'/1.cfm',3),(1814,1,1,'/test.cfm',3),(2040,1,1,'/test12311.cfm',3),(2087,1,1,'/About_Us.cfm',2),(2635,1,1,'home',3),(3012,1,1,'/press.cfm',202),(3013,1,1,'/the_bus.cfm',202),(3014,1,1,'/The_Least__The_Lost__and_The_Last.cfm',202),(3015,1,1,'/the_family.cfm',202),(3016,1,1,'/your_neighbor.cfm',202),(3017,1,1,'/the_route.cfm',202),(3018,1,1,'domestic',202),(3019,1,1,'/Contact.cfm',202),(3020,1,1,'/the_toad.cfm',202),(3021,1,1,'international',202),(3022,1,1,'/the_video.cfm',202),(3023,1,1,'/Tour.cfm',202),(3024,1,1,'/tour_pictures.cfm',202),(3025,1,1,'/Tour_visit_request.cfm',202),(3026,1,1,'/Crazy_Love_Tour_Blog.cfm',202),(3027,1,1,'/What_is_CrazyLove.cfm',202),(3028,1,1,'/donate.cfm',202),(3029,1,1,'location',202),(3030,1,1,'home',202),(3031,1,1,'MemberList',202),(3080,1,1,'/Tomb_of_Trailers.cfm',203),(3081,1,1,'home',203),(3082,1,1,'/trailers.cfm',203),(3083,1,1,'SuperAdmin',203),(3084,1,1,'/About_Us.cfm',203),(3085,1,1,'/Channel_of_Terror.cfm',203),(3094,1,1,'/Dog_Bites.cfm',204),(3095,1,1,'/Contact.cfm',204),(3096,1,1,'/About_Us.cfm',204),(3097,1,1,'/Personal_Injury.cfm',204),(3098,1,1,'/Appointment.cfm',204),(3099,1,1,'home',204),(3100,1,1,'/about.cfm',204),(3101,1,1,'/Premises_Liability.cfm',204),(3102,1,1,'/Practice_Areas.cfm',204),(3103,1,1,'/FAQs.cfm',204),(3105,1,1,'/Auto_Truck_Litigation.cfm',204),(3106,1,1,'/Page_1.cfm',204),(3107,1,1,'/Page_2.cfm',204),(3108,1,1,'/Insurance_Coverage.cfm',204),(3109,1,1,'/Page_3.cfm',204),(3110,1,1,'/Products_Liability.cfm',204),(3143,1,1,'link',205),(3144,1,1,'profile_44',205),(3145,1,1,'profile_21',205),(3146,1,1,'profile_1',205),(3147,1,1,'profile_60',205),(3148,1,1,'home',205),(3149,1,1,'splash',205),(3150,1,1,'/about_us.cfm',205),(3151,1,1,'/Events.cfm',205),(3182,1,1,'/sundaze_sessions.cfm',206),(3183,1,1,'splash',206),(3184,1,1,'MemberList',206),(3185,1,1,'/Contact_Us.cfm',206),(3186,1,1,'home',206),(3187,1,1,'/Links.cfm',206),(3206,1,1,'/About.cfm',207),(3207,1,1,'/sponsorship.cfm',207),(3208,1,1,'splash',207),(3209,1,1,'home',207),(3210,1,1,'/contact.cfm',207),(3290,1,1,'splash',208),(3291,1,1,'/Contact_Us.cfm',208),(3292,1,1,'/About_Us.cfm',208),(3293,1,1,'/Page_3.cfm',208),(3294,1,1,'/page_2.cfm',208),(3295,1,1,'home',208),(3296,1,1,'/splash.cfm',208),(3309,1,1,'/Menus.cfm',213),(3310,1,1,'/Contact_Us.cfm',213),(3311,1,1,'/Events.cfm',213),(3312,1,1,'/Page_3.cfm',213),(3313,1,1,'/About_Us.cfm',213),(3314,1,1,'home',213),(3315,1,1,'/Page_1.cfm',213),(3316,1,1,'/Page_2.cfm',213),(3317,1,1,'/About.cfm',213),(3330,1,1,'/Page_3.cfm',214),(3331,1,1,'/About_Us.cfm',214),(3332,1,1,'/Page_1.cfm',214),(3333,1,1,'/Coming_soon.cfm',214),(3334,1,1,'home',214),(150,1,2,'/team.cfm',2),(151,1,2,'/custom.cfm',2),(153,1,2,'/how_overview.cfm',2),(160,1,2,'/what_overview.cfm',2),(648,1,2,'/aboutus.cfm',2),(648,1,2,'/About_Us.cfm',2),(648,1,2,'/business.cfm',2),(648,1,2,'/cms.cfm',2),(648,1,2,'/socialmedia.cfm',2),(648,1,2,'/technology.cfm',2),(798,1,2,'home',64),(811,1,2,'/About_Us.cfm',66),(812,1,2,'home',66),(1217,1,2,'/tour.cfm',2),(1271,1,2,'/contact.cfm',2),(1271,1,2,'/jobs.cfm',2),(1441,1,2,'/pricing.cfm',2),(2355,1,2,'Forum',3),(2485,1,2,'home',3),(3052,1,2,'/the_toad.cfm',202),(3053,1,2,'home',202),(3054,1,2,'/the_video.cfm',202),(3055,1,2,'/Tour.cfm',202),(3056,1,2,'/Contact.cfm',202),(3057,1,2,'/tour_pictures.cfm',202),(3058,1,2,'/Crazy_Love_Tour_Blog.cfm',202),(3059,1,2,'/Tour_visit_request.cfm',202),(3060,1,2,'/donate.cfm',202),(3061,1,2,'/What_is_CrazyLove.cfm',202),(3062,1,2,'/press.cfm',202),(3063,1,2,'/your_neighbor.cfm',202),(3064,1,2,'/the_bus.cfm',202),(3065,1,2,'/the_family.cfm',202),(3066,1,2,'/The_Least__The_Lost__and_The_Last.cfm',202),(3067,1,2,'/the_route.cfm',202),(3086,1,2,'home',203),(3087,1,2,'/About_Us.cfm',203),(3088,1,2,'/Channel_of_Terror.cfm',203),(3089,1,2,'Forum',203),(3122,1,2,'/Dog_Bites.cfm',204),(3123,1,2,'/Appointment.cfm',204),(3124,1,2,'/FAQs.cfm',204),(3125,1,2,'/Insurance_Coverage.cfm',204),(3126,1,2,'/Personal_Injury.cfm',204),(3127,1,2,'/Practice_Areas.cfm',204),(3128,1,2,'/Premises_Liability.cfm',204),(3129,1,2,'home',204),(3130,1,2,'/Products_Liability.cfm',204),(3131,1,2,'/About_Us.cfm',204),(3132,1,2,'/about.cfm',204),(3134,1,2,'/Auto_Truck_Litigation.cfm',204),(3135,1,2,'/Contact.cfm',204),(3161,1,2,'/Events.cfm',205),(3162,1,2,'/Photos.cfm',205),(3163,1,2,'home',205),(3164,1,2,'/news.cfm',205),(3165,1,2,'/about_us.cfm',205),(3191,1,2,'/sundaze_sessions.cfm',206),(3192,1,2,'home',206),(3193,1,2,'event',206),(3194,1,2,'/Links.cfm',206),(3195,1,2,'/Contact_Us.cfm',206),(3196,1,2,'link',206),(3214,1,2,'video',207),(3215,1,2,'/About.cfm',207),(3216,1,2,'/contact.cfm',207),(3217,1,2,'/sponsorship.cfm',207),(3218,1,2,'home',207),(3300,1,2,'/page_2.cfm',208),(3301,1,2,'/About_Us.cfm',208),(3302,1,2,'/Contact_Us.cfm',208),(3303,1,2,'home',208),(3319,1,2,'/Contact_Us.cfm',213),(3320,1,2,'/About_Us.cfm',213),(3321,1,2,'home',213),(3322,1,2,'/About.cfm',213),(3323,1,2,'/Menus.cfm',213),(3335,1,2,'home',214),(3336,1,2,'/Coming_soon.cfm',214),(3337,1,2,'/Page_3.cfm',214),(3338,1,2,'/About_Us.cfm',214),(801,1,3,'home',64),(1263,1,3,'/Page_2.cfm',3),(2484,1,3,'profile_21',3),(3071,1,3,'home',202),(3200,1,3,'home',206),(3227,1,3,'/About.cfm',207),(3228,1,3,'/contact.cfm',207),(3229,1,3,'/sponsorship.cfm',207),(3230,1,3,'home',207),(2548,1,4,'profile',3),(3173,1,4,'music',205),(3203,1,4,'event',206),(3204,1,4,'profile',206),(3205,1,4,'video',206),(3235,1,4,'event',207),(3236,1,4,'link',207),(3237,1,4,'MemberList',207),(1364,1,5,'profile_1',3),(3076,1,5,'MemberList',202),(3174,1,5,'link',205),(3175,1,5,'blog',205),(3238,1,5,'video',207),(3239,1,5,'event',207),(3240,1,5,'MemberList',207),(3241,1,5,'gallery',207),(3242,1,5,'link',207),(3341,1,5,'location',214),(3342,1,5,'restaurant',214),(3077,1,6,'MemberList',202),(3176,1,6,'link',205),(3177,1,6,'blog',205),(3251,1,6,'video',207),(3252,1,6,'event',207),(3253,1,6,'MemberList',207),(3254,1,6,'gallery',207),(3255,1,6,'link',207),(3343,1,6,'location',214),(3344,1,6,'restaurant',214),(3078,1,7,'MemberList',202),(3178,1,7,'link',205),(3179,1,7,'blog',205),(3264,1,7,'video',207),(3265,1,7,'event',207),(3266,1,7,'MemberList',207),(3267,1,7,'gallery',207),(3268,1,7,'link',207),(3345,1,7,'location',214),(3346,1,7,'restaurant',214),(1264,1,8,'/Page_2.cfm',3),(3079,1,8,'MemberList',202),(3180,1,8,'link',205),(3181,1,8,'blog',205),(3277,1,8,'video',207),(3278,1,8,'event',207),(3279,1,8,'MemberList',207),(3280,1,8,'gallery',207),(3281,1,8,'link',207),(3347,1,8,'location',214),(3348,1,8,'restaurant',214),(804,2,1,'home',64),(1380,2,1,'/aboutus.cfm',2),(2084,2,1,'home',2),(2482,2,1,'profile_1',3),(2656,2,1,'home',3),(3032,2,1,'/your_neighbor.cfm',202),(3033,2,1,'/tour_pictures.cfm',202),(3034,2,1,'/donate.cfm',202),(3035,2,1,'/the_video.cfm',202),(3036,2,1,'/the_bus.cfm',202),(3037,2,1,'/the_toad.cfm',202),(3038,2,1,'/Tour_visit_request.cfm',202),(3039,2,1,'/the_family.cfm',202),(3040,2,1,'/The_Least__The_Lost__and_The_Last.cfm',202),(3041,2,1,'/the_route.cfm',202),(3042,2,1,'/Crazy_Love_Tour_Blog.cfm',202),(3043,2,1,'/press.cfm',202),(3044,2,1,'home',202),(3104,2,1,'/About_Us.cfm',204),(3111,2,1,'/about.cfm',204),(3112,2,1,'/FAQs.cfm',204),(3114,2,1,'/Auto_Truck_Litigation.cfm',204),(3115,2,1,'/Personal_Injury.cfm',204),(3116,2,1,'/Insurance_Coverage.cfm',204),(3117,2,1,'home',204),(3118,2,1,'/Products_Liability.cfm',204),(3119,2,1,'/Premises_Liability.cfm',204),(3120,2,1,'/Dog_Bites.cfm',204),(3152,2,1,'home',205),(3153,2,1,'/about_us.cfm',205),(3154,2,1,'/Events.cfm',205),(3155,2,1,'profile_21',205),(3156,2,1,'profile_60',205),(3157,2,1,'profile_44',205),(3188,2,1,'/sundaze_sessions.cfm',206),(3189,2,1,'home',206),(3211,2,1,'home',207),(3297,2,1,'/page_2.cfm',208),(3298,2,1,'home',208),(3299,2,1,'/Contact_Us.cfm',208),(3318,2,1,'/About.cfm',213),(124,2,2,'/aboutus.cfm',2),(126,2,2,'/pricing.cfm',2),(799,2,2,'home',64),(1271,2,2,'/About_Us.cfm',2),(3068,2,2,'home',202),(3090,2,2,'home',203),(3133,2,2,'/About_Us.cfm',204),(3136,2,2,'/about.cfm',204),(3138,2,2,'/FAQs.cfm',204),(3139,2,2,'/Practice_Areas.cfm',204),(3140,2,2,'home',204),(3141,2,2,'/Appointment.cfm',204),(3142,2,2,'/Contact.cfm',204),(3166,2,2,'/Events.cfm',205),(3167,2,2,'/news.cfm',205),(3168,2,2,'home',205),(3197,2,2,'/sundaze_sessions.cfm',206),(3198,2,2,'home',206),(3219,2,2,'home',207),(3220,2,2,'/About.cfm',207),(3221,2,2,'/contact.cfm',207),(3222,2,2,'/sponsorship.cfm',207),(3304,2,2,'/page_2.cfm',208),(3305,2,2,'home',208),(3324,2,2,'/About.cfm',213),(3325,2,2,'/Menus.cfm',213),(3326,2,2,'/Contact_Us.cfm',213),(3327,2,2,'home',213),(3339,2,2,'home',214),(3340,2,2,'/About_Us.cfm',214),(3072,2,3,'home',202),(3201,2,3,'home',206),(3231,2,3,'/About.cfm',207),(3232,2,3,'home',207),(3243,2,5,'video',207),(3244,2,5,'MemberList',207),(3245,2,5,'event',207),(3246,2,5,'link',207),(3247,2,5,'gallery',207),(3256,2,6,'video',207),(3257,2,6,'MemberList',207),(3258,2,6,'event',207),(3259,2,6,'link',207),(3260,2,6,'gallery',207),(3269,2,7,'video',207),(3270,2,7,'MemberList',207),(3271,2,7,'event',207),(3272,2,7,'link',207),(3273,2,7,'gallery',207),(3282,2,8,'video',207),(3283,2,8,'MemberList',207),(3284,2,8,'event',207),(3285,2,8,'link',207),(3286,2,8,'gallery',207),(802,3,1,'home',64),(2085,3,1,'home',2),(3045,3,1,'/your_neighbor.cfm',202),(3046,3,1,'home',202),(3047,3,1,'/tour_pictures.cfm',202),(3048,3,1,'/The_Least__The_Lost__and_The_Last.cfm',202),(3113,3,1,'/About_Us.cfm',204),(3121,3,1,'home',204),(3158,3,1,'/Events.cfm',205),(3159,3,1,'home',205),(3190,3,1,'home',206),(3212,3,1,'home',207),(800,3,2,'home',64),(3069,3,2,'home',202),(3091,3,2,'home',203),(3137,3,2,'/About_Us.cfm',204),(3169,3,2,'/Events.cfm',205),(3170,3,2,'home',205),(3199,3,2,'home',206),(3223,3,2,'/About.cfm',207),(3224,3,2,'/contact.cfm',207),(3225,3,2,'/sponsorship.cfm',207),(3226,3,2,'home',207),(3306,3,2,'home',208),(3307,3,2,'/page_2.cfm',208),(3328,3,2,'home',213),(3073,3,3,'home',202),(3202,3,3,'home',206),(3233,3,3,'home',207),(3248,3,5,'MemberList',207),(3249,3,5,'event',207),(3250,3,5,'link',207),(3261,3,6,'MemberList',207),(3262,3,6,'event',207),(3263,3,6,'link',207),(3274,3,7,'MemberList',207),(3275,3,7,'event',207),(3276,3,7,'link',207),(3287,3,8,'MemberList',207),(3288,3,8,'event',207),(3289,3,8,'link',207),(3049,4,1,'/The_Least__The_Lost__and_The_Last.cfm',202),(3050,4,1,'home',202),(3160,4,1,'/Events.cfm',205),(3213,4,1,'home',207),(3070,4,2,'home',202),(3092,4,2,'home',203),(3171,4,2,'home',205),(3308,4,2,'/page_2.cfm',208),(3329,4,2,'home',213),(3074,4,3,'home',202),(3234,4,3,'home',207),(3051,5,1,'home',202),(3093,5,2,'home',203),(3172,5,2,'home',205),(3075,5,3,'home',202),(1271,7,5,'article',2);
/*!40000 ALTER TABLE `modulepage` ENABLE KEYS */;



/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (3,'HTML','any','dsp_html','          ','widget','Add your own custom HTML','html_add.png','','frm_editHTML'),(4,'RSS','any','dsp_rss','          ','widget','Add your favorite RSS feed','rss_go.png','','frm_editRss'),(6,'Blogs','Home','dsp_content','blog','media','Publish content and allow members to comment','book.png','','frm_editContent'),(7,'Articles','Home','dsp_content','article','media','Publish content and allow members to comment','book.png','','frm_editContent'),(8,'Members','Home','dsp_memberList',NULL,'community','Show a list of your members','group.png','','frm_editGeneric'),(11,'Photo Galleries','Home','dsp_content','gallery','media','Add photos to your page','picture.png','','frm_editContent'),(15,'Weather','Home','dsp_weather',NULL,'widget','Add local weather forecast','weather_cloudy','','frm_editGeneric'),(16,'Horoscope','Home','dsp_horoscope',NULL,'widget','Add astrological horoscope ','star.png','','frm_editGeneric'),(17,'Forums','Home','dsp_forums',NULL,'community','Add community discussion forum','comments.png','','frm_editGeneric'),(18,'Bulletin','Home','dsp_bulletin',NULL,'community','Allow visitors to post notes','script_edit.png','','frm_editGeneric'),(19,'Poll','Home','dsp_poll',NULL,'community','Ask your visitors a question and poll the results','chart_bar.png','','frm_editPoll'),(20,'Video','Home','dsp_content','video     ','media','Add videos to your page','webcam.png','','frm_editContent'),(24,'Mailing List','Home','dsp_mailinglist',NULL,'promote','Collect email addresses for marketing','email_edit.png','','frm_editGeneric'),(26,'Share','Home','dsp_share',NULL,'promote','Allow users to share page with others','thumb_up.png','','frm_editGeneric'),(27,'Invite','Home','dsp_invite',NULL,'promote','Allow members to invite others','group_go.png','','frm_editGeneric'),(28,'Music','Home','dsp_content','Music','media','Add music','cd.png','','frm_editContent'),(29,'Events','any','dsp_events','Event','community','Add events to your page','calendar.png','','frm_editEvent'),(30,'Form','any','dsp_form',NULL,'widget','Create and manage your own forms','pencil.png','','frm_editTitle'),(31,'Knowledgebase','any','dsp_content','kb_topic','community','Create and manage help topics','help.png','','frm_editContent'),(32,'Mini Cart','any','dsp_shoppingMiniCart',NULL,'shopping','Display a mini shopping car','cart.png','','frm_editContent'),(33,'Categories','any','dsp_shoppingCategories',NULL,'shopping','Display the product categories','cart_go.png','','frm_editContent'),(34,'Photos','any','dsp_gallery','photo','media','Display a particular photo gallery','picture.png','','frm_editGallery'),(35,'Friends','any','dsp_friendList',NULL,'profile','Display a list of your friends','group.png','','frm_editGeneric'),(36,'Events','any','dsp_events','Event','profile','Display a list of events you posted','calendar.png','','frm_editEvent'),(37,'Comments','Profile','dsp_comments',NULL,'profile','Display comments from your friends','comments.png','','frm_editGeneric'),(38,'Login','any','dsp_login',NULL,'community','Display a Login Box','user.png','','frm_editTitle'),(39,'Advertisement','any','dsp_ad',NULL,'advertising','Display an ad unit','coin.png','','frm_ad'),(40,'Links','any','dsp_links','Link','community','Display a list of Links','link.png','','frm_editLinks'),(41,'Quote of the Day','any','dsp_quote',NULL,'widget','Display random quotes','comment.png','','frm_editTitle'),(42,'Word of the Day','any','dsp_word',NULL,'widget','Display a word of the day','book.png','',NULL),(43,'Twitter','any','dsp_twitter',NULL,'widget','Display a feed from a Twitter User or Keyword','twitter.png','','frm_editTwitter'),(44,'Property Listing','any','dsp_content','Property','media','Display a list of properties for sale','coins.png','','frm_editContent'),(45,'Documents','any','dsp_content','Document','media','Display a list of uploaded documents','folder.png','','frm_editContent'),(46,'Search','any','dsp_contentSearch','','media','Displays a search box','magnifier.png','','frm_editGeneric'),(47,'Recent Activity','any','dsp_recentActivity',NULL,'community','Displays a recent activity feed','script.png','','frm_editGeneric'),(48,'Groups','any','dsp_groups','Group','community','Display a listing of groups','users.png','','frm_editContent'),(49,'User Menu','any','dsp_userMenu','','community','User oriented profile menu','user.png','','frm_editGeneric'),(50,'DJ Charts','any','dsp_content','DJChart','media','Top 10 Music Chart','cd.png',NULL,'frm_editGeneric');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;

/*!40000 ALTER TABLE `modulesettings` DISABLE KEYS */;
INSERT INTO `modulesettings` VALUES (69,3,NULL,NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(108,3,'Customer Spotlight',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(110,3,'Social Media and Business Collaboration for the Future! ',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(114,3,'welcome.to.diffuse.audio',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(115,3,'get.music',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(116,3,'diffuse.audio.artists',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(123,3,'About SocialCloudZ',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(124,3,'Contact Us',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(125,3,'Compare Plans / Features',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(126,3,'Add-on Features',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(127,3,'General',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(128,3,'why socialcloudz?',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(135,11,'Photos','publishdate',9,NULL,'thumbnail',NULL,'175',NULL,NULL,NULL,NULL,'','','\0','\0'),(136,20,NULL,NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(137,3,'Welcome!',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(139,29,'Events','publishdate',6,NULL,'List',NULL,'>',NULL,NULL,NULL,NULL,'','','\0','\0'),(144,24,NULL,NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(147,3,'Overview',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(148,3,'Custom Development and Enterprise Deployments',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(149,3,'Team',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(150,3,'Careers',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(151,3,'Custom Design',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(152,3,'How We Do It',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(153,3,NULL,NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(154,3,'Technology: Overview',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(155,3,'Partners',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(156,3,'Technology: Content Management',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(157,3,NULL,NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(158,3,'Technology: Business Tools',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(159,3,NULL,NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(160,3,NULL,NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(161,3,'Technology: Media Library',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(162,3,NULL,NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(163,3,'Community Driven Content',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(164,3,'User Interaction and Collaboration',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(168,3,'Our Toolbox',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(179,3,NULL,NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(180,3,'Home',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(181,3,'Contact Us',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(182,3,'About Us',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(184,3,'Our Services',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(185,3,'AIGA',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(186,3,'A few words about budgets',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(192,30,'Contact Us Form','publishdate',1,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(193,3,'Premium Features',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(194,6,'Blogs','publishdate',3,NULL,'list',NULL,'45',NULL,NULL,NULL,NULL,'','','\0','\0'),(195,3,'Projects',NULL,NULL,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(196,29,'Events','publishdate',1,NULL,'',NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(200,3,'My Resume',NULL,NULL,NULL,NULL,NULL,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(648,3,'Our Platform',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(650,3,'SocialCloudz Technology',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(798,8,NULL,NULL,NULL,NULL,NULL,64,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(799,29,NULL,NULL,NULL,NULL,NULL,64,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(800,17,NULL,NULL,NULL,NULL,NULL,64,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(801,6,NULL,NULL,NULL,NULL,NULL,64,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(802,11,NULL,NULL,NULL,NULL,NULL,64,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(803,20,NULL,NULL,NULL,NULL,NULL,64,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(804,28,NULL,NULL,NULL,NULL,NULL,64,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(805,3,'Welcome to the Basic Site Demo!',NULL,NULL,NULL,NULL,66,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(807,3,'Titltetitletitletieltitlteitel',NULL,NULL,NULL,NULL,66,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(808,3,'HTMLTitletitletitlte',NULL,NULL,NULL,NULL,66,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(809,3,NULL,NULL,NULL,NULL,NULL,66,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(810,3,NULL,NULL,NULL,NULL,NULL,66,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(811,3,NULL,NULL,NULL,NULL,NULL,66,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(812,7,NULL,NULL,NULL,NULL,NULL,66,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(1217,3,'Learn More',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(1218,3,' ',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(1268,3,'Jobs @ SocialCloudz',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(1271,3,' ',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'','','\0','\0'),(1279,3,'SocialCloudz Tour',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(1280,3,'SocialCloudz Features',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(1380,3,'How SocialCloudz Works',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(1396,30,'Contact Form','publishdate',6,NULL,'list',2,'45',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(1441,3,'Every Plan Includes',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(1814,30,NULL,NULL,NULL,NULL,NULL,3,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2040,8,NULL,NULL,NULL,NULL,NULL,3,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2084,3,' ',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2085,3,' ',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2087,3,'About Us',NULL,NULL,NULL,NULL,2,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2355,3,NULL,NULL,NULL,NULL,NULL,3,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2482,3,NULL,NULL,NULL,NULL,NULL,3,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2484,3,NULL,NULL,NULL,NULL,NULL,3,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2485,38,NULL,NULL,NULL,NULL,NULL,3,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2548,28,NULL,NULL,NULL,NULL,NULL,3,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2635,3,NULL,NULL,NULL,NULL,NULL,3,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(2656,24,NULL,NULL,NULL,NULL,NULL,3,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3012,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3013,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3014,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3015,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3016,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3017,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3018,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3019,30,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3020,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3021,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3022,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3023,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3024,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3025,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3026,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3027,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3028,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3029,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3030,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3031,8,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3032,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3033,11,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3034,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3035,20,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3036,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3037,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3038,30,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3039,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3040,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3041,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3042,7,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3043,7,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3044,8,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3045,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3046,20,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3047,34,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3048,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3049,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3050,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3051,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3052,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3053,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3054,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3055,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3056,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3057,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3058,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3059,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3060,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3061,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3062,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3063,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3064,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3065,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3066,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3067,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3068,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3069,48,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3070,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3071,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3072,3,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3073,20,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3074,6,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3075,11,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3076,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3077,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3078,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3079,49,NULL,NULL,NULL,NULL,NULL,202,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3080,3,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3081,6,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3082,6,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3083,31,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3084,3,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3085,3,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3086,3,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3087,8,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3088,3,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3089,3,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3090,29,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3091,8,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3092,3,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3093,3,NULL,NULL,NULL,NULL,NULL,203,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3094,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3095,30,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3096,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3097,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3098,30,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3099,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3100,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3101,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3102,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3103,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3104,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3105,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3106,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3107,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3108,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3109,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3110,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3111,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3112,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3113,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3114,7,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3115,7,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3116,7,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3117,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3118,7,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3119,7,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3120,7,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3121,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3122,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3123,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3124,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3125,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3126,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3127,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3128,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3129,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3130,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3131,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3132,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3133,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3134,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3135,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3136,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3137,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3138,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3139,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3140,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3141,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3142,3,NULL,NULL,NULL,NULL,NULL,204,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3143,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3144,35,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3145,35,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3146,36,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3147,37,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3148,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3149,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3150,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3151,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3152,28,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3153,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3154,29,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3155,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3156,11,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3157,28,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3158,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3159,28,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3160,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3161,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3162,11,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3163,38,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3164,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3165,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3166,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3167,7,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3168,46,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3169,19,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3170,29,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3171,7,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3172,6,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3173,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3174,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3175,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3176,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3177,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3178,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3179,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3180,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3181,3,NULL,NULL,NULL,NULL,NULL,205,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3182,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3183,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3184,8,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3185,30,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3186,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3187,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3188,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3189,8,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3190,29,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3191,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3192,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3193,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3194,24,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3195,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3196,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3197,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3198,6,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3199,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3200,28,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3201,20,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3202,11,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3203,4,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3204,28,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3205,3,NULL,NULL,NULL,NULL,NULL,206,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3206,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3207,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3208,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3209,29,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3210,30,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3211,6,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3212,7,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3213,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3214,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3215,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3216,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3217,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3218,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3219,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3220,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3221,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3222,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3223,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3224,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3225,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3226,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3227,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3228,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3229,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3230,38,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3231,43,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3232,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3233,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3234,43,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3235,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3236,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3237,3,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3238,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3239,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3240,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3241,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3242,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3243,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3244,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3245,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3246,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3247,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3248,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3249,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3250,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3251,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3252,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3253,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3254,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3255,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3256,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3257,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3258,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3259,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3260,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3261,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3262,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3263,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3264,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3265,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3266,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3267,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3268,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3269,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3270,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3271,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3272,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3273,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3274,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3275,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3276,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3277,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3278,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3279,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3280,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3281,8,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3282,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3283,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3284,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3285,11,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3286,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3287,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3288,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3289,20,NULL,NULL,NULL,NULL,NULL,207,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3290,3,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3291,30,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3292,3,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3293,3,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3294,3,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3295,3,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3296,3,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3297,7,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3298,11,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3299,3,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3300,3,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3301,3,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3302,3,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3303,7,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3304,29,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3305,29,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3306,24,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3307,11,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3308,24,NULL,NULL,NULL,NULL,NULL,208,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3309,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3310,30,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3311,43,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3312,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3313,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3314,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3315,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3316,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3317,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3318,43,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3319,24,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3320,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3321,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3322,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3323,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3324,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3325,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3326,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3327,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3328,24,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3329,3,NULL,NULL,NULL,NULL,NULL,213,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3330,30,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3331,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3332,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3333,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3334,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3335,46,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3336,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3337,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3338,6,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3339,7,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3340,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3341,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3342,46,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3343,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3344,46,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3345,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3346,46,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3347,3,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0'),(3348,46,NULL,NULL,NULL,NULL,NULL,214,'75',NULL,NULL,NULL,NULL,'',NULL,'\0','\0');
/*!40000 ALTER TABLE `modulesettings` ENABLE KEYS */;



/*!40000 ALTER TABLE `pageSettingList` DISABLE KEYS */;
INSERT INTO `pageSettingList` VALUES (1,'Title','Articles','Articles','text',1,'article','Title','General'),(2,'RelatedMedia','0,1','1','bit',5,'article','Related Media','Modules'),(3,'TagCloud','0,1','1','bit',6,'article','Tag Cloud','Modules'),(4,'Categories','0,1','1','bit',3,'article','Categories','Modules'),(5,'Archives','0,1','1','bit',4,'article','Archives','Modules'),(6,'Title','Blogs','Blogs','text',1,'blog','Title','General'),(7,'RelatedMedia','0,1','1','bit',3,'blog','Related Media','Modules'),(8,'TagCloud','0,1','1','bit',4,'blog','Tag Cloud','Modules'),(9,'Categories','0,1','1','bit',5,'blog','Categories','Modules'),(10,'Archives','0,1','1','bit',6,'blog','Archives','Modules'),(11,'Title','Events','events','text',1,'event','Title','General'),(12,'RelatedMedia','0,1','1','bit',3,'event','Related Media','Modules'),(13,'TagCloud','0,1','1','bit',4,'knowledgebase','Tag Cloud','Modules'),(14,'Categories','0,1','1','bit',5,'event','Categories','Modules'),(15,'Archives','0,1','1','bit',6,'event','Archives','Modules'),(16,'Title','knowledgebase','knowledgebase','text',1,'knowledgebase','Title','General'),(17,'RelatedMedia','0,1','1','bit',3,'knowledgebase','Related Media','Modules'),(19,'Categories','0,1','1','bit',5,'knowledgebase','Categories','Modules'),(20,'Archives','0,1','1','bit',6,'knowledgebase','Archives','Modules'),(21,'Title','music','music','text',1,'music','Title','General'),(22,'RelatedMedia','0,1','1','bit',3,'music','Related Media','Modules'),(23,'TagCloud','0,1','1','bit',4,'music','Tag Cloud','Modules'),(24,'Categories','0,1','1','bit',5,'music','Categories','Modules'),(25,'Archives','0,1','1','bit',6,'music','Archives','Modules'),(26,'Title','galleries','galleries','text',1,'gallery','Title','General'),(27,'RelatedMedia','0,1','1','bit',3,'gallery','Related Media','Modules'),(28,'TagCloud','0,1','1','bit',4,'gallery','Tag Cloud','Modules'),(29,'Categories','0,1','1','bit',5,'gallery','Categories','Modules'),(30,'Archives','0,1','1','bit',6,'gallery','Archives','Modules'),(31,'Title','photos','photos','text',1,'photo','Title','General'),(32,'RelatedMedia','0,1','1','bit',3,'photo','Related Media','Modules'),(33,'TagCloud','0,1','1','bit',4,'photo','Tag Cloud','Modules'),(34,'Categories','0,1','1','bit',5,'photo','Categories','Modules'),(35,'Archives','0,1','1','bit',6,'photo','Archives','Modules'),(36,'Title','videos','Videos','text',1,'video','Title','General'),(37,'RelatedMedia','0,1','1','bit',3,'video','Related Media','Modules'),(38,'TagCloud','0,1','1','bit',4,'video','Tag Cloud','Modules'),(39,'Categories','0,1','1','bit',5,'video','Categories','Modules'),(40,'Archives','0,1','1','bit',6,'video','Archives','Modules'),(41,'Title','links','links','text',1,'link','Title','General'),(42,'RelatedMedia','0,1','1','bit',3,'link','Related Media','Modules'),(43,'TagCloud','0,1','1','bit',4,'link','Tag Cloud','Modules'),(44,'Categories','0,1','1','bit',5,'link','Categories','Modules'),(45,'Archives','0,1','1','bit',6,'link','Archives','Modules'),(46,'Title','mail','mail','text',1,'mail','Title','General'),(47,'RelatedMedia','0,1','1','bit',3,'mail','Related Media','Modules'),(48,'TagCloud','0,1','1','bit',4,'mail','Tag Cloud','Modules'),(49,'Categories','0,1','1','bit',5,'mail','Categories','Modules'),(50,'Archives','0,1','1','bit',6,'mail','Archives','Modules'),(51,'MediaDetails','0,1','1','bit',7,'article','Media Detail','Modules'),(52,'MediaDetails','0,1','1','bit',7,'blog','Media Detail','Modules'),(54,'MediaDetails','0,1','1','bit',7,'knowledgebase','Media Detail','Modules'),(55,'MediaDetails','0,1','1','bit',7,'music','Media Detail','Modules'),(56,'MediaDetails','0,1','1','bit',7,'gallery','Media Detail','Modules'),(57,'MediaDetails','0,1','1','bit',7,'photo','Media Detail','Modules'),(58,'MediaDetails','0,1','1','bit',7,'video','Media Detail','Modules'),(77,'SortOrder','publishdate,title','publishdate','select',8,'article','Sort By','Sorting'),(78,'SortDirection','asc,desc','desc','select',9,'article','Direction','Sorting'),(79,'SortOrder','publishdate,title','publishdate','select',8,'blog','Sort By','Sorting'),(80,'SortDirection','asc,desc','desc','select',9,'blog','Direction','Sorting'),(81,'SortOrder','startDate,publishdate,title','startDate','select',8,'event','Sort By','Sorting'),(82,'SortDirection','asc,desc','asc','select',9,'event','Direction','Sorting'),(83,'SortOrder','publishdate,title','publishdate','select',8,'knowledgebase','Sort By','Sorting'),(84,'SortDirection','asc,desc','desc','select',9,'knowledgebase','Direction','Sorting'),(85,'SortOrder','publishdate,title','publishdate','select',8,'music','Sort By','Sorting'),(86,'SortDirection','asc,desc','desc','select',9,'music','Direction','Sorting'),(87,'SortOrder','publishdate,title','publishdate','select',8,'gallery','Sort By','Sorting'),(88,'SortDirection','asc,desc','desc','select',9,'gallery','Direction','Sorting'),(89,'SortOrder','publishdate,title','publishdate','select',8,'photo','Sort By','Sorting'),(90,'SortDirection','asc,desc','desc','select',9,'photo','Direction','Sorting'),(91,'SortOrder','publishdate,title','publishdate','select',8,'video','Sort By','Sorting'),(92,'SortDirection','asc,desc','desc','select',9,'video','Direction','Sorting'),(93,'SortOrder','publishdate,title','publishdate','select',8,'link','Sort By','Sorting'),(94,'SortDirection','asc,desc','desc','select',9,'link','Direction','Sorting'),(95,'Article_Approval','Auto,Manual','Auto','select',2,'article','Approval','General'),(96,'Blog_Approval','Auto,Manual','Auto','select',2,'blog','Approval','General'),(97,'Music_Approval','Auto,Manual','Auto','select',2,'music','Approval','General'),(98,'Gallery_Approval','Auto,Manual','Auto','select',2,'gallery','Approval','General'),(99,'Video_Approval','Auto,Manual','Auto','select',2,'video','Approval','General'),(100,'Event_Approval','Auto,Manual','Auto','select',2,'event','Approval','General'),(101,'KnowledgeBase_Approval','Auto,Manual','Auto','select',2,'knowledgebase','Approval','General'),(102,'Links_Approval','Auto,Manual','Auto','select',2,'link','Approval','General'),(103,'Article_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'article','Thumbnail Size','General'),(104,'Blog_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'blog','Thumbnail Size','General'),(105,'Music_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'music','Thumbnail Size','General'),(106,'Gallery_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'gallery','Thumbnail Size','General'),(107,'Video_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'video','Thumbnail Size','General'),(108,'Article_Related_Thumbnail','45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','80','select',4,'article','Thumbnail Size','RelatedMedia'),(109,'Blog_Related_Thumbnail','45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','80','select',4,'blog','Thumbnail Size','RelatedMedia'),(110,'Music_Related_Thumbnail','45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','80','select',4,'music','Thumbnail Size','RelatedMedia'),(111,'Gallery_Related_Thumbnail','45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','80','select',4,'gallery','Thumbnail Size','RelatedMedia'),(112,'Video_Related_Thumbnail','45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','80','select',4,'video','Thumbnail Size','RelatedMedia'),(113,'RSVP','Yes,No','1','select',5,'event','Show RSVP','Modules'),(114,'Gallery_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','90','select',5,'photo','Thumbnail Size','General'),(115,'Gallery_related_Thumbnail','80','80','select',5,'photo','Thumbnail Size','RelatedMedia'),(116,'Event_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','90','select',3,'event','Thumbnail Size','General'),(117,'Embed','Yes,No','1','select',5,'video','Embed','Modules'),(118,'Embed','Yes,No','1','select',5,'gallery','Embed','Modules'),(119,'MediaDetails','0,1','1','bit',7,'event','Media Detail','Modules'),(120,'Title','Properties','Properties','text',1,'property','Title','General'),(121,'RelatedMedia','0,1','1','bit',5,'property','Related Media','Modules'),(122,'TagCloud','0,1','1','bit',6,'property','Tag Cloud','Modules'),(123,'Categories','0,1','1','bit',3,'property','Categories','Modules'),(124,'Archives','0,1','1','bit',4,'property','Archives','Modules'),(125,'MediaDetails','0,1','1','bit',7,'property','Media Detail','Modules'),(126,'SortOrder','PublishDate,Title','publishdate','select',8,'property','Sort By','Sorting'),(127,'SortDirection','asc,desc','desc','select',9,'property','Direction','Sorting'),(128,'Property_Approval','Auto,Manual','Auto','select',2,'property','Approval','General'),(129,'Property_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'property','Thumbnail Size','General'),(130,'Property_Related_Thumbnail','45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','80','select',4,'property','Thumbnail Size','RelatedMedia'),(131,'Title','Documents','Documents','text',1,'document','Title','General'),(132,'RelatedMedia','0,1','1','bit',1,'document','Related Media','Modules'),(133,'TagCloud','0,1','1','bit',2,'document','Tag Cloud','Modules'),(134,'Archives','0,1','1','bit',3,'document','Archives','Modules'),(135,'MediaDetails','0,1','1','bit',4,'document','Media Detail','Modules'),(136,'SortOrder','publishDate,title','publishdate','select',1,'document','Sort By','Sorting'),(137,'SortDirection','asc,desc','desc','select',2,'document','Sort Direction','Sorting'),(138,'Document_Approval','Auto,Manual','Auto','select',2,'document','Approval','General'),(149,'RatingType','Stars,Thumbs','Stars','select',2,'article','Rating Style','MediaDetails'),(150,'RatingType','Stars,Thumbs','Stars','select',2,'blog','Rating Style','MediaDetails'),(151,'RatingType','Stars,Thumbs','Stars','select',2,'knowledgebase','Rating Style','MediaDetails'),(152,'RatingType','Stars,Thumbs','Stars','select',2,'music','Rating Style','MediaDetails'),(153,'RatingType','Stars,Thumbs','Stars','select',2,'gallery','Rating Style','MediaDetails'),(154,'RatingType','Stars,Thumbs','Stars','select',2,'photo','Rating Style','MediaDetails'),(155,'RatingType','Stars,Thumbs','Stars','select',2,'video','Rating Style','MediaDetails'),(156,'RatingType','Stars,Thumbs','Stars','select',2,'link','Rating Style','MediaDetails'),(157,'RatingType','Stars,Thumbs','Stars','select',2,'property','Rating Style','MediaDetails'),(158,'RatingType','Stars,Thumbs','Stars','select',2,'document','Rating Style','MediaDetails'),(159,'RatingType','Stars,Thumbs','Stars','select',2,'event','Rating Style','MediaDetails'),(160,'Groups_Approval','Auto,Manual','Auto','select',1,'group','Approval','General'),(161,'Title','Groups','Groups','text',1,'group','Title','General'),(162,'Categories','0,1','1','bit',1,'group','Categories','Modules'),(163,'TagCloud','0,1','1','bit',2,'group','Tag Cloud','Modules'),(164,'MediaDetails','0,1','1','bit',3,'group','Media Details','Modules'),(165,'Related','0,1','1','bit',4,'group','Related Media','Modules'),(166,'Share','0,1','1','bit',5,'group','Share','Modules'),(167,'SortOrder','PublishDate,Title','publishdate','select',1,'group','Sort By','Sorting'),(168,'SortDirection','asc,desc','desc','select',2,'group','Direction','Sorting'),(169,'Group_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',4,'group','Thumbnail Size','General'),(170,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','5','select',4,'article','Display','General'),(171,'','','','',0,'','',''),(172,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','5','select',4,'blog','Display','General'),(173,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','5','select',4,'event','Display','General'),(174,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','10','select',4,'knowledgebase','Display','General'),(175,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','10','select',4,'music','Display','General'),(176,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','20','select',4,'gallery','Display','General'),(177,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','20','select',4,'photo','Display','General'),(178,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','20','select',4,'video','Display','General'),(179,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','10','select',4,'link','Display','General'),(180,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','10','select',4,'property','Display','General'),(181,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','5','select',4,'document','Display','General'),(183,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','5','select',4,'group','Display','General'),(184,'Group_Related_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',4,'group','Member Thumbnail Size','General'),(185,'Title','Locations','Locations','text',1,'location','Title','General'),(186,'RelatedMedia','0,1','1','bit',5,'location','Related Media','Modules'),(187,'Categories','0,1','1','bit',3,'location','Categories','Modules'),(188,'MediaDetails','0,1','1','bit',7,'location','Media Detail','Modules'),(189,'SortOrder','PublishDate,Title','publishdate','select',8,'location','Sort By','Sorting'),(190,'SortDirection','asc,desc','desc','select',9,'location','Direction','Sorting'),(191,'Location_Approval','Auto,Manual','Auto','select',2,'location','Approval','General'),(192,'Location_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'location','Thumbnail Size','General'),(193,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','5','select',4,'location','Display','General'),(194,'Title','International Ministries','International Ministries','text',1,'international','Title','General'),(195,'RelatedMedia','0,1','1','bit',5,'international','Related Media','Modules'),(196,'TagCloud','0,1','1','bit',6,'international','Tag Cloud','Modules'),(197,'Categories','0,1','1','bit',3,'international','Categories','Modules'),(198,'Archives','0,1','1','bit',4,'international','Archives','Modules'),(199,'MediaDetails','0,1','1','bit',7,'international','Media Detail','Modules'),(200,'SortOrder','publishdate,Title','publishdate','select',8,'international','Sort By','Sorting'),(201,'SortDirection','asc,desc','desc','select',9,'international','Direction','Sorting'),(202,'international_Approval','Auto,Manual','Auto','select',2,'international','Approval','General'),(203,'international_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'international','Thumbnail Size','General'),(204,'international_Related_Thumbnail','45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','80','select',4,'international','Thumbnail Size','RelatedMedia'),(205,'RatingType','Stars,Thumbs','Stars','select',2,'international','Rating Style','MediaDetails'),(206,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','5','select',4,'international','Display','General'),(207,'Title','US Ministries','US Ministries','text',1,'domestic','Title','General'),(208,'RelatedMedia','0,1','1','bit',5,'domestic','Related Media','Modules'),(209,'TagCloud','0,1','1','bit',6,'domestic','Tag Cloud','Modules'),(210,'Categories','0,1','1','bit',3,'domestic','Categories','Modules'),(211,'Archives','0,1','1','bit',4,'domestic','Archives','Modules'),(212,'MediaDetails','0,1','1','bit',7,'domestic','Media Detail','Modules'),(213,'SortOrder','PublishDate,Title','publishdate','select',8,'domestic','Sort By','Sorting'),(214,'SortDirection','asc,desc','desc','select',9,'domestic','Direction','Sorting'),(215,'domestic_Approval','Auto,Manual','Auto','select',2,'domestic','Approval','General'),(216,'domestic_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'domestic','Thumbnail Size','General'),(217,'domestic_Related_Thumbnail','45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','80','select',4,'domestic','Thumbnail Size','RelatedMedia'),(218,'RatingType','Stars,Thumbs','Stars','select',2,'domestic','Rating Style','MediaDetails'),(219,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','5','select',4,'domestic','Display','General'),(220,'displaySorting','Yes,No','1','bit',5,'article','Display Sorting','General'),(221,'displaySorting','Yes,No','1','bit',5,'blog','Display Sorting','General'),(222,'displaySorting','Yes,No','1','bit',5,'event','Display Sorting','General'),(223,'displaySorting','Yes,No','1','bit',5,'knowledgebase','Display Sorting','General'),(224,'displaySorting','Yes,No','1','bit',5,'music','Display Sorting','General'),(225,'displaySorting','Yes,No','1','bit',5,'gallery','Display Sorting','General'),(226,'displaySorting','Yes,No','1','bit',5,'photo','Display Sorting','General'),(227,'displaySorting','Yes,No','1','bit',5,'video','Display Sorting','General'),(228,'displaySorting','Yes,No','1','bit',5,'link','Display Sorting','General'),(229,'displaySorting','Yes,No','1','bit',5,'property','Display Sorting','General'),(230,'displaySorting','Yes,No','1','bit',5,'document','Display Sorting','General'),(231,'displaySorting','Yes,No','1','bit',5,'group','Display Sorting','General'),(232,'displaySorting','Yes,No','1','bit',5,'location','Display Sorting','General'),(233,'displaySorting','Yes,No','1','bit',5,'international','Display Sorting','General'),(234,'displaySorting','Yes,No','1','bit',5,'domestic','Display Sorting','General'),(235,'LocationSearch','0,1','1','bit',7,'event','Search','Modules'),(236,'LocationSearch','0,1','1','bit',7,'property','Search','Modules'),(237,'LocationSearch','0,1','1','bit',7,'location','Search','Modules'),(238,'LocationSearch','0,1','1','bit',7,'domestic','Search','Modules'),(239,'thumbNail_Align','left,right','left','select',8,'article','Thumbnail Align','General'),(240,'thumbNail_Align','left,right','left','select',8,'blog','Thumbnail Align','General'),(241,'thumbNail_Align','left,right','left','select',8,'event','Thumbnail Align','General'),(242,'thumbNail_align','left,right','left','select',8,'knowledgebase','Thumbnail Align','General'),(243,'thumbNail_align','left,right','left','select',8,'music','Thumbnail Align','General'),(244,'thumbNail_align','left,right','left','select',8,'property','Thumbnail Align','General'),(245,'thumbNail_align','left,right','left','select',8,'document','Thumbnail Align','General'),(246,'thumbNail_align','left,right','left','select',8,'group','Thumbnail Align','General'),(247,'thumbNail_align','left,right','left','select',8,'location','Thumbnail Align','General'),(248,'Title','','Members','text',1,'memberlist','Title','General'),(249,'Title','djchart','DJ Charts','text',1,'djchart','Title','General'),(250,'Categories','0,1','1','bit',5,'djchart','Categories','Modules'),(251,'Archives','0,1','1','bit',6,'djchart','Archives','Modules'),(252,'MediaDetails','0,1','1','bit',7,'djchart','Media Detail','Modules'),(253,'SortOrder','publishdate,title','publishdate','select',8,'djchart','Sort By','Sorting'),(254,'SortDirection','asc,desc','desc','select',9,'djchart','Direction','Sorting'),(255,'djchart_Approval','Auto,Manual','Auto','select',2,'djchart','Approval','General'),(256,'djchart_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'djchart','Thumbnail Size','General'),(257,'djchart_Related_Thumbnail','45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','80','select',4,'djchart','Thumbnail Size','RelatedMedia'),(258,'RatingType','Stars,Thumbs','Stars','select',2,'djchart','Rating Style','MediaDetails'),(259,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','10','select',4,'djchart','Display','General'),(260,'displaySorting','Yes,No','1','bit',5,'djchart','Display Sorting','General'),(261,'thumbNail_align','left,right','left','select',8,'djchart','Thumbnail Align','General'),(262,'Title','Restaurants','Restaurants','text',1,'restaurant','Title','General'),(263,'RelatedMedia','0,1','1','bit',5,'restaurant','Related Media','Modules'),(264,'Categories','0,1','1','bit',3,'restaurant','Categories','Modules'),(265,'MediaDetails','0,1','1','bit',7,'restaurant','Media Detail','Modules'),(266,'SortOrder','PublishDate,Title','publishdate','select',8,'restaurant','Sort By','Sorting'),(267,'SortDirection','asc,desc','desc','select',9,'restaurant','Direction','Sorting'),(268,'Restaurant_Approval','Auto,Manual','Auto','select',2,'restaurant','Approval','General'),(269,'Restaurant_Thumbnail','None,45,50,55,60,65,70,75,80,85,90,100,120,125,150,175','100','select',3,'restaurant','Thumbnail Size','General'),(270,'DisplayRows',' 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,\n44,45,46,47,48,49,50','5','select',4,'restaurant','Display','General'),(271,'displaySorting','Yes,No','1','bit',5,'restaurant','Display Sorting','General'),(272,'LocationSearch','0,1','1','bit',7,'restaurant','Search','Modules'),(273,'thumbNail_align','left,right','left','select',8,'restaurant','Thumbnail Align','General'),(274,'Map','0,1','1','bit',9,'restaurant','Map','Modules');
/*!40000 ALTER TABLE `pageSettingList` ENABLE KEYS */;

/*!40000 ALTER TABLE `startPageList` DISABLE KEYS */;
INSERT INTO `startPageList` VALUES (1,'lastPage','Last Visited Page'),(2,'/index.cfm','Homepage'),(3,'/index.cfm?fuseaction=members.profile','Profile');
/*!40000 ALTER TABLE `startPageList` ENABLE KEYS */;

/*!40000 ALTER TABLE `styleElementList` DISABLE KEYS */;
INSERT INTO `styleElementList` VALUES (11,1,'.body','Background','',''),(12,2,'#hd','Background','',''),(13,2,'#hd','Border','\0',''),(14,2,'#siteName','Site Name','',''),(15,2,'#siteTagLine','Site Tagline','',''),(16,4,'#bd','Background','',''),(17,4,'#bd','Border','\0',''),(18,5,'.listLeft div.mod div.hd','Header','',''),(19,5,'.listLeft div.mod div.bd','Body','',''),(20,5,'.listLeft div.mod div.bd a','Links','',''),(21,5,'.listLeft div.mod div.ft','Footer','',''),(22,6,'.listRight div.mod div.hd','Header','',''),(23,6,'.listRight div.mod div.bd','Body','',''),(24,6,'.listRight div.mod div.bd a','Links','',''),(25,6,'.listRight div.mod div.ft','Footer','',''),(26,7,'#ft','Background','',''),(27,7,'#ft','Size','',''),(28,7,'#ft','Text','',''),(29,7,'#ft a','Links','',''),(30,7,'#ft','Border','\0',''),(31,2,'#hd','Size','',''),(32,3,'#menuBar','Background','',''),(34,3,'#menuBar ul li a','Menu Tab - Normal','',''),(35,3,'#menuBar ul li a:hover','Menu Tab - Hover','',''),(40,5,'.listLeft .odd','Odd Row ','\0',''),(41,5,'.listLeft .even','Even Row','\0',''),(42,6,'.listRight .odd','Odd Row','\0',''),(43,6,'.listRight .even','Even Row','\0',''),(48,4,'#bd','Size','',''),(49,5,'.listLeft .mod','Module','\0',''),(50,6,'.listRight .mod','Module','\0',''),(51,8,'.yui-skin-sam .yui-navset .yui-nav a em','Normal Tab','\0',''),(52,8,'.yui-skin-sam .yui-navset .yui-nav .selected a em','Selected Tab','\0',''),(53,8,'.yui-skin-sam .yui-navset .yui-content','Tab Content','\0',''),(54,5,'.listLeft div.mod div.hd a','Header Links','',''),(55,6,'.listRight div.mod div.hd a','Header Links','',''),(56,9,'.listSingle div.mod div.hd','Header','\0',''),(57,9,'.listSingle div.mod div.bd','Body','\0',''),(58,9,'.listSingle div.mod div.bd a','Links','\0',''),(59,9,'.listSingle div.mod div.ft','Footer','\0',''),(60,9,'.listSingle .odd','Odd Row','\0',''),(61,9,'.listSingle .even','Even Row','\0',''),(62,9,'.listSingle .mod','Module','\0',''),(63,9,'.listSingle div.mod div.hd a','Header Links','\0',''),(64,3,'#menuBar ul li a','Border','\0',''),(65,3,'#menuBar','Size','\0',''),(66,1,'.bodyContent','Border','\0',''),(67,2,'#clock','Clock','\0',''),(68,11,'.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd','Header','',''),(69,11,'.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd','Body','',''),(70,11,'.listLeft div.mod div.ft, .lisRight div.mod div.ft, .listSingle div.mod div.ft','Footer','',''),(71,11,'.listLeft div.mod div.hd a, .listRightt div.mod div.hd a, .listSingle div.mod div.hd a','Header Links','',''),(72,11,'.listLeft div.mod div.bd a, .listRight div.mod div.bd a, .listSingle div.mod div.bd a','Body Links','',''),(73,11,'.listLeft div.mod, .listRight div.mod, .listSingle div.mod','Module','',''),(74,2,'#siteLogo','Site Logo','',''),(75,12,'#pagination','General','\0','');
/*!40000 ALTER TABLE `styleElementList` ENABLE KEYS */;

/*!40000 ALTER TABLE `styleItemList` DISABLE KEYS */;
INSERT INTO `styleItemList` VALUES (1,'Body','',''),(2,'Page Header','',''),(3,'Menu','',''),(4,'Page Body','\0',''),(5,'Left Modules','\0',''),(6,'Right Modules','\0',''),(7,'Footer','',''),(9,'100% Width Modules','\0',''),(11,'All Modules','',''),(12,'Pagination','\0','');
/*!40000 ALTER TABLE `styleItemList` ENABLE KEYS */;

/*!40000 ALTER TABLE `stylePropertyList` DISABLE KEYS */;
INSERT INTO `stylePropertyList` VALUES (11,'backgroundColor','Color',11,'body','',''),(12,'backgroundImage','Image',11,'body','',''),(13,'backgroundColor','Color',12,'#hd','',''),(14,'backgroundImage','Image',12,'#hd','',''),(15,'borderWidth','Width',13,'#hd','\0',''),(16,'borderColor','Color',13,'#hd','\0',''),(17,'color','Color',14,'#siteName','',''),(18,'font','Font',14,'#siteName','',''),(21,'padding','Padding',14,'#siteName','\0',''),(25,'color','Color',15,'#siteTagLine','',''),(26,'font','Font',15,'#siteTagLine','',''),(29,'padding','Padding',15,'#siteTagLine','\0',''),(33,'backgroundColor','Color',16,'#bd','',''),(34,'backgroundImage','Image',16,'#bd','',''),(35,'borderColor','Color',17,'#bd','\0',''),(36,'borderWidth','Width',17,'#bd','\0',''),(37,'backgroundColor','Background Color',18,'.listLeft div.mod div.hd','',''),(38,'backgroundImage','Background Image',18,'.listLeft div.mod div.hd','',''),(39,'color','Text Color',18,'.listLeft div.mod div.hd','',''),(40,'height','Height',18,'.listLeft div.mod div.hd','',''),(41,'padding','Padding',18,'.listLeft div.mod div.hd','\0',''),(45,'borderColor','Border Color',18,'.listLeft div.mod div.hd','\0',''),(46,'borderWidth','Border Size',18,'.listLeft div.mod div.hd','\0',''),(47,'backgroundColor','Background Color',19,'.listLeft div.mod div.bd','\0',''),(48,'backgroundImage','Background Image',19,'.listLeft div.mod div.bd','\0',''),(49,'color','Text Color',19,'.listLeft div.mod div.bd','\0',''),(50,'padding','Padding',19,'.listLeft div.mod div.bd','\0',''),(54,'borderColor','Border Color',19,'.listLeft div.mod div.bd','\0',''),(55,'borderWidth','Border Width',19,'.listLeft div.mod div.bd','\0',''),(56,'font','Font',20,'.listLeft div.mod div.bd a','',''),(59,'color','Color',20,'.listLeft div.mod div.bd a','',''),(60,'backgroundColor','Background Color',21,'.listLeft div.mod div.ft','',''),(61,'backgroundImage','Background Image',21,'.listLeft div.mod div.ft','',''),(62,'height','Height',21,'.listLeft div.mod div.ft','',''),(63,'borderColor','Border Color',21,'.listLeft div.mod div.ft','\0',''),(64,'borderWidth','Border Width',21,'.listLeft div.mod div.ft','\0',''),(65,'backgroundColor','Background Color',22,'.listRight div.mod div.hd','',''),(66,'backgroundImage','Background Image',22,'.listRight div.mod div.hd','',''),(67,'color','Text Color',22,'.listRight div.mod div.hd','',''),(68,'height','Height',22,'.listRight div.mod div.hd','',''),(69,'padding','Padding',22,'.listRight div.mod div.hd','\0',''),(73,'borderColor','Border Color',22,'.listRight div.mod div.hd','\0',''),(74,'borderWidth','Border Width',22,'.listRight div.mod div.hd','\0',''),(75,'backgroundColor','Background Color',23,'.listRight div.mod div.bd','\0',''),(76,'backgroundImage','Background Image',23,'.listRight div.mod div.bd','\0',''),(77,'color','Text Color',23,'.listRight div.mod div.bd','\0',''),(78,'padding','Padding',23,'.listRight div.mod div.bd','\0',''),(82,'borderColor','Border Color',23,'.listRight div.mod div.bd','\0',''),(83,'borderWidth','Border Width',23,'.listRight div.mod div.bd','\0',''),(84,'font','Font',24,'.listRight div.mod div.bd a','\0',''),(87,'color','Color',24,'.listRight div.mod div.bd a','\0',''),(88,'backgroundColor','Background Color',25,'.listRight div.mod div.ft','\0',''),(89,'backgroundImage','Background Image',25,'.listRight div.mod div.ft','\0',''),(90,'height','Height',25,'.listRight div.mod div.ft','\0',''),(91,'borderColor','Border Color',25,'.listRight div.mod div.ft','\0',''),(92,'borderWidth','Border Width',25,'.listRight div.mod div.ft','\0',''),(93,'backgroundColor','Color',26,'#ft','\0',''),(94,'backgroundImage','Image',26,'#ft','\0',''),(95,'height','Height',27,'#ft','\0',''),(96,'padding','Padding',27,'#ft_left,#ft_right','\0',''),(100,'font','Font',28,'#ft','\0',''),(103,'color','Color',28,'#ft','\0',''),(104,'font','Font',29,'#ft a','\0',''),(107,'color','Color',29,'#ft a','\0',''),(108,'borderColor','Color',30,'#ft','\0',''),(109,'borderWidth','Width',30,'#ft','\0',''),(110,'height','Height',31,'#hd','\0',''),(111,'padding','Padding',31,'#hd','\0',''),(112,'backgroundColor','Color',32,'#menuBar','\0',''),(113,'backgroundImage','Image',32,'#menuBar','\0',''),(114,'backgroundColor','Background Color',34,'#menuBar ul li a','\0',''),(115,'backgroundImage','Background Image',34,'#menuBar ul li a','\0',''),(116,'backgroundColor','Background Color',35,'#menuBar ul li a:hover','\0',''),(117,'backgroundImage','Background Image',35,'#menuBar ul li a:hover','\0',''),(120,'color','Text',34,'#menuBar ul li a','\0',''),(123,'color','Text',35,'#menuBar ul li a:hover','\0',''),(124,'font','Font',18,'.listLeft div.mod div.hd','\0',''),(125,'font','Font',19,'.listLeft div.mod div.bd','\0',''),(128,'font','Font',22,'.listRight div.mod div.hd','\0',''),(129,'font','Font',23,'.listRight div.mod div.bd','\0',''),(131,'font','Font',34,'#menuBar ul li a','\0',''),(137,'backgroundImage','Image',74,'#siteLogo','\0',''),(139,'color','Text Color',40,'.listLeft div.mod .odd','\0',''),(140,'backgroundColor','Background Color',40,'.listLeft div.mod .odd','\0',''),(141,'color','Text Color',41,'.listLeft div.mod .even','\0',''),(142,'backgroundColor','Background Color',41,'.listLeft div.mod .even','\0',''),(143,'color','Text Color',42,'.listRight div.mod .odd','\0',''),(144,'backgroundColor','Background Color',42,'.listRight div.mod .odd','\0',''),(145,'color','Text Color',43,'.listRight div.mod .even','\0',''),(146,'backgroundColor','Background Color',43,'.listRight div.mod .even','\0',''),(147,'color','Link Color',40,'.listLeft div.mod .odd a','\0',''),(148,'color','Link Color',43,'.listLeft div.mod .even a','\0',''),(149,'color','Link Color',42,'.listRight div.mod .odd a','\0',''),(150,'color','Link Color',43,'.listRight div.mod .even a','\0',''),(152,'padding','Padding',48,'#bd','\0',''),(153,'borderColor','Border Color',49,'.listLeft .mod','\0',''),(154,'borderWidth','Border Width',49,'.listLeft .mod','\0',''),(155,'borderColor','Border Color',50,'.listRight .mod','\0',''),(156,'borderWidth','Border Width',50,'.listRight .mod','\0',''),(157,'padding','Padding',49,'.listLeft .mod','\0',''),(158,'padding','Padding',50,'.listRight .mod','\0',''),(180,'color','Color',54,'.listLeft div.mod div.hd a','\0',''),(181,'color','Color',55,'.listRight div.mod div.hd','\0',''),(182,'font','Font',54,'.listLeft div.mod div.hd a','\0',''),(183,'font','Font',55,'.listRight div.mod div.hd','\0',''),(184,'padding','Padding',54,'.listLeft div.mod div.hd a','\0',''),(185,'padding','Padding',55,'.listRight div.mod div.hd','\0',''),(187,'color','Hover - Color',20,'.listLeft div.mod div.bd a:hover','\0',''),(189,'color','Hover - Color',24,'.listRight div.mod div.bd a:hover','\0',''),(191,'color','Hover - Color',29,'#ft a:hover','\0',''),(192,'color','Hover - Color',40,'.listLeft div.mod .odd a:hover','\0',''),(193,'color','Hover - Color',43,'.listLeft div.mod .even a:hover','\0',''),(194,'color','Hover - Color',54,'.listLeft div.mod div.hd a:hover','\0',''),(196,'backgroundColor','Background Color',56,'.listSingle div.mod div.hd','\0',''),(197,'backgroundImage','Background Image',56,'.listSingle div.mod div.hd','\0',''),(198,'color','Text Color',56,'.listSingle div.mod div.hd','\0',''),(199,'height','Height',56,'.listSingle div.mod div.hd','\0',''),(200,'padding','Padding',56,'.listSingle div.mod div.hd','\0',''),(201,'borderColor','Border Color',56,'.listSingle div.mod div.hd','\0',''),(202,'borderWidth','Border Width',56,'.listSingle div.mod div.hd','\0',''),(203,'backgroundColor','Background Color',57,'.listSingle div.mod div.bd','\0',''),(204,'backgroundImage','Background Image',57,'.listSingle div.mod div.bd','\0',''),(205,'color','Text Color',57,'.listSingle div.mod div.bd','\0',''),(206,'padding','Padding',57,'.listSingle div.mod div.bd','\0',''),(207,'borderColor','Border Color',57,'.listSingle div.mod div.bd','\0',''),(208,'borderWidth','Border Width',57,'.listSingle div.mod div.bd','\0',''),(209,'font','Font',58,'.listSingle div.mod div.bd a','\0',''),(210,'color','Color',58,'.listSingle div.mod div.bd a','\0',''),(211,'backgroundColor','Background Color',59,'.listSingle div.mod div.ft','\0',''),(212,'backgroundImage','Background Image',59,'.listSingle div.mod div.ft','\0',''),(213,'height','Height',59,'.listSingle div.mod div.ft','\0',''),(214,'borderColor','Border Color',59,'.listSingle div.mod div.ft','\0',''),(215,'borderWidth','Border Width',59,'.listSingle div.mod div.ft','\0',''),(216,'font','Font',56,'.listSingle div.mod div.hd','\0',''),(217,'font','Font',57,'.listSingle div.mod div.bd','\0',''),(218,'color','Text Color',60,'.listSingle div.mod .odd','\0',''),(219,'backgroundColor','Background Color',60,'.listSingle div.mod .odd','\0',''),(220,'color','Text Color',61,'.listSingle div.mod .even','\0',''),(221,'backgroundColor','Background Color',61,'.listSingle div.mod .even','\0',''),(222,'color','Link Color',61,'.listLeft div.mod .even a','\0',''),(223,'color','Link Color',60,'.listSingle div.mod .odd a','\0',''),(224,'color','Link Color',61,'.listSingle div.mod .even a','\0',''),(225,'borderColor','Border Color',62,'.listSingle .mod','\0',''),(226,'borderWidth','Border Width',62,'.listSingle .mod','\0',''),(227,'padding','Padding',62,'.listSingle .mod','\0',''),(228,'color','Color',63,'.listSingle div.mod div.hd a','\0',''),(229,'font','Font',63,'.listSingle div.mod div.hd a','\0',''),(230,'padding','Padding',63,'.listSingle div.mod div.hd a','\0',''),(231,'color','Hover - Color',58,'.listSingle div.mod div.bd a:hover','\0',''),(232,'color','Hover - Color',61,'.listLeft div.mod .even a:hover','\0',''),(233,'borderColor','Border color',64,'#menuBar ul li a','\0',''),(234,'borderWidth','Border Width',64,'#menuBar ul li a','\0',''),(235,'padding','Padding',34,'#menuBar ul li a','\0',''),(236,'padding','Padding',65,'#menuBar ul','\0',''),(237,'borderColor','Color',66,'.bodyContent','\0',''),(238,'borderWidth','Width',66,'.bodyContent','\0',''),(239,'color','Text Color',67,'#clock','\0',''),(240,'backgroundColor','Background',67,'#clock','\0',''),(241,'padding','Padding',67,'#clock','\0',''),(242,'backgroundColor','Background Color',68,'.listLeft div.mod div.hd,.listRight div.mod div.hd,.listSingle div.mod div.hd','\0',''),(243,'font','Font',68,'.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd','\0',''),(246,'padding','Padding',68,'.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd','\0',''),(247,'height','Height',68,'.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd','\0',''),(248,'color','Text Color',68,'.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd','\0',''),(249,'backgroundImage','Background Image',68,'.listLeft div.mod div.hd, .listRight div.mod div.hd, .listSingle div.mod div.hd','\0',''),(250,'font','Font',69,'.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd','\0',''),(253,'padding','Padding',69,'.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd','\0',''),(254,'color','Text Color',69,'.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd','\0',''),(255,'backgroundColor','Background Color',69,'.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd','\0',''),(256,'backgroundImage','Background Image',69,'.listLeft div.mod div.bd, .listRight div.mod div.bd, .listSingle div.mod div.bd','\0',''),(257,'font','Font',72,'.listLeft div.mod div.bd a, .listRight div.mod div.bd a, .listSingle div.mod div.bd a','\0',''),(258,'color','Color',72,'.listLeft div.mod div.bd a, .listRight div.mod div.bd a, .listSingle div.mod div.bd a','\0',''),(261,'height','Height',70,'.listLeft div.mod div.ft, .listRight div.mod div.ft, .listSingle div.mod div.ft','\0',''),(262,'backgroundImage','Background Image',70,'.listLeft div.mod div.ft, .listRight div.mod div.ft, .listSingle div.mod div.ft','\0',''),(263,'backgroundColor','Background Color',70,'.listLeft div.mod div.ft, .listRight div.mod div.ft, .listSingle div.mod div.ft','\0',''),(264,'color','Color',71,'.listLeft div.mod div.hd a, .listRight div.mod div.hd a, .listSingle div.mod div.hd a','\0',''),(265,'font','Font',71,'.listLeft div.mod div.hd a, .listRight div.mod div.hd a, .listSingle div.mod div.hd a','\0',''),(266,'padding','Padding',71,'.listLeft div.mod div.hd a, .listRight div.mod div.hd a, .listSingle div.mod div.hd a','\0',''),(267,'color','Hover Color',72,'.listLeft div.mod div.bd a:hover, .listRight div.mod div.bd a:hover, .listSingle div.mod div.bd a:hover','\0',''),(268,'borderColor','Border Color',73,'.listLeft div.mod, .listRight div.mod, .listSingle div.mod','\0',''),(269,'borderWidth','Border Width',73,'.listLeft div.mod, .listRight div.mod, .listSingle div.mod','\0',''),(271,'height','Height',74,'#siteLogo','\0',''),(272,'color','Text Color',75,'ul#pagination li, ul#pagination li a, ul#pagination li a:link, ul#pagination li a:visited, ul#pagination li a:active','\0',''),(273,'backgroundColor','Background Color',75,'ul#pagination li, ul#pagination li a, ul#pagination li a:link, ul#pagination li a:visited, ul#pagination li a:active','\0',''),(275,'font','Font',75,'ul#pagination li, ul#pagination li a, ul#pagination li a:link, ul#pagination li a:visited, ul#pagination li a:active','\0',''),(276,'borderColor','Border Color',75,'ul#pagination li, ul#pagination li a, ul#pagination li a:link, ul#pagination li a:visited, ul#pagination li a:active','\0',''),(277,'borderWidth','Border Width',75,'ul#pagination li, ul#pagination li a, ul#pagination li a:link, ul#pagination li a:visited, ul#pagination li a:active','\0',''),(278,'color','Active Text Color',75,'ul#pagination li.active, ul#pagination li.active a,ul#pagination li.active a:active,ul#pagination li.active a:link,ul#pagination li.active a:visited','\0',''),(279,'backgroundColor','Active Background color',75,'ul#pagination li.active, ul#pagination li.active a,ul#pagination li.active a:active,ul#pagination li.active a:link,ul#pagination li.active a:visited','\0',''),(280,'color','Content Title',57,'.listSingle div.mod div.bd h1, .listSingle div.mod div.bd h2, .listSingle div.mod div.bd h3 a','\0',''),(281,'color','Content Title',69,'.listLeft div.mod div.bd h1, .listRight div.mod div.bd h1, .listSingle div.mod div.bd h1, .listLeft div.mod div.bd h2, .listRight div.mod div.bd h2, .listSingle div.mod div.bd h2, .listLeft div.mod div.bd h3 a, .listRight div.mod div.bd h3 a, .listSingle div..mod div.bd h3 a','\0',''),(282,'color','Content Title',23,'.listRight div.mod div.bd H1, .listRight div.mod div.bd h2, .listRight div.mod div.bd h3 a','\0',''),(283,'color','Content Title',19,'.listLeft div.mod div.bd h1, .listLeft div.mod div.bd h2, .listLeft div.mod div.bd h3 a','\0',''),(284,'font','Content Title Font',57,'.listSingle div.mod div.bd h1, .listSingle div.mod div.bd h2, .listSingle div.mod div.bd h3 a','\0',''),(285,'font','Content Title Font',69,'.listLeft div.mod div.bd h1, .listRight div.mod div.bd h1, .listSingle div.mod div.bd h1, .listLeft div.mod div.bd h2, .listRight div.mod div.bd h2, .listSingle div.mod div.bd h2, .listLeft div.mod div.bd h3 a, .listRight div.mod div.bd h3 a, .listSingle div..mod div.bd h3 a','\0',''),(286,'font','Content Title Font',23,'.listRight div.mod div.bd H1, .listRight div.mod div.bd h2, .listRight div.mod div.bd h3 a','\0',''),(287,'font','Content Title Font',19,'.listLeft div.mod div.bd h1, .listLeft div.mod div.bd h2, .listLeft div.mod div.bd h3 a','\0','');
/*!40000 ALTER TABLE `stylePropertyList` ENABLE KEYS */;

/*!40000 ALTER TABLE `templateData` DISABLE KEYS */;
INSERT INTO `templateData` VALUES (11,'body','background-color','#ffffff',611),(11,'#menuBar','background-color','#0e4e0f',612),(11,'body','background-color','#ffffff',613),(11,'.listLeft div.mod div.hd','color','#717171',614),(11,'.listLeft div.mod div.hd','background-color','#9fa8dd',615),(11,'#hd','background-color','#339966',616),(11,'#siteName','color','#CAFFCA',617),(11,'#siteName','padding','24px 0px 0px 25px ',618),(11,'#bd','background-color','#ffffff',619),(11,'.listLeft div.mod div.hd','color','#084f00',620),(11,'.listLeft div.mod div.hd','background-color','#339966',621),(11,'.listLeft div.mod div.bd','background-color','#ffffff',622),(11,'#hd','background-color','#339966',623),(11,'#siteTagLine','color','#caffca',624),(11,'#siteTagLine','padding','6px 0px 0px 126px ',625),(11,'#siteName','color','#caffca',626),(11,'#hd','height','128px',627),(11,'#hd','background-image','url(http://assets.socialcloudz.com/content/community/3/a11.jpg)',628),(11,'#menuBar','background-image','url(http://assets.socialcloudz.com/content/community/3/a2.gif)',629),(11,'#menuBar ul','padding','14px 0px 32px 40px ',630),(11,'#menuBar ul li a','color','#caffca',631),(11,'#menuBar ul li a:hover','color','#ffffff',632),(11,'#menuBar ul li a:hover','background-color','#000000',633),(11,'#menuBar','background-color','#0e4e0f',634),(11,'#bd','padding','26px 0px 0px 0px ',635),(11,'#ft','color','#009900',636),(11,'#ft','background-image','url(http://assets.socialcloudz.com/content/community/3/a3.jpg)',637),(11,'#ft','padding','56px 22px 34px 22px ',638),(11,'#ft a','color','#009900',639),(11,'.listRight div.mod div.bd a','color','#009900',640),(11,'.listRight div.mod div.bd','color','#085f00',641),(11,'.listSingle div.mod div.bd a','color','#009900',642),(11,'.listLeft div.mod div.bd a','color','#009900',643),(11,'.listRight .mod','border-width','0px',644),(11,'.listSingle .mod','border-width','0px',645),(11,'.listSingle div.mod div.hd','color','#004400',646),(11,'.listSingle div.mod div.hd','background-color','#339966',647),(11,'.listSingle div.mod div.bd','color','#085f00',648),(11,'.listLeft .mod','border-width','0px',649),(11,'.listLeft div.mod div.bd','color','#085f00',650),(11,'.listRight div.mod div.hd','color','#004400',651),(11,'.listRight div.mod div.hd','background-color','#339966',652),(11,'.listRight div.mod div.hd','font-family','Helvetica',653),(11,'.listRight div.mod div.hd','font-weight','bold',654),(11,'.listRight div.mod div.hd','padding','3px 3px 10px 14px ',655),(11,'.listRight div.mod div.hd','font-size','18px',656),(11,'.listSingle div.mod div.hd','font-family','Helvetica',657),(11,'.listSingle div.mod div.hd','font-weight','bold',658),(11,'.listSingle div.mod div.hd','padding','3px 3px 10px 14px ',659),(11,'.listSingle div.mod div.hd','font-size','18px',660),(11,'.listLeft div.mod div.hd','font-family','Helvetica',661),(11,'.listLeft div.mod div.hd','font-weight','bold',662),(11,'.listLeft div.mod div.hd','padding','3px 3px 10px 14px ',663),(11,'.listLeft div.mod div.hd','font-size','18px',664),(11,'#menuBar ul li a','font-weight','bold',665),(11,'#menuBar ul li a','border-width','0px',666),(5,'body','background-color','#000000',667),(5,'#hd','background-color','#9d0e17',668),(5,'#siteName','color','#ffffff',669),(5,'#siteTagLine','color','#defc4a',670),(5,'#bd','background-color','#ff6be6',671),(5,'.listLeft div.mod div.hd','color','#ffffff',672),(5,'.listLeft div.mod div.hd','background-color','#ff47d5',673),(5,'.listRight div.mod div.bd','color','#808080',674),(5,'.listRight div.mod div.bd','background-color','#1a1a1a',675),(5,'.listRight div.mod div.hd','background-color','#ff47d5',676),(5,'#menuBar ul li a','color','#5B6371',677),(5,'#menuBar ul li a','background-color','transparent',678),(5,'#menuBar','background-color','#fa00d6',679),(5,'#menuBar ul li a','padding','16px 12px 18px 12px ',680),(5,'#menuBar ul li a','font-size','20px',681),(5,'#ft','height','24px',682),(5,'#ft','background-color','#1a1a1a',683),(5,'#ft','padding','20px 10px 22px 10px ',684),(5,'.listRight div.mod div.hd','color','#000000',685),(5,'.listSingle div.mod div.hd','color','#ffffff',686),(5,'.listSingle div.mod div.hd','background-color','#ff47d5',687),(5,'.listSingle div.mod div.bd','color','#808080',688),(5,'.listSingle div.mod div.bd','background-color','#000000',689),(5,'.listSingle div.mod div.bd a','color','#FA9C39',690),(5,'.listSingle div.mod div.ft','background-color','#000000',691),(5,'.listRight div.mod div.bd a','color','#FA9C39',692),(5,'#ft','color','#444444',693),(5,'#ft a','color','#444444',694),(5,'#hd','background-repeat','repeat-x',695),(5,'#hd','background-image','url(http://assets.socialcloudz.com/content/community/3/img016.gif)',696),(5,'.listLeft div.mod div.bd a','color','#fa9c39',697),(5,'.listRight .mod','border-width','0px',698),(5,'.listSingle .mod','border-width','0px',699),(5,'.listSingle div.mod div.hd','font-size','24px',700),(5,'.listLeft div.mod div.hd','border-width','0px',701),(5,'.listLeft div.mod div.hd','font-size','22px',702),(5,'.listLeft .mod','border-width','0px',703),(5,'.listLeft div.mod div.bd','color','#808080',704),(5,'.listLeft div.mod div.bd','background-color','#ffa8ed',705),(5,'.listRight div.mod div.hd','height','40px',706),(5,'.listRight div.mod div.hd','background-image','url(http://assets.socialcloudz.com/content/community/3/img07.gif)',707),(5,'.listRight div.mod div.hd','padding','6px 3px 3px 16px ',708),(5,'.listRight div.mod div.hd','font-size','24px',709),(5,'.listLeft div.mod div.hd a','color','#FA9C39',710),(5,'#menuBar ul li a','background-image','url()',711),(5,'#siteTagLine','padding','0px 0px 0px 80px ',712),(5,'#siteName','padding','64px 0px 0px 50px ',713),(5,'#siteName','font-size','36px',714),(5,'#menuBar ul li a:hover','color','#ffffff',715),(5,'#menuBar ul li a:hover','background-color','#738197',716),(5,'#menuBar ul li a:hover','background-image','url()',717),(5,'#menuBar','background-image','url(http://assets.socialcloudz.com/content/community/3/img01BOT11.gif)',718),(7,'body','background-image','url(http://assets.socialcloudz.com/content/community/3/homepage011.jpg)',719),(7,'body','background-color','#273840',720),(7,'#hd','background-color','#ffffff',721),(7,'#siteTagLine','color','#273840',722),(7,'#siteName','color','#273840',723),(7,'#menuBar ul li a','background-repeat','no-repeat',724),(7,'#menuBar ul li a','background-color','transparent',725),(7,'#menuBar ul li a','color','#ffffff',726),(7,'.listSingle div.mod div.bd a','color','#004784',727),(7,'.listRight div.mod div.bd a','color','#004784',728),(7,'.listSingle div.mod div.hd a','color','#800080',729),(7,'.listRight div.mod div.hd','background-color','#ffffff',730),(7,'.listSingle div.mod div.hd','background-color','#ffffff',731),(7,'.listLeft div.mod div.hd','background-color','#ffffff',732),(7,'.listLeft div.mod div.bd a','color','#004784',733),(7,'.listLeft div.mod div.hd','color','#273840',734),(7,'.listLeft div.mod div.hd','font-size','18px',735),(7,'.listSingle div.mod div.hd','color','#273840',736),(7,'.listSingle div.mod div.hd','font-size','18px',737),(7,'#bd','background-color','#ffffff',738),(7,'#ft','background-color','#ffffff',739),(7,'.listLeft .mod','border-width','0px',740),(7,'.listSingle .mod','border-width','0px',741),(7,'.listRight div.mod div.hd','color','#273840',742),(7,'.listRight div.mod div.hd','font-size','18px',743),(7,'.listLeft div.mod div.hd','border-width','0px',744),(7,'#ft','color','#273840',745),(7,'#ft','font-size','10px',746),(7,'.listRight .mod','border-width','0PX',747),(7,'#ft a','color','#004784',748),(7,'#bd','padding','34px 28px 12px 26px ',749),(7,'#menuBar ul li a','font-weight','bold',750),(7,'#menuBar ul li a','border-width','0px',751),(7,'#menuBar ul li a','padding','12px 28px 12px 26px ',752),(7,'.listRight div.mod div.hd','font-weight','bold',753),(7,'.listSingle div.mod div.hd','font-weight','bold',754),(7,'.listLeft div.mod div.hd','font-weight','bold',755),(7,'#menuBar ul','padding','0px 28px 12px 0px ',756),(7,'body','background-repeat','repeat-x',757),(7,'body','background-position','top',758),(7,'#bd','border-color','#ffffff',759),(7,'#bd','border-width','0px',760),(7,'#ft','padding','10px 40px 24px 32px ',761),(7,'#menuBar ul li a:hover','color','#000000',762),(7,'.listRight div.mod div.hd','padding','0px 0px 10px 0px ',763),(7,'.listSingle div.mod div.hd','padding','0px 0px 10px 0px ',764),(7,'.listLeft div.mod div.hd','padding','0px 0px 10px 0px ',765),(7,'.listLeft div.mod div.hd a','color','#004784',766),(7,'#menuBar','background-image','url(http://assets.socialcloudz.com/content/community/3/homepage022.gif)',767),(8,'body','background-color','#590000',768),(8,'#bd','background-color','#590000',769),(8,'#hd','background-color','#b80505',770),(8,'.listLeft div.mod div.bd','border-width','0px',771),(8,'.listLeft div.mod div.bd','background-color','#590000',772),(8,'.listLeft div.mod div.bd','padding','8px 8px 8px 8px',773),(8,'.listLeft div.mod div.hd','height','26px',774),(8,'.listLeft div.mod div.hd','color','#ffffff',775),(8,'.listLeft div.mod div.hd','background-color','#590000',776),(8,'.listLeft div.mod div.hd','font-size','22px',777),(8,'.listSingle div.mod div.bd a','color','#CC0001',778),(8,'.listSingle div.mod div.bd','background-color','#590000',779),(8,'.listSingle div.mod div.hd','height','26px',780),(8,'.listSingle div.mod div.hd','color','#ffffff',781),(8,'.listSingle div.mod div.hd','background-color','#590000',782),(8,'.listSingle div.mod div.hd','font-size','20px',783),(8,'.listLeft div.mod div.bd a','color','#cc0001',784),(8,'.listLeft div.mod div.bd','color','#CD7A7A',785),(8,'.listSingle div.mod div.bd','color','#cd7a7a',786),(8,'.listLeft .mod','border-width','0px',787),(8,'.listSingle .mod','border-width','0px',788),(8,'#menuBar ul li a','color','#ffffff',789),(8,'#menuBar','background-color','#000000',790),(8,'.listRight div.mod div.hd','background-color','#2f0000',791),(8,'#siteName a','color','#ffffff',792),(8,'#siteName','text-decoration','none',793),(8,'#siteTagLine','color','#ffffff',794),(8,'#siteName','color','#ffffff',795),(8,'.listRight .mod','border-width','0px',796),(8,'.listRight div.mod div.bd','background-color','#2f0000',797),(8,'.listRight div.mod div.bd a','text-decoration','none',798),(8,'.listRight div.mod div.bd a','color','#ffffff',799),(8,'.listRight div.mod div.bd','color','#cd7a7a',800),(8,'.listRight div.mod div.hd','height','8px',801),(8,'.listRight div.mod div.hd','color','#ffffff',802),(8,'.listRight div.mod div.hd','padding','20px 3px 12px 14px ',803),(8,'.listRight div.mod div.hd','font-size','20px',804),(8,'#ft','color','#cd7a7a',805),(8,'#ft','background-color','#2f0000',806),(8,'#ft a','color','#ffffff',807),(8,'#menuBar ul li a','border-width','0px',808),(8,'#menuBar ul li a:hover','background-color','#590000',809),(8,'.listLeft div.mod div.hd a','color','#ffffff',810),(8,'.listRight div.mod div.bd','padding','20px 22px 12px 22px',811),(13,'#siteName','color','#ffffff',812),(13,'#menuBar ul li a','color','#ffffff',813),(13,'#menuBar','background-color','#850000',814),(13,'undefined','background-color','#333333',815),(13,'#siteTagLine','color','#ffffff',816),(13,'#hd','background-color','#9d0e17',817),(13,'body','background-color','#333333',818),(13,'#bd','background-color','#9d0e17',819),(13,'#menuBar ul li a:hover','background-color','#a90202',820),(13,'#ft a','color','#ffffff',821),(13,'#ft a','font','#ffffff',822),(13,'.listLeft div.mod div.bd a','color','#ffffff',823),(13,' .listSingle div.mod div.bd','color','#ffffff',824),(13,' .listSingle div.mod div.bd','background-color','#c41c23',825),(13,' .listSingle div.mod div.hd','color','#ffffff',826),(13,'#ft','color','#ffffff',827),(13,'#ft','background-color','#8f0009',828),(13,' .listRight div.mod div.bd','color','#ffffff',829),(13,' .listRight div.mod div.bd','background-color','#c41c23',830),(13,' .listRight div.mod div.hd','color','#ffffff',831),(13,' .listRight div.mod div.bd a','color','#ffffff',832),(13,' .listSingle div.mod div.bd a','color','#ffffff',833),(13,'.listLeft div.mod div.hd a','color','#ffffff',834),(13,'.listLeft div.mod div.bd','color','#ffffff',835),(13,'.listLeft div.mod div.bd','background-color','#c41c23',836),(13,'.listLeft div.mod div.hd','color','#ffffff',837),(13,'.listLeft div.mod div.hd','background-color','#e60000',838),(13,'.listRight div.mod div.hd','background-color','#e60000',839),(13,' .listRight div.mod div.hd a','color','#ffffff',840),(13,'.listSingle div.mod div.hd','background-color','#e60000',841),(13,' .listSingle div.mod div.hd a','color','#ffffff',842),(14,'#ft a','color','#ffffff',843),(14,'.listLeft div.mod div.bd a','color','#ffffff',844),(14,'#menuBar ul li a','color','#ffffff',845),(14,' .listSingle div.mod div.bd','color','#ffffff',846),(14,' .listSingle div.mod div.bd','font','#ffffff',847),(14,' .listSingle div.mod div.bd','background-color','#238d02',848),(14,' .listSingle div.mod div.hd','color','#ffffff',849),(14,'#bd','background-color','#386420',850),(14,'#ft','color','#ffffff',851),(14,'#ft','background-color','#234415',852),(14,' .listRight div.mod div.bd','color','#ffffff',853),(14,' .listRight div.mod div.bd','font','#ffffff',854),(14,' .listRight div.mod div.bd','background-color','#238d02',855),(14,'#hd','background-color','#386420',856),(14,' .listRight div.mod div.hd','color','#ffffff',857),(14,'undefined','background-color','#292929',858),(14,'#menuBar','background-color','#234319',859),(14,' .listRight div.mod div.bd a','color','#ffffff',860),(14,' .listSingle div.mod div.bd a','color','#ffffff',861),(14,'body','background-color','#292929',862),(14,'.listLeft div.mod div.hd a','color','#ffffff',863),(14,'.listLeft div.mod div.bd','color','#ffffff',864),(14,'.listLeft div.mod div.bd','font','#ffffff',865),(14,'.listLeft div.mod div.bd','background-color','#238d02',866),(14,'.listLeft div.mod div.hd','color','#ffffff',867),(14,'.listLeft div.mod div.hd','background-color','#5ea540',868),(14,'#menuBar ul li a:hover','background-color','#549530',869),(14,'.listRight div.mod div.hd','background-color','#5ea540',870),(14,' .listRight div.mod div.hd a','color','#ffffff',871),(14,'#siteTagLine','color','#ffffff',872),(14,'.listSingle div.mod div.hd','background-color','#5ea540',873),(14,' .listSingle div.mod div.hd a','color','#ffffff',874),(14,'#siteName','color','#ffffff',875),(15,'#ft a','color','#ffffff',876),(15,'.listLeft div.mod div.bd a','color','#ffffff',877),(15,' .listSingle div.mod div.bd','color','#ffffff',878),(15,' .listSingle div.mod div.bd','background-color','#434dc7',879),(15,' .listSingle div.mod div.hd','color','#ffffff',880),(15,'#bd','background-color','#171579',881),(15,'#ft','color','#ffffff',882),(15,'#ft','background-color','#0200a6',883),(15,'#hd','background-color','#171579',884),(15,' .listRight div.mod div.bd','color','#ffffff',885),(15,' .listRight div.mod div.bd','background-color','#434dc7',886),(15,' .listRight div.mod div.hd','color','#ffffff',887),(15,'undefined','background-color','#bababa',888),(15,'#menuBar','background-color','#1e2ddc',889),(15,' .listRight div.mod div.bd a','color','#ffffff',890),(15,' .listSingle div.mod div.bd a','color','#ffffff',891),(15,'body','background-color','#bababa',892),(15,'.listLeft div.mod div.hd a','color','#ffffff',893),(15,'.listLeft div.mod div.bd','color','#ffffff',894),(15,'.listLeft div.mod div.bd','background-color','#434dc7',895),(15,'.listLeft div.mod div.hd','color','#ffffff',896),(15,'.listLeft div.mod div.hd','background-color','#0200a3',897),(15,'.listRight div.mod div.hd','background-color','#0200a3',898),(15,' .listRight div.mod div.hd a','color','#ffffff',899),(15,'.listSingle div.mod div.hd','background-color','#0200a3',900),(15,' .listSingle div.mod div.hd a','color','#ffffff',901),(15,'#menuBar ul li a','color','#ffffff',902),(15,'#menuBar ul li a:hover','background-color','#121c84',903),(15,'#siteTagLine','color','#ffffff',904),(15,'#siteName','color','#ffffff',905),(16,'.listLeft div.mod div.bd a','color','#000000',906),(16,' .listSingle div.mod div.bd','background-color','#fffd7a',907),(16,'#bd','background-color','#fffa9e',908),(16,'#ft','background-color','#fffb3b',909),(16,'#hd','background-color','#fffa9e',910),(16,' .listRight div.mod div.bd','background-color','#fffd7a',911),(16,'undefined','background-color','#ffffff',912),(16,'#menuBar','background-color','#fffa14',913),(16,' .listRight div.mod div.bd a','color','#000000',914),(16,' .listSingle div.mod div.bd a','color','#000000',915),(16,'body','background-color','#ffffff',916),(16,'.listLeft div.mod div.hd a','color','#000000',917),(16,'.listLeft div.mod div.bd','background-color','#fffd7a',918),(16,'.listLeft div.mod div.hd','background-color','#ffe033',919),(16,'.listRight div.mod div.hd','background-color','#ffe033',920),(16,' .listRight div.mod div.hd a','color','#000000',921),(16,'.listSingle div.mod div.hd','background-color','#ffe033',922),(16,' .listSingle div.mod div.hd a','color','#000000',923),(17,' .listRight div.mod div.bd','background-color','#ffccfe',924),(17,'#menuBar','background-color','#ff42d7',925),(17,'undefined','background-color','#333333',926),(17,' .listSingle div.mod div.bd','background-color','#ffccfe',927),(17,'#ft','background-color','#f304d6',928),(17,'#hd','background-color','#ff8af4',929),(17,'body','background-color','#333333',930),(17,'#bd','background-color','#ff8af4',931),(17,'#menuBar ul li a:hover','background-color','#e821b0',932),(17,'.listSingle div.mod div.hd','background-color','#ff70da',933),(17,'.listLeft div.mod div.hd','background-color','#ff70da',934),(17,'.listLeft div.mod div.bd','background-color','#ffccfe',935),(17,'.listRight div.mod div.hd','background-color','#ff70da',936),(18,'.listLeft div.mod div.bd a','color','#a84f00',937),(18,' .listSingle div.mod div.bd','background-color','#ebcf98',938),(18,'#bd','background-color','#ebe1a3',939),(18,'#ft','background-color','#ecaf69',940),(18,'#hd','background-color','#ebe1a3',941),(18,' .listRight div.mod div.bd','background-color','#ebcf98',942),(18,'undefined','background-color','#ffffff',943),(18,'#menuBar','background-color','#d1954d',944),(18,' .listRight div.mod div.bd a','color','#a84f00',945),(18,' .listSingle div.mod div.bd a','color','#a84f00',946),(18,'body','background-color','#ffffff',947),(18,'.listLeft div.mod div.hd a','color','#562f0b',948),(18,'.listLeft div.mod div.bd','background-color','#ebcf98',949),(18,'.listLeft div.mod div.hd','background-color','#e4c17c',950),(18,'.listRight div.mod div.hd','background-color','#e4c17c',951),(18,' .listRight div.mod div.hd a','color','#562f0b',952),(18,'.listSingle div.mod div.hd','background-color','#e4c17c',953),(18,' .listSingle div.mod div.hd a','color','#562f0b',954),(19,'.listLeft div.mod div.bd a','color','#182b7b',955),(19,' .listSingle div.mod div.bd','background-color','#75cfff',956),(19,'#bd','background-color','#1fc3ff',957),(19,'#ft','background-color','#2990ff',958),(19,'#hd','background-color','#1fc3ff',959),(19,' .listRight div.mod div.bd','background-color','#75cfff',960),(19,'undefined','background-color','#ffffff',961),(19,'#menuBar','background-color','#1f79ff',962),(19,' .listRight div.mod div.bd a','color','#182b7b',963),(19,' .listSingle div.mod div.bd a','color','#182b7b',964),(19,'body','background-color','#ffffff',965),(19,'.listLeft div.mod div.hd a','color','#000000',966),(19,'.listLeft div.mod div.bd','background-color','#75cfff',967),(19,'.listLeft div.mod div.hd','background-color','#0aa8ff',968),(19,'#menuBar ul li a:hover','background-color','#52d9ff',969),(19,'.listRight div.mod div.hd','background-color','#0aa8ff',970),(19,' .listRight div.mod div.hd a','color','#000000',971),(19,'.listSingle div.mod div.hd','background-color','#0aa8ff',972),(19,' .listSingle div.mod div.hd a','color','#000000',973),(5,'undefined','background-color','#333333',974),(20,' .listRight div.mod div.bd','background-color','#bebebe',975),(20,'#menuBar','background-color','#bebebe',976),(20,'undefined','background-color','#000000',977),(20,' .listSingle div.mod div.bd','background-color','#bebebe',978),(20,'#bd','background-color','#666666',979),(20,'.listSingle div.mod div.hd','background-color','#4d4d4d',980),(20,'.listLeft div.mod div.hd','background-color','#4d4d4d',981),(20,'.listRight div.mod div.hd','background-color','#4d4d4d',982),(20,'.listLeft div.mod div.bd','background-color','#bebebe',983),(20,'.listLeft div.mod div.hd a','color','#8f8f8f',984),(20,' .listSingle div.mod div.bd a','color','#454545',985),(20,' .listRight div.mod div.hd a','color','#8f8f8f',986),(20,'.listLeft div.mod div.bd a','color','#454545',987),(20,' .listRight div.mod div.bd a','color','#454545',988),(20,' .listSingle div.mod div.hd a','color','#8f8f8f',989),(13,' .listRight div.mod div.bd','font','#ffffff',990),(13,' .listSingle div.mod div.hd','font-weight','bold',991),(13,' .listSingle div.mod div.hd','padding','5px 8px 5px 10px',992),(13,' .listSingle div.mod div.bd','font','#ffffff',993),(13,'#ft','font-size','10px',994),(13,'#bd','padding','3px 5px 0px 5px',995),(13,'#menuBar ul','padding','0px 3px 3px 10px ',996),(13,'.listLeft div.mod div.hd','font-weight','bold',997),(13,'.listLeft div.mod div.hd','padding','5px 8px 5px 10px',998),(13,' .listRight div.mod div.hd','font-weight','bold',999),(13,' .listRight div.mod div.hd','padding','5px 8px 5px 10px',1000),(13,'.listLeft div.mod div.bd','font','#ffffff',1001),(14,'#bd','padding','3px 5px 0px 5px',1002),(14,'#menuBar ul','padding','0px 0px 0px 15px',1003),(15,'#bd','padding','3px 5px 0px 5px',1004),(15,'#menuBar ul','padding','0px 0px 0px 15px',1005),(16,'#siteName','color','#000000',1006),(16,'#siteTagLine','color','#000000',1007),(16,'#bd','padding','3px 5px 0px 5px',1008),(16,'#menuBar ul','padding','0px 0px 0px 15px',1009),(17,' .listRight div.mod div.bd','font','#f269e1',1010),(17,'#siteName','color','#80054e',1011),(17,' .listSingle div.mod div.bd','font','#f269e1',1012),(17,'#siteTagLine','color','#9a0960',1013),(17,'#bd','padding','3px 5px 0px 5px',1014),(17,'#menuBar ul','padding','0px 0px 0px 15px',1015),(17,'.listLeft div.mod div.bd','font','#f269e1',1016),(5,' .listRight div.mod div.bd','background-color','#ffa8ed',1017),(5,' .listSingle div.mod div.bd','background-color','#ffa8ed',1018),(18,'#menuBar ul li a','color','#ffffff',1019),(18,' .listSingle div.mod div.bd','color','#502d0b',1020),(18,' .listSingle div.mod div.hd','color','#603000',1021),(18,' .listSingle div.mod div.hd','font-weight','bold',1022),(18,'#bd','padding','3px 5px 0px 5px',1023),(18,' .listRight div.mod div.bd','color','#502d0b',1024),(18,' .listRight div.mod div.hd','color','#603000',1025),(18,' .listRight div.mod div.hd','font-weight','bold',1026),(18,'.listLeft div.mod div.bd','color','#502d0b',1027),(18,'#menuBar ul','padding','0px 0px 0px 15px',1028),(18,'.listLeft div.mod div.hd','color','#603000',1029),(18,'.listLeft div.mod div.hd','font-weight','bold',1030),(18,'#menuBar ul li a:hover','color','#ffffff',1031),(18,'#siteTagLine','color','#502d0b',1032),(18,'#siteName','color','#502d0b',1033),(16,'#menuBar ul li a','color','#000000',1034),(16,'#menuBar ul li a:hover','background-color','#ffca14',1035),(17,'#menuBar ul li a','color','#ffffff',1036),(17,' .listSingle div.mod div.bd a','color','#a42d9a',1037),(17,'.listLeft div.mod div.bd a','color','#a42d9a',1038),(17,' .listRight div.mod div.bd a','color','#a42d9a',1039),(17,' .listSingle div.mod div.hd','color','#ffffff',1040),(17,' .listSingle div.mod div.hd','font-weight','bold',1041),(17,'.listLeft div.mod div.hd','color','#ffffff',1042),(17,'.listLeft div.mod div.hd','font-weight','bold',1043),(17,' .listRight div.mod div.hd','color','#ffffff',1044),(17,' .listRight div.mod div.hd','font-weight','bold',1045),(14,' .listRight div.mod div.hd','font-weight','bold',1046),(14,' .listSingle div.mod div.hd','font-weight','bold',1047),(14,'.listLeft div.mod div.hd','font-weight','bold',1048),(14,' .listRight div.mod div.hd','padding','5px 8px 5px 10px',1049),(14,' .listSingle div.mod div.hd','padding','5px 8px 5px 10px',1050),(14,'.listLeft div.mod div.hd','padding','5px 8px 5px 10px',1051),(15,' .listRight div.mod div.hd','font-weight','bold',1052),(15,' .listRight div.mod div.hd','padding','5px 8px 5px 10px',1053),(15,' .listSingle div.mod div.hd','font-weight','bold',1054),(15,' .listSingle div.mod div.hd','padding','5px 8px 5px 10px',1055),(15,'.listLeft div.mod div.hd','font-weight','bold',1056),(15,'.listLeft div.mod div.hd','padding','5px 8px 5px 10px',1057),(16,' .listRight div.mod div.hd','font-weight','bold',1058),(16,' .listRight div.mod div.hd','padding','5px 8px 5px 10px',1059),(16,' .listSingle div.mod div.hd','font-weight','bold',1060),(16,' .listSingle div.mod div.hd','padding','5px 8px 5px 10px',1061),(16,'.listLeft div.mod div.hd','font-weight','bold',1062),(16,'.listLeft div.mod div.hd','padding','5px 8px 5px 10px',1063),(17,' .listSingle div.mod div.hd','padding','5px 8px 5px 10px',1064),(17,'.listLeft div.mod div.hd','padding','5px 8px 5px 10px',1065),(17,' .listRight div.mod div.hd','padding','5px 8px 5px 10px',1066),(18,' .listRight div.mod div.hd','padding','5px 8px 5px 10px',1067),(18,' .listSingle div.mod div.hd','padding','5px 8px 5px 10px',1068),(18,'.listLeft div.mod div.hd','padding','5px 8px 5px 10px',1069),(19,'#menuBar ul li a','color','#dbf2ff',1070),(19,'#menuBar ul li a','border-color','#a3e5ff',1071),(19,' .listSingle div.mod div.hd','font-weight','bold',1072),(19,' .listSingle div.mod div.hd','padding','5px 8px 5px 10px',1073),(19,'#bd','padding','3px 5px 0px 5px',1074),(19,'#menuBar ul','padding','0px 0px 0px 15px',1075),(19,'.listLeft div.mod div.hd','font-weight','bold',1076),(19,'.listLeft div.mod div.hd','padding','5px 8px 5px 10px',1077),(19,' .listRight div.mod div.hd','font-weight','bold',1078),(19,' .listRight div.mod div.hd','padding','5px 8px 5px 10px',1079),(19,'.listLeft div.mod div.bd a','font','#ffffff',1080),(19,' .listSingle div.mod div.bd','color','#002a85',1081),(19,' .listSingle div.mod div.hd','color','#ffffff',1082),(19,' .listRight div.mod div.bd','color','#002a85',1083),(19,' .listRight div.mod div.hd','color','#ffffff',1084),(19,' .listRight div.mod div.bd a','font','#ffffff',1085),(19,' .listSingle div.mod div.bd a','font','#ffffff',1086),(19,'.listLeft div.mod div.bd','color','#002a85',1087),(19,'.listLeft div.mod div.hd','color','#ffffff',1088),(19,'#siteTagLine','color','#0557ff',1089),(19,'#siteName','color','#0037a8',1090),(20,'#menuBar ul li a','color','#0a0a0a',1091),(20,'#menuBar ul li a','border-color','#666666',1092),(20,' .listSingle div.mod div.hd','color','#f2f2f2',1093),(20,' .listSingle div.mod div.hd','font-weight','bold',1094),(20,' .listSingle div.mod div.hd','padding','5px 8px 5px 10px',1095),(20,'#bd','padding','3px 5px 0px 5px',1096),(20,'#hd','background-color','#666666',1097),(20,' .listRight div.mod div.hd','color','#f2f2f2',1098),(20,' .listRight div.mod div.hd','font-weight','bold',1099),(20,' .listRight div.mod div.hd','padding','5px 8px 5px 10px',1100),(20,'body','background-color','#333333',1101),(20,'#menuBar ul','padding','0px 0px 0px 15px',1102),(20,'.listLeft div.mod div.hd','color','#f2f2f2',1103),(20,'.listLeft div.mod div.hd','font-weight','bold',1104),(20,'.listLeft div.mod div.hd','padding','5px 8px 5px 10px',1105),(20,'#menuBar ul li a:hover','background-color','#949494',1106),(20,'#siteTagLine','color','#2b2b2b',1107),(20,'#siteName','color','#e3e3e3',1108),(5,'#siteName','font-family','Arial',1109),(5,'#siteName','text-decoration','none',1110),(5,'#siteTagLine','font-size','20px',1111),(7,'undefined','background-color','#590000',1112);
/*!40000 ALTER TABLE `templateData` ENABLE KEYS */;

/*!40000 ALTER TABLE `template` DISABLE KEYS */;
INSERT INTO `template` VALUES (5,'Artificial','gray.png',NULL,'advanced'),(7,'Corporate','blue.png',NULL,'advanced'),(8,'Pastries','red.png',NULL,'advanced'),(11,'Distorted','green.png',NULL,'advanced'),(13,'Red','SC_tHumb_red.png',NULL,'basic'),(14,'Green','SC_tHumb_green.png',NULL,'basic'),(15,'Blue','SC_tHumb_blue.png',NULL,'basic'),(16,'Yellow','SC_tHumb_yellow.png',NULL,'basic'),(17,'Pink','SC_tHumb_pink.png',NULL,'basic'),(18,'Beige','SC_tHumb_beige.png',NULL,'basic'),(19,'Light Blue','SC_tHumb_ltblue.png',NULL,'basic'),(20,'Gray','SC_tHumb_grey.png',NULL,'basic');
/*!40000 ALTER TABLE `template` ENABLE KEYS */;



use members;

/*!40000 ALTER TABLE `access` DISABLE KEYS */;
INSERT INTO `access` VALUES (1,2,100),(1,3,100),(1,64,100),(1,66,100),(1,202,20),(1,203,20),(1,204,20),(1,205,20),(1,206,20),(1,207,20),(1,208,20),(1,213,20),(1,214,20);
/*!40000 ALTER TABLE `access` ENABLE KEYS */;

/*!40000 ALTER TABLE `membersaccount` DISABLE KEYS */;
INSERT INTO `membersaccount` VALUES (2,1,'2008-12-04 00:04:49','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',134,84,'','','\0'),(3,0,'2010-08-29 17:32:53','\0','\0','\0','2010-08-29 17:37:09',NULL,'\0','\0','\0',NULL,0,0,'','','\0'),(3,1,'2008-12-04 02:13:01','\0','','','2010-08-29 17:47:15',NULL,'\0','','\0','/images/user_icon.png',342,250,'','',''),(64,1,'2009-04-16 23:33:08','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',6,27,'','','\0'),(66,1,'2009-04-16 23:34:37','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',9,5,'','','\0'),(202,1,'2010-08-18 21:46:56','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',0,3,'','','\0'),(203,1,'2010-08-18 21:48:13','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',0,4,'','','\0'),(204,1,'2010-08-18 21:49:46','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',0,0,'','','\0'),(205,1,'2010-08-18 21:51:28','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',0,0,'','','\0'),(206,1,'2010-08-18 21:53:53','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',0,3,'','','\0'),(207,1,'2010-08-18 21:57:09','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',0,3,'','','\0'),(208,1,'2010-08-18 21:58:28','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',0,0,'','','\0'),(213,1,'2010-08-18 22:32:04','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',0,0,'','','\0'),(214,1,'2010-08-18 22:33:29','\0','\0','\0','2010-08-28 06:02:37',NULL,'\0','','\0','/images/user_icon.png',0,0,'','','\0');
/*!40000 ALTER TABLE `membersaccount` ENABLE KEYS */;

/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'billieblaze','bill@socialcloudz.com','bblaze','Billie','Blaze','Raleigh','NC','94547','us','35.771946','-78.638885',1,'1979-08-26',NULL,'0',NULL,'',NULL,'',0);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;

/*!40000 ALTER TABLE `preferencelist` DISABLE KEYS */;
INSERT INTO `preferencelist` VALUES (1,'Friend Request','friend','Yes,No',1,1,'Friends',NULL),(2,'Receive Mail','mail','Yes,No',1,1,'Mail',NULL),(3,'Comments on Blog Post','content_Blog','Yes,No',1,3,'Content',NULL),(4,'Comments on Article','content_Article','Yes,No',1,2,'Content',NULL),(5,'Comments on Event','content_Event','Yes,No',1,4,'Content',NULL),(6,'Comments on Photo','content_Gallery','Yes,No',1,5,'Content',NULL),(7,'Comments on Album','content_Music','Yes,No',1,1,'Content',NULL),(8,'Comments on Video','content_Video','Yes,No',1,6,'Content',NULL),(9,'Comments on Group','content_Group','Yes,No',1,7,'Content',NULL),(10,'Comments on Document','content_Document','Yes,No',1,8,'Content',NULL);
/*!40000 ALTER TABLE `preferencelist` ENABLE KEYS */;



USE `socialcloudz`;

/*!40000 ALTER TABLE `helpSections` DISABLE KEYS */;
INSERT INTO `helpSections` VALUES (1,'Getting Started',NULL,1,'admin'),(2,'Account / Billing',NULL,2,'admin'),(3,'Content Management',NULL,3,'admin'),(4,'Design / Layout',NULL,4,'admin'),(5,'Domain Names',NULL,5,'admin'),(6,'Premium Services',NULL,6,'admin'),(7,'User Content',NULL,7,'admin'),(8,'Getting Started',NULL,1,'user'),(9,'General',NULL,2,'user'),(10,'Articles / Blogs',NULL,3,'user'),(11,'Document Manager',NULL,4,'user'),(12,'Events',NULL,5,'user'),(13,'Links',NULL,8,'user'),(14,'Music',NULL,9,'user'),(15,'Profile',NULL,11,'user'),(16,'Forum',NULL,6,'user'),(17,'Photos',NULL,12,'user'),(18,'Videos',NULL,13,'user'),(19,'Knowledgebase',NULL,7,'user');
/*!40000 ALTER TABLE `helpSections` ENABLE KEYS */;

/*!40000 ALTER TABLE `help` DISABLE KEYS */;
INSERT INTO `help` VALUES (2,'editModule','Make changes to this modules settings such as Title, Sorting, Thumbnail size or Number to display.'),(3,'closeModule','Remove this module from the current page.'),(4,'addArticle','Add a new article.'),(5,'editArticle','Edit this article.'),(6,'deleteArticle','Delete this article.'),(7,'addEvent','Add a new event.'),(8,'editEvent','Edit this event.'),(9,'deleteEvent','Delete this event.'),(10,'addSection','Add a forum section.'),(11,'addForum','Add a forum.'),(12,'editForum','Edit this forum.'),(13,'deleteForum','Delete this forum.'),(14,'moveForumSectionUp','Move this forum section up.'),(15,'moveForumSectionDown','Move this forum section down.'),(16,'moveForumUp','Move this forum up.'),(17,'moveForumDown','Move this forum down.'),(18,'editForumSection','Edit this forum section.'),(19,'deleteForumSection','Delete this forum section.'),(20,'addBlog','Add a new blog.'),(21,'editBlog','Edit this blog.'),(22,'deleteBlog','Delete this blog.'),(23,'myAlbums','My albums.'),(24,'addAlbum','Add a new album.'),(25,'editAlbum','Edit this album.'),(26,'deleteAlbum','Delete this album.'),(27,'myGalleries','My galleries.'),(28,'addGallery','Add a new gallery.'),(29,'editGallery','Edit this gallery.'),(30,'deleteGallery','Delete this gallery.'),(31,'myVideos','My videos'),(32,'addVideo','Add a new video.'),(33,'editVideo','Edit this video.'),(34,'deleteVideo','Delete this video.'),(35,'addKBSection','Add knowledgebase section.'),(36,'addKBTopic','Add a knowledgebase entry.'),(37,'editKBTopic','Edit this topic.'),(38,'editKBSection','Edit this section.'),(39,'deleteKBTopic','Delete this topic.'),(40,'deleteKBSection','Delete this section.'),(41,'adminSiteName','This is the title of your site.  It is displayed on the top of the browser, in your sites header, throughout the sites content / emails and on external search engine listings.'),(42,'adminSiteTagline','This is your sites tagline.  It is displayed in the header area of your site.'),(43,'adminSiteCategory','Your sites category is fed into search engine results, and also allows SocialCloudz to help you find ways to increase your sites visibility amongst your target audience.'),(44,'adminSiteKeywords','These keywords are fed into search engines looking at your site.  By applying a meaningful set of keywords that relates to your content, you are helping to increase the exposure of your site.'),(45,'adminSiteDescription','The description are fed to search engines looking at your site.  By creating a description that is inline with your keywords, you\'re maximizing your search engine exposure.'),(46,'adminSitePrivate','By setting your site to private, people can only see your sites content after they have logged in.  If you have signup enabled, members can only access your site after you approve their membership request.'),(47,'adminSiteSignup','This flag determines whether or not to present \"Signup\" links throughout the site to potential members.  This is useful if you are trying to use your SocialCloudz site in a \"non-community\" fashion.'),(48,'adminSiteDateFormat','The date format allows you to determine the mask which is applied to dates wherever they are presented to users on your site. '),(49,'menuPosition','This setting allows you to modify the positioning of your navigation menu.  It may be placed above or below the site header image, as well as in the sidebar navigation area.'),(50,'addLI','This link allows you to add a menu item to the drag / drop list on the left.'),(51,'menuTitle','The menu title is the text which appears on a menu item\'s link.'),(52,'menuNewPage','This option creates a new, blank Content Management System page that you can customize with whatever modules you chose.'),(53,'menuURL','This option allows you to link to any URL that you desire from within your menu.'),(54,'menuFeature','This option allows you to select a SocialCloudz feature to link to.'),(55,'menuNewWindow','This option opens the link in a new browser window when clicked.'),(56,'menuVisibility','This option allows you to select who can see a given menu item. <BR><BR>Everyone = Non-Members & Members<BR>Members = Logged in members only<BR>Administrators = members who have administrative priveleges on your site.'),(57,'adminSiteContentApproval','This option determines if content is automatically posted to your site, or if it requires you to approve it before it is visible.'),(58,'adminSiteStartPage','This is the page a user will goto after successfully logging in to your site.'),(59,'adminGoogleAnalytics','Signup for Google Analytics and paste the code here to get detailed information about your visitors and traffic.');
/*!40000 ALTER TABLE `help` ENABLE KEYS */;

/*!40000 ALTER TABLE `helpTopics` DISABLE KEYS */;
INSERT INTO `helpTopics` VALUES (7,'How do I delete content?',3,'<p>You first have to be logged in, then you can either access the content manager from the admin menu at the top or you can go directly to the content you wish to delete, and at the top of the page you will see an actions menu where you can select to delete any content specifically.</p>\r\n<p>If you go to your content manager you can search for content by date or category/keyword, when you find which piece you want to delete, just use the delete option on the line entry of the content you wish to delete, once you confirm delete it will be gone permanently</p>\r\n<p>Can\'t find what you\'re looking for?  Email us @ <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a></p>',0,NULL),(8,'How do I rearrange my modules?',4,'<p>It is very easy to rearrange the modules by first logging in to whatever site you are wanting to edit to which you are an admin. Once you are logged in scroll down to the page body section of your website on the page that you want to change individually. Roll your mouse over a module header and you will see the wrench and the delete controls popup, you will notice that they appear anytime you rollover any part of a module header. When you see your mouse pointer turn into a hand you know you have it in the right place, click and hold the mouse button down and drag that module around to whatever space you want it, Its sort of tricky to get the hang of at first but once you try it a couple times you will get it, when you see the outlines show where its supposed to go you can let go and it will go into place and thats it, No saving or anything.</p>\r\n<p>Be careful if you are on IE 6 or 8 you may have some issues with the popup drag n drop issues if this situation applies to you we greatly apologize for the inconvenience, in your case we recommend downloading firefox to use as your browser when editing this website.&nbsp;We are 100% certain that socialcloudz operates completely normally in FF environment.</p>',0,'2009-08-18 18:09:49'),(9,'How do I control the sorting on a specific content section?',8,'<p>There are sorting controls at the top of every section in the main content list area.&nbsp;If you would like to sort the way the main list displays on your webpage just login and go to the customize menu at the top, select page settings, and when the popup displays you will see a tab called &quot;sorting&quot;, in this tab you can select from several combinations of options and then select save and it will change the current display to whatever you set it to once it refreshes.</p>\r\n<p>If you have further questions about sorting please contact <a href=\"javascript:location.href=\'mailto:\'+String.fromCharCode(115,117,112,112,111,114,116,64,115,111,99,105,97,108,99,108,111,117,100,122,46,99,111,109)+\'?\'\">support@socialcloudz.com</a></p>',0,'2009-11-25 11:31:05'),(10,'How do I edit a module?',1,'<p>We have changed the edit module/edit this page feature to be self contained instead of utilizing the old edit this page link at the top customize menu.&nbsp;You can now edit a module\'s properties or content by logging in and then rolling over the header of the specific module you want to edit with your mouse and when you do the control should appear at the top right of the header bar while you are over it. When the control shows up, then you would hit the wrench icon, and the module properties or html editor will appear depending on what type of module it is.</p>',0,'2009-11-25 11:43:40'),(11,'How do I sign up for a SocialCloudz user account?',8,'<p>You can sign up for a SocialCloudz user account on any SocialCloudz website that is open to member signup.&nbsp;The way you can tell is if the site has a public signup box on the home page, or if you see the signup link available at the top on the target bar of the site next to the login link. If the signup link is available click it and the popup will appear and you can enter your information.&nbsp;You will then receive an email with your account details and the site you signed up on.</p>\r\n<p>A benefit of creating a SocialCloudz user account is that once you have whats called your SCid you can use it to access your profile information on any site in our network of sites.</p>\r\n<p>If you have any question not covered by our help section please send them to <a href=\"javascript:location.href=\'mailto:\'+String.fromCharCode(115,117,112,112,111,114,116,64,115,111,99,105,97,108,99,108,111,117,100,122,46,99,111,109)+\'?\'\">support@socialcloudz.com</a></p>',0,'2009-11-25 15:54:28'),(12,'How do I check my account usage statistics?',2,'<p>You can access your account/site usage stats on any of the admin section pages. Just go to your admin menu and select &quot;general&quot;, when the page loads up, you will see a module on either the left or right of your site that says &quot;usage&quot;.</p>\r\n<p>Bandwidth= how much data upload/download your site has received in the current billing cycle.</p>\r\n<p>Storage= how much data you have stored on your personal account.</p>\r\n<p>Page views= how many times your site has been viewed</p>\r\n<p>Didn\'t find what you\'re looking for?  Email us @ <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a></p>',0,'2009-11-25 16:00:19'),(13,'How do I sign in?',8,'<p>Use the login/signup links at the top of the page to the right.</p>\r\n<p>Can\'t find what you\'re looking for?  Email us @ <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a></p>',0,'2009-11-25 16:08:30'),(14,'How do I use my existing domain name on my site?',5,'<p>This is a two step process, first of all you have to login, and then use the admin menu to navigate to configure panel of the admin section by selecting admin &gt; configure &gt; domain and you will see the domain manager panel. From here you can type in your domain name, any top level domain will work. Once you enter in your domain name, and select save you are now ready to configure your dns on your dns manager where you are hosting your domain name. If you are not familiar with dns management contact support at your domain host company (ie. godaddy, etc) once you are logged into your dns manager, be very careful not to change any settings you are unfamiliar with as this could cause services to stop working properly.</p>\r\n<p>Change your ARecord to 216.121.93.92 and save, and then give it up to two hours for the dns to propagate and your site should be live.</p>\r\n<p>Can\'t find what you\'re looking for?  Email us @ <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a></p>',0,'2009-11-25 16:19:14'),(15,'How do I change the name of a module?',4,'<p>With SocialCloudz you can edit the names of every feature section or feature module that we offer. You have to do this in two different places. You can change the name of a module header for instance on your home page you have an articles module and you want to change the name to whatever the articles are going to be about ie. &quot;News&quot;. </p>\r\n<p>First of all you have to login, once your logged in, you can access the module controls by rolling over the header of the module you want to edit, when the controls popup/appear, select the wrench option and the edit module popup dialog will appear. Change the title field to whatever you want, ie &quot;News&quot; and then hit save.</p>\r\n<p>Can\'t find what you\'re looking for?  Email us @ <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a></p>',0,'2009-11-26 12:30:51'),(16,'How do I change my keywords and description for search engines?',1,'<p>You must be logged first, once your logged in go to the admin menu and select general options, when this page loads you will see the boxes just under tagline where you can enter in your new description and keywords. </p>\r\n<p>When you are finished, just select save and your done.</p>\r\n<p>Can\'t find what you\'re looking for?  Email us @ <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a></p>',0,'2009-12-06 13:28:23'),(17,'How do I upload a picture to my profile?',15,'<p>First be logged in and then using your user menu on the target bar, select edit profile and then select &quot;upload&quot; under the profile image and a popup dialog will appear.&nbsp;You can use an image from your site images, or use an avatar from the provided gallery or upload a file from your computer.</p>\r\n<p>When you are finished, just select save profile and your done.</p>\r\n<p>Can\'t find what you\'re looking for?  Email us @ <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a></p>',0,'2009-12-08 09:28:01'),(18,'How do I add a photo gallery?',3,'<p>There are several ways to add photos or galleries. First you must login, then the easiest way is to go directly to a gallery and then use the actions menu you click on &quot;Add&quot; and it will take you to the new gallery add form.</p>\r\n<p>The second way is to go to the url:&nbsp;yourdomain.socialcloudz.com/gallery/main and then use the actions menu to click the add button and again you will be taken to the add gallery form.</p>\r\n<p>Thirdly you can do this by clicking this link <a href=\"/gallery/form/0\">Add Gallery</a></p>\r\n<p>Once you are looking at the form, fill out the details of your gallery, title, description, tags, choose a category or create a new one(covered in another topic) and then select your advanced options.</p>\r\n<p>Your advanced options allow you to set a future publish date and also to choose whether your gallery will allow comments and ratings as well as downloads, and access levels which we will also cover in another topic.</p>\r\n<p>Once you have entered all of your gallery details it is time to add the pictures, you have to first save the details on the form before you can add images to the gallery so hit save one time, do not refresh it will do that automatically.</p>\r\n<p>Now on the refreshed form you will see the select files and upload links in the upper right module. Use the selector to find the folder&nbsp;of files you want to upload and select as many of them as desired by using your control or cmd key(on macs) and selecting either the first and last while holding down the cntrl key or individually selecting while holding down the key.</p>\r\n<p>Next you want to choose &quot;Upload&quot; and you will see the progress bars show up for each image in the list. Once they are all finished uploading the page will refresh to another tab that will say &quot;Edit Images&quot; where you can change the orientation of the images as well as descriptions and default gallery thumb image.</p>\r\n<p>Then on the third tab you will see change order, where you can drag and drop the images into the order you want to see them appear.</p>\r\n<p>Once you have set all of the details of the newly created gallery, you can save the gallery once more, and the page will refresh to the thumbnail view of that gallery, or you can use the actions menu to select &quot;view&quot; which will do the same thing.</p>\r\n<p>And thats how you create a gallery.</p>\r\n<p>Can\'t find what you\'re looking for?  Email us @ <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a></p>',0,'2009-12-08 09:44:51'),(19,'How do I turn off the google ads on the bottom of my page (*Premium Plan N/A)',6,'<p>Right now the only way to turn on or off your banner manager service is to email support@socialcloudz.com and put banner manager in the subject line. Simply state which website your inquiring about, your email address associated with that account and simply say remove banners ads, or turn on banner manager.</p>\r\n<p>When your Banner Manager is turned on you can control what ads display and where and how many ads appear throughout your site, you also get a manager that allows you to upload ads of any size, specify what size, and then you get to place your ad using the add modules feature anywhere throughout the site or you can specify leaderboard or footer in the manager when uploading if you want them to appear there, then upload several and track how many times they were displayed and clicked.</p>',0,'2009-12-14 21:28:37'),(20,'How do I make a link with a word(s) or an image?',8,'<p>The following steps apply to the html modules in general, you can access the wysiwyg editor for the html module by logging in and then rolling over the header of an html content module on any of your pages once logged in. You will see the module controls popup when they are active and you can click on the wrench to bring up the html module wysiwyg editor. We also use wysiwyg editors on all of our main content features such as blogs, articles, links, audio, all of the main features use the editor to enter descriptions or body content.<br />\r\n<br />\r\nOnce you have accessed the editor in any section, proceed to the following steps.<br />\r\n<br />\r\nIf you start from scratch you can eliminate the chances of this happening. So to start you would clear everything, deleting all prior or hidden source code, you can check that its blank by pressing the source icon and the box switches modes to only show the backend source code.<br />\r\n<br />\r\nWhen you are sure its blank and you are starting from scratch, then switch it back to wysiwyg mode, and type a word like &quot;contact us&quot; once its typed, you can then highlight it. and use the chain icon to add the link url and set the target destination window and when you hit ok, you will see that the link is highlighted.<br />\r\n<br />\r\nTo do this with an image it is some what easier and involves less steps. So first for this tutorial clear everything again, then place the cursor where you want the image to go and then use the image icon to activate the image upload manager(fck editor).&nbsp; Once the image manager is visible, go to the upload tab, and click in the browse field to bring up your local explorer. Select the web ready image you are wanting to use, hit &quot;ok&quot; then hit &quot;send to server&quot; once its uploaded it will revert back to the image manager main tab showing a preview of the image you are adding to your acct and also it will give you the relative url of the image on your acct server. Its should look very similar to this<br />\r\n<br />\r\n<span style=\"color: rgb(51, 102, 255);\">/content/users/629/image.jpg</span><br />\r\n<br />\r\nIf you take this relative url and add your domain name to the beginning such as, <span style=\"color: rgb(51, 102, 255);\">www.mydomain.com/content/users/629/image.jpg<br />\r\n</span><br />\r\nyou can access that image from any browser, this is the actual url of it. The image manager main tab will allow you to use an actual url of an image if you are using an image hosted elsewhere on the web. For instance on an image host such as mediafire or photobucket. You would just use the url of the media, in the url field on the main tab of the image manager popup.<br />\r\n<br />\r\nAn image preview should show in the little preview window. you can set the height and width and border of the image. then proceed to the second tab to add the url link, you can add the url link all from the same manager. So once you get the image in place, uploaded or via the url, and you see the preview, go to the second tab of the image manager, and it will ask you for a url/link location. Use the whole url such as<br />\r\n<br />\r\n<span style=\"color: rgb(51, 102, 255);\">http://www.marykay.com/sarahkleckner</span><br />\r\n<br />\r\nand then use the dropdown to select the target, the target is where you want the url to open, so if you want your site to stay open when someone browses away, you have to choose &quot;new window&quot; in the taget dropdown. Otherwise if its a local link such as on your site, you could leave it blank, or choose same window. By default links will open in the same window on the same tab, so if you don\'t set it, the link when clicked will navigate the user from your page with the link to the linking url\'s web page.<br />\r\n<br />\r\nOnce you have the image and the link set, click ok, and you will see your image in the html wysiwyg editor window, now in order to verify your work, you can check the source code you just wrote by clicking the source icon once again and it will show something similar to the code below<br />\r\n<span style=\"color: rgb(51, 204, 204);\"><br />\r\n<span style=\"color: rgb(153, 153, 153);\">&lt;a href=&quot;</span><span style=\"color: rgb(51, 102, 255);\">http://www.marykay.com/sarahkleckner</span></span><span style=\"color: rgb(153, 153, 153);\">&quot; target=&quot;_blank&quot;&gt;</span><br />\r\n<span style=\"color: rgb(153, 153, 153);\">&lt;img height=&quot;80&quot; width=&quot;79&quot; src=&quot;<span style=\"color: rgb(51, 102, 255);\">/content/users/629/MaryKayLogosmal(5).jpg</span>&quot; alt=&quot;&quot; /&gt;</span><br />\r\n<span style=\"color: rgb(153, 153, 153);\">&lt;/a&gt;</span></p>\r\n<p>Click Save and your link will be saved.</p>',0,'2010-01-04 21:37:45'),(21,'What is HTML and do I need to know how to use it for the SocialCloudz site?',9,'<p>HTML&nbsp;looks like this:</p>\r\n<p>&lt;a href=&quot;http://www.marykay.com/sarahkleckner&quot; target=&quot;_blank&quot;&gt;<br />\r\n&lt;img height=&quot;80&quot; width=&quot;79&quot; src=&quot;/content/users/629/MaryKayLogosmal(5).jpg&quot; alt=&quot;&quot; /&gt;<br />\r\n&lt;/a&gt;</p>\r\n<p>and it is not necessary to know HTML to build a SocialCloudz website.&nbsp;We offer a number of premade templates and layout that you an just customize to achieve the look and feel you are looking for.</p>\r\n<p>However if you do know it you will be blessed with the ability to use it to build and tailor your website or content however you like.&nbsp;Achieving more advanced design and layout control and capbility.</p>\r\n<p>Also if you are unfamiliar with html or design in general you can contact us and we will be happy to refer you to guides where you can teach yourself or if you just want to hire someone to build your SocialCloudz site for you we can refer to you designers that specialize in using our technology.</p>',0,'2010-01-04 21:40:39'),(22,'Can I use HTML on a SocialCloudz website?',9,'<p>You can use HTML in any of our wysiwyg editors.&nbsp;The wysiwyg editor is the content editor box that shows up on the add blog or add article or link or music forms, where you can type in or add media as the main copy or body of the content you are entering. You can also use HTML in the specifically designed HTML&nbsp;modules that are available to use on any page via the add modules link in the customize tab.</p>',0,'2010-01-04 21:43:52'),(23,'How do I add an image to my html content/body?',8,'<p>You can only add an image to a wysiwyg editor module on either a content section form or an HTML module.</p>\r\n<p>place the cursor where you want the image to go and then use the image icon to activate the image upload manager(fck editor).&nbsp; Once the image manager is visible, go to the upload tab, and click in the browse field to bring up your local explorer. Select the web ready image you are wanting to use, hit &quot;ok&quot; then hit &quot;send to server&quot; once its uploaded it will revert back to the image manager main tab showing a preview of the image you are adding to your acct and also it will give you the relative url of the image on your acct server. Its should look very similar to this<br />\r\n<br />\r\n<span style=\"color: rgb(51, 102, 255);\">/content/users/629/image.jpg</span><br />\r\n<br />\r\nIf you take this relative url and add your domain name to the beginning such as, <span style=\"color: rgb(51, 102, 255);\">www.mydomain.com/content/users/629/image.jpg</span><br />\r\n<br />\r\nyou can access that image from any browser, this is the actual url of it. The image manager main tab will allow you to use an actual url of an image if you are using an image hosted elsewhere on the web. For instance on an image host such as mediafire or photobucket. You would just use the url of the media, in the url field on the main tab of the image manager popup.<br />\r\n<br />\r\nAn image preview should show in the little preview window. you can set the height and width and border of the image.</p>\r\n<p>&nbsp;</p>',0,'2010-01-04 21:48:22'),(24,'How do I make my image a link?',8,'<p>Use the second tab on the image manager popup to add the url link, you can add the url link and upload an image all from the same manager. So once you get the image in place, uploaded or via the url, and you see the preview, go to the second tab of the image manager, and it will ask you for a url/link location. Use the whole url such as<br />\r\n<br />\r\n<span style=\"color: rgb(51, 102, 255);\">http://www.marykay.com/sarahkleckner</span><br />\r\n<br />\r\nand then use the dropdown to select the target, the target is where you want the url to open, so if you want your site to stay open when someone browses away, you have to choose &quot;new window&quot; in the taget dropdown. Otherwise if its a local link such as on your site, you could leave it blank, or choose same window. By default links will open in the same window on the same tab, so if you don\'t set it, the link when clicked will navigate the user from your page with the link to the linking url\'s web page.</p>',0,'2010-01-04 21:51:13'),(25,'Where can I post media or content on a SocialCloudz website?',9,'<p>Where you can post media or content and what types of content are directly at the sole discretion of the specific site owner.&nbsp;Every SocialCloudz website comes with the capability to manage user access levels for each and every individual feature or content management section we offer independantly. So as an admin you can choose who can comment, post, view, and rate.</p>',0,'2010-01-04 21:59:55'),(26,'What are tags and categories?',9,'<p>Our content management system uses two means of organization. The cms sections display either or both of these systems to help classify media content that is being presented on a specific site. Every individual feature or content section has its own independant categories and tags. Some sites may not use them at all and some may use them heavily. Tags are basically keywords that classify and individual post into more specific groups, and categories are usually broader terms to label general aspects of a content type.</p>',0,'2010-01-04 22:11:02'),(27,'How do I change the title of a content section such as articles or blogs?',4,'<p>With SocialCloudz you can edit the names of every feature section or feature module that we offer. You have to do this in different places. The first place you can change the name would be on a feature module header for instance on your home page you have an articles module and you want to change the name to whatever the articles are going to be about ie. &quot;News&quot;. First of all you have to login, once your logged in, you can access the module controls by rolling over the header of the module you want to edit, when the controls popup/appear, select the wrench option and the edit module popup dialog will appear. Change the title field to whatever you want, ie &quot;News&quot; and then hit save.</p>\r\n<p>To change the title of a main content section, such as url yoursite.socialcloudz.com/galleries/main for photos, or links/main for links and so on for other content sections. YOu first have to login and second navigate to the page you want to visibly edit. Once you are on that page, go to the customize tab at the top, and click on the page settings link this will popup a tabbed dialog with individual page/section settings. On the first tab, you will see a text field called &quot;Title&quot;, in it you can change the main content module title text to whatever you want. Such as changing articles to news.</p>\r\n<p>Can\'t find what you\'re looking for?  Email us @ <a href=\"mailto:support@socialcloudz.com\">support@socialcloudz.com</a></p>',0,'2010-01-04 22:24:34'),(28,'How do I view a list of the modules Ive used on my site and or reuse or delete them?',1,'<p>You can access your modules on the add modules popup feature. To access the add modules panel, just navigate to the customize dropdown and then select choose modules from the first column.</p>\r\n<p>When the popup appears you see multiple tabs, the last one is always &quot;my modules&quot;. There you can see a list of the modules you are using, as well as wht pages they appear on.</p>\r\n<p>You can do one of two things from this panel, you can reuse a module by clicking the title of it while your on the page you want to add it to, or you can delete a module on any page in your site, if you delete a module from the my modules list, you will delete it for good from the whole site everywhere it appears.</p>\r\n<p>There is a warning dialog when you go to delete these modules so be careful because you can\'t get them back.</p>',0,'2010-02-03 12:36:58');
/*!40000 ALTER TABLE `helpTopics` ENABLE KEYS */;

/*!40000 ALTER TABLE `list` DISABLE KEYS */;
INSERT INTO `list` VALUES (1,'events','type','Anniversary',0),(2,'events','type','Birthday',0),(3,'events','type','Concert',0),(4,'events','type','Holiday',0);
/*!40000 ALTER TABLE `list` ENABLE KEYS */;

/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (1,'Trial',1073741824,536870912,'\0','\0','',''),(2,'Individual',10737418240,5368709120,'','\0','',''),(3,'Small Business',26843545600,10737418240,'','','\0',''),(4,'Enterprise / Custom',64424509440,21474836480,'','','\0','');
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;

/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Basic','9.99',2,'Plan','',0,1,1),(3,'Social','24.99',3,'Plan',NULL,NULL,1,1),(5,'Business','99.99',4,'Plan',NULL,NULL,1,1),(9,'10GB Additional Bandwidth','5.00',0,'Add-on','Bandwidth',10737418240,1,0),(11,'Ad Control ','10.00',0,'Premium','Ads',1,1,0),(12,'Remove Branding ','5.00',0,'Premium','Branding',1,1,0),(16,'10GB Additional Storage','5.00',0,'Add-on','Storage',10737418240,1,0),(18,'Mass Email Marketing','20.00',0,'Premium','Massmail',1,1,0),(19,'Trial','0.00',1,'Plan',NULL,NULL,1,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;


USE `statistics`;

/*!40000 ALTER TABLE `bots` DISABLE KEYS */;
INSERT INTO `bots` VALUES (2,'2009-04-06 15:03:35','BaiDuSpider  '),(3,'2009-04-06 15:03:39','Baiduspider+(+http://help.baidu.jp/system/05.html)  '),(4,'2009-04-06 15:03:44','Baiduspider+(+http://www.baidu.com/search/spider.htm)  '),(5,'2009-04-06 15:03:49','Baiduspider+(+http://www.baidu.com/search/spider_jp.html)  '),(6,'2009-04-06 15:04:24','Googlebot-Image/1.0  '),(7,'2009-04-06 15:04:31','Googlebot-Image/1.0 ( http://www.googlebot.com/bot.html) '),(8,'2009-04-06 15:04:44','Googlebot/2.1 ( http://www.google.com/bot.html)'),(9,'2009-04-06 15:04:52','Googlebot/2.1 ( http://www.googlebot.com/bot.html)'),(10,'2009-04-06 15:06:48','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'),(11,'2009-04-06 20:09:28','Mozilla/5.0 (compatible; Yahoo! Slurp/3.0; http://help.yahoo.com/help/us/ysearch/slurp)'),(12,'2009-04-10 07:39:42','msnbot/1.1 (+http://search.msn.com/msnbot.htm)'),(13,'2009-04-23 08:20:55','Mediapartners-Google'),(14,'2009-04-23 08:21:16','Mozilla/5.0 (compatible; askpeter_bot/5.0; +http://www.askpeter.info)'),(15,'2009-04-25 08:10:41','Gaisbot/3.0+(robot06@gais.cs.ccu.edu.tw;+http://gais.cs.ccu.edu.tw/robot.php)'),(16,'2009-05-14 10:01:55','Mozilla/5.0 (Twiceler-0.9 http://www.cuil.com/twiceler/robot.html)'),(17,'2009-05-19 11:33:51','Mozilla/5.0 (compatible; Googlebot/2.1; http://www.google.com/bot.html)'),(18,'2009-05-20 11:51:42','Twiceler-0.9 http://www.cuil.com/twiceler/robot.html'),(19,'2009-08-08 07:23:32','msnbot/2.0b (+http://search.msn.com/msnbot.htm)'),(20,'2009-08-18 19:08:05','MLBot (www.metadatalabs.com/mlbot)'),(21,'2009-09-25 05:41:04','nutch.biz/Nutch-1.0 (nutch.biz; crawler@nutch.biz)'),(22,'2009-09-25 05:41:04','Mediapartners-Google'),(23,'2009-09-25 05:41:04','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'),(24,'2009-10-02 06:24:47','bitlybot'),(25,'2009-10-02 06:24:56','Mozilla/5.0 (compatible; MSIE 6.0b; Windows NT 5.0) Gecko/2009011913 Firefox/3.0.6 TweetmemeBot'),(26,'2009-10-02 06:25:15','Mozilla/5.0 (compatible; discobot/1.1; +http://discoveryengine.com/discobot.html)'),(27,'2009-10-02 06:25:22','Feedfetcher-Google; (+http://www.google.com/feedfetcher.html; feed-id=11371582789469634252)'),(28,'2009-10-02 06:25:30','Yandex/1.01.001 (compatible; Win16; I)'),(29,'2009-10-02 06:25:38','Mozilla/5.0 (compatible; Tagoobot/3.0; +http://www.tagoo.ru)'),(30,'2010-08-20 00:00:00','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'),(31,'2010-08-28 04:37:19','CyberPatrol SiteCat Webbot (http://www.cyberpatrol.com/cyberpatrolcrawler.asp)');
/*!40000 ALTER TABLE `bots` ENABLE KEYS */;




use `contentstore`;
INSERT INTO `contenttype` VALUES ('Article','Article','/article/detail/','contentID','/article/main/','text','',0),('Blog','Blog','/blog/detail/','contentID','/blog/main/','text','',0),('DJChart','DJCharts','/djchart/detail','contentID','/djchart/main/','chart',NULL,0),('Document','Document','/document/detail/','contentID','/document/main/','file',NULL,0),('domestic','US Ministries','/domestic/detail','contentID','/domestic/main/','text',NULL,133),('Event','Event','/event/detail/','contentID','/event/main/','calendar','',0),('gallery','Gallery','/gallery/detail/','contentID','/gallery/main/','image','',0),('Group','Groups','/group/detail/','contentID','/group/main/','text','',0),('international','International Ministries','/international/detail','contentID','/international/main','text',NULL,133),('knowledgebase','KnowledgeBase','/knowledgebase/detail/','parentID','/knowledgebase/main/','text','',0),('Link','Link','','attribute_link','/link/main/','text','',0),('Location','Location','/location/detail','contentID','/location/main/','text','',0),('Music','Album','/music/detail/','contentID','/music/main/','image','',0),('Photo','Photo','/gallery/detail/','contentID','/gallery/main/','image','gallery',0),('Property','Properties','/property/detail/','contentID','/property/main/','image','',0),('PropertyThumbnail','Property Thumbnail','/property/detail/','contentID','/property/main/','image','Property',0),('Restaurant','Restaurant','/restaurant/detail/','contentID','/restaurant/main/','text',NULL,0),('Song','Song','/music/detail/','parentID','/music/main/','image','music',0),('Video','Video','/video/detail/','contentID','/video/main/','image','',0);

/*!40000 ALTER TABLE `UISettings` DISABLE KEYS */;
INSERT INTO `UISettings` VALUES (1,'article','template_preview','template_detail','frm_addText',0,'foot_pagination','foot_share','foot_blank','Categories,Archives,Related,TagCloud','MediaDetails,Related,Share','frm_addImage,frm_addTags,frm_addCategories,frm_advanced',NULL,'',NULL,NULL,NULL,NULL,'/article/detail/[contentID]',NULL),(2,'Blog','template_preview','template_detail','frm_addText',0,'foot_pagination','foot_share','foot_blank','Categories,Archives,Related,TagCloud','MediaDetails,Related,Share','frm_addImage,frm_addTags,frm_addCategories,frm_advanced',NULL,'',NULL,NULL,NULL,NULL,'/blog/detail/[contentID]',NULL),(3,'event','template_eventList','template_eventDetail','frm_addEvent',0,'foot_pagination','foot_share','foot_blank','Categories,LocationSearch,Archives','MediaDetails,share,RSVP','frm_addImage,frm_addStartEndDate,frm_addLocation,frm_addCategories,frm_advanced',NULL,'',NULL,NULL,'contentStore.recurEvent',NULL,'/event/detail/[contentID]',NULL),(4,'gallery','template_thumbnail','template_gallery','frm_addPhotos',0,'foot_pagination','foot_paginationChild','foot_blank','Categories,related,Tagcloud','MediaDetails,Related,Share','frm_addTags,frm_addCategories,frm_advanced','frm_managePhotos','foot_blank',NULL,NULL,NULL,'uploadGalleryPhoto.cfm','/gallery/form/[contentID]#tabs-2','sort_photos'),(6,'Link','template_links',NULL,'frm_addLink',0,'foot_pagination','','foot_blank','Categories','','frm_addCategories,frm_advanced',NULL,'',NULL,NULL,NULL,NULL,'/link/main/',NULL),(7,'Music','template_musicList','template_musicDetail','frm_addMusic',0,'foot_pagination','foot_share','foot_blank','Categories,TagCloud','MediaDetails,Related,Share','frm_addImage,frm_addTags,frm_addCategories,frm_advanced','frm_manageSongs','foot_blank',NULL,NULL,NULL,'uploadAlbumSong.cfm','/music/form/[contentID]#tabs-2',NULL),(8,'video','template_thumbnail','template_video','frm_addVideo',0,'foot_pagination','foot_share','foot_blank','Categories,TagCloud','MediaDetails,EmbedVideo,Related,Share','frm_addTags,frm_addCategories,frm_advanced',NULL,'',NULL,'utils.heywatch',NULL,NULL,'/video/main?memberID=[memberID]',NULL),(9,'Photo',NULL,'template_photo',NULL,0,NULL,'foot_share',NULL,'','MediaDetails,EmbedPhoto,Related,Share','',NULL,'',NULL,NULL,NULL,NULL,'',NULL),(10,'property','template_previewProperty','template_detailProperty','frm_addProperty',0,'foot_pagination','foot_share','foot_blank','LocationSearch,Related,TagCloud','MediaDetails,Related,Share','frm_addLocation,frm_addTags,frm_addCategories,frm_advanced','frm_manageProperties','foot_blank',NULL,NULL,NULL,'uploadPropertyPhoto.cfm','/property/form/[contentID]',NULL),(11,'knowledgebase','template_list','template_detail','frm_addText',0,'foot_blank','foot_share','foot_blank','Categories,Related,Archives,TagCloud','MediaDetails,Related,Share','frm_addImage,frm_addTags,frm_addCategories,frm_advanced','frm_manageKnowledgebase','foot_blank',NULL,NULL,NULL,NULL,'/knowledgebase/detail/[contentID]',NULL),(12,'group','template_preview','template_detail','frm_addTextSubtitle',0,'foot_pagination','foot_share','foot_blank','Categories,TagCloud','MediaDetails,Members','frm_addImage,frm_addTags,frm_addCategories,frm_advanced','',NULL,NULL,NULL,'groups.create',NULL,'/group/detail/[contentID]',NULL),(13,'document','template_filelist','template_detailFile','frm_addText',0,'foot_pagination','foot_share','foot_blank','Categories,Archives,TagCloud','MediaDetails,Related,Share','frm_addFile,frm_addTags,frm_addCategories,frm_advanced','',NULL,NULL,'utils.fileTypeIcon',NULL,NULL,'/document/detail/[contentID]',NULL),(14,'video','template_preview2UP','template_video','frm_addVideo',3,'foot_pagination','foot_share','foot_blank','Categories,TagCloud','MediaDetails,EmbedVideo,Related,Share','frm_addImage,frm_addTags,frm_addCategories,frm_advanced','','','','utils.heywatch','','','/video/main?memberID=[memberID]',''),(15,'video','template_preview2UP','template_video','frm_addVideo',133,'foot_pagination','foot_share','foot_blank','Categories,TagCloud','MediaDetails,EmbedVideo,Related,Share','frm_addTags,frm_addCategories,frm_advanced','','','','utils.heywatch','','','/video/main?memberID=[memberID]',''),(16,'location','template_previewLocation','template_location','frm_addText',0,'foot_pagination','foot_share','foot_blank','LocationSearch','MediaDetails,Related,Share','frm_addImage,frm_addLocation,frm_addCategories','',NULL,NULL,NULL,NULL,NULL,'/location/detail/[contentID]',NULL),(17,'domestic','template_previewLocation_133a','template_location','frm_addText',133,'foot_pagination','foot_share','foot_blank','LocationSearch','MediaDetails,Related,Share','frm_addImage,frm_addLocation,frm_addCategories','','','','','','','/domestic/detail/[contentID]',''),(18,'international','template_previewLocation_133b','template_location','frm_addText',133,'foot_pagination','foot_share','foot_blank','Categories','MediaDetails,Related,Share','frm_addImage,frm_addLocation,frm_addCategories','','','','','','','/international/detail/[contentID]',''),(19,'djchart','template_preview','template_djChart','frm_addDJChart',0,'foot_pagination','foot_blank','foot_blank','Categories,Archives','MediaDetails,Share,Related','frm_addCategories,frm_advanced',NULL,NULL,NULL,NULL,NULL,NULL,'/djchart/detail/[contentID]',NULL),(20,'restaurant','template_previewRestaurant','template_restaurant','frm_addRestaurant',0,'foot_pagination','foot_blank','foot_blank','Map,LocationSearch,Categories,TagCloud','Map,Related,Share','frm_addImage,frm_addLocation,frm_addCategories',NULL,NULL,NULL,NULL,NULL,NULL,'/restaurant/detail/[contentID]',NULL);
/*!40000 ALTER TABLE `UISettings` ENABLE KEYS */;
