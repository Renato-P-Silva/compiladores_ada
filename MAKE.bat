rm ./compilador.exe
rm ./lex.yy.c
rm ./y.tab.c
rm ./y.tab.h

flex ./interpretador.lex
bison -d ./interpretador.yacc -o y.tab.c
gcc *.c -o compilador.exe
