%{
#include <stdio.h>

int yylex();
int yywrap();

%}  


%%

\\\n ;

%%

int yywrap() {
    return 1;
}

int main() {
    return yylex();
}

