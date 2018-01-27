//
// Tipos e constantes para tokens da linguagem Mini C
//


#ifndef __MINIC_TOKENS_H

#define __MINIC_TOKENS_H

// Tipos de token
#define TOK_PCHAVE                              1
#define TOK_ID                                  4
#define TOK_NUM                                 5
#define TOK_PONT                                6
#define TOK_OP                                  7
#define TOK_STRING                              8
#define TOK_PROLOGO                             9
#define TOK_ERRO                                100

// valores para palavra-chave 
#define PC_IF                                   0
#define PC_THEN                                 1 
#define PC_ELSIF                                2 
#define PC_ELSE                                 3
#define PC_LOOP                                 4
#define PC_END                                  5 
#define PC_BEGIN                                6 
#define PC_PROCEDURE                            7 
#define PC_MAIN                                 8 
#define PC_MOD                                  9 
#define PC_FUNCTION                             10 
#define PC_RETURN                               11
#define PC_PUT                                  12
#define PC_GET                                  13

// valores para pontuacao
#define PARESQ                                  1
#define PARDIR                                  2
#define CHVESQ                                  3
#define CHVDIR                                  4
#define VIRG                                    5
#define PNTVIRG                                 6

// valores para operadores
#define SOMA                                    1
#define SUB                                     2
#define MULT                                    3
#define DIV                                     4
#define MENOR                                   5
#define IGUAL                                   6
#define AND                                     7
#define NOT                                     8
#define ATRIB                                   9
#define MAIOR                                   10
#define MENOROUIGUAL                            11
#define MAIOROUIGUAL                            12


// tipos
typedef struct 
{
  int tipo;
  int valor;
} Token;

// declaracao do analisador lexico
#define YY_DECL Token * yylex()

extern Token * yylex();


#endif
