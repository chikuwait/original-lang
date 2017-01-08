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
           {
            fprintf(stdout,"%g\n",$1);
           }
          ;
expr : NUM
     | expr ADD NUM
        {
            $$=$1+$3;
        }
     | expr SUB NUM
        {
            $$=$1-$3;
        }
     | expr MUL NUM
        {
            $$=$1*$3;
        }
     | expr DIV NUM
        {
            $$=$1/$3;
        }
    ;
%%

int
main()
{
    yyparse();
}
