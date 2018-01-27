mclex: lexer.c lexer.h tabelas.c lex_teste.c
	gcc -o mclex lexer.c tabelas.c lex_teste.c

lexer.c: lex.l
	flex lex.l

lexer.h: lex.l
	flex lex.l

clean:
	rm -f mclex
	rm -f lexer.c lexer.h
	rm -f *.o 