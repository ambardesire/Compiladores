%{
/* simple.y: Contiene los inicios de una especificacion para usarse en bison*/

#include <stdio.h>
#include "util.h"
#include "errormsg.h"
#include "tokens.h"


int yylex(void); /* C necesita conocer el prototipo de la función de  */
		 /* Análisis Léxico                                    */

void yyerror(char *s)
{
  EM_error(EM_tokPos, "%s", s);
}
%}

%token  ID
%token  CADE
%token  ENTERO
%token  DESPLIEGA
%token  REGRESA
%token  TIPOENT
%nonassoc  NOT OR AND
%nonassoc  SI
%nonassoc  OTRO
%nonassoc  MIENTRAS
%nonassoc  DEFINEF

%right  '='
%right  DIFER IGUAL MAYORQUE MENORQUE MAYORIGUAL MENORIGUAL
%left  '+' '-'
%left  '*' '/'


%union{
  int ival;
  char *sval;
};
        
%start program

/* A continuación la gramática */
                                 
%%

program: decla bloq
;

decla:
	| sentdecla decla
;

sentdecla: ID '=' exp ';'
	| DEFINEF ID '(' paramd ')' ':' TIPOENT '{' bloques '}'
;

bloq: '{' bloques '}'
;

bloques: 
	| sent bloques
;

sent: 
	| DESPLIEGA '(' exp ')' ';'
	| DESPLIEGA '(' CADE ')' ';' 
    | SI '(' exp ')' sent %prec SI 
    | SI '(' exp ')' sent OTRO sent
    | SI  exp  sent %prec SI 
    | SI  exp  sent OTRO sent
    | SI '(' exp ')' '{' bloques '}' %prec SI 
    | SI '(' exp ')' '{' bloques '}' OTRO sent
    | SI  exp  '{' bloques '}' %prec SI 
    | SI  exp  '{' bloques '}' OTRO sent
    | MIENTRAS '(' exp ')' sent %prec MIENTRAS 
    | MIENTRAS  exp  sent %prec MIENTRAS 
    | MIENTRAS '(' exp ')' '{' bloques '}' %prec MIENTRAS 
    | MIENTRAS  exp  '{' bloques '}' %prec MIENTRAS 
    | ID '=' exp ';'
    | REGRESA exp ';'
    | ID '(' parami ')' ';'
    ;

exp: ENTERO
	| ID
	| ID '(' parami ')'
	| exp '+' exp
	| exp '-' exp
	| exp '*' exp
	| exp '/' exp
	| exp AND exp
	| exp OR exp
	| NOT exp
	| '(' exp ')'
	| exp IGUAL exp
	| exp DIFER exp
	| exp MAYORQUE exp
	| exp MENORQUE exp
	| exp MAYORIGUAL exp
	| exp MENORIGUAL exp
   ;

paramd:
	| ID
	| ID ',' paramd
;

parami:
	| exp
	| exp ',' parami
	| ID
	| ID ',' parami
;