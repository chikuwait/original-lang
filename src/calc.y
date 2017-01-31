%{
#include <stdio.h>
#include <math.h>
#include <string.h>
#define IDENTIFIER_SIZE 32

typedef struct _identifier
{
    char name;
    double value;
} identifier;
identifier imap[IDENTIFIER_SIZE];
//int identifier_register(char name, int value)
int index_identifier(char name);
int identifier_register(char name,double value);
double getvalue(char name);
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
    char cval;
}
%type <double_value> expr facter
%token <cval> IDENTIFIER
%token <double_value> NUM
%token ADD SUB MUL DIV MOD POW NL EXIT LP RP EQ
%left ADD SUB
%left MUL DIV
%right POW
%%
program : statement
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
     | EXIT
        {
            return 0;
        }
     |IDENTIFIER
        {
            $$ = getvalue($1);
        }
     | IDENTIFIER EQ expr
        {
            identifier_register($1,$3);
        }
     | LP expr RP
        {
            $$ = $2;
        }
     | expr ADD expr
        {
            $$ = $1 + $3;
        }
     | expr SUB expr
        {
            $$ = $1 - $3;
        }
     | expr MUL expr
        {
            $$ = $1 * $3;
        }
     | expr DIV expr
        {
            $$ = $1 / $3;
        }
    | expr MOD expr
        {
            $$ = fmod($1,$3);
        }
    | expr POW expr
        {
            $$ = pow($1,$3);
        }
    ;
facter : NUM
%%
int
index_identifier(char name)
{
    for(int i = 0; i < IDENTIFIER_SIZE; i++)
    {
        if(imap[i].name==name)
        {
            return i;
        }
    }
    return -1;
}
int
identifier_register(char name, double value)
{
    int i = index_identifier(name);
    if(i==-1)
    {
        static int identifier_id=0;
        imap[identifier_id].name=name;
        imap[identifier_id].value=value;
        identifier_id++;
    }
    else
    {
        imap[i].value=value;
    }
    return 0;
}
double
getvalue(char name)
{
    int i = index_identifier(name);
    if(i!=-1)
    {
        return imap[i].value;
    }
    else
    {
        printf("Error: \'%c\' is not defined\n",name);
    }
}
int
main()
{
    yyparse();
}
