%{
#include <stdio.h>
#include "calc.tab.h"

int
yywrap(void)
{
    return 1;
}
%}
WORD    [a-zA-Z]
%%
"+"     return ADD;
"-"     return SUB;
"/"     return DIV;
"*"     return MUL;
"%"     return MOD;
"^"     return POW;
"\n"    return NL;
"("     return LP;
")"     return RP;
"="     return EQ;

{WORD} {
    yylval.cval=yytext[0];
    return  IDENTIFIER;
}
([1-9][0-9]*)|0|([0-9]+\.[0-9]*) {
    double temp;
    sscanf(yytext,"%lf",&temp);
    yylval.double_value=temp;
    return NUM;
};
[ \t];
("quit"|"exit") {
    return EXIT;
}
. {
    fprintf(stderr,"lexical error.\n");
    exit(1);
}
%%
