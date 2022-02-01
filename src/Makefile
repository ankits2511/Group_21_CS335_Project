.ONESHELL:
.SILENT:

build:
	flex lexer.l
	gcc lex.yy.c -lfl -o ../bin/lexer
	rm lex.yy.c
clean:
	-rm ../bin/lexer