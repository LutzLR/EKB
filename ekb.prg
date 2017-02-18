* ekb.prg
** END HEADER *
* Grundeinstellungen
CLEAR ALL
SET BELL ON
SET CENTURY ON
SET CONFIRM ON
SET CONSOLE ON
SET CUAENTER OFF
SET CURSOR ON
SET DECIMALS TO 2
SET ESCAPE OFF
SET EXACT ON
SET FULLPATH ON
SET LDCONVERT ON
SET SAFETY OFF
SET TALK OFF
set space off
* sonstige Variablen:
* ORGVERZ
* Quelle1
* Quelle2
* Quelle3
* Quelle4
* Quelle5
* Quelle6
* Ziel
* Ausschl1
* Ausschl2
* Befehl
* fd1 ... Dateiobjekt für ekb.cfg und backup.cmd
* fd2 ... Dateiobjekt für exclude-list.txt
* m ... für div. Zeichenketten
* n ... allg. Zähler
* ORGVERZ ... für Installationsverzeichnis
PUBLIC ORGVERZ,Quelle1,Quelle2,Quelle3,Quelle4,Quelle5,Quelle6,Quelle7,Ziel,Ausschl1,Ausschl2,Befehl,m,n
STORE "" TO ORGVERZ,Quelle1,Quelle2,Quelle3,Quelle4,Quelle5,Quelle6,Quelle7,Ziel,Ausschl1,Ausschl2,Befehl,m
STORE 0 to n
public fd1,fd2  && Dateiobjekte initialisieren
* Verzeichnis von EKB feststellen und speichern
store program(1) to m
store substr(m,1,len(m)-8) to orgverz
* Prüfen der Installation
set directory to &ORGVERZ
if file ("rsync.exe")
   * ok
else
   copy file rsync.bin to rsync.exe
endif
if file ("ekb.pdf");
	.and. file ("ekb.ini");
	.and. file ("PLUSrun.exe");
   .and. file ("Plusr_de.dll");
   .and. file ("cygwin1.dll");
   .and. file ("cygiconv-2.dll")
	* Konfiguration lesen
	if file ("ekb.cfg")
		fd1 = new File()
		fd1.open("ekb.cfg","R")
		quelle1 = fd1.gets()
		quelle2 = fd1.gets()
		quelle3 = fd1.gets()
		quelle4 = fd1.gets()
		quelle5 = fd1.gets()
		quelle6 = fd1.gets()
		quelle7 = fd1.gets()
		ziel = fd1.gets()
		fd1.close()
	endif
   if file ("exclude-list.txt")
		fd2 = new File()
		fd2.open("exclude-list.txt","R")
		Ausschl1 = fd2.gets()
		Ausschl2 = fd2.gets()
		fd2.close()
	endif
	* Oberfläche laden
	do ekb.wfm
else
	* Fehlermeldung
   MSGBOX("Die Installation ist unvollständig. EKB kann nicht gestartet werden.","Fehler !",16)
endif
* Programmende
set directory to &ORGVERZ
CLEAR ALL
CANCEL

