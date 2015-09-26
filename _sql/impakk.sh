#! /bin/bash

DBROOTPW=root-pw-der-db

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
  shred -u $F.zwi
fi

mysql --user=root --password=$DBROOTPW ppdakk <<mysqlende
  DELETE FROM tblakk;
  LOAD DATA INFILE '$F' INTO TABLE tblakk
     FIELDS TERMINATED BY ';'
     OPTIONALLY ENCLOSED BY '"'
     LINES TERMINATED BY '\r\n'
     (@akkid,mitgliedsnummer,refcode,vorname,nachname,strasse,plz,ort,lv,kv,geburtsdatum,stimmberechtigung,offenerbeitrag,eintrittsdatum,schwebend,suchname,suchvname,akk,akkrediteur,geaendert,kommentar,warnung,offenerbeitragold)
 ;
mysqlende

echo "Akk-Datei wurde geladen"

shred -u $F

