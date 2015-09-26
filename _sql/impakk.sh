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

if [ ! -r $1 ]
then
  echo "Datei $1 nicht gefunden"
  exit 0
fi

if [ `head -1 $1  | sed 's,[^;],,g'|wc -c` != 23 ]
then
  echo "Falsches Format"
  exit 0
fi

sed 's,^﻿,,' <$1 >$F

head -1 $F | grep -q 'mitgliedsnummer.*refcode.*nachname'
if [ "$?" = "0" ]
then
  sed '1d' <$F >$F.zwi
  cp $F.zwi $F
  shred -u $F.zwi 2>/dev/null || rm -f $F.zwi
fi

mysql --user=$DBUSER --password=$DBASS $DBNAME <<mysqlende
  DELETE FROM tblpay;
  DELETE FROM tblakk;
  DELETE FROM tbladress;
  LOAD DATA INFILE '$F' INTO TABLE tblakk
     FIELDS TERMINATED BY ';'
     OPTIONALLY ENCLOSED BY '"'
     LINES TERMINATED BY '\r\n'
     (@akkid,mitgliedsnummer,refcode,vorname,nachname,strasse,plz,ort,lv,kv,geburtsdatum,stimmberechtigung,offenerbeitrag,eintrittsdatum,schwebend,suchname,suchvname,akk,akkrediteur,geaendert,kommentar,warnung,offenerbeitragold)
 ;
mysqlende

RESULT=$?
if [ $RESULT == 0 ]; then
	echo "Akk-Datei wurde geladen"
	shred -u $F 2>/dev/null || rm -f $F
else
	echo Fehler bei MySQL LOAD DATA INFILE INTO TABLE
fi
