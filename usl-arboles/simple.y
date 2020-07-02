%{
/* simple.y: Contiene los inicios de una especificacion para usarse en bison*/

#include <stdio.h>
#include "util.h"
#include "errormsg.h"
#include "slpau.h"
#include "symbol.h"
#include "tokens.h"

A_programi raiz_sintabs;

int yylex(void); /* C necesita conocer el prototipo de la función de  */
		 /* Análisis Léxico                                    */

void yyerror(char *s)
{
  EM_error(EM_tokPos, "%s", s);
}
%}

%union{
  int ival;
  char *sval;
  A_programi programi;
  A_decla decla;
  A_sentdecla sentdecla;
  A_bloq bloq;
  A_bloques bloques;
  A_sent sent;
  A_exp exp;
  A_logexp logexp;
  A_paramd paramd;
  A_lparam lparam;
  A_parami parami;
  A_lparami lparami;
}

%type<programi> program programi
%type<decla> decla
%type<sentdecla> sentdecla
%type<bloq> bloq
%type<bloques> bloques
%type<sent> sent
%type<exp> exp
%type<logexp> logexp
%type<paramd> paramd
%type<lparam> lparam
%type<parami> parami
%type<lparami> lparami 

%token <sval> ID 
%token <ival> ENTERO

%token  CADE
%token  DESPLIEGA
%token  REGRESA
%token  TIPOENT
%nonassoc  SI
%nonassoc  OTRO
%nonassoc  MIENTRAS
%nonassoc  DEFINEF
%nonassoc  ID
%nonassoc  ENTERO

%right  '='
%right  NOT
%left  OR
%left  AND
%right  DIFER IGUAL MAYORQUE MENORQUE MAYORIGUAL MENORIGUAL
%left  '+' '-'
%left  '*' '/'      

%start program

/* A continuación la gramática */
                                 
%%

program: programi							{raiz_sintabs=$1;}
;

programi: decla bloq 							{$$=A_Inicial($1,$2);}
;

decla:													{}
	| sentdecla decla						{$$=A_BloqDeclara($1,$2);}
;

sentdecla: ID '=' exp ';'						{$$=A_VGlobal(S_Symbol($1),$3);}
	| DEFINEF ID '(' paramd ')' ':' TIPOENT bloq 			{$$=A_DefineF(S_Symbol($2),$4,$8);}
;

bloq: '{' bloques '}'							{$$=A_Bloque($2);}
	| sent 								{$$=A_BloqAlone($1);}
;

bloques: 										{}
	| sent bloques							{$$=A_BSentencias($1,$2);}
;

sent: DESPLIEGA '(' exp ')' ';'						{$$=A_SentDespl($3);}
//    | DESPLIEGA '(' CADE ')' ';' 					{$$=A_SentDesplS($3);}
    | SI  logexp  bloq %prec SI 					{$$=A_SentSi($2,$3);}
    | SI  logexp  bloq OTRO bloq 					{$$=A_SentSiOtro($2,$3,$5);}
    | MIENTRAS  logexp  bloq %prec MIENTRAS 				{$$=A_SentMientras($2,$3);}
    | ID '=' exp ';'							{$$=A_SentAsigna(S_Symbol($1),$3);}
    | REGRESA exp ';'							{$$=A_SentRegresa($2);}
    | ID '(' parami ')' ';'						{$$=A_SentLlamada(S_Symbol($1),$3);}
    ;

exp: ENTERO								{$$=A_ExpNum($1);}
	| ID 								{$$=A_ExpId(S_Symbol($1));}
	| ID '(' parami ')' 						{$$=A_ExpLlamada(S_Symbol($1),$3);}
	| exp '+' exp 							{$$=A_ExpOp($1,A_mas,$3);}
	| exp '-' exp 							{$$=A_ExpOp($1,A_menos,$3);}
	| exp '*' exp 							{$$=A_ExpOp($1,A_por,$3);}
	| exp '/' exp 							{$$=A_ExpOp($1,A_entre,$3);}
	| '(' exp ')' 							{$$=A_ExpParen($2);}
   ;

logexp: logexp AND logexp 						{$$=A_ExpOpl($1,A_and,$3);}
	| logexp OR logexp 						{$$=A_ExpOpl($1,A_or,$3);}
	| NOT logexp 							{$$=A_ExpNot($2);}
	| exp IGUAL exp 						{$$=A_ExpLogic($1,A_igual,$3);}
	| exp DIFER exp 						{$$=A_ExpLogic($1,A_difer,$3);}
	| exp MAYORQUE exp   						{$$=A_ExpLogic($1,A_mayor,$3);}
	| exp MENORQUE exp 						{$$=A_ExpLogic($1,A_menor,$3);}
	| exp MAYORIGUAL exp 						{$$=A_ExpLogic($1,A_mayori,$3);}
	| exp MENORIGUAL exp 						{$$=A_ExpLogic($1,A_menori,$3);}
	| '(' logexp ')'    						{$$=A_LogParen($2);}
	;

paramd: 										{}
	| ID lparam 							{$$=A_ParamdP(S_Symbol($1),$2);}
;

lparam:											{}
	| ',' ID lparam 						{$$=A_LparamdP(S_Symbol($2),$3);}
	;

parami:											{}
	| exp lparami 							{$$=A_ParamiP($1,$2);}
;

lparami:										{}
	| ',' exp lparami 						{$$=A_LparamiP($2,$3);}
	;
