%{
  #include <stdio.h>
  int num_caracteres = 0;
  int num_palabras = 0;
  int num_palabras_may = 0;
  int num_palabras_min = 0;
  int num_palabras_num = 0;
  int num_frases = 0;

  int yyleng_blancos() {
    int count = 0;
    for (int i = 0; yytext[i] != '\0'; i++) {
        if (yytext[i] == ' ' || yytext[i] == '\t') {
            count++;
        }
    }
    return count;
  }

%}

mayus [A-ZÁÉÍÓÚÜÑÇ]+
minus [a-záéíóúüñç]+
num [0-9]+
palabra [^ \t\n.]+
blanco [ \t]+
puntos \.{1,}
linea [\n]+

%%

{mayus} {num_palabras++; num_caracteres += yyleng; num_palabras_may++;}      
{mayus}{blanco}{puntos} {num_frases++; num_palabras++; num_caracteres += yyleng - yyleng_blancos(); num_palabras_may++;} 

{minus} {num_palabras++; num_caracteres += yyleng; num_palabras_min++;}   
{minus}{blanco}{puntos} {num_frases++; num_palabras++; num_caracteres += yyleng - yyleng_blancos(); num_palabras_min++;}    

{num} {num_palabras++; num_caracteres += yyleng; num_palabras_num++;}  
{num}{blanco}{puntos} {num_frases++; num_palabras++; num_caracteres += yyleng - yyleng_blancos(); num_palabras_num++;}  

{palabra} {num_palabras++; num_caracteres += yyleng;} 
{palabra}{blanco}{puntos} {num_frases++; num_caracteres += yyleng - yyleng_blancos(); num_palabras++;}

{puntos} {num_caracteres += yyleng;}	
{linea} {num_caracteres += yyleng;}

{blanco} ;  //Ignorar espacios y tabulaciones

%%

int main(int argc, char **argv) {

	//Intenta abrir el archivo pasado como parámetro
	if (argc > 1) {
  	yyin = fopen(argv[1], "r");
    if (!yyin) {
    	perror("Error al abrir el archivo");
      return 1;
    }
  }

	//Analizador léxico
  yylex(); 

  //Resultados
  printf("Número total de caracteres: %d\n", num_caracteres);
  printf("Número total de palabras: %d\n", num_palabras);
  printf("Número de palabras en mayúsculas: %d\n", num_palabras_may);
  printf("Número de palabras en minúsculas: %d\n", num_palabras_min);
  printf("Número de palabras numéricas: %d\n", num_palabras_num);
  printf("Número de frases: %d\n", num_frases);
    
  //Cerrar el archivo solo si se abrió correctamente
  if (yyin != NULL) {
  	fclose(yyin); 
  }

  return 0;

}
