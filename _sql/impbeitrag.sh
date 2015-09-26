#! /bin/bash

DBROOTPW=root-pw-der-db
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
  shred -u $F.zwi
fi

mysql --user=root --password=DBROOTPW ppdakk <<mysqlende
  DELETE FROM tblbeitrag;
  LOAD DATA INFILE '$F' INTO TABLE tblbeitrag
     FIELDS TERMINATED BY ';'
     OPTIONALLY ENCLOSED BY '"'
     LINES TERMINATED BY '\r\n'
     (mnr,opjahr,beitragsoll,beitragist,datumsoll,datumist,bemerkung)
 ;
 DELETE FROM tblbeitrag WHERE mnr IN (SELECT mitgliedsnummer FROM tblakk WHERE offenerbeitrag=0);
mysqlende

echo "Beitrag-Datei wurde geladen"

shred -u $F

