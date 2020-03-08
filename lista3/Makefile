all: lexer parser
	g++ -std=c++11 calc.tab.c lex.yy.c functions.cpp -o kalkulator

lexer: 
	flex calc.l

parser:
	win_bison -d calc.y

clean:
	del calc.tab.h calc.tab.c lex.yy.c kalkulator.exe