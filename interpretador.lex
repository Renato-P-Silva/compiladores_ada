%option outfile="lexer.c"
%option caseless

%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
void yyerror(char *);

%}

letra	[a-z|A-Z|_] 
numero	[0-9]
INT														{numero}+
FLOAT													{INT}"."{INT}
identificador	{letra}({letra}|{numero})*
%%


{INT}	{ yylval = atoi(yytext);
		  		return INT;
		}

{FLOAT}	{ yylval = atoi(yytext);
		  		return FLOAT;
		}

int		{	yylval = INT;
				return TYPE;
		}
float	{
				yylval = FLOAT;
				return TYPE;
		}

PRINT	{	return PRINT; 
		}

{identificador}	{
			yylval = (int) strdup(yytext);
			return ID;
		}

[-+=(){};:,<>]	{	return *yytext; }

":="			{return ATTR;}

[ \t\n] 	; /* skip whitespace */
. 	yyerror("invalid character");
%%

int yywrap(void) {
return 1;
}