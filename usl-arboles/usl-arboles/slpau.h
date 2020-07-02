/* Definiciones para los ‡rboles de sintaxis abstracta */

#ifndef SLPAU_H
#define SLPAU_H

#include <string.h>
#include "symbol.h"

/* Un nodo de un çrbol de Sintaxis Abstracta es una sentencia o una expresion */
/* Declaramos los apuntadores correspondientes.                            */

typedef struct A_programi_ *A_programi;
typedef struct A_decla_ *A_decla;
typedef struct A_bloq_ *A_bloq;
typedef struct A_sentdecla_ *A_sentdecla;
typedef struct A_bloques_ *A_bloques;
typedef struct A_sent_ *A_sent;
typedef struct A_exp_ *A_exp;
typedef struct A_logexp_ *A_logexp;
typedef struct A_paramd_ *A_paramd;
typedef struct A_lparam_ *A_lparam;
typedef struct A_parami_ *A_parami;
typedef struct A_lparami_ *A_lparami;

/* Los tipos de operadores binarios válidos son: */
// -----------------------------------------------------------------------------
typedef enum {A_mas,A_menos,A_por,A_entre} A_opbin;
typedef enum {A_igual,A_difer,A_mayor,A_menor,A_mayori,A_menori} A_explog;
typedef enum {A_and,A_or} A_oplog;
//-------------------------------------------------------------------------------
struct A_programi_ {enum {A_inicial} clase;
            union {struct{A_decla declaraciones; A_bloq codigo;} programa;
            }u;
};

A_programi A_Inicial(A_decla declaraciones, A_bloq codigo);
/*--------------------------------------------------------------------------------
Los nodos de un arbol se definen polimorficamente. Estan formados por:
- Un indicador de cual es el tipo de nodo que estamos creando (dependiendo del tipo
  de sentencia)
- Una union que contiene los campos correspondientes para esa instancia particular
  que estamos creando 
  Asi, por ejemplo, un nodo que almacene una sentencia de asignacion debe contener
  un A_sentComp en el campo clase, y debe utilizar el contenido de campo asigna
  de la union u; es decir debe contener una cadena (el identificador) y un
  apuntador a una estructura de tipo exp (que contiene la expresion).
--------------------------------------------------------------------------------*/

struct A_sent_ {enum {A_sentAsigna, A_sentDespl,A_sentDesplS,A_sentSi,A_sentSiOtro,A_sentMientras,A_sentRegresa,A_sentLlamada} clase;
             union {struct {S_symbol id; A_exp exp;} asigna;
                    struct {A_exp exp;} despl;
                    //struct {String exp;} despls;
                    struct {A_logexp exp; A_bloq sent;} si;
                    struct {A_logexp exp; A_bloq sent1, sent2;} siOtro;
                    struct {A_logexp exp; A_bloq sent;} mientras;
                    struct {A_exp exp;} regresa;
                    struct {S_symbol id; A_parami param;} llamada;
                   } u;
            };

/*------------------------------------------------------------------------------- 
   Para crear cada uno de los nodos, deben existir los constructores
   correspondientes, uno para cada tipo de sentencia valida. Todo lo que hacen
   es crear un nuevo nodo del tipo indicado, solicitando el espacio en memoria
   llenando los campos correspondientes. Cabe hacer notar que hay que tener 
   cuidado al invocarlos dado que tienen un nombre muy parecido al de los
   valores que puede tomar el campo clase de la estructura A_sent.
-------------------------------------------------------------------------------*/
   
A_sent A_SentAsigna(S_symbol id, A_exp exp);
A_sent A_SentDespl(A_exp exp);
//A_sent A_SentDesplS(String exp);
A_sent A_SentSi(A_logexp exp, A_bloq sent);
A_sent A_SentSiOtro(A_logexp exp, A_bloq sent1,A_bloq sent2);
A_sent A_SentMientras(A_logexp exp, A_bloq sent);
A_sent A_SentRegresa(A_exp exp);
A_sent A_SentLlamada(S_symbol id,A_parami param);
// -----------------------------------------------------------------------------
struct A_decla_ {enum {A_bloqDeclara} clase;
            union{struct {A_sentdecla sent; A_decla decla;} declarar;
                }u;
            };
