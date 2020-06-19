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
%nonassoc  SI
%nonassoc  OTRO
%nonassoc  MIENTRAS
%nonassoc  DEFINEF

%right  '='
%right  NOT
%left  OR
%left  AND
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

sent: DESPLIEGA '(' exp ')' ';'
	| DESPLIEGA '(' CADE ')' ';' 
    | SI '(' logexp ')' sent %prec SI 
    | SI '(' logexp ')' sent OTRO sent
    | SI  logexp  sent %prec SI 
    | SI  logexp  sent OTRO sent
    | SI '(' logexp ')' '{' bloques '}' %prec SI 
    | SI '(' logexp ')' '{' bloques '}' OTRO sent
    | SI  logexp  '{' bloques '}' %prec SI 
    | SI  logexp  '{' bloques '}' OTRO sent
    | MIENTRAS '(' logexp ')' sent %prec MIENTRAS 
    | MIENTRAS  logexp  sent %prec MIENTRAS 
    | MIENTRAS '(' logexp ')' '{' bloques '}' %prec MIENTRAS 
    | MIENTRAS  logexp  '{' bloques '}' %prec MIENTRAS 
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
	| '(' exp ')'
   ;

logexp: logexp AND logexp
	| logexp OR logexp
	| NOT logexp
	| exp IGUAL exp
	| exp DIFER exp
	| exp MAYORQUE exp
	| exp MENORQUE exp
	| exp MAYORIGUAL exp
	| exp MENORIGUAL exp
	;

paramd:
	| ID lparam
;

lparam:
	| ',' ID lparam
	;

parami:
	| exp lparami
;

lparami:
	| ',' exp lparami
	;