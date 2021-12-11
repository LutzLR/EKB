* ekb2.prg
** END HEADER *
set directory to &ORGVERZ
* Bereinigen der Eingaben, trimmen
store ltrim(rtrim(quelle1)) to quelle1
store ltrim(rtrim(quelle2)) to quelle2
store ltrim(rtrim(quelle3)) to quelle3
store ltrim(rtrim(quelle4)) to quelle4
store ltrim(rtrim(quelle5)) to quelle5
store ltrim(rtrim(quelle6)) to quelle6
store ltrim(rtrim(quelle7)) to quelle7
store ltrim(rtrim(ziel)) to ziel
store ltrim(rtrim(ausschl1)) to ausschl1
store ltrim(rtrim(ausschl2)) to ausschl2
* Bereinigen der Eingaben, ggf. fehlende \ ergänzen
if len(quelle1)>0 AND substr(quelle1,len(quelle1),1)#"\"
	store quelle1+"\" to quelle1
endif
if len(quelle2)>0 AND substr(quelle2,len(quelle2),1)#"\"
	store quelle2+"\" to quelle2
endif
if len(quelle3)>0 AND substr(quelle3,len(quelle3),1)#"\"
	store quelle3+"\" to quelle3
endif
if len(quelle4)>0 AND substr(quelle4,len(quelle4),1)#"\"
	store quelle4+"\" to quelle4
endif
if len(quelle5)>0 AND substr(quelle5,len(quelle5),1)#"\"
	store quelle5+"\" to quelle5
endif
if len(quelle6)>0 AND substr(quelle6,len(quelle6),1)#"\"
	store quelle6+"\" to quelle6
endif
if len(quelle7)>0 AND substr(quelle7,len(quelle7),1)#"\"
	store quelle7+"\" to quelle7
endif
if len(ziel)>0 AND substr(ziel,len(ziel),1)#"\"
	store ziel+"\" to ziel
endif
* cfg-Datei mit altem Inhalt löschen
if file ("ekb.cfg")
	delete file ekb.cfg
endif
* Daten in ekb.cfg schreiben
fd1 = new File()
fd1.create("ekb.cfg","A")
fd1.puts(quelle1)
fd1.puts(quelle2)
fd1.puts(quelle3)
fd1.puts(quelle4)
fd1.puts(quelle5)
fd1.puts(quelle6)
fd1.puts(quelle7)
fd1.puts(ziel)
fd1.puts(s)
* Syntax der Eingaben an cygwin anpassen
* C: durch /cygdrive/c usw. ersetzen
if len(quelle1)>1
	store "/cygdrive/"+substr(quelle1,1,1)+substr(quelle1,3,len(quelle1)-2) to quelle1
endif
if len(quelle2)>1
	store "/cygdrive/"+substr(quelle2,1,1)+substr(quelle2,3,len(quelle2)-2) to quelle2
endif
if len(quelle3)>1
	store "/cygdrive/"+substr(quelle3,1,1)+substr(quelle3,3,len(quelle3)-2) to quelle3
endif
if len(quelle4)>1
	store "/cygdrive/"+substr(quelle4,1,1)+substr(quelle4,3,len(quelle4)-2) to quelle4
endif
if len(quelle5)>1
	store "/cygdrive/"+substr(quelle5,1,1)+substr(quelle5,3,len(quelle5)-2) to quelle5
endif
if len(quelle6)>1
	store "/cygdrive/"+substr(quelle6,1,1)+substr(quelle6,3,len(quelle6)-2) to quelle6
endif
if len(quelle7)>1
	store "/cygdrive/"+substr(quelle7,1,1)+substr(quelle7,3,len(quelle7)-2) to quelle7
endif
if len(ziel)>1
	store "/cygdrive/"+substr(ziel,1,1)+substr(ziel,3,len(ziel)-2) to ziel
endif
* "\" durch "/" ersetzen
for n=1 to len(quelle1) step 1
	if substr(quelle1,n,1)="\"
		store substr(quelle1,1,n-1)+"/"+substr(quelle1,n+1,len(quelle1)-n) to quelle1
	endif
next
for n=1 to len(quelle2) step 1
	if substr(quelle2,n,1)="\"
		store substr(quelle2,1,n-1)+"/"+substr(quelle2,n+1,len(quelle2)-n) to quelle2
	endif
next
for n=1 to len(quelle3) step 1
	if substr(quelle3,n,1)="\"
		store substr(quelle3,1,n-1)+"/"+substr(quelle3,n+1,len(quelle3)-n) to quelle3
	endif
