%code requires
{
	#define YYSTYPE double
}

%{
#include <stdio.h>
#include "tabela.h"

int yylex(void);
void yyerror(char *);

pilha_contexto *pilha;

%}

%token TYPE PRINT T_INTEGER T_FLOAT INTEGER FLOAT ID INPUT OUTPUT
%token ATTRIBUTION DECLARATION FUNCTION PROCEDURE RETURN IS K_BEGIN
%token END DECLARE LOOP EXIT IF ELSIF ELSE DIFFERENT GTE LTE NOT AND
%token OR THEN ARRAY OF SET_COMPREHENSION MOD
%left '/' '*' MOD '+' '-' AND OR

%%

program:
	program function_definition { }
	|
	program procedure_definition { }
	|
	;

p_declarations:
	stmts
	;

p_body:
	stmts
	;

function_definition:
	FUNCTION ID empty_or_parameter_list RETURN TYPE IS		{
																tabela *contexto = criar_contexto(topo_pilha(pilha));
																pilha = empilhar_contexto(pilha, contexto);
															}
	p_declarations K_BEGIN p_body RETURN expr END ID ';'	{
																imprimir_contexto(topo_pilha(pilha));
																desempilhar_contexto(&pilha);
															}
	;

procedure_definition:
	PROCEDURE ID empty_or_parameter_list IS		{
																tabela *contexto = criar_contexto(topo_pilha(pilha));
																pilha = empilhar_contexto(pilha, contexto);
															}
	p_declarations K_BEGIN p_body END ID ';'	{
																imprimir_contexto(topo_pilha(pilha));
																desempilhar_contexto(&pilha);
															}
	;

funCall:
	ID '(' argsVazio ')'
	;

argsVazio:
	args
	|
	;

args:
	args ',' expr
	|
	expr
	;

stmts: 
	stmts stmt
	|
	stmts decl
	|
	;

array_decl:
	ID DECLARATION ARRAY '('INTEGER SET_COMPREHENSION INTEGER')' OF TYPE ';'
	|
	ID DECLARATION ARRAY '('INTEGER SET_COMPREHENSION INTEGER')' OF TYPE ATTRIBUTION '(' args ')'';'
	;

decl:
	ID DECLARATION TYPE ';'						{
													simbolo * s = criar_simbolo((char *) (int) $1, $3); 
													inserir_simbolo(topo_pilha(pilha), s);
												}
	|
	ID DECLARATION TYPE ATTRIBUTION expr ';'	{
													simbolo * s = criar_simbolo((char *) (int) $1, $3); 
													inserir_simbolo(topo_pilha(pilha), s);
													s = localizar_simbolo(topo_pilha(pilha), (char *) (int) $1);
													if (s->tipo == T_FLOAT) {
														s->val.fval = $5;
													}
													else {
														s->val.dval = $5;
													}
												}
	;

declaration:
	DECLARE stmts K_BEGIN stmts END ';'
	;

empty_or_parameter_list:
	'(' parameter_list ')'
	|
	;

parameter_list:
	parameter_list ';' parameter
	|
	parameter
	;

parameter:
	ID DECLARATION TYPE
	;

elsif_multi:
	elsif_multi ELSIF condition THEN stmt
	|
	;

conditional:
	IF condition THEN stmts END IF ';'
	|
	IF condition THEN stmts elsif_multi ELSE stmts END IF ';'
	;

condition:
	NOT expr
	|
	expr '=' expr
	|
	expr DIFFERENT expr
	|
	expr '<' expr
	|
	expr '>' expr
	|
	expr GTE expr
	|
	expr LTE expr
	|
	expr OR expr
	|
	expr AND expr
	|
	'(' condition ')'
	;

loop:
	LOOP stmts EXIT condition END LOOP
	;

stmt:
	expr ';'
	| declaration
	| array_decl
	| conditional
	| loop
	| attr			
	| OUTPUT ID ';'								{
													simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) (int) $2);
													if(s == NULL)
														yyerror("Identificador não declarado");
													else  {
													if (s->tipo == T_FLOAT) {
															printf(">>>%f\n", s->val.fval);
														}
														else {
															printf(">>>%d\n", s->val.dval);
														}
													}
												}		
	;

attr:
ID ATTRIBUTION expr ';'							{ 
													simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) (int) $1);
													if(s == NULL)
														yyerror("Identificador não declarado");
													else {
														if (s->tipo == T_FLOAT) {
															s->val.fval = $3;
														}
														else {
															s->val.dval = $3;
														}
													}
												}

expr:

	FLOAT
											    {
													$$ = $1;
												}
	|
	INTEGER										{
													$$ = $1;
												}
	|
	ID											{ 
													simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) (int) $1);
													if(s == NULL)
														yyerror("Identificador não declarado");
													else {
														if (s->tipo == T_FLOAT) {
															$$ = s->val.fval;
														}
														else {
															$$ = s->val.dval;
														}
													}
												}
	|
	expr '*' expr								{
													$$ = $1 * $3;
												}
	|
	expr '/' expr								{
													$$ = $1 / $3;
												}
	|
	expr MOD expr								{
													$$ = (int) $1 % (int) $3;
												}
	|
	expr '+' expr								{
													$$ = $1 + $3;
												}
	|
	expr '-' expr								{
													$$ = $1 - $3;
												}
	|
	'(' expr ')'								{
													$$ = $2;
												}
	|
	funCall
	; 

%%

void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	pilha = NULL;
	yyparse();
	return 0;
}
