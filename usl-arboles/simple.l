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

%x STRINGS
%x COMENTARIOS

%%

[ \t]+        {adjust(); continue;}
<COMENTARIOS,INITIAL>\n       	  {adjust(); EM_newline(); continue;}
","		  	  {adjust(); return ',';}
";"			  {adjust(); return ';';}
"="			  {adjust(); return '=';}
":"           {adjust(); return ':';}
"{"			  {adjust(); return '{';}
"}"			  {adjust(); return '}';}
"["			  {adjust(); return '[';}
"]"			  {adjust(); return ']';}
"("			  {adjust(); return '(';}
")"			  {adjust(); return ')';}
"+"			  {adjust(); return '+';}
"-"			  {adjust(); return '-';}
"*"			  {adjust(); return '*';}
"/"			  {adjust(); return '/';}
"&&"             {adjust(); return AND;}
"||"             {adjust(); return OR;}
"!"			  {adjust(); return NOT;}
"=="            {adjust(); return IGUAL;}
"<>"            {adjust(); return DIFER;}
">"             {adjust(); return MAYORQUE;}
"<"             {adjust(); return MENORQUE;}
">="            {adjust(); return MAYORIGUAL;}
"<="            {adjust(); return MENORIGUAL;}
[0-9]+		  {adjust(); yylval.ival=atoi(yytext); return ENTERO;}
si 		      {adjust(); return SI;}
otro 		  {adjust(); return OTRO;}
def 		  {adjust(); return DEFINEF;}
despliega 	  {adjust(); return DESPLIEGA;}
mientras 	  {adjust(); return MIENTRAS;}
regresa 	  {adjust(); return REGRESA;}
entero 		  {adjust(); return TIPOENT;}
[a-zA-Z_][a-zA-Z0-9_]* {adjust(); yylval.sval=String(yytext); return ID;}

"\'"                   {BEGIN(STRINGS);}
<STRINGS>[^\']* 		  {yylval.sval=String(yytext);}
<STRINGS>"\'"			{BEGIN(INITIAL);return CADE;}

"---"[-]*[.]*				  {BEGIN(COMENTARIOS);}
<COMENTARIOS>"---"[-]*    {BEGIN(INITIAL);}

<<EOF>> {printf("\nFin de Archivo encontrado."); exit(0);}

.        {adjust(); EM_error(EM_tokPos,"token ilegal");}
%%