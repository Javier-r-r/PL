%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *msg);
int yylex();

typedef struct {
    char *palo;
    int numero;
} Carta;

typedef struct {
    char *nombre;
    Carta mano[7];
} Jugador;

Jugador jugadores[4];
int num_jugadores = 0;
int puntos_maximos = 0;
int valor_cierre = 0;
Carta mazo[40];
int top_mazo = -1;

void agregar_jugador(const char *nombre);
void agregar_carta_a_mazo(Carta carta);
%}

%union {
    char* str;
    Carta carta;
}

/* Tokens */
%token <str> JUGADOR REGLA ACCION_ROBAR ACCION_DESCARTE
%token <carta> CARTA
%type <str> PARTIDA CONFIGURACION REGLAS JUGADORES
%type <carta> MAZO ACCION ESTADO

%%

PARTIDA:
    CONFIGURACION TURNO_LISTA
    ;

CONFIGURACION:
    REGLAS JUGADORES MAZO
    ;

REGLAS:
    REGLA {
        if (strncmp($1, "puntos_maximos=", 15) == 0) {
            puntos_maximos = atoi($1 + 15);
        } else if (strncmp($1, "valor_cierre=", 13) == 0) {
            valor_cierre = atoi($1 + 13);
        }
        free($1);
    }
    ;

JUGADORES:
    JUGADOR {
        agregar_jugador($1);
        free($1);
    }
    | JUGADOR JUGADORES
    ;

MAZO:
    CARTA {
        agregar_carta_a_mazo($1);
    }
    | CARTA MAZO
    ;

TURNO_LISTA:
    TURNO TURNO_LISTA
    | TURNO
    ;

TURNO:
    JUGADOR ACCION {
        printf("Turno del jugador %s.\n", $1);
        free($1);
    }
    ;

ACCION:
    ACCION_ROBAR {
        printf("Acción: Robar %s.\n", $1);
        free($1);
    }
    | ACCION_DESCARTE {
        printf("Acción: %s.\n", $1);
        free($1);
    }
    ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}

void agregar_jugador(const char *nombre) {
    if (num_jugadores >= 4) {
        yyerror("Demasiados jugadores. Máximo 4.");
        return;
    }
    jugadores[num_jugadores].nombre = strdup(nombre);
    jugadores[num_jugadores].num_cartas = 0;
    num_jugadores++;
}

void agregar_carta_a_mazo(Carta carta) {
    if (top_mazo >= 39-num_jugadores*7) {
        printf("El mazo está lleno.");
        return;
    }
    mazo[++top_mazo] = carta;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("No se puede abrir el archivo");
            return 1;
        }
        yyin = file;
    }

    printf("Hola soy el chinchoneitor, cuantos vais a jugar?\n");

    yyparse();

    if (!cabecera) {
        yyerror("No se ha encontrado la cabecera XML.");
    }

    if (isEmpty()) {
        printf("Sintaxis XML correcta.\n");
    } else {
        yyerror("Etiquetas sin cerrar.");
    }
    fclose(yyin);
    return 0;
}
