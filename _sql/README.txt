README
======
Das Script db-init.sql legt die Datenbank 'akk' an.

Username und Passwort muessen mit der Einstellung in akk.ini uebereinstimmen.

Userverwaltung für das AKK-TOOL
===============================
In akk.ini und inc/akk.ini sind Einträge für eine htpasswd Datei definiert, 
diese sind aber nicht relevant. 
Relevant sind die Einträge in .htaccess und inc/.htaccess,
welche aber auf die (gleiche) Datei "/web/akk/data/passwd.users" zeigen.
   
Diese muss angelegt werden, Beispiel:

	htpasswd -c /web/akk/data/passwd.users user1 
	htpasswd -b /web/akk/data/passwd.users admin1 admin1

Es wird empfohlen ein anderes sicherere Passwörter zu nehmen!

Der Zugang mit Passwort wird über die htpasswd geregelt, die Rollenverteilung
(Admin, Akkrediteur) aber über die Datenbank.  Ja, das ist übel gehackt aber
ist im Moment so.
Darum legst du auch noch die User wie folgt an:

INSERT INTO tbluser (login, name, rolle) VALUES ('admin1', 'Der Admin', 9);
INSERT INTO tbluser (login, name, rolle) VALUES ('user1', 'Hans Wurst', 1);


Mac OS X - Wie man apache, sql und php ans laufen bringt
========================================================

Man lese
http://coolestguidesontheplanet.com/get-apache-mysql-php-phpmyadmin-working-osx-10-10-yosemite/


1. Möglicherweise ist MySQL für PHP nicht aktiviert.
In dem Fall bekommst du eine Fehlermeldung etwa

  PHP Fatal error:  Uncaught exception 'PDOException' with message 'SQLSTATE[HY000] [2002] 
  No such file or directory' in .../akk/inc/db.php:13

wenn du 

  php index.php

ausführst. Dann:

Als root /etc/php.ini.default nach /etc/php.ini kopieren.
Den Eintrag pdo_mysql.default_socket in php.ini ändern in:

  pdo_mysql.default_socket=/tmp/mysql.sock



2. Möglicherweise meckert PHP, dass es old_passwords nicht mag:

  PHP Fatal error:  Uncaught exception 'PDOException' with message 'SQLSTATE[HY000] [2054] 
  The server requested authentication method unknown to the client'

Schalte old_passwords in /etc/my.cnt deiner MySQL (oder über die Adminoberfläche) aus.
Setze das Passwort des users aus akk.ini in der MySQL neu.
Alternative: 
http://zewaren.net/site/?q=node/121

