%{
#include <stdio.h>
#include <stdbool.h>

int yywrap();
int yylex();

bool print_doc = true;
%}

BCKSLSH \\|\n

%x SINGLE_LINE_COMMENT
%x MULTI_LINE_COMMENT
%x SINGLE_LINE_DOC_COMMENT
%x MULTI_LINE_DOC_COMMENT
%x COMMENT_IN_STR
%x TAG

%%

\"                              {BEGIN(COMMENT_IN_STR);  ECHO;}
\<                  {ECHO; BEGIN(TAG);}
<COMMENT_IN_STR>{   
. ECHO;
\n ECHO;
.\" {ECHO;BEGIN(INITIAL);}
}

<TAG>{
 	. ECHO;
	\n ECHO;
	.> {ECHO;BEGIN(INITIAL);}
   
}

\/{BCKSLSH}*\/                 {BEGIN(SINGLE_LINE_COMMENT);}
<SINGLE_LINE_COMMENT>{
    .*\\\n                      ;
    .                           ;      
    [^\\]\n                        {printf("\n"); BEGIN(INITIAL);}
}

\/{BCKSLSH}*\*                 BEGIN(MULTI_LINE_COMMENT);
<MULTI_LINE_COMMENT>{
    .|\n                        ;
    \*{BCKSLSH}*\/             BEGIN(INITIAL);
}

\/{BCKSLSH}*\/{BCKSLSH}*\/    {BEGIN(SINGLE_LINE_DOC_COMMENT); if(print_doc) ECHO;}
<SINGLE_LINE_DOC_COMMENT>{
    .                           {if(print_doc) ECHO;}
    .*\\\n                      {if(print_doc) ECHO;}
    .?\n                     {if(print_doc) printf("\n"); BEGIN(INITIAL);}
}

\/{BCKSLSH}*\*{BCKSLSH}*\*    {BEGIN(MULTI_LINE_DOC_COMMENT); if(print_doc) ECHO;}
<MULTI_LINE_DOC_COMMENT>{
    .|\n                        {if(print_doc) ECHO;}
    \*{BCKSLSH}*\/             {printf("\n"); if(print_doc) ECHO; BEGIN(INITIAL);}
}

%%

int yywrap() {
    return 1;
}

int main() {
    return yylex();
}