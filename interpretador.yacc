%{
#include <stdio.h>
#include "tabela.h"

int yylex(void);
void yyerror(char *);

pilha_contexto *pilha;

%}

%token TYPE INT FLOAT PRINT NUMBER ID
%left '+' '-'
%%


program:
			
	program funcao	{ }
	|
	; 


funcao:
	TYPE ID '(' listaParametroVazio ')' bloco
	;

listaParametroVazio:
	listaParametro
	|
	;

listaParametro:
	listaParametro ',' parametro
	| parametro
	;

parametro: 
	TYPE ID
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
	| expr
	;

bloco: 
	'{' 			{ tabela *contexto = criar_contexto(topo_pilha(pilha));
				  pilha = empilhar_contexto(pilha, contexto);

				 }
	decls stmts '}'		{ imprimir_contexto(topo_pilha(pilha));
				  desempilhar_contexto(&pilha); }
	;

decls: 
	decls decl		{ }
	|
	;
	
decl:
	TYPE	ID ';'		{	simbolo * s = criar_simbolo((char *) $2, $1); 
					inserir_simbolo(topo_pilha(pilha), s); }

	;

stmts: 
	stmts stmt
	| 	
	;

stmt:
	expr ';'
	| bloco
	| attr			
	| PRINT ID ';'		{ simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) $2);
				  if(s == NULL)
					yyerror("Identificador não declarado");
				  else  {
					printf(">>>%d\n", s->val.dval);
			          }
				}		
	;

attr: 
	ID '=' expr ';'		{ 
	simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) $1);
				  if(s == NULL)
					yyerror("Identificador não declarado");
				  else  {
					s->val.dval = $3;
				  }
				}
expr:

	 NUMBER			{ //printf("%d", $1); 
				  $$ = $1; }
	| ID			{ 
simbolo * s = localizar_simbolo(topo_pilha(pilha), (char *) $1);
				  if(s == NULL)
					yyerror("Identificador não declarado");
				  else  {
//					printf("(%d, %s, %d)", s->tipo, s->lexema, s->val.dval);
					$$ = s->val.dval;
				  }
				}
	| expr'+' expr		{ $$ = $1 + $3; }
	| expr '-' expr		{ $$ = $1 - $3;}
	| '(' expr ')'		{ $$ = $2; }
	| funCall
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
