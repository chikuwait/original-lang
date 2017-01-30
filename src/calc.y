%{
#include <stdio.h>
#include <math.h>
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
%token ADD SUB MUL DIV MOD POW NL EXIT LP RP

%%
program : statement
        | EXIT
        {
            return 0;
        }
        | program EXIT
        {
            return 0;
        }
        | program statement
        ;
statement : expr NL
           {
            fprintf(stdout,"%g\n",$1);
           }
          ;
expr : NUM
     | LP expr RP
     {
        $$=$2;
     }
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
    | expr POW NUM
        {
            $$=pow($1,$3);
        }
    ;
%%

int
main()
{
    yyparse();
}
