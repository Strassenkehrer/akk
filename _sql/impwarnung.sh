#! /bin/bash

. config.sh

if [ "$2" == "" ]; then
	echo "Usage: $0 MITGLIEDSNUMMER \"WARNUNGSTEXT\""
	echo "       Warnungstext gleich Mitgliedsnummer -> dann wird die Warnung geloescht"
	exit
fi

if [ "$1" == "$2" ]; then
mysql --user=$DBUSER --password=$DBASS $DBNAME <<mysqlende
  UPDATE tblakk SET warnung = null WHERE mitgliedsnummer = $1;
mysqlende
  echo Warnung bei Mitglied $1 entfernt, Kommentar bleibt bestehen.
else
mysql --user=$DBUSER --password=$DBASS $DBNAME <<mysqlende  UPDATE tblakk SET warnung = 1, kommentar = "$2" WHERE mitgliedsnummer = $1;
mysqlende
  echo Warnung bei Mitglied $1 gesetzt.
fi