A_decla A_BloqDeclara(A_sentdecla sent, A_decla decla);
// -----------------------------------------------------------------------------
struct A_sentdecla_ {enum {A_vGlobal,A_defineF} clase;
            union{struct {S_symbol id; A_exp exp;} variable;
                  struct {S_symbol id; A_paramd param; A_bloq bloque;} funcion;
                  }u;
            };
A_sentdecla A_VGlobal(S_symbol id, A_exp exp);
A_sentdecla A_DefineF(S_symbol id, A_paramd param, A_bloq bloque);
// -----------------------------------------------------------------------------
struct A_bloq_ {enum {A_bloque,A_bloqAlone} clase;
            union{struct {A_bloques bloque;} bloque;
                  struct {A_sent sent;} alone;
            }u;
};

A_bloq A_Bloque(A_bloques bloque);
A_bloq A_BloqAlone(A_sent sent);
// -----------------------------------------------------------------------------
struct A_bloques_ {enum{A_bSentencias} clase;
            union {struct{A_sent sentencia; A_bloques sig;} sentencias;
            }u;
};

A_bloques A_BSentencias(A_sent sentencia, A_bloques sig);
// -----------------------------------------------------------------------------
struct A_exp_ {enum {A_expId, A_expNum, A_expOp,A_expLlamada,A_expParen} clase;
             union {S_symbol id;
                    int num;
                    struct {A_exp izq; A_opbin oper; A_exp der;} op;
                    struct {S_symbol id;A_parami param;} llamada;
                    A_exp paren;
                   } u;
            };

A_exp A_ExpId(S_symbol id);
A_exp A_ExpNum(int num);
A_exp A_ExpOp(A_exp izq, A_opbin oper, A_exp der);
A_exp A_ExpLlamada(S_symbol id,A_parami param);
A_exp A_ExpParen(A_exp paren);
// -----------------------------------------------------------------------------
struct A_logexp_ {enum{A_expOpl,A_expNot,A_expLogic,A_logParen} clase;
            union {struct{A_logexp exp1; A_oplog oper; A_logexp exp2;} oplogic; //para and y or
                  A_logexp exp1;
                  struct{A_exp exp1; A_explog oper; A_exp exp2;} explogic; //para mayor que, menor que y eso
                  struct{A_logexp exp1;} paren;
            }u;
};

A_logexp A_ExpOpl(A_logexp exp1, A_oplog oper, A_logexp exp2);//para and y or
A_logexp A_ExpNot(A_logexp exp1);
A_logexp A_ExpLogic(A_exp exp1, A_explog oper, A_exp exp2);//para mayor que, menor que y eso
A_logexp A_LogParen(A_logexp exp1);
// -----------------------------------------------------------------------------
struct A_paramd_ {enum{A_paramdP} clase;
            union {struct{S_symbol id; A_lparam param;} param;
            }u;
};

A_paramd A_ParamdP(S_symbol id, A_lparam param);
// -----------------------------------------------------------------------------
struct A_lparam_ {enum{A_lparamdP} clase;
            union {struct{S_symbol id; A_lparam param;} param;
            }u;
};

A_lparam A_LparamdP(S_symbol id, A_lparam param);
// -----------------------------------------------------------------------------
struct A_parami_ {enum{A_paramiP} clase;
            union {struct{A_exp exp; A_lparami param;} param;
            }u;
};

A_parami A_ParamiP(A_exp exp, A_lparami param);
// -----------------------------------------------------------------------------
struct A_lparami_ {enum{A_lparamiP} clase;
            union {struct{A_exp exp; A_lparami param;} param;
            }u;
};

A_lparami A_LparamiP(A_exp exp, A_lparami param);
#endif
