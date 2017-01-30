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
%type <double_value> expr facter
%token <double_value> NUM
%token ADD SUB MUL DIV MOD POW NL EXIT LP RP
%left ADD SUB
%left MUL DIV
%right POW
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
expr : facter
     | LP expr RP
     {
        $$=$2;
     }
     | expr ADD expr
        {
            $$=$1+$3;
        }
     | expr SUB expr
        {
            $$=$1-$3;
        }
     | expr MUL expr
        {
            $$=$1*$3;
        }
     | expr DIV expr
        {
            $$=$1/$3;
        }
    | expr MOD expr
        {
            $$=fmod($1,$3);
        }
    | expr POW expr
        {
            $$=pow($1,$3);
        }
    ;
facter:NUM
%%

int
main()
{
    yyparse();
}