next
for n=1 to len(quelle4) step 1
	if substr(quelle4,n,1)="\"
		store substr(quelle4,1,n-1)+"/"+substr(quelle4,n+1,len(quelle4)-n) to quelle4
	endif
next
for n=1 to len(quelle5) step 1
	if substr(quelle5,n,1)="\"
		store substr(quelle5,1,n-1)+"/"+substr(quelle5,n+1,len(quelle5)-n) to quelle5
	endif
next
for n=1 to len(quelle6) step 1
	if substr(quelle6,n,1)="\"
		store substr(quelle6,1,n-1)+"/"+substr(quelle6,n+1,len(quelle6)-n) to quelle6
	endif
next
for n=1 to len(quelle7) step 1
	if substr(quelle7,n,1)="\"
		store substr(quelle7,1,n-1)+"/"+substr(quelle7,n+1,len(quelle7)-n) to quelle7
	endif
next
for n=1 to len(ziel) step 1
	if substr(ziel,n,1)="\"
		store substr(ziel,1,n-1)+"/"+substr(ziel,n+1,len(ziel)-n) to ziel
	endif
next
* exclude-list-Datei mit altem Inhalt löschen
if file ("exclude-list.txt")
	delete file exclude-list.txt
endif
* Batchdatei mit altem Inhalt löschen
if file ("backup.cmd")
	delete file backup.cmd
endif
* log-Dateien mit altem Inhalt löschen
if file ("Logdatei.txt")
	delete file Logdatei.txt
endif
if file ("Protokoll.txt")
	delete file Protokoll.txt
endif
* Daten in exclude-list.txt schreiben
fd2 = new File()
fd2.create("exclude-list.txt","A")
fd2.puts(ausschl1)
fd2.puts(ausschl2)
* Dateien schließen
fd1.close()
fd2.close()
* Backup.cmd erstellen
fd1 = new File()
fd1.create("backup.cmd","A")
store "@echo off" to m
fd1.puts(m)
store "color F1" to m
fd1.puts(m)
store "set cygwin=nontsec" to m
fd1.puts(m)
if quelle1<>""
   store "rsync --delete -auvPb --exclude-from 'exclude-list.txt' --ignore-errors '"+oem(quelle1);
   +"' '"+oem(ziel+"1/")+"' --log-file=./Logdatei.txt --backup-dir='"+oem(ziel)+"x1'" to m
   fd1.puts(m)
endif
if quelle2<>""
   store "rsync --delete -auvPb --exclude-from 'exclude-list.txt' --ignore-errors '"+oem(quelle2);
   +"' '"+oem(ziel+"2/")+"' --log-file=./Logdatei.txt --backup-dir='"+oem(ziel)+"x2'" to m
   fd1.puts(m)
endif
if quelle3<>""
   store "rsync --delete -auvPb --exclude-from 'exclude-list.txt' --ignore-errors '"+oem(quelle3);
   +"' '"+oem(ziel+"3/")+"' --log-file=./Logdatei.txt --backup-dir='"+oem(ziel)+"x3'" to m
   fd1.puts(m)
endif
if quelle4<>""
   store "rsync --delete -auvPb --exclude-from 'exclude-list.txt' --ignore-errors '"+oem(quelle4);
   +"' '"+oem(ziel+"4/")+"' --log-file=./Logdatei.txt --backup-dir='"+oem(ziel)+"x4'" to m
   fd1.puts(m)
endif
if quelle5<>""
   store "rsync --delete -auvPb --exclude-from 'exclude-list.txt' --ignore-errors '"+oem(quelle5);
   +"' '"+oem(ziel+"5/")+"' --log-file=./Logdatei.txt --backup-dir='"+oem(ziel)+"x5'" to m
   fd1.puts(m)
endif
if quelle6<>""
   store "rsync --delete -auvPb --exclude-from 'exclude-list.txt' --ignore-errors '"+oem(quelle6);
   +"' '"+oem(ziel+"6/")+"' --log-file=./Logdatei.txt --backup-dir='"+oem(ziel)+"x6'" to m
   fd1.puts(m)
endif
if quelle7<>""
   store "rsync --delete -auvPb --exclude-from 'exclude-list.txt' --ignore-errors '"+oem(quelle7);
   +"' '"+oem(ziel+"7/")+"' --log-file=./Logdatei.txt --backup-dir='"+oem(ziel)+"x7'" to m
   fd1.puts(m)
endif
store "unix2dos .\Logdatei.txt" to m  && Konvertierung der Zeilenumbrüche
fd1.puts(m)
store "rem Ende" to m
fd1.puts(m)
fd1.close()
*
return