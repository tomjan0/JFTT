%{
#include <stdio.h>
#include <stdbool.h>

int yylex();
int yywrap();

bool printDoc = false;
bool multilineDoc = false;

%}  

%x STR
%x MULTILINE

%%

#include.* ECHO;
\"            {ECHO; BEGIN(STR);}
(\/\/\/.*)|(\/\/\!.*) {if (printDoc) { ECHO; } }
\/(\\\n)*\/(.|\\\n)* ;
(\/\*\*)|(\/\*\!) {if(printDoc) { ECHO; multilineDoc = true; } BEGIN(MULTILINE);}
\/\* BEGIN(MULTILINE);

<STR>{
	\" {ECHO; BEGIN(INITIAL);}
	.|\n {ECHO;}
}

<MULTILINE>{
	\*\/ {if (multilineDoc) { ECHO; multilineDoc = false;} BEGIN(INITIAL);}
    .|\n {if (multilineDoc) ECHO; }
   
}

%%

int yywrap() {
    return 1;
}

int main() {
    return yylex();
}

