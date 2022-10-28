.ONESHELL:
.SILENT:

build:    
	flex lexer.l
	bison -d -y parser.y
	g++ y.tab.c lex.yy.c AST.cpp symbol_table.cpp typecheck.cpp -o ../bin/final
	rm lex.yy.c
	rm y.tab.c
	rm y.tab.h
clean:
	-rm ../bin/final
