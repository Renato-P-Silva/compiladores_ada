%option caseless
%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
void yyerror(char *);
#include "y.tab.h"
%}

ID_LETTER										[a-z|A-Z|_]
DIGIT											[0-9]
IDENTIFIER										{ID_LETTER}({ID_LETTER}|{DIGIT})*

%%

{DIGIT}+\.{DIGIT}+								{
													yylval = atof(yytext);
													return FLOAT;
												}

{DIGIT}+										{
													yylval = atoi(yytext);
													return INTEGER;
												}

integer											{
													yylval = T_INTEGER;
													return TYPE;
												}

float											{
													yylval = T_FLOAT;
													return TYPE;
												}

put												{
													return OUTPUT;
												}

get												{
													return INPUT;
												}

function										{
													return FUNCTION;
												}

procedure										{
													return PROCEDURE;
												}

return											{
													return RETURN;
												}

is												{
													return IS;
												}

begin											{
													return K_BEGIN;
												}

end												{
													return END;
												}

declare											{
													return DECLARE;
												}

loop											{
													return LOOP;
												}

"exit when"										{
													return EXIT;
												}

if												{
													return IF;
												}

elif											{
													return ELSIF;
												}

else											{
													return ELSE;
												}

then											{
													return THEN;
												}

array											{
													return ARRAY;
												}


not												{
													return NOT;
												}

and												{
													return AND;
												}
												
of												{
													return OF;
												}

or												{
													return OR;
												}

mod												{
													return MOD;
												}

{IDENTIFIER}									{
													yylval = (int) strdup(yytext);
													return ID;
												}

".."											{
													return SET_COMPREHENSION;
												}

":="											{
													return ATTRIBUTION;
												}

":"												{
													return DECLARATION;
												}

"/="											{
													return DIFFERENT;
												}

">="											{
													return GTE;
												}

"<="											{
													return LTE;
												}

[-+(){};,=/*]									{
													return *yytext;
												}

[ \t\n] 	; /* skip whitespace */
. 	yyerror("invalid character");

%%

int yywrap(void) {
return 1;
}
