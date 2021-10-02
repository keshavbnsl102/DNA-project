-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: GABRUS
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `GABRUS`
--

/*!40000 DROP DATABASE IF EXISTS `GABRUS`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `GABRUS` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `GABRUS`;

--
-- Table structure for table `BOT`
--

DROP TABLE IF EXISTS `BOT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BOT` (
  `Name` varchar(30) NOT NULL,
  `Handle` varchar(30) NOT NULL,
  `API` varchar(30) NOT NULL,
  `CreationTime` datetime NOT NULL,
  `Uploads_On` varchar(30) DEFAULT NULL,
  `HostIP` varchar(30) NOT NULL,
  `Username` varchar(30) NOT NULL,
  `Password` varchar(30) NOT NULL,
  PRIMARY KEY (`Handle`),
  UNIQUE KEY `API` (`API`),
  CONSTRAINT `BOT_ibfk_1` FOREIGN KEY (`HostIP`, `Username`, `Password`) REFERENCES `SERVER` (`HostIP`, `Username`, `Password`) ON UPDATE CASCADE,
  CONSTRAINT `BOT_ibfk_2` FOREIGN KEY (`Uploads_On`) REFERENCES `TEAM_DRIVE` (`TeamId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BOT`
--

LOCK TABLES `BOT` WRITE;
/*!40000 ALTER TABLE `BOT` DISABLE KEYS */;
INSERT INTO `BOT` VALUES ('Hoarding Bot 1','hoardingMirror1Bot','qasllleafcxkvaajq','2019-11-15 00:00:00','d','191.12.78.2','tHoardu1','torrentHoarding420*'),('Hoarding Bot 2','hoardingMirror2Bot','jalkmfwelqawejklk','2019-12-01 00:00:00','d','191.12.78.2','tHoardu2','torrentHoarding420*'),('Hoarding Bot 3','hoardingMirror3Bot','jalkmtmelqcwejklk','2019-10-01 00:00:00','d','191.10.58.7','tHoardu3','torrentHoarding420*'),('Meta Bot 1','metaleech1Bot','qweoijawlkjdslfa','2019-12-15 00:00:00','u','191.87.69.0','metapublu1','metaPublicLeech99*'),('NJ Bot 1','njtorrbot1','oiqwnafjshvakj','2019-04-12 00:00:00','i','167.45.12.4','njtorru1','njTorrents6593&'),('Course Bot 1','premCourseBot1','vwnjkalsdkjfa','2020-03-11 00:00:00','af','134.435.72.52','courseBotu1','coursesPremium1948*'),('Viper Bot 1','viper1Bot','lbjvklzdsnkfalaskj','2020-06-14 00:00:00','o','192.11.50.1','vipercu1','viperCloud1950*'),('Viper Bot 2','viper2Bot','jqlkwajfwqekljfl','2020-06-14 00:00:00','o','192.11.50.1','vipercu2','viperCloud1950*');
/*!40000 ALTER TABLE `BOT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DOWNLOAD`
--

DROP TABLE IF EXISTS `DOWNLOAD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DOWNLOAD` (
  `Name` varchar(50) NOT NULL,
  `TeamID` varchar(30) NOT NULL,
  `Size` decimal(10,0) NOT NULL,
  `FolderFlag` tinyint(1) NOT NULL,
  `NumberOfFiles` int DEFAULT '0',
  PRIMARY KEY (`Name`,`TeamID`),
  CONSTRAINT `DOWNLOAD_ibfk_1` FOREIGN KEY (`TeamID`) REFERENCES `TEAM_DRIVE` (`TeamId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DOWNLOAD`
--

LOCK TABLES `DOWNLOAD` WRITE;
/*!40000 ALTER TABLE `DOWNLOAD` DISABLE KEYS */;
INSERT INTO `DOWNLOAD` VALUES ('13.Reasons.Why.S04.1080p','u',20,1,11),('13.Reasons.Why.S04.720p','a',10,1,11),('13.Reasons.Why.S04.720p','g',10,1,11),('Aarya.S01.720p','a',6,1,9),('Aarya.S01.720p','h',6,1,9),('Breaking.Bad.720p','o',62,1,62),('Breaking.Bad.720p','u',62,1,62),('C++','ae',50,1,100),('file.zip','h',9,0,NULL),('file1.zip','a',5,0,NULL),('file2.zip','af',2,0,NULL),('Khuda.Haafiz.1080p.mkv','d',2,0,NULL),('Khuda.Haafiz.1080p.mkv','u',2,0,NULL),('Metro Park','d',3,1,9),('Metro Park','i',3,1,9),('Metro Park','o',3,1,9),('Metro Park','u',3,1,9),('Mysql','af',14,1,120),('Python','ad',30,1,50);
/*!40000 ALTER TABLE `DOWNLOAD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EXTENSIONS`
--

DROP TABLE IF EXISTS `EXTENSIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EXTENSIONS` (
  `Name` varchar(30) NOT NULL,
  `TeamID` varchar(30) NOT NULL,
  `Extension` varchar(30) NOT NULL,
  PRIMARY KEY (`Name`,`TeamID`,`Extension`),
  CONSTRAINT `EXTENSIONS_ibfk_1` FOREIGN KEY (`Name`, `TeamID`) REFERENCES `DOWNLOAD` (`Name`, `TeamID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EXTENSIONS`
--

LOCK TABLES `EXTENSIONS` WRITE;
/*!40000 ALTER TABLE `EXTENSIONS` DISABLE KEYS */;
INSERT INTO `EXTENSIONS` VALUES ('13-Reasons-Why-S04-1080p','u','mkv'),('13-Reasons-Why-S04-1080p','u','txt'),('13-Reasons-Why-S04-720p','a','mkv'),('13-Reasons-Why-S04-720p','a','txt'),('13-Reasons-Why-S04-720p','g','mkv'),('13-Reasons-Why-S04-720p','g','txt'),('Aarya-S01-720p','a','mp4'),('Aarya-S01-720p','h','mp4'),('Breaking-Bad-720p','o','mp4'),('Breaking-Bad-720p','u','mp4'),('C++','ae','cpp'),('C++','ae','mp4'),('C++','ae','srt'),('Metro Park','d','mkv'),('Metro Park','i','mkv'),('Metro Park','o','mkv'),('Metro Park','u','mkv'),('Mysql','af','mp4'),('Mysql','af','sql'),('Mysql','af','srt'),('Python','ad','mp4'),('Python','ad','py'),('Python','ad','srt');
/*!40000 ALTER TABLE `EXTENSIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FILE_EXTENSION`
--

DROP TABLE IF EXISTS `FILE_EXTENSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FILE_EXTENSION` (
  `Name` varchar(30) NOT NULL,
  `Extension` varchar(30) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FILE_EXTENSION`
--

LOCK TABLES `FILE_EXTENSION` WRITE;
/*!40000 ALTER TABLE `FILE_EXTENSION` DISABLE KEYS */;
INSERT INTO `FILE_EXTENSION` VALUES ('file.zip','zip'),('file1.zip','zip'),('file2.zip','zip'),('Khuda.Haafiz.1080p.mkv','mkv');
/*!40000 ALTER TABLE `FILE_EXTENSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP`
--

DROP TABLE IF EXISTS `GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GROUP` (
  `Handle` varchar(30) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Start-Date` datetime NOT NULL,
  PRIMARY KEY (`Handle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP`
--

LOCK TABLES `GROUP` WRITE;
/*!40000 ALTER TABLE `GROUP` DISABLE KEYS */;
INSERT INTO `GROUP` VALUES ('MetaPublicLeech','Meta Public-Leecher','2020-05-04 14:30:08'),('njtorrent','NJ Torrent','2019-09-03 12:08:50'),('premiumcoursesdrive','Courses Drive','2019-12-28 09:36:06'),('TorrentMirror','Torrent Hoarding','2019-06-14 17:42:13'),('ViperCloud','Viper Cloud','2019-04-26 19:00:00');
/*!40000 ALTER TABLE `GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IS_AN_ADMIN_OF`
--

DROP TABLE IF EXISTS `IS_AN_ADMIN_OF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IS_AN_ADMIN_OF` (
  `GroupHandle` varchar(30) NOT NULL,
  `UserHandle` varchar(30) NOT NULL,
  PRIMARY KEY (`UserHandle`,`GroupHandle`),
  CONSTRAINT `IS_AN_ADMIN_OF_ibfk_1` FOREIGN KEY (`UserHandle`) REFERENCES `GABRUS.USER` (`UserHandle`),
  CONSTRAINT `IS_AN_ADMIN_OF_ibfk_2` FOREIGN KEY (`GroupHandle`) REFERENCES `GABRUS.GROUP` (`Handle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IS_AN_ADMIN_OF`
--

LOCK TABLES `IS_AN_ADMIN_OF` WRITE;
/*!40000 ALTER TABLE `IS_AN_ADMIN_OF` DISABLE KEYS */;
INSERT INTO `IS_AN_ADMIN_OF` VALUES ('Jeel02','premiumcoursesdrive'),('Jeel02','ViperCloud'),('KAKAROT379','MetaPublicLeech'),('KAKAROT379','njtorrent'),('KAKAROT379','TorrentMirror'),('maverickG','premiumcoursesdrive'),('maverickG','ViperCloud'),('noob','premiumcoursesdrive'),('teslaSid','MetaPublicLeech'),('TobiOrNotTobi','TorrentMirror'),('TobiOrNotTobi','ViperCloud');
/*!40000 ALTER TABLE `IS_AN_ADMIN_OF` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MEMBER_OF`
--

DROP TABLE IF EXISTS `MEMBER_OF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MEMBER_OF` (
  `UserHandle` varchar(30) NOT NULL,
  `GroupHandle` varchar(30) NOT NULL,
  PRIMARY KEY (`UserHandle`,`GroupHandle`),
  CONSTRAINT `MEMBER_OF_ibfk_1` FOREIGN KEY (`UserHandle`) REFERENCES `USER` (`UserHandle`),
  CONSTRAINT `MEMBER_OF_ibfk_2` FOREIGN KEY (`GroupHandle`) REFERENCES `GROUP` (`Handle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MEMBER_OF`
--

LOCK TABLES `MEMBER_OF` WRITE;
/*!40000 ALTER TABLE `MEMBER_OF` DISABLE KEYS */;
INSERT INTO `MEMBER_OF` VALUES ('Jeel02','MetaPublicLeech'),('KAKAROT379','MetaPublicLeech'),('maverickG','MetaPublicLeech'),('noob','MetaPublicLeech'),('obvalt','MetaPublicLeech'),('piper','MetaPublicLeech'),('Raddmax','MetaPublicLeech'),('Rnero','MetaPublicLeech'),('teslaSid','MetaPublicLeech'),('TobiOrNotTobi','MetaPublicLeech'),('Jeel02','njtorrent'),('KAKAROT379','njtorrent'),('maverickG','njtorrent'),('noob','njtorrent'),('obvalt','njtorrent'),('Raddmax','njtorrent'),('Rnero','njtorrent'),('teslaSid','njtorrent'),('TobiOrNotTobi','njtorrent'),('izDead','premiumcoursesdrive'),('Jeel02','premiumcoursesdrive'),('maverickG','premiumcoursesdrive'),('noob','premiumcoursesdrive'),('obvalt','premiumcoursesdrive'),('piper','premiumcoursesdrive'),('Raddmax','premiumcoursesdrive'),('teslaSid','premiumcoursesdrive'),('TobiOrNotTobi','premiumcoursesdrive'),('izDead','TorrentMirror'),('Jeel02','TorrentMirror'),('KAKAROT379','TorrentMirror'),('noob','TorrentMirror'),('obvalt','TorrentMirror'),('piper','TorrentMirror'),('Rnero','TorrentMirror'),('teslaSid','TorrentMirror'),('TobiOrNotTobi','TorrentMirror'),('Jeel02','ViperCloud'),('KAKAROT379','ViperCloud'),('maverickG','ViperCloud'),('noob','ViperCloud'),('obvalt','ViperCloud'),('piper','ViperCloud'),('Raddmax','ViperCloud'),('Rnero','ViperCloud'),('teslaSid','ViperCloud'),('TobiOrNotTobi','ViperCloud');
/*!40000 ALTER TABLE `MEMBER_OF` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SERVER`
--

DROP TABLE IF EXISTS `SERVER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SERVER` (
  `HostIP` varchar(30) NOT NULL,
  `Username` varchar(30) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `LastRestartTime` datetime NOT NULL,
  PRIMARY KEY (`HostIP`,`Username`,`Password`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SERVER`
--

LOCK TABLES `SERVER` WRITE;
/*!40000 ALTER TABLE `SERVER` DISABLE KEYS */;
INSERT INTO `SERVER` VALUES ('134.435.72.52','courseBotu1','coursesPremium1948*','2019-03-01 12:45:45'),('167.45.12.4','njtorru1','njTorrents6593&','2019-05-05 15:30:59'),('191.10.58.7','tHoardu3','torrentHoarding420*','2020-10-06 16:15:15'),('191.12.78.2','tHoardu1','torrentHoarding420*','2020-10-02 16:30:20'),('191.12.78.2','tHoardu2','torrentHoarding420*','2020-10-02 16:15:15'),('191.87.69.0','metapublu1','metaPublicLeech99*','2020-10-02 16:30:20'),('192.11.50.1','vipercu1','viperCloud1950*','2020-10-02 13:40:10'),('192.11.50.1','vipercu2','viperCloud1950*','2020-10-02 16:30:20');
/*!40000 ALTER TABLE `SERVER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SPECIFICATIONS`
--

DROP TABLE IF EXISTS `SPECIFICATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SPECIFICATIONS` (
  `HostIP` varchar(30) NOT NULL,
  `OS` varchar(30) NOT NULL,
  `CPU` int NOT NULL,
  `Storage` decimal(10,0) NOT NULL,
  `Memory` decimal(10,0) NOT NULL,
  `Region` varchar(30) NOT NULL,
  `Company` varchar(30) NOT NULL,
  PRIMARY KEY (`HostIP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SPECIFICATIONS`
--

LOCK TABLES `SPECIFICATIONS` WRITE;
/*!40000 ALTER TABLE `SPECIFICATIONS` DISABLE KEYS */;
INSERT INTO `SPECIFICATIONS` VALUES ('134.435.72.52','Ubuntu',4,128,4,'India','Microsoft'),('191.10.58.7','Ubuntu',2,128,2,'India','Google'),('191.11.50.1','Windows',12,128,8,'USA','Amazon'),('191.12.78.2','Ubuntu',8,256,4,'India','Google'),('191.87.69.0','Windows',5,256,8,'London','Microsoft'),('192.11.50.1','Ubuntu',4,256,4,'USA','Amazon');
/*!40000 ALTER TABLE `SPECIFICATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TASK`
--

DROP TABLE IF EXISTS `TASK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TASK` (
  `BotHandle` varchar(30) NOT NULL,
  `GroupHandle` varchar(30) NOT NULL,
  `DownloadName` varchar(30) NOT NULL,
  `DownloadTeamDriveID` varchar(30) NOT NULL,
  `UserHandle` varchar(30) NOT NULL,
  PRIMARY KEY (`DownloadName`,`DownloadTeamDriveID`),
  CONSTRAINT `TASK_ibfk_1` FOREIGN KEY (`BotHandle`) REFERENCES `BOT` (`Handle`),
  CONSTRAINT `TASK_ibfk_2` FOREIGN KEY (`GroupHandle`) REFERENCES `GROUP` (`Handle`),
  CONSTRAINT `TASK_ibfk_3` FOREIGN KEY (`DownloadName`, `DownloadTeamDriveID`) REFERENCES `DOWNLOAD` (`Name`, `TeamID`),
  CONSTRAINT `TASK_ibfk_4` FOREIGN KEY (`UserHandle`) REFERENCES `USER` (`UserHandle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TASK`
--

LOCK TABLES `TASK` WRITE;
/*!40000 ALTER TABLE `TASK` DISABLE KEYS */;
INSERT INTO `TASK` VALUES ('metaleech1Bot','MetaPublicLeech','13.Reasons.Why.S04.1080p','u','maverickG'),('hoardingMirror1Bot','TorrentMirror','13.Reasons.Why.S04.720p','a','Rnero'),('njtorrbot1','njtorrent','13.Reasons.Why.S04.720p','g','maverickG'),('hoardingMirror2Bot','TorrentMirror','Aarya.S01.720p','a','noob'),('njtorrbot1','njtorrent','Aarya.S01.720p','h','Rnero'),('viper1Bot','ViperCloud','Breaking.Bad.720p','o','maverickG'),('metaleech1Bot','MetaPublicLeech','Breaking.Bad.720p','u','Rnero'),('premCourseBot1','premiumcoursesdrive','C++','ae','teslaSid'),('njtorrbot1','njtorrent','file.zip','h','KAKAROT379'),('hoardingMirror3Bot','TorrentMirror','file1.zip','a','izDead'),('premCourseBot1','premiumcoursesdrive','file2.zip','af','Raddmax'),('hoardingMirror3Bot','TorrentMirror','Khuda.Haafiz.1080p.mkv','d','Jeel02'),('metaleech1Bot','MetaPublicLeech','Khuda.Haafiz.1080p.mkv','u','noob'),('hoardingMirror3Bot','TorrentMirror','Metro Park','d','Jeel02'),('njtorrbot1','njtorrent','Metro Park','i','noob'),('viper2Bot','ViperCloud','Metro Park','o','Rnero'),('metaleech1Bot','MetaPublicLeech','Metro Park','u','piper'),('premCourseBot1','premiumcoursesdrive','Mysql','af','TobiOrNotTobi'),('premCourseBot1','premiumcoursesdrive','Python','ad','Jeel02');
/*!40000 ALTER TABLE `TASK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEAM_DRIVE`
--

DROP TABLE IF EXISTS `TEAM_DRIVE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEAM_DRIVE` (
  `TeamId` varchar(30) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `BackupOf` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`TeamId`),
  CONSTRAINT `TEAM_DRIVE_ibfk_1` FOREIGN KEY (`BackupOf`) REFERENCES `TEAM_DRIVE` (`TeamId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEAM_DRIVE`
--

LOCK TABLES `TEAM_DRIVE` WRITE;
/*!40000 ALTER TABLE `TEAM_DRIVE` DISABLE KEYS */;
INSERT INTO `TEAM_DRIVE` VALUES ('a','Torrent Hoarding 1',NULL),('aa','ML Backup 32','t'),('ab','ML Backup 41','u'),('ac','ML Backup 42','u'),('ad','Course Drive 1',NULL),('ae','Course Drive 2',NULL),('af','Course Drive 3',NULL),('ag','CD Backup 11','ad'),('ah','CD Backup 31','af'),('ai','CD Backup 12','ad'),('aj','CD Backup 22','ae'),('ak','CD Backup 32','af'),('al','CD Backup 21','ae'),('az','NJT Backup 32','i'),('b','TH Backup 11','a'),('c','TH Backup 12','a'),('d','Torrent Hoarding 2',NULL),('e','TH Backup 21','d'),('f','TH Backup 22','d'),('g','NJ Torrents 1',NULL),('h','NJ Torrents 2',NULL),('i','NJ Torrents 3',NULL),('j','NJT Backup 11','g'),('k','NJT Backup 12','g'),('l','NJT Backup 21','h'),('m','NJT Backup 22','h'),('n','NJT Backup 31','i'),('o','Viper Cloud 1',NULL),('p','VC Backup 11','o'),('q','VC Backup 12','o'),('r','Meta Leech 1',NULL),('s','Meta Leech 2',NULL),('t','Meta Leech 3',NULL),('u','Meta Leech 4',NULL),('v','ML Backup 11','r'),('w','ML Backup 12','r'),('x','ML Backup 21','s'),('y','ML Backup 22','s'),('z','ML Bakcup 31','t');
/*!40000 ALTER TABLE `TEAM_DRIVE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER`
--

DROP TABLE IF EXISTS `USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER` (
  `UserId` int NOT NULL,
  `Name` varchar(30) NOT NULL,
  `UserHandle` varchar(30) NOT NULL,
  PRIMARY KEY (`UserHandle`),
  UNIQUE KEY `UserId` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER`
--

LOCK TABLES `USER` WRITE;
/*!40000 ALTER TABLE `USER` DISABLE KEYS */;
INSERT INTO `USER` VALUES (12012,'Acid','izDead'),(10889,'Jeel','Jeel02'),(12436,'Kakarot','KAKAROT379'),(21552,'Gaurav','maverickG'),(76235,'Anirudh','noob'),(26341,'Obvalt','obvalt'),(32892,'Pooja','piper'),(19819,'Max','Raddmax'),(23849,'Raju','Rnero'),(89237,'Sidharth','teslaSid'),(29129,'Tobi','TobiOrNotTobi');
/*!40000 ALTER TABLE `USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WORKS_IN`
--

DROP TABLE IF EXISTS `WORKS_IN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WORKS_IN` (
  `BotHandle` varchar(30) NOT NULL,
  `GroupHandle` varchar(30) NOT NULL,
  PRIMARY KEY (`BotHandle`,`GroupHandle`),
  CONSTRAINT `WORKS_IN_ibfk_1` FOREIGN KEY (`BotHandle`) REFERENCES `BOT` (`Handle`),
  CONSTRAINT `WORKS_IN_ibfk_2` FOREIGN KEY (`GroupHandle`) REFERENCES `GROUP` (`Handle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WORKS_IN`
--

LOCK TABLES `WORKS_IN` WRITE;
/*!40000 ALTER TABLE `WORKS_IN` DISABLE KEYS */;
INSERT INTO `WORKS_IN` VALUES ('metaleech1Bot','MetaPublicLeech'),('njtorrbot1','njtorrent'),('premCourseBot1','premiumcoursesdrive'),('hoardingMirror1Bot','TorrentMirror'),('hoardingMirror2Bot','TorrentMirror'),('hoardingMirror3Bot','TorrentMirror'),('viper1Bot','ViperCloud'),('viper2Bot','ViperCloud');
/*!40000 ALTER TABLE `WORKS_IN` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-06 22:42:57
