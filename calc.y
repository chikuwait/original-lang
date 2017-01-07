%{
#include <stdio.h>
int yylex();
static void
yyerror(const char *s)
{
    fputs(s, stderr);
    fputs("\n",stderr);
}
%}
%union
{
    double double_value;
}
%type <double_value> expr
%token <double_value> NUM
%token ADD SUB MUL DIV NL

%%

program : statement
        | program statement
        ;
statement : expr NL
          ;
expr : NUM
     | expr ADD NUM
     | expr SUB NUM
     | expr MUL NUM
     | expr DIV NUM
    ;
%%

int
main()
{
    yyparse();
}
