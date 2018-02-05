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
%token END DECLARE
%left '/' '*' '+' '-'
%%


program:
	program function_def { }
	|
	;

function_def:
	FUNCTION ID '(' EMPTY_PARAMETER_LIST ')' RETURN TYPE procedure_block ID ';'
	|
	PROCEDURE ID '(' EMPTY_PARAMETER_LIST ')' procedure_block ID ';'
	;

p_declarations:
	stmts
	;

p_body:
	stmts
	;

data_return:
	RETURN ID ';'
	|
	RETURN FLOAT ';'
	|
	RETURN INTEGER ';'
	|
	;

procedure_block:
	IS												{
														tabela *contexto = criar_contexto(topo_pilha(pilha));
														pilha = empilhar_contexto(pilha, contexto);
													}
	p_declarations K_BEGIN p_body data_return END	{
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

EMPTY_PARAMETER_LIST:
	PARAMETER_LIST
	|
	;

PARAMETER_LIST:
	PARAMETER_LIST ';' PARAMETER
	|
	PARAMETER
	;

PARAMETER:
	ID DECLARATION TYPE
	;

stmt:
	expr ';'
	| bloco
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
