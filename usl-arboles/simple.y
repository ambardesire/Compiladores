%{
/* simple.y: Contiene los inicios de una especificacion para usarse en bison*/

#include <stdio.h>
#include "util.h"
#include "errormsg.h"
#include "slpau.h"
#include "symbol.h"
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

program: programi										{raiz_sintabs=$1;}
;

programi: decla bloq 									{$$=A_Inicial($1,$2);}
;

decla:													
	| sentdecla decla									{$$=A_bloqDeclara($1,$2);}
;

sentdecla: ID '=' exp ';'								{$$=A_vGlobal($1,$3);}
	| DEFINEF ID '(' paramd ')' ':' TIPOENT bloq 		{$$=A_defineF($2,$4,$8);}
;

bloq: '{' bloques '}'									{$$=A_bloque($2);}
	| sent 												{$$=A_bloqAlone($1);}
;

bloques: 
	| sent bloques										{$$=A_bSentencias($1,$2);}
;

sent: DESPLIEGA '(' exp ')' ';'							{$$=A_SentDespl($3);}
	| DESPLIEGA '(' CADE ')' ';' 						{$$=A_SentDesplS($3);}
    | SI  logexp  bloq %prec SI 						{$$=A_sentSi($2,$3);}
    | SI  logexp  bloq OTRO bloq 						{$$=A_sentSiOtro($2,$3,$5);}
    | MIENTRAS  logexp  bloq %prec MIENTRAS 			{$$=A_sentMientras($2,$3);}
    | ID '=' exp ';'									{$$=A_SentAsigna(S_Symbol($1),$3);}
    | REGRESA exp ';'									{$$=A_sentRegresa($2);}
    | ID '(' parami ')' ';'								{$$=A_SentAsigna(S_Symbol($1),$3);}
    ;

exp: ENTERO												{$$=A_ExpNum($1);}
	| ID 												{$$=A_ExpId(S_Symbol($1));}
	| ID '(' parami ')' 								{$$=A_expLlamada(S_Symbol($1),$3);}
	| exp '+' exp 										{$$=A_ExpOp($1,A_mas,$3);}
	| exp '-' exp 										{$$=A_ExpOp($1,A_menos,$3);}
	| exp '*' exp 										{$$=A_ExpOp($1,A_por,$3);}
	| exp '/' exp 										{$$=A_ExpOp($1,A_entre,$3);}
	| '(' exp ')' 										{$$=A_expParen($2);}
   ;

logexp: logexp AND logexp 								{$$=A_expOpl($1,A_and,$3);}
	| logexp OR logexp 									{$$=A_expOpl($1,A_or,$3);}
	| NOT logexp 										{$$=A_expNot($2);}
	| exp IGUAL exp 									{$$=A_expOpl($1,A_igual,$3);}
	| exp DIFER exp 									{$$=A_expOpl($1,A_difer,$3);}
	| exp MAYORQUE exp   								{$$=A_expOpl($1,A_mayor,$3);}
	| exp MENORQUE exp 									{$$=A_expOpl($1,A_menor,$3);}
	| exp MAYORIGUAL exp 								{$$=A_expOpl($1,A_mayori,$3);}
	| exp MENORIGUAL exp 								{$$=A_expOpl($1,A_menori,$3);}
	| '(' logexp ')'    								{$$=A_logParen($2);}
	;

paramd:
	| ID lparam 										{$$=A_paramdP(S_Symbol($1),$2);}
;

lparam:
	| ',' ID lparam 									{$$=A_lparamdP(S_Symbol($2),$3);}
	;

parami:
	| exp lparami 										{$$=A_paramiP(S_Symbol($1),$2);}
;

lparami:
	| ',' exp lparami 									{$$=A_lparamiP(S_Symbol($2),$3);}
	;