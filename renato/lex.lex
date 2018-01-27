%option noyywrap 
%option nodefault
%option outfile="lexer.c"

%{
#include "minic_tokens.h"
#include "tabelas.h"

//prototipo da funcao token
Token *token(int, int); 
%}

NUM [0-9]+
ID [[:alpha:]]([[:alnum:]])*
STRING \"[^\"\n]*\"

%% 

[[:space:]]  {  }  /* ignora espacos em branco */
\/\/[^\n]*     {  }  /* elimina comentarios de linha */

"with Ada.Text_IO;"  { return token(TOK_PROLOGO, 0); }
"with Ada.Integer_Text_IO;"  { return token(TOK_PROLOGO, 1); }
"with Ada.Float_Text_IO;"  { return token(TOK_PROLOGO, 2); }


{STRING} { return token(TOK_STRING, adiciona_string(yytext)); } 

if       { return token(TOK_PCHAVE, PC_IF); } 
then	 { return token(TOK_PCHAVE, PC_THEN); } 
elsif     { return token(TOK_PCHAVE, PC_ELSIF); }
else     { return token(TOK_PCHAVE, PC_ELSE); }
end     { return token(TOK_PCHAVE, PC_END); }
begin     { return token(TOK_PCHAVE, PC_BEGIN); }
loop    { return token(TOK_PCHAVE, PC_LOOP); }
return   { return token(TOK_PCHAVE, PC_RETURN); }
Put   { return token(TOK_PCHAVE, PC_PUT); } 
Get   { return token(TOK_PCHAVE, PC_GET); } 
mod      { return token(TOK_PCHAVE, PC_MOD); } 
Main	{ return token(TOK_PCHAVE, PC_MAIN); }
procedure	{ return token(TOK_PCHAVE, PC_PROCEDURE); }
function	{ return token(TOK_PCHAVE, PC_FUNCTION); }

{NUM}    { return token(TOK_NUM, atoi(yytext)); }
{ID}     { return token(TOK_ID, adiciona_simbolo(yytext)); }

\+       { return token(TOK_OP, SOMA);  }
-        { return token(TOK_OP, SUB);   }
\*       { return token(TOK_OP, MULT);  }
\/       { return token(TOK_OP, DIV);   }
\<       { return token(TOK_OP, MENOR); } 
\<=       { return token(TOK_OP, MENOROUIGUAL); } 
\>       { return token(TOK_OP, MAIOR); } 
\>=       { return token(TOK_OP, MAIOROUIGUAL); } 
=       { return token(TOK_OP, IGUAL); }
:=       { return token(TOK_OP, ATRIB); }
\/=        { return token(TOK_OP, NOT);   }
\(       { return token(TOK_PONT, PARESQ); }
\)       { return token(TOK_PONT, PARDIR); }
\{       { return token(TOK_PONT, CHVESQ); }
\}       { return token(TOK_PONT, CHVDIR); }
,        { return token(TOK_PONT, VIRG);   }
;        { return token(TOK_PONT, PNTVIRG); }

.        { return token(TOK_ERRO, 0);  }

%% 

Token tok;


Token *token(int tipo, int valor)
{
  tok.tipo = tipo;
  tok.valor = valor;

  return &tok;
}

