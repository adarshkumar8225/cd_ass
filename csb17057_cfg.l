/* lex file run first using flex <filename>.l 
output file will be csb17057_cfg.output */
%{
#include<stdio.h>
#include<stdlib.h>
#include"csb17057_cfg.tab.h"  //header file created by bison.
%}

ALPHA [a-z_A-Z]
DIGIT [0-9]

%%
    while                return WHILE;
    {ALPHA}({ALPHA}|{DIGIT})*    return ID;
    {DIGIT}+             {yylval=atoi(yytext); return NUM;}
    [ \t]                 ;
    "<"                 return LE;
    \n                return 0;
    .                 return yytext[0];
%%


void yyerror(char *st)
{
   printf("%s \n",st);
}
