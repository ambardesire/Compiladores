
parsetst: parsetst.o y.tab.o lex.yy.o errormsg.o util.o table.o symbol.o slpau.o
	gcc -g -o parsetst parsetst.o y.tab.o lex.yy.o errormsg.o util.o table.o symbol.o slpau.o

parsetst.o: parsetst.c tokens.h errormsg.h util.h
	gcc -g -c parsetst.c

errormsg.o: errormsg.c errormsg.h util.h
	gcc -g -c errormsg.c

lex.yy.o: lex.yy.c y.tab.h errormsg.h util.h
	gcc -g -c lex.yy.c

lex.yy.c: simple.l y.tab.h simple.y
	flex simple.l

y.tab.o: y.tab.c errormsg.h util.h
	gcc -g -c y.tab.c

y.tab.c: simple.y
	bison -dvy simple.y

util.o: util.c util.h
	gcc -g -c util.c

table.o: table.c table.h util.h
	gcc -g -c table.c

symbol.o: symbol.c util.h table.h
	gcc -g -c symbol.c

slpau.o: slpau.c util.h slpau.h
	gcc -g -c slpau.c

clean: 
	rm -f lextest *.o y.output y.vcg
realclean: 
	rm -f a.out parsetst lextest *.o lex.yy.c y.tab.c y.tab.h\
	      y.output y.vcg *~