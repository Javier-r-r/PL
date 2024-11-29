## PL. Fichero makefile basico
# FUENTE: nombre fichero fuente con extension .l
FUENTE = cartas
# PRUEBA: nombre fichero de prueba
PRUEBA1 = prueba1.xml
PRUEBA2 = prueba2.xml
PRUEBA3 = prueba3.xml
PRUEBA4 = prueba4.xml
PRUEBA5 = prueba5.xml
PRUEBA6 = prueba6.xml
PRUEBA7 = prueba7.xml
# LIB (libreria flex): lfl (gnu/linux, windows); ll (macos)
LIB = lfl

all: compile run

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -$(LIB) -ly

counter:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd -Wcounterexamples
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -$(LIB) -ly

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h

run:
	./$(FUENTE)

run%:
	./$(FUENTE) $(PRUEBA$*)
