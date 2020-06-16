/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    CADE = 259,
    ENTERO = 260,
    DESPLIEGA = 261,
    REGRESA = 262,
    TIPOENT = 263,
    NOT = 264,
    OR = 265,
    AND = 266,
    SI = 267,
    OTRO = 268,
    MIENTRAS = 269,
    DEFINEF = 270,
    DIFER = 271,
    IGUAL = 272,
    MAYORQUE = 273,
    MENORQUE = 274,
    MAYORIGUAL = 275,
    MENORIGUAL = 276
  };
#endif
/* Tokens.  */
#define ID 258
#define CADE 259
#define ENTERO 260
#define DESPLIEGA 261
#define REGRESA 262
#define TIPOENT 263
#define NOT 264
#define OR 265
#define AND 266
#define SI 267
#define OTRO 268
#define MIENTRAS 269
#define DEFINEF 270
#define DIFER 271
#define IGUAL 272
#define MAYORQUE 273
#define MENORQUE 274
#define MAYORIGUAL 275
#define MENORIGUAL 276

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 37 "simple.y" /* yacc.c:1909  */

  int ival;
  char *sval;

#line 101 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
