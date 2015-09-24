# akk

Für Deployment und Ausführung:

1. im Verzeichnis _sql ist ein README.txt für die Datenbank und Apache.
   Dort wird auch das mit der Userverwaltung erklärt.
   Lesen und machen.

2. Das Akk-Tool geht davon aus das es unter dem http(s):/localhost Root
   betrieben wird. URLs wie http://localhost/~benutzer/akk/index.html
   funktionieren nicht!
   
   Wenn du dieses Paket nach "$HOME/Sites/akk" entpackt hast, dann 
   richte nun einen virtuellen Host in Apache ein der auf einem Port
   (z.B. 1337) hört und der exakt diesen Pfad als sein DocumentRoot
   Pfad ansieht:
   
 Mac:
   cd /etc/apache2/users
   sudo vi $LOGNAME.conf
   
   Trage etwa das folgende ein, wobei BENUTZERNAME dein $LOGNAME ist:

=== CUT HERE ===   
<Directory "/Users/BENUTZERNAME/Sites/">
Options Indexes FollowSymLinks Multiviews
AllowOverride All
Order allow,deny
Allow from all
Require all granted
</Directory>

Listen 1337
<VirtualHost *:1337>
  DocumentRoot "/Users/BENUTZERNAME/Sites/akk"
</VirtualHost>
=== CUT HERE ===   

   Noch besser wäre, wenn du SSL für diesen virtuellen host einrichtest.
   
   Neustart des Apache2: 
   sudo apachectl restart

3. Trage deinen Parteitag in inc/akk.ini ein:

	[akk]
	Veranstaltung = Bezeichnung des Parteitags, z.B. BPT 15.1
	Datum = Datumszeitraum, z.B. 25.7. - 26.7.2015
	Ort = Ort des Parteitags, z.B. Würzburg
	Ebene = Gliederungsebene: "BV" für einen BPT (Statistik über LVs),
			"LV" für einen LPT (Statistik über KVs)
			oder "KV" für eine Kreismitgliederversammlung (Statistik über Orte)


4. Verbinde dich auf http://localhost:1337/ oder https://localhost:1337/
   Nach login sollte rechts ein Menü erscheinen.
   Unter "Statistik" gibt es eine "Userverwaltung".
   Falls du deinen admin Account einträgst, achte auf die richtige Rolle.
