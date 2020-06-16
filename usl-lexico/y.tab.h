#ifndef Y_TAB_H
#define Y_TAB_H
typedef union {
   int pos;
   int ival;
   string sval;
} YYSTYPE;
#define	ID	258
#define	CADE	259
#define	ENTERO	260
#define	DESPLIEGA 261
#define SI        262
#define OTRO      263
#define AND       264 
#define OR        265 
#define NOT       266 
#define DIFER     267 
#define IGUAL     268 
#define REGRESA   269
#define DEFINEF   270
#define MIENTRAS  271
#define ASIGNA    272
#define COMENTARIO 273
#define FINDEC	  274
#define ABRECOR   275
#define CIERRACOR 276
#define ABREPAR   277
#define CIERRAPAR 278
#define DEVUELVE  279
#define SUMA      280
#define RESTA     281
#define MULTIPLICA 282
#define DIVIDE    283
#define MAYORQUE  284
#define MENORQUE  285
#define MAYORIGUAL 286
#define MENORIGUAL 287
extern YYSTYPE yylval;
#endif
