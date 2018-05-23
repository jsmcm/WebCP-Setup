-- MySQL dump 10.13  Distrib 5.1.61, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: cpadmin
-- ------------------------------------------------------
-- Server version	5.1.61

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

CREATE DATABASE cpadmin;
USE cpadmin;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` tinytext,
  `username` tinytext,
  `first_name` tinytext,
  `surname` tinytext,
  `email_address` tinytext,
  `password` tinytext,
  `created` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','admin','admin','admin','admin@admin.admin',md5('adminadmin'),'2014-05-11 12:31:56',0);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aliases`
--

DROP TABLE IF EXISTS `aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aliases` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) NOT NULL,
  `local_part` varchar(250) NOT NULL,
  `goto` varchar(250) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aliases`
--

LOCK TABLES `aliases` WRITE;
/*!40000 ALTER TABLE `aliases` DISABLE KEYS */;
/*!40000 ALTER TABLE `aliases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bandwidth`
--

DROP TABLE IF EXISTS `bandwidth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bandwidth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_user_name` tinytext,
  `service` tinytext,
  `time` datetime DEFAULT NULL,
  `bandwidth` int(11) DEFAULT NULL,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bandwidth`
--

LOCK TABLES `bandwidth` WRITE;
/*!40000 ALTER TABLE `bandwidth` DISABLE KEYS */;
/*!40000 ALTER TABLE `bandwidth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csf`
--

DROP TABLE IF EXISTS `csf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `csf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` tinytext,
  `reverse` tinytext,
  `country_code` tinytext,
  `country` tinytext,
  `port` tinytext,
  `type` int(1) DEFAULT NULL,
  `direction` tinytext,
  `ban_time` datetime DEFAULT NULL,
  `timeout` int(11) DEFAULT NULL,
  `message` text,
  `logs` text,
  `triggered` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csf`
--

LOCK TABLES `csf` WRITE;
/*!40000 ALTER TABLE `csf` DISABLE KEYS */;
/*!40000 ALTER TABLE `csf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dns_options`
--

DROP TABLE IF EXISTS `dns_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dns_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_name` tinytext,
  `option_value` text,
  `extra1` text,
  `extra2` text,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dns_options`
--

LOCK TABLES `dns_options` WRITE;
/*!40000 ALTER TABLE `dns_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `dns_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domains`
--

DROP TABLE IF EXISTS `domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domains` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `UserName` tinytext,
  `Gid` int(11) DEFAULT NULL,
  `Uid` int(11) DEFAULT NULL,
  `fqdn` varchar(250) NOT NULL,
  `path` text,
  `admin_username` varchar(250) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` int(1) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT NULL,
  `mail_type` tinytext,
  `domain_type` tinytext,
  `parent_domain_id` int(11) DEFAULT NULL,
  `ancestor_domain_id` int(11) DEFAULT NULL,
  `package_id` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domains`
--

LOCK TABLES `domains` WRITE;
/*!40000 ALTER TABLE `domains` DISABLE KEYS */;
/*!40000 ALTER TABLE `domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_forwarding`
--

DROP TABLE IF EXISTS `email_forwarding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_forwarding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `domain_id` int(11) DEFAULT NULL,
  `source_local_part` tinytext,
  `destination_address` tinytext,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_forwarding`
--

LOCK TABLES `email_forwarding` WRITE;
/*!40000 ALTER TABLE `email_forwarding` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_forwarding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_options`
--

DROP TABLE IF EXISTS `email_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_name` tinytext,
  `option_value` text,
  `extra1` text,
  `extra2` text,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_options`
--

LOCK TABLES `email_options` WRITE;
/*!40000 ALTER TABLE `email_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_trace`
--

DROP TABLE IF EXISTS `email_trace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_trace` (
  `id` int(18) NOT NULL AUTO_INCREMENT,
  `mail_queue_id` tinytext,
  `to_user` tinytext,
  `from_user` tinytext,
  `start_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `sender_host` tinytext,
  `receiver_host` tinytext,
  `protocol` tinytext,
  `auth_type` tinytext,
  `sender_size` int(11) DEFAULT NULL,
  `receiver_size` int(11) DEFAULT NULL,
  `subject` text,
  `from_address` tinytext,
  `for_address` tinytext,
  `return_path` tinytext,
  `transport` tinytext,
  `router` tinytext,
  `queue_time` tinytext NOT NULL,
  `confirmation` text,
  `status` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_trace`
--

LOCK TABLES `email_trace` WRITE;
/*!40000 ALTER TABLE `email_trace` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_trace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fail2ban`
--

DROP TABLE IF EXISTS `fail2ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fail2ban` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service` tinytext,
  `ip` tinytext,
  `count` int(11) DEFAULT NULL,
  `reverse` text,
  `country_code` tinytext,
  `country` tinytext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fail2ban`
--

LOCK TABLES `fail2ban` WRITE;
/*!40000 ALTER TABLE `fail2ban` DISABLE KEYS */;
/*!40000 ALTER TABLE `fail2ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ftpd`
--

DROP TABLE IF EXISTS `ftpd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ftpd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `User` tinytext,
  `domain_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '0',
  `Password` varchar(64) NOT NULL DEFAULT '',
  `Uid` varchar(11) NOT NULL DEFAULT '-1',
  `Gid` varchar(11) NOT NULL DEFAULT '-1',
  `Dir` varchar(128) NOT NULL DEFAULT '',
  `ULBandwidth` smallint(5) NOT NULL DEFAULT '0',
  `DLBandwidth` smallint(5) NOT NULL DEFAULT '0',
  `comment` tinytext NOT NULL,
  `ipaccess` varchar(15) NOT NULL DEFAULT '*',
  `QuotaSize` smallint(5) NOT NULL DEFAULT '0',
  `QuotaFiles` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ftpd`
--

LOCK TABLES `ftpd` WRITE;
/*!40000 ALTER TABLE `ftpd` DISABLE KEYS */;
/*!40000 ALTER TABLE `ftpd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mailboxes`
--

DROP TABLE IF EXISTS `mailboxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailboxes` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) NOT NULL,
  `domain_user_name` tinytext,
  `local_part` varchar(250) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailboxes`
--

LOCK TABLES `mailboxes` WRITE;
/*!40000 ALTER TABLE `mailboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mysql`
--

DROP TABLE IF EXISTS `mysql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mysql` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `domain_username` tinytext,
  `username` tinytext,
  `database_name` tinytext,
  `password` tinytext,
  `created` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mysql`
--

LOCK TABLES `mysql` WRITE;
/*!40000 ALTER TABLE `mysql` DISABLE KEYS */;
/*!40000 ALTER TABLE `mysql` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_options`
--

DROP TABLE IF EXISTS `package_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `package_id` int(11) DEFAULT NULL,
  `setting` text,
  `value` int(5) DEFAULT NULL,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_options`
--

LOCK TABLES `package_options` WRITE;
/*!40000 ALTER TABLE `package_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `package_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packages` (
  `package_id` int(11) NOT NULL AUTO_INCREMENT,
  `package_name` text,
  `username` int(11) DEFAULT NULL,
  `active` int(1) DEFAULT NULL,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`package_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_directories`
--

DROP TABLE IF EXISTS `password_directories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_directories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) DEFAULT NULL,
  `domain_user_name` tinytext,
  `directory` text,
  `username` tinytext,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_directories`
--

LOCK TABLES `password_directories` WRITE;
/*!40000 ALTER TABLE `password_directories` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_directories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_settings`
--

DROP TABLE IF EXISTS `server_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `setting` text,
  `value` tinytext,
  `extra1` tinytext,
  `extra2` tinytext,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_settings`
--

LOCK TABLES `server_settings` WRITE;
/*!40000 ALTER TABLE `server_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_notices`
--

DROP TABLE IF EXISTS `user_notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` tinytext,
  `notice_type` tinytext,
  `count` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_notices`
--

LOCK TABLES `user_notices` WRITE;
/*!40000 ALTER TABLE `user_notices` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_notices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vacations`
--

DROP TABLE IF EXISTS `vacations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vacations` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `mailbox_id` int(11) DEFAULT NULL,
  `subject` varchar(250) DEFAULT NULL,
  `body` text,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `active` int(1) DEFAULT NULL,
  `frequency` tinytext,
  `deleted` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacations`
--

LOCK TABLES `vacations` WRITE;
/*!40000 ALTER TABLE `vacations` DISABLE KEYS */;
/*!40000 ALTER TABLE `vacations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-07-21 20:39:55
