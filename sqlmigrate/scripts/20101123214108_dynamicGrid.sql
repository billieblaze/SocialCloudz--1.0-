--// dynamicGrid
-- Migration SQL that makes the change goes here.
CREATE TABLE socialcloudz.`dynamicGridColumns` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `gridName` varchar(45) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `hidden` bit(1) DEFAULT NULL,
  `viewName` varchar(45) DEFAULT NULL,
  `colOrder` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `pid` varchar(20) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL,
  `formatter` varchar(100) DEFAULT NULL,
  `key` bit(1) DEFAULT NULL,
  `classes` varchar(45) DEFAULT NULL,
  `align` varchar(45) DEFAULT NULL,
  `hideDlg` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=468 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dynamicGridColumns`
--

LOCK TABLES socialcloudz.`dynamicGridColumns` WRITE;
/*!40000 ALTER TABLE `dynamicGridColumns` DISABLE KEYS */;
INSERT INTO socialcloudz.`dynamicGridColumns` VALUES (369,'emailMarketing','MESSAGE','','default',3,100,NULL,'MESSAGE','','\0','','left','\0'),(370,'emailMarketing','CREATEDON','\0','default',1,150,NULL,'CREATEDON','','\0','','left','\0'),(371,'emailMarketing','MEMBERID','','default',5,98,NULL,'MEMBERID','','\0','','left','\0'),(372,'contentCategories','COUNT','','default',2,50,'','COUNT','','\0','','left','\0'),(373,'contentCategories','CATEGORY','\0','default',4,50,'','CATEGORY','','\0','','left','\0'),(366,'emailMarketing','MESSAGEID','\0','default',0,154,NULL,'MESSAGEID','linkFormat','\0',NULL,'left','\0'),(367,'emailMarketing','SUBJECT','\0','default',4,204,NULL,'SUBJECT','','\0','','left','\0'),(368,'emailMarketing','COMMUNITYID','','default',2,100,NULL,'COMMUNITYID','','\0','','left','\0'),(365,'emailTemplates','SUBJECT','','default',9,67,NULL,'SUBJECT','','\0','','left','\0'),(363,'emailTemplates','BCC','','default',7,67,NULL,'BCC','','\0','','left','\0'),(364,'emailTemplates','NOTE','','default',8,67,NULL,'NOTE','','\0','','left','\0'),(362,'emailTemplates','BODY','','default',6,67,NULL,'BODY','','\0','','left','\0'),(360,'emailTemplates','ACTION','','default',4,67,NULL,'ACTION','','\0','','left','\0'),(361,'emailTemplates','COMMUNITYID','','default',5,67,NULL,'COMMUNITYID','','\0','','left','\0'),(359,'emailTemplates','CC','','default',3,67,NULL,'CC','','\0','','left','\0'),(358,'emailTemplates','EDITABLE','','default',2,67,NULL,'EDITABLE','','\0','','left','\0'),(354,'messageList','REPLIED','','default',6,46,NULL,'REPLIED','','\0','','left','\0'),(355,'messageList','ID','\0','default',1,95,NULL,'ID','checkFormatter','','copy','left','\0'),(356,'emailTemplates','NAME','\0','default',1,355,NULL,'NAME','templateFormatter','\0',NULL,'left','\0'),(357,'emailTemplates','ID','\0','default',0,106,NULL,'ID',NULL,'',NULL,'left','\0'),(353,'messageList','DATEREAD','','default',5,46,NULL,'DATEREAD','','\0','','left','\0'),(352,'messageList','DATECREATED','\0','default',4,131,NULL,'DATECREATED','','\0','','left','\0'),(349,'messageList','SUBJECT','\0','default',7,130,NULL,'SUBJECT','linkFormatter','\0',NULL,'left','\0'),(350,'messageList','SOURCEID','\0','default',2,131,NULL,'SOURCEID','imgFormatter','\0',NULL,'left','\0'),(351,'messageList','READ','','default',3,46,NULL,'READ','','\0','','left','\0'),(348,'messageList','TARGETID','','default',0,46,NULL,'TARGETID','','\0','','left','\0'),(346,'memberInvite','LANDINGPAGE','','default',9,60,NULL,'LANDINGPAGE','','\0','','left','\0'),(347,'memberInvite','INVITATIONCODE','','default',3,105,NULL,'INVITATIONCODE','','\0','','left','\0'),(343,'memberInvite','COMMUNITYID','','default',6,60,NULL,'COMMUNITYID','','\0','','left','\0'),(345,'memberInvite','EMAIL','','default',4,97,NULL,'EMAIL','','\0','','left','\0'),(344,'memberInvite','MEMBERID','','default',7,60,NULL,'MEMBERID','','\0','','left','\0'),(342,'memberInvite','MEMBERS','\0','default',10,146,NULL,'MEMBERS',NULL,'\0',NULL,'center','\0'),(336,'communityAdmin','COMMUNITYID','\0','default',41,245,NULL,'COMMUNITYID','actionFormatter',NULL,'copy','left',NULL),(335,'communityAdmin','NUMLOGINS','\0','default',38,98,NULL,'NUMLOGINS',NULL,NULL,NULL,NULL,NULL),(334,'communityAdmin','LASTCLICK','\0','default',14,200,NULL,'LASTCLICK',NULL,NULL,NULL,NULL,NULL),(341,'memberInvite','CAMPAIGN','','default',5,97,NULL,'CAMPAIGN','','\0','','left','\0'),(337,'memberInvite','IDSTRING','','default',0,60,NULL,'IDSTRING','','\0','','left','\0'),(331,'communityAdmin','STATE','','default',43,-5,NULL,'STATE',NULL,'\0','','left','\0'),(328,'communityAdmin','INVISIBLE','','default',40,79,NULL,'INVISIBLE',NULL,'\0','','left','\0'),(338,'memberInvite','VISITORS','\0','default',8,153,NULL,'VISITORS',NULL,'\0',NULL,'center','\0'),(330,'communityAdmin','GENDER','','default',42,10,NULL,'GENDER',NULL,'\0','','left','\0'),(142,'cmsAdmin','COMMUNITYID','','default',2,74,'','COMMUNITYID','','\0','','left','\0'),(145,'cmsAdmin','URL','\0','default',5,182,'','URL','','\0','','left','\0'),(146,'cmsAdmin','DATEUPDATED','','default',6,74,'','DATEUPDATED','','\0','','left','\0'),(147,'cmsAdmin','DESCRIPTION','\0','default',7,182,'','DESCRIPTION','','\0','','left','\0'),(144,'cmsAdmin','DATECREATED','','default',4,74,'','DATECREATED','','\0','','left','\0'),(140,'cmsAdmin','ID','\0','default',0,62,'',' ','viewPage','\0','copy','center','\0'),(143,'cmsAdmin','TITLE','\0','default',3,182,'','TITLE','','\0','','left','\0'),(105,'visitors','LOCATION','\0','default',1,50,'','LOCATION','','\0','','left','\0'),(106,'visitors','FIRSTPAGE','\0','default',2,50,'','FIRSTPAGE','','\0','','left','\0'),(107,'visitors','IPADDRESS','\0','default',3,50,'','IPADDRESS','','\0','','left','\0'),(108,'visitors','REGION','\0','default',4,50,'','REGION','','\0','','left','\0'),(109,'visitors','STARTPAGE','\0','default',5,50,'','STARTPAGE','','\0','','left','\0'),(110,'visitors','PAGECOUNT','\0','default',6,50,'','PAGECOUNT','','\0','','left','\0'),(111,'visitors','TOKEN','\0','default',7,50,'','TOKEN','','\0','','left','\0'),(112,'visitors','VISITORID','\0','default',8,50,'','VISITORID','','\0','','left','\0'),(113,'visitors','COMMUNITYID','\0','default',9,50,'','COMMUNITYID','','\0','','left','\0'),(114,'visitors','ISBOT','\0','default',10,50,'','ISBOT','','\0','','left','\0'),(115,'visitors','DATEUPDATED','\0','default',11,50,'','DATEUPDATED','','\0','','left','\0'),(116,'visitors','REFERER','\0','default',12,50,'','REFERER','','\0','','left','\0'),(117,'visitors','DATEENTERED','\0','default',13,50,'','DATEENTERED','','\0','','left','\0'),(118,'visitors','LASTPAGE','\0','default',14,50,'','LASTPAGE','','\0','','left','\0'),(119,'visitors','CITY','\0','default',15,50,'','CITY','','\0','','left','\0'),(120,'visitors','EXITPAGE','\0','default',16,50,'','EXITPAGE','','\0','','left','\0'),(121,'visitors','COUNTRYCODE','\0','default',17,50,'','COUNTRYCODE','','\0','','left','\0'),(122,'visitors','BROWSER','\0','default',18,50,'','BROWSER','','\0','','left','\0'),(123,'visitors','MEMBERID','\0','default',19,50,'','MEMBERID','','\0','','left','\0'),(141,'cmsAdmin','KEYWORDS','','default',1,74,'','KEYWORDS','','\0','','left','\0'),(392,'contentAdmin','LINKID','','default',16,10,NULL,'LINKID','','\0','','left','\0'),(391,'contentAdmin','CREATOR','','default',15,10,NULL,'CREATOR','','\0','','left','\0'),(390,'contentAdmin','APPROVED','\0','default',31,10,NULL,'APPROVED','approvalFormat','\0',NULL,'left','\0'),(389,'contentAdmin','FEATURED','','default',13,10,NULL,'FEATURED','','\0','','left','\0'),(301,'communityAdmin','SIGNUPCOMPLETE','','default',13,15,NULL,'SIGNUPCOMPLETE',NULL,'\0','','left','\0'),(340,'memberInvite','DATEENTERED','\0','default',2,406,NULL,'Invite','inviteFormat','\0','copy','left','\0'),(303,'communityAdmin','ONLINE','','default',15,15,NULL,'ONLINE',NULL,'\0','','left','\0'),(304,'communityAdmin','IMAGE','','default',16,207,NULL,'IMAGE',NULL,'\0','','left','\0'),(305,'communityAdmin','DNSMASK','','default',17,15,NULL,'DNSMASK',NULL,'\0','','left','\0'),(306,'communityAdmin','ZIP','','default',18,15,NULL,'ZIP',NULL,'\0','','left','\0'),(307,'communityAdmin','DOMAIN','','default',19,79,NULL,'DOMAIN',NULL,'\0','','left','\0'),(308,'communityAdmin','BASEURL','','default',20,79,NULL,'BASEURL',NULL,'\0','','left','\0'),(309,'communityAdmin','EMAIL','','default',21,15,NULL,'EMAIL',NULL,'\0','','left','\0'),(310,'communityAdmin','HEARDABOUT','','default',22,15,NULL,'HEARDABOUT',NULL,'\0','','left','\0'),(311,'communityAdmin','MAILBOUNCE','','default',23,15,NULL,'MAILBOUNCE',NULL,'\0','','left','\0'),(312,'communityAdmin','BIRTHDATE','','default',24,15,NULL,'BIRTHDATE',NULL,'\0','','left','\0'),(313,'communityAdmin','NEWSLETTER','','default',25,15,NULL,'NEWSLETTER',NULL,'\0','','left','\0'),(314,'communityAdmin','STATUS','','default',26,15,NULL,'STATUS',NULL,'\0','','left','\0'),(315,'communityAdmin','LASTNAME','','default',27,15,NULL,'LASTNAME',NULL,'\0','','left','\0'),(316,'communityAdmin','PASSWORD','','default',28,15,NULL,'PASSWORD',NULL,'\0','','left','\0'),(317,'communityAdmin','USERNAME','','default',29,15,NULL,'USERNAME',NULL,'\0','','left','\0'),(318,'communityAdmin','BANNED','','default',30,79,NULL,'BANNED',NULL,'\0','','left','\0'),(319,'communityAdmin','DATEENTERED','','default',31,15,NULL,'DATEENTERED',NULL,'\0','','left','\0'),(320,'communityAdmin','SUBDOMAIN','','default',32,15,NULL,'SUBDOMAIN',NULL,'\0','','left','\0'),(321,'communityAdmin','COUNTRY','','default',33,15,NULL,'COUNTRY',NULL,'\0','','left','\0'),(322,'communityAdmin','REMOVED','','default',34,79,NULL,'REMOVED',NULL,'\0','','left','\0'),(323,'communityAdmin','LONGITUDE','','default',35,15,NULL,'LONGITUDE',NULL,'\0','','left','\0'),(324,'communityAdmin','FLAGGED','','default',36,15,NULL,'FLAGGED',NULL,'\0','','left','\0'),(325,'communityAdmin','GLOBALADMIN','','default',37,15,NULL,'GLOBALADMIN',NULL,'\0','','left','\0'),(339,'memberInvite','ID','','default',1,97,NULL,'ID','','\0','','left','\0'),(327,'communityAdmin','FIRSTNAME','','default',39,15,NULL,'FIRSTNAME',NULL,'\0','','left','\0'),(388,'contentAdmin','CITY','','default',12,10,NULL,'CITY','','\0','','left','\0'),(387,'contentAdmin','FAVORITECOUNT','','default',11,10,NULL,'FAVORITECOUNT','','\0','','left','\0'),(386,'contentAdmin','STARTDATE','','default',10,10,NULL,'STARTDATE','','\0','','left','\0'),(385,'contentAdmin','ISFAVORITE','','default',9,10,NULL,'ISFAVORITE','','\0','','left','\0'),(384,'contentAdmin','PHONE','','default',8,10,NULL,'PHONE','','\0','','left','\0'),(383,'contentAdmin','LATITUDE','','default',7,10,NULL,'LATITUDE','','\0','','left','\0'),(382,'contentAdmin','DOWNLOAD','','default',6,10,NULL,'DOWNLOAD','','\0','','left','\0'),(381,'contentAdmin','VENUE','','default',5,10,NULL,'VENUE','','\0','','left','\0'),(380,'contentAdmin','HOMELINK','','default',4,10,NULL,'HOMELINK','','\0','','left','\0'),(379,'contentAdmin','MEMBERID','\0','default',26,10,NULL,'MEMBERID','userFmatter','\0',NULL,'left','\0'),(378,'contentAdmin','COMMENTS','','default',2,10,NULL,'COMMENTS','','\0','','left','\0'),(377,'contentAdmin','IMAGE','','default',1,10,NULL,'IMAGE','','\0','','left','\0'),(376,'contentAdmin','VIEWS','','default',0,10,NULL,'VIEWS','','\0','','left','\0'),(375,'contentCategories','ID','\0','default',1,50,'','ID','categoryCheckbox','\0','','left','\0'),(299,'communityAdmin','CITY','','default',11,15,NULL,'CITY',NULL,'\0','','left','\0'),(300,'communityAdmin','APPROVED','','default',12,15,NULL,'APPROVED',NULL,'\0','','left','\0'),(298,'communityAdmin','FEATURED','','default',10,15,NULL,'FEATURED',NULL,'\0','','left','\0'),(296,'communityAdmin','CELLPHONE','','default',8,15,NULL,'CELLPHONE',NULL,'\0','','left','\0'),(374,'contentCategories','HOMELINK','','default',3,50,'','HOMELINK','','\0','','left','\0'),(297,'communityAdmin','ACCESSLEVEL','\0','default',9,98,NULL,'ACCESSLEVEL','accessFormatter','\0',NULL,'left','\0'),(295,'communityAdmin','PROFILEVIEWS','','default',7,15,NULL,'PROFILEVIEWS',NULL,'\0','','left','\0'),(294,'communityAdmin','CELLPROVIDER','','default',6,15,NULL,'CELLPROVIDER',NULL,'\0','','left','\0'),(293,'communityAdmin','TIMEZONE','','default',5,15,NULL,'TIMEZONE',NULL,'\0','','left','\0'),(292,'communityAdmin','HTMLMAIL','','default',4,15,NULL,'HTMLMAIL',NULL,'\0','','left','\0'),(291,'communityAdmin','IDLE','','default',3,15,NULL,'IDLE',NULL,'\0','','left','\0'),(290,'communityAdmin','LATITUDE','','default',2,15,NULL,'LATITUDE',NULL,'\0','','left','\0'),(289,'communityAdmin','MEMBERID','','default',1,15,NULL,'MEMBERID',NULL,'\0','','left','\0'),(288,'communityAdmin','SITE','\0','default',0,194,NULL,'SITE','communityFormatter','\0','','left','\0'),(393,'contentAdmin','CATEGORIES','','default',17,10,NULL,'CATEGORIES','','\0','','left','\0'),(394,'contentAdmin','PUBLISHDATE','','default',18,10,NULL,'PUBLISHDATE','','\0','','left','\0'),(395,'contentAdmin','CONTENTTYPE','\0','default',19,10,NULL,'CONTENTTYPE','','\0','','left','\0'),(396,'contentAdmin','SUBTITLE','','default',20,10,NULL,'SUBTITLE','','\0','','left','\0'),(397,'contentAdmin','SORTORDER','','default',21,10,NULL,'SORTORDER','','\0','','left','\0'),(398,'contentAdmin','TAGS','','default',22,10,NULL,'TAGS','','\0','','left','\0'),(399,'contentAdmin','ISDELETED','','default',23,10,NULL,'ISDELETED','','\0','','left','\0'),(400,'contentAdmin','ENDDATE','','default',24,10,NULL,'ENDDATE','','\0','','left','\0'),(401,'contentAdmin','PARENTID','','default',25,10,NULL,'PARENTID','','\0','','left','\0'),(402,'contentAdmin','TITLE','\0','default',14,10,NULL,'TITLE','titleFmatter','\0',NULL,'left','\0'),(403,'contentAdmin','EXPLICIT','','default',27,10,NULL,'EXPLICIT','','\0','','left','\0'),(404,'contentAdmin','PRIVATE','','default',28,10,NULL,'PRIVATE','','\0','','left','\0'),(405,'contentAdmin','COMMENTCOUNT','','default',29,10,NULL,'COMMENTCOUNT','','\0','','left','\0'),(406,'contentAdmin','CHILDCOUNT','','default',30,10,NULL,'CHILDCOUNT','','\0','','left','\0'),(407,'contentAdmin','CONTENTID','\0','default',3,10,NULL,'CONTENTID','photoFmatter','\0',NULL,'left','\0'),(408,'contentAdmin','COUNTRY','','default',32,10,NULL,'COUNTRY','','\0','','left','\0'),(409,'contentAdmin','RATING','','default',33,10,NULL,'RATING','','\0','','left','\0'),(410,'contentAdmin','DESC','','default',34,10,NULL,'DESC','','\0','','left','\0'),(411,'contentAdmin','LONGITUDE','','default',35,10,NULL,'LONGITUDE','','\0','','left','\0'),(412,'contentAdmin','FLAGGED','\0','default',36,10,NULL,'FLAGGED','flagFormat','\0',NULL,'left','\0'),(413,'contentAdmin','ATTRIBS','','default',37,10,NULL,'ATTRIBS','','\0','','left','\0'),(414,'contentAdmin','ADDRESS','','default',38,10,NULL,'ADDRESS','','\0','','left','\0'),(415,'contentAdmin','ZIPCODE','','default',39,10,NULL,'ZIPCODE','','\0','','left','\0'),(416,'contentAdmin','RATINGAVERAGE','','default',40,10,NULL,'RATINGAVERAGE','','\0','','left','\0'),(417,'contentAdmin','DATECREATED','','default',41,10,NULL,'DATECREATED','','\0','','left','\0'),(418,'contentAdmin','STATE','','default',42,10,NULL,'STATE','','\0','','left','\0'),(419,'contentAdmin','TYPE','','default',43,25,NULL,'TYPE','','\0','','left','\0'),(420,'memberAdmin','IMAGE','\0','default',0,85,NULL,'IMAGE','photoFmatter','\0',NULL,'left','\0'),(421,'memberAdmin','MEMBERID','','default',32,83,NULL,'MEMBERID','','\0','','left','\0'),(422,'memberAdmin','LATITUDE','','default',2,11,NULL,'LATITUDE','','\0','','left','\0'),(423,'memberAdmin','IDLE','','default',3,11,NULL,'IDLE','','\0','','left','\0'),(424,'memberAdmin','HTMLMAIL','','default',4,11,NULL,'HTMLMAIL','','\0','','left','\0'),(425,'memberAdmin','TIMEZONE','','default',5,11,NULL,'TIMEZONE','','\0','','left','\0'),(426,'memberAdmin','CELLPROVIDER','','default',6,11,NULL,'CELLPROVIDER','','\0','','left','\0'),(427,'memberAdmin','PROFILEVIEWS','','default',7,11,NULL,'PROFILEVIEWS','','\0','','left','\0'),(428,'memberAdmin','CELLPHONE','','default',8,11,NULL,'CELLPHONE','','\0','','left','\0'),(429,'memberAdmin','FEATURED','','default',9,11,NULL,'FEATURED','','\0','','left','\0'),(430,'memberAdmin','CITY','','default',10,11,NULL,'CITY','','\0','','left','\0'),(431,'memberAdmin','APPROVED','\0','default',16,85,NULL,'APPROVED','yesNoFormat','\0',NULL,'left','\0'),(432,'memberAdmin','SIGNUPCOMPLETE','','default',12,11,NULL,'SIGNUPCOMPLETE','','\0','','left','\0'),(433,'memberAdmin','ONLINE','','default',13,11,NULL,'ONLINE','','\0','','left','\0'),(434,'memberAdmin','LASTCLICK','','default',14,11,NULL,'LASTCLICK','','\0','','left','\0'),(435,'memberAdmin','ZIP','','default',15,11,NULL,'ZIP','','\0','','left','\0'),(436,'memberAdmin','BANNED','\0','default',30,85,NULL,'BANNED','yesNoFormat','\0',NULL,'left','\0'),(437,'memberAdmin','REMOVED','','default',17,11,NULL,'REMOVED','','\0','','left','\0'),(438,'memberAdmin','EMAIL','','default',18,11,NULL,'EMAIL','','\0','','left','\0'),(439,'memberAdmin','HEARDABOUT','','default',19,11,NULL,'HEARDABOUT','','\0','','left','\0'),(440,'memberAdmin','MAILBOUNCE','','default',20,11,NULL,'MAILBOUNCE','','\0','','left','\0'),(441,'memberAdmin','BIRTHDATE','','default',21,11,NULL,'BIRTHDATE','','\0','','left','\0'),(442,'memberAdmin','STATUS','','default',22,11,NULL,'STATUS','','\0','','left','\0'),(443,'memberAdmin','LASTNAME','','default',23,11,NULL,'LASTNAME','','\0','','left','\0'),(444,'memberAdmin','NEWSLETTER','','default',24,11,NULL,'NEWSLETTER','','\0','','left','\0'),(445,'memberAdmin','PASSWORD','','default',25,11,NULL,'PASSWORD','','\0','','left','\0'),(446,'memberAdmin','USERNAME','\0','default',1,85,NULL,'USERNAME','userFmatter','\0',NULL,'left','\0'),(447,'memberAdmin','NUMLOGINS','','default',27,11,NULL,'NUMLOGINS','','\0','','left','\0'),(448,'memberAdmin','DATEENTERED','','default',28,11,NULL,'DATEENTERED','','\0','','left','\0'),(449,'memberAdmin','COUNTRY','','default',29,11,NULL,'COUNTRY','','\0','','left','\0'),(450,'memberAdmin','ACCESSLEVEL','\0','default',11,85,NULL,'ACCESSLEVEL','accessFormat','\0',NULL,'left','\0'),(451,'memberAdmin','LONGITUDE','','default',31,11,NULL,'LONGITUDE','','\0','','left','\0'),(452,'memberAdmin','FLAGGED','\0','default',26,85,NULL,'FLAGGED','yesNoFormat','\0',NULL,'left','\0'),(453,'memberAdmin','GLOBALADMIN','','default',33,11,NULL,'GLOBALADMIN','','\0','','left','\0'),(454,'memberAdmin','INVISIBLE','','default',34,11,NULL,'INVISIBLE','','\0','','left','\0'),(455,'memberAdmin','FIRSTNAME','','default',35,11,NULL,'FIRSTNAME','','\0','','left','\0'),(456,'memberAdmin','COMMUNITYID','','default',36,11,NULL,'COMMUNITYID','','\0','','left','\0'),(457,'memberAdmin','GENDER','','default',37,11,NULL,'GENDER','','\0','','left','\0'),(458,'memberAdmin','STATE','','default',38,15,NULL,'STATE','','\0','','left','\0'),(459,'announcements','ID','','default',0,65,NULL,'ID','','\0','','left','\0'),(460,'announcements','DATEENTERED','\0','default',1,180,NULL,'DATEENTERED','doubleDateFormat','\0',NULL,'left','\0'),(461,'announcements','COMMUNITYID','','default',2,65,NULL,'COMMUNITYID','','\0','','left','\0'),(462,'announcements','SHOWFREQUENCY','','default',3,65,NULL,'SHOWFREQUENCY','','\0','','left','\0'),(463,'announcements','DISPLAY','','default',4,65,NULL,'DISPLAY','','\0','','left','\0'),(464,'announcements','TYPE','','default',5,65,NULL,'TYPE','','\0','','left','\0'),(465,'announcements','SUBJECT','\0','default',6,309,NULL,'SUBJECT','subjectMessageFormat','\0',NULL,'left','\0'),(466,'announcements','DATEEXPIRES','','default',7,65,NULL,'DATEEXPIRES','','\0','','left','\0'),(467,'announcements','MESSAGE','','default',8,63,NULL,'MESSAGE','','\0','','left','\0');
/*!40000 ALTER TABLE `dynamicGridColumns` ENABLE KEYS */;
UNLOCK TABLES;


CREATE TABLE socialcloudz.`dynamicGrid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gridName` varchar(45) DEFAULT NULL,
  `className` varchar(45) DEFAULT NULL,
  `methodName` varchar(50) DEFAULT NULL,
  `application` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dynamicGrid`
--

LOCK TABLES socialcloudz.`dynamicGrid` WRITE;
/*!40000 ALTER TABLE `dynamicGrid` DISABLE KEYS */;
INSERT INTO socialcloudz.`dynamicGrid` VALUES (1,'communityAdmin',NULL,NULL,NULL),(2,'cmsAdmin',NULL,NULL,NULL),(3,'visitors',NULL,NULL,NULL),(4,'memberInvite',NULL,NULL,NULL),(5,'messageList',NULL,NULL,NULL),(6,'emailTemplates',NULL,NULL,NULL),(7,'emailMarketing',NULL,NULL,NULL),(10,'contentCategories',NULL,NULL,NULL),(11,'contentAdmin',NULL,NULL,NULL),(12,'memberAdmin',NULL,NULL,NULL),(13,'announcements',NULL,NULL,NULL);
/*!40000 ALTER TABLE `dynamicGrid` ENABLE KEYS */;
UNLOCK TABLES;

--//@UNDO
-- SQL to undo the change goes here.


drop table socialcloudz.dynamicGrid;
drop table socialcloudz.dynamicGridColumns;