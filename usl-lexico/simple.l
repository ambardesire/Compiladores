%{
	#include <string.h>
	#include "util.h"
	#include "y.tab.h"
	#include "errormsg.h"

	int charPos=1;

	extern YYSTYPE yylval;

	int yywrap(void){
 		charPos=1;
 		return 1;
	}

	void adjust(void){
 		EM_tokPos=charPos;
 		charPos+=yyleng;
	}

	#define MAX_STR_CONST   256
	char string_buf[MAX_STR_CONST];
	char *string_buf_ptr;

%}

%x STRING
%x COMENTARIO

%%

" "      	  {adjust(); continue;}
\n       	  {adjust(); EM_newline(); continue;}
","		  	  {adjust(); return ',';}
";"			  {adjust(); return FINDEC;}
"="			  {adjust(); return ASIGNA;}
":"           {anjust(); return DEVUELVE;
{			  {adjust(); return ABRECOR;}
}			  {adjust(); return CIERRACOR;}
(			  {adjust(); return ABREPAR;}
)			  {adjust(); return CIERRAPAR;}
"+"			  {adjust(); return SUMA;}
"-"			  {adjust(); return RESTA;}
"*"			  {adjust(); return MULTIPLICA;}
"/"			  {adjust(); return DIVIDE;}
&             {adjust(); return AND;}
|             {adjust(); return OR;}
!			  {adjust(); return NOT;}
==            {adjust(); return IGUAL;}
<>            {adjust(); return DIFER;}
>             {adjust(); return MAYORQUE;}
<             {adjust(); return MENORQUE;}
>=            {adjust(); return MAYORIGUAL;}
<=            {adjust(); return MENORIGUAL;}
[0-9]+		  {adjust(); yylval.ival=atoi(yytext); return ENTERO;}
si 		      {adjust(); return SI;}
otro 		  {adjust(); return OTRO;}
def 		  {adjust(); return DEFINEF;}
despliega 	  {adjust(); return DESPLIEGA;}
mientras 	  {adjust(); return MIENTRAS;}
regresa 	  {adjust(); return REGRESA;}
[a-zA-Z_][a-zA-Z0-9_]+ {adjust(); yylval.sval=String(yytext); return ID;}

"'"                   {BEGIN(STRING);}
<STRING>[^\"]*         {strcpy(u.s,yytext);}
<STRING>"'"           {BEGIN(INITIAL);return CADE;}

"---"                   {BEGIN(COMENTARIO);}
<COMENTARIO>[^[:alnum:]"*/"]* {}
<COMENTARIO>[[:alnum:]]* {}
<COMENTARIO>"---"       {BEGIN(INITIAL)}



<<EOF>>       {printf("\nFin de Archivo encontrado."); exit(0); }

.             {adjust(); EM_error(EM_tokPos, "token ilegal\n");}
