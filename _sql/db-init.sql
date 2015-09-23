CREATE DATABASE `akk` /*!40100 DEFAULT CHARACTER SET utf8 */;


DROP TABLE IF EXISTS `akk`.`tblakk`;
CREATE TABLE  `akk`.`tblakk` (
  `akkID` int(10) unsigned NOT NULL auto_increment,
  `mitgliedsnummer` int(10) unsigned default NULL,
  `refcode` varchar(15) default NULL,
  `vorname` varchar(60) default NULL,
  `nachname` varchar(60) default NULL,
  `strasse` varchar(64) default NULL,
  `plz` varchar(10) default NULL,
  `ort` varchar(40) default NULL,
  `lv` varchar(10) default NULL,
  `kv` varchar(50) default NULL,
  `geburtsdatum` date default NULL,
  `stimmberechtigung` tinyint(3) default NULL,
  `offenerbeitrag` int(10) unsigned default NULL,
  `eintrittsdatum` date default NULL,
  `schwebend` tinyint(3) default NULL,
  `suchname` varchar(120) default NULL,
  `suchvname` varchar(120) default NULL,
  `akk` tinyint(3) unsigned NOT NULL default '0',
  `akkrediteur` varchar(50) default NULL,
  `geaendert` datetime default NULL,
  `kommentar` varchar(255) NOT NULL,
  `warnung` varchar(1) default NULL,
  `offenerbeitragold` int(10) unsigned default NULL,
  PRIMARY KEY  (`akkID`),
  KEY `ix_mnr` (`mitgliedsnummer`)
) ENGINE=InnoDB AUTO_INCREMENT=19965 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `akk`.`tbladress`;
CREATE TABLE  `akk`.`tbladress` (
  `adressID` int(10) unsigned NOT NULL auto_increment,
  `akkID` int(10) unsigned NOT NULL,
  `mitgliedsnummer` int(10) unsigned default NULL,
  `vorname` varchar(250) default NULL,
  `nachname` varchar(60) default NULL,
  `strasse` varchar(64) default NULL,
  `plz` varchar(10) default NULL,
  `ort` varchar(40) default NULL,
  `lv` varchar(10) default NULL,
  `kv` varchar(50) default NULL,
  `akkrediteur` varchar(50) default NULL,
  `geaendert` datetime default NULL,
  `kommentar` varchar(255) default NULL,
  `edit` tinyint(3) unsigned default NULL,
  `new` tinyint(3) unsigned default NULL,
  PRIMARY KEY  (`adressID`),
  KEY `tbladress_ibfk_1` (`akkID`),
  CONSTRAINT `tbladress_ibfk_1` FOREIGN KEY (`akkID`) REFERENCES `tblakk` (`akkID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `akk`.`tblbeitrag`;
CREATE TABLE  `akk`.`tblbeitrag` (
  `mnr` varchar(20) NOT NULL,
  `opjahr` int(11) NOT NULL,
  `beitragsoll` int(11) NOT NULL,
  `beitragist` int(11) default NULL,
  `datumsoll` date default NULL,
  `datumist` date default NULL,
  `bemerkung` varchar(255) default NULL,
  `mnrorg` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `akk`.`tblpay`;
CREATE TABLE  `akk`.`tblpay` (
  `beitragID` int(10) unsigned NOT NULL auto_increment,
  `akkID` int(10) unsigned default NULL,
  `mitgliedsnummer` varchar(20) default NULL,
  `beitragoffen` int(11) default NULL,
  `gezahlt` int(11) default NULL,
  `akkrediteur` varchar(50) default NULL,
  `geaendert` datetime default NULL,
  `kommentar` varchar(255) default NULL,
  PRIMARY KEY  (`beitragID`),
  KEY `akkID` (`akkID`),
  CONSTRAINT `tblpay_ibfk_1` FOREIGN KEY (`akkID`) REFERENCES `tblakk` (`akkID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `akk`.`tbluser`;
CREATE TABLE  `akk`.`tbluser` (
  `login` varchar(50) default NULL,
  `name` varchar(50) default NULL,
  `rolle` int(11) default NULL,
  PRIMARY KEY  (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

