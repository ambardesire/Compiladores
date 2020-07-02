#include "util.h"
#include "slpau.h"
#include <string.h>

A_programi A_Inicial(A_decla declaraciones, A_bloq codigo) {
 A_programi p = checked_malloc(sizeof *p);
 p->clase=A_inicial; p->u.programa.declaraciones=declaraciones; p->u.programa.codigo=codigo;
 return p;
}

A_sent A_SentAsigna(S_symbol id, A_exp exp) {
  A_sent s = checked_malloc(sizeof *s);
  s->clase=A_sentAsigna; s->u.asigna.id=id; s->u.asigna.exp=exp;
  return s;
}

A_sent A_SentDespl(A_exp exp) {
  A_sent s = checked_malloc(sizeof *s);
  s->clase=A_sentDespl; s->u.despl.exp=exp;
  return s;
}

/*A_sent A_SentDesplS(String exp) {
   A_sent s = checked_malloc(sizeof *s);
   s->clase=A_sentDesplS; s->u.despls.exp=exp;
   return s;
}*/

A_sent A_SentSi(A_logexp exp, A_bloq sent) {
   A_sent s = checked_malloc(sizeof *s);
   s->clase=A_sentSi; s->u.si.exp=exp; s->u.si.sent=sent;
   return s;
}

A_sent A_SentSiOtro(A_logexp exp, A_bloq sent1,A_bloq sent2) {
   A_sent s = checked_malloc(sizeof *s);
   s->clase=A_sentSiOtro; s->u.siOtro.exp = exp; s->u.siOtro.sent1=sent1; s->u.siOtro.sent2=sent2;
   return s;
}

A_sent A_SentMientras(A_logexp exp, A_bloq sent) {
   A_sent s = checked_malloc(sizeof *s);
   s->clase=A_sentMientras; s->u.mientras.exp=exp; s->u.mientras.sent=sent;
   return s;
}

A_sent A_SentRegresa(A_exp exp) {
   A_sent s = checked_malloc(sizeof *s);
   s->clase=A_sentRegresa; s->u.regresa.exp=exp;
   return s;
}

A_sent A_SentLlamada(S_symbol id, A_parami param) {
   A_sent s = checked_malloc(sizeof *s);
   s->clase=A_sentLlamada; s->u.llamada.id=id; s->u.llamada.param=param;
   return s;
}

A_decla A_BloqDeclara(A_sentdecla sent, A_decla decla) {
   A_decla d = checked_malloc(sizeof *d);
   d->clase=A_bloqDeclara; d->u.declarar.sent=sent; d->u.declarar.decla=decla;
   return d;
}

A_sentdecla A_VGlobal(S_symbol id, A_exp exp) {
   A_sentdecla c = checked_malloc(sizeof *c);
   c->clase=A_vGlobal; c->u.variable.id=id; c->u.variable.exp=exp;
   return c;
}

A_sentdecla A_DefineF(S_symbol id, A_paramd param, A_bloq bloque) {
   A_sentdecla c = checked_malloc(sizeof *c);
   c->clase=A_defineF; c->u.funcion.id=id; c->u.funcion.param=param; c->u.funcion.bloque=bloque;
   return c;
}

A_bloq A_Bloque(A_bloques bloque) {
   A_bloq b = checked_malloc(sizeof *b);
   b->clase=A_bloque; b->u.bloque.bloque=bloque;
   return b;
}

A_bloq A_BloqAlone(A_sent sent) {
   A_bloq b = checked_malloc(sizeof *b);
   b->clase=A_bloqAlone; b->u.alone.sent=sent;
   return b;
}

A_bloques A_BSentencias(A_sent sentencia, A_bloques sig) {
   A_bloques d = checked_malloc(sizeof *d);
   d->clase=A_bSentencias; d->u.sentencias.sentencia=sentencia; d->u.sentencias.sig=sig;
   return d;
}

A_exp A_ExpId(S_symbol id) {
  A_exp e = checked_malloc(sizeof *e);
  e->clase=A_expId; e->u.id=id;
  return e;
}


A_exp A_ExpNum(int num) {
  A_exp e = checked_malloc(sizeof *e);
  e->clase=A_expNum; e->u.num=num;
  return e;
}

A_exp A_ExpOp(A_exp izq, A_opbin oper, A_exp der) {
  A_exp e = checked_malloc(sizeof *e);
  e->clase=A_expOp; e->u.op.izq=izq; e->u.op.oper=oper; e->u.op.der=der;
  return e;
}

A_exp A_ExpLlamada(S_symbol id, A_parami param) {
   A_exp e = checked_malloc(sizeof *e);
   e->clase=A_expLlamada; e->u.llamada.id=id; e->u.llamada.param=param; 
   return e;
}

A_exp A_ExpParen(A_exp paren) {
   A_exp e = checked_malloc(sizeof *e);
   e->clase=A_expParen; e->u.paren=paren;
   return e;
}

A_logexp A_ExpOpl(A_logexp exp1, A_oplog oper, A_logexp exp2) {
   A_logexp l = checked_malloc(sizeof *l);
   l->clase=A_expOpl; l->u.oplogic.exp1=exp1; l->u.oplogic.oper=oper; l->u.oplogic.exp2=exp2;
   return l;
}

A_logexp A_ExpNot(A_logexp exp1) {
   A_logexp l = checked_malloc(sizeof *l);
   l->clase=A_expNot; l->u.exp1=exp1;
   return l;
}

A_logexp A_ExpLogic(A_exp exp1, A_explog oper, A_exp exp2) {
   A_logexp l = checked_malloc(sizeof *l);
   l->clase=A_expLogic; l->u.explogic.exp1=exp1; l->u.explogic.oper=oper; l->u.explogic.exp2=exp2;
   return l;
}

A_logexp A_LogParen(A_logexp exp1) {
   A_logexp l = checked_malloc(sizeof *l);
   l->clase=A_logParen; l->u.paren.exp1=exp1;
   return l;
}

A_paramd A_ParamdP(S_symbol id, A_lparam param) {
   A_paramd m = checked_malloc(sizeof *m);
   m->clase=A_paramdP; m->u.param.id=id; m->u.param.param=param;
   return m;
}

A_lparam A_LparamdP(S_symbol id, A_lparam param) {
   A_lparam n = checked_malloc(sizeof *n);
   n->clase=A_lparamdP; n->u.param.id=id; n->u.param.param=param;
   return n;
}

A_parami A_ParamiP(A_exp exp, A_lparami param) {
   A_parami i = checked_malloc(sizeof *i);
   i->clase=A_paramiP; i->u.param.exp=exp; i->u.param.param=param;
   return i;
}

A_lparami A_LparamiP(A_exp exp, A_lparami param) {
   A_lparami r = checked_malloc(sizeof *r);
   return r;
}
