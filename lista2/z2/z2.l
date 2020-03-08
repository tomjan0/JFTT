%{
#include <stdio.h>

int yylex();
int yywrap();

%}  

%x COMMENT
%x TAG
%x ATTR

%%

\<!--(.*--.*)*--\> ECHO;
\<!--              BEGIN(COMMENT);
\<                  {ECHO; BEGIN(TAG);}

<TAG>{
 	=\"|='            {ECHO; BEGIN(ATTR);}
	.>             {ECHO; BEGIN(INITIAL);}
    .|\n          ECHO;
   
}

<ATTR>{
	\"|' {ECHO;BEGIN(TAG);}
	.|\n {ECHO;}
}

<COMMENT>{
    .|\n            ;
    --\>            {BEGIN(INITIAL);}
}

%%

int yywrap() {
    return 1;
}

int main() {
    return yylex();
}

