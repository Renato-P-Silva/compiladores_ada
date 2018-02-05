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

{IDENTIFIER}									{
													yylval = (int) strdup(yytext);
													return ID;
												}

:=												{
													return ATTRIBUTION;
												}

:												{
													return DECLARATION;
												}

[-+(){};,=/*]										{
													return *yytext;
												}

[ \t\n] 	; /* skip whitespace */
. 	yyerror("invalid character");

%%

int yywrap(void) {
return 1;
}
