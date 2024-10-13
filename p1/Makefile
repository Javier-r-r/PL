### PL. Fichero makefile basico
# FUENTE: nombre fichero fuente con extension .l
FUENTE = practica1
# PRUEBA: nombre fichero de prueba
PRUEBA1 = prueba1.txt
PRUEBA2 = prueba2.txt
PRUEBA3 = prueba3.txt
# LIB (libreria flex): lfl (gnu/linux, windows); ll (macos)
LIB = lfl

all: compile

compile:
	flex $(FUENTE).l
	gcc -o $(FUENTE) lex.yy.c -$(LIB)

clean:
	rm $(FUENTE) lex.yy.c 

run:
	./$(FUENTE)

run1:
	./$(FUENTE) $(PRUEBA1)

run2:
	./$(FUENTE) $(PRUEBA2)

run3:
	./$(FUENTE) $(PRUEBA3)
