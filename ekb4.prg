* ekb4.prg
** END HEADER *
* Array vergrößern, Daten schreiben
if n>0
	TxtArr1.grow(1)  && Array 1 vergrößern
endif
store n+1 to n  && Zähler für Arrayzeilen weitersetzen
store m to TxtArr1[n,1]  && konv. Daten schreiben
return
