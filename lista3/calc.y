%{
#include <iostream>
#include <sstream>
#include <cmath>

#include"functions.hpp"

extern int yylineno;

bool err = false;
std::ostringstream buffer;
const std::string default_err = "invalid syntax";
std::string err_msg = default_err;

int yylex();
void yyerror(const char *s);
%}

%token NUM
%token NEWLINE
%token LBRACKET
%token RBRACKET
%left PLUS MINUS
%left MULT MOD DIV
%right PWR
%precedence NEG

%%
input:
    %empty
    | input line
;

line:
    NEWLINE
    | expr NEWLINE   {
                     
                            buffer << "\nWynik dzialania: " << $1 << std::endl;
                            std::string s = buffer.str();
                            buffer.str("");
                            buffer.clear();
                            std::cout << s << std::endl;
                      
                    }
    | error NEWLINE 
;

expr:
    NUM                         { $$ = $1; buffer << $1 << " ";}
    | expr PLUS expr            { $$ = $1 + $3; buffer << "+ "; }
    | expr MINUS expr           { $$ = $1 - $3; buffer << "- "; }
    | expr MULT expr            { $$ = $1 * $3; buffer << "* "; }
    | expr DIV expr             { 
                                    buffer << "/ ";
                                    if($3 == 0) {
                                        yyerror("dzielenie przez 0");
                                    } else {
                                        $$ = floor((double)$1 / (double) $3);
                                    }
                                }
    | expr MOD expr             {
                                    buffer << "% ";
                                    if($3 == 0) {
                                        yyerror("dzielenie przez 0");
                                    } else {
										int res = $1 % $3;
										if( $3*res < 0 ){
											res = $3 + res;
										}
                                        $$ = res;
                                    }
                                }
    | MINUS expr %prec NEG		{ $$ = -$2; buffer << "~ "; }
    | expr PWR expr             {
                                    buffer << "^ ";
                                    if($3 < 0) {
                                        yyerror("ujemna potega");
                                    } else {
                                        $$ = pow($1, $3);
                                    }
                                }
    | LBRACKET expr RBRACKET   { $$ = $2; }
;
%%

void yyerror(const char *msg) {
    std::cerr << "Wystapil blad: " << msg << std::endl;
	buffer.str("");
    buffer.clear();
    return;
}

int main() {
    return yyparse();
}
