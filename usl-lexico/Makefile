lextest: driver.o lex.yy.o errormsg.o util.o
	gcc -g -o lextest driver.o lex.yy.o errormsg.o util.o

driver.o: driver.c y.tab.h errormsg.h util.h
	gcc -g -c driver.c

lex.yy.o: lex.yy.c y.tab.h errormsg.h util.h
	gcc -g -c lex.yy.c

lex.yy.c: simple.l y.tab.h
	flex simple.l

errormsg.o: errormsg.c errormsg.h util.h
	gcc -g -c errormsg.c

util.o: util.c util.h
	gcc -g -c util.c

clean: 
	rm -f a.out lextest util.o driver.o lex.yy.o lex.yy.c errormsg.o
