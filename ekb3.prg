* ekb3.prg
** END HEADER *
TxtArr1 = new Array(1,1)
* Array neu initialisieren
TxtArr1.resize(1,1)
store .F. to TxtArr1[1,1]
sleep 1
*
store "0" to f  && Fehlerflag zurücksetzen
store 0 to n  && Zähler für Arrayzeilen
* Log-Datei öffnen
set directory to &ORGVERZ
fd1 = new File()
fd1.open("Logdatei.txt","R")
*
DO WHILE not fd1.eof()
  	m = fd1.gets()
   * Div. Ausdrücke ändern
   x = at("] building file list",m)
   if x>0
		store substr(m,1,20)+"Dateiliste erstellt." to m
      do ekb4.prg
      store 0 to x
   endif
	*
   x = at("] created directory",m)
   if x>0
		store substr(m,1,20)+"Verzeichnis erstellt: "+substr(m,len(m)-1,len(m)-1) to m
      do ekb4.prg
      store 0 to x
   endif
	*
   x = at("] >f+++++++++",m)
   if x>0
		store substr(m,1,20)+"Datei ins Backup geschrieben ___:"+substr(m,x+13,len(m)-x+14) to m
      do ekb4.prg
      store 0 to x
   endif
   *
   x = at("] *deleting",m)
   if x>0
		store substr(m,1,20)+"Aus dem Backup entfernt ________:"+substr(m,x+13,len(m)-x+14) to m
      do ekb4.prg
      store 0 to x
   endif
	*
   x = at("ile name too long",m)
   if x>0
   	x = at("cygdrive",m)
		store substr(m,1,20)+"Fehler! Pfad/Dateiname zu lang _: "+substr(m,x+9,1)+":"+substr(m,x+10,len(m)-x+11-54) to m
      store "1" to f  && Fehlerflag setzen
      do ekb4.prg
      store 0 to x
   endif
	*
   x = at("ile has vanished",m)
   if x>0
   	x = at("cygdrive",m)
		store substr(m,1,20)+"Fehler! Datei nicht übertragen _: "+substr(m,x+9,1)+":"+substr(m,x+10,len(m)-x+11) to m
      store "1" to f  && Fehlerflag setzen
      do ekb4.prg
      store substr(m,1,20)+"Bitte prüfen: Möglicherweise wurde die Datei nach dem Erstellen der Dateiliste gelöscht." to m
      do ekb4.prg
      store substr(m,1,20)+"Es könnte auch sein, dass der Dateiname nicht richtig codiert ist, Sonderzeichen enthält." to m
      do ekb4.prg
      store 0 to x
   endif
	*
   x = at("] sent ",m)
   if x>0
		store substr(m,1,20)+"Job beendet ____________________: "+substr(m,x+2,len(m)-x+3) to m
      do ekb4.prg
      store " " to m
      do ekb4.prg
      store 0 to x
   endif
enddo
* Log-Datei achliessen
set directory to &ORGVERZ
fd1.close()
* Daten des Array 1 in Datei schreiben
fd2 = new File()
fd2.create("Protokoll.txt","A")
fd2.flush()
*
if f="1"  && Ggf. Vermerk zu Fehlern einfügen
	fd2.puts("Es sind Fehler aufgetreten !")
   fd2.puts("Bitte prüfen Sie den Inhalt dieses Protokolls.")
   fd2.puts(" ")
endif
*
for n = 1 to alen(TxtArr1,1)
   fd2.puts(TxtArr1[n,1])
next
fd2.close()
*
set directory to &ORGVERZ
if s="0"
	store "notepad .\Protokoll.txt" to m  && Logdatei anzeigen
else
	store "shutdown /s /t 010" to m  && Shutdown
endif
run (.t.,m)
return
