#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define NMAX 100
char *token[NMAX];
int ix;

int
lexer(char *text)
{
    ix = 0;
    while(*text != '\0')
    {
        if(*text <= ' ')
        {
            text++;
            continue;
        }
        char *pBgn = text;

        if(*text == '0' && *(text+1) == 'x')
        {
            text+=2;
            while(isxdigit(*text) || *text == '.') text++;
        }
        else if(isdigit(*text))
        {
            while(isdigit(*text) || *text == '.' ) text++;
        }
        else if(isalpha(*text))
        {
            while(isalnum(*text)) text++;
        }
        else if(isxdigit(*text))
        {
            while(isxdigit(*text) || *text == '.') text++;
        }
        else
        {
            text++;
        }

        token[ix] = malloc((int)(text-pBgn)+1);
        strncpy(token[ix],pBgn,(int)(text-pBgn));
        token[ix][text-pBgn] = '\0';
        ix++;
    }
    return ix;
}
int
main(void)
{
    char buf[128];
    int pnt;
    fgets(buf,100,stdin);
    pnt = lexer(buf);
    printf("%d\n",pnt);
    for(int i =0 ; i < pnt ; i++){
        free(token[i]);
    }
}

