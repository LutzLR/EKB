* ekb4.prg
** END HEADER *
* Array vergr��ern, Daten schreiben
if n>0
	TxtArr1.grow(1)  && Array 1 vergr��ern
endif
store n+1 to n  && Z�hler f�r Arrayzeilen weitersetzen
store m to TxtArr1[n,1]  && konv. Daten schreiben
return
