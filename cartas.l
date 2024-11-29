%{
#include "cartas.tab.h"
%}

%option noyywrap

/* Tokens */
PALO            oros|copas|espadas|bastos
NUMERO          [1-7]|10|11|12
JUGADOR         jugador=[a-zA-Z]+
REGLA           puntos_maximos=[1-9][0-9]*|valor_cierre=[1-9][0-9]*
ACCION_ROBAR    mazo|descubierta
ACCION_DESCARTE cerrar|continuar
CARTA           {NUMERO}[ ]{PALO}

%%

{CARTA}              { yylval.str = strdup(yytext); return CARTA; }
{JUGADOR}            { yylval.str = strdup(yytext); return JUGADOR; }
{REGLA}              { yylval.str = strdup(yytext); return REGLA; }
{ACCION_ROBAR}       { yylval.str = strdup(yytext); return ACCION_ROBAR; }
{ACCION_DESCARTE}    { yylval.str = strdup(yytext); return ACCION_DESCARTE; }

"="                  { return IGUAL; }
";"                  { return PUNTOYCOMA; }
[ \n\t]              { /* Ignorar espacios */ }
.                    { printf("Error: carácter inesperado '%s'\n", yytext); }

%%
