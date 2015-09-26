#! /bin/bash

#
# Achtung:
# Das Script funktioniert auf jeden Fall mit root Zugriff 
# auf die DB, das MySQL Kommando
# LOAD DATA INFILE ..
# funktioniert naemlich nicht fuer jeden User
#
DBUSER=root
DBPASS=db-password
DBNAME=pddakk

F=$1.zwi
touch $F
chmod a+r $F

if [ ! -r $1 ]
then
  echo "Datei $1 nicht gefunden"
  exit 0
fi

if [ `head -1 $1  | sed 's,[^;],,g'|wc -c` != 7 ]
then
  echo "Falsches Format"
  exit 0
fi

sed 's,^﻿,,' <$1 | iconv -f ISO8859-1 -t UTF-8 >$F

head -1 $F | grep -q 'mnr*opjahr*beitragsoll'
if [ "$?" = "0" ]
then
  sed '1d' <$F >$F.zwi
  cp $F.zwi $F
  shred -u $F.zwi 2>/dev/null || rm -f $F.zwi
fi

chmod a+r $F # mglw hat der mysql deamon user sonst keinen Zugriff auf die Datei
mysql --user=$DBUSER --password=$DBASS $DBNAME <<mysqlende
  DELETE FROM tblbeitrag;
  LOAD DATA INFILE '$F' INTO TABLE tblbeitrag
     FIELDS TERMINATED BY ';'
     OPTIONALLY ENCLOSED BY '"'
     LINES TERMINATED BY '\r\n'
     (mnr,opjahr,beitragsoll,beitragist,datumsoll,datumist,bemerkung)
 ;
 DELETE FROM tblbeitrag WHERE mnr IN (SELECT mitgliedsnummer FROM tblakk WHERE offenerbeitrag=0);
mysqlende

RESULT=$?
if [ $RESULT == 0 ]; then
	echo "Beitrag-Datei wurde geladen"
	shred -u $F 2>/dev/null || rm -f $F
else
	echo Fehler bei MySQL LOAD DATA INFILE INTO TABLE
fi


