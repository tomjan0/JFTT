%{

    #include<stdio.h>
    int yylex();
    int yywrap();

    int words = 0;
	int lines = 0;

%}

%%

^[[:blank:]]*\n* ;
[[:blank:]]+$ ;
[[:blank:]]+    { printf(" "); }


[a-zA-Z]+       { ECHO; words++; }
\n              { printf("\n"); lines++; }


%%

int yywrap() {
	if(lines != 0) lines++;
    printf("\nWords: %d\nLines: %d\n", words, lines);
    return 1;
}

int main() {
    return yylex();
}