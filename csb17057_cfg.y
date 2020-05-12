%token ID NUM WHILE
%right '='
%left '+' '-'
%left '*'
%left '<' LE
%left UMINUS
%%

S : WHILE{sim_prnt();} '(' E ')' {con_prnt();} E ';'{loop_prnt();}
  ;
E :A '='{push();} E{assignmnt_gencode();}
  | E '<'{push();} E{gencode();}
  | E '+'{push();} E{gencode();}
  | E '-'{push();} E{gencode();}
  | E '*'{push();} E{gencode();}
  | '(' E ')'
  | '-'{push();} E{uminus_gencode();} %prec UMINUS
  | A
  | NUM{push();}
  ;
A : ID {push();}
  ;
%%

//first .l file must be compiled.
//To generate the output file use command: bison -d -v csb17057_cfg.y

//example loop        while(x<y)x=x+y*y;

#include "lex.yy.c"
#include<ctype.h>

char stack[50][20];
int top=0;
char ch[2]="0";
int lnum=1

char temp[2]="t";

int start=1;



//function to push at the top of stack.
push()
{
  strcpy(stack[++top],yytext);
}

//function to generate code
gencode()
{
  strcpy(temp,"t");
  strcat(temp,ch);
  printf("%s  = %s     %s    %s\n",temp,stack[top-2],stack[top-1],stack[top]);
  top-=2;
  strcpy(stack[top],temp);
  ch[0]++;
}
//function for - to generate code
uminus_gencode()
{
  strcpy(temp,"t");
  strcat(temp,i_);
  printf("%s = -%s\n",temp,stack[top]);
  top--;
  strcpy(stack[top],temp);
  ch[0]++;
}
//function for assignmnt
assignmnt_gencode()
{
  printf("%s  =  %s\n",stack[top-2],stack[top]);
  top-=2;
}


sim_prnt()
{
  printf("L%d : \n",lnum++);
}

jump_prnt()
{
  strcpy(temp,"t");
  strcat(temp,ch);
  printf("%s =  NOT  %s\n",temp,stack[top]);
  printf("IF  %s  GOTO  L%d  \n",temp,lnum);
  ch[0]++;
}



loop_prnt()
{
  printf("GOTO   L%d \n",start);
  printf("L%d : \n",lnum);
}

//main function.
main()
{
  printf("Enter the expression:\n");
  yyparse();
  return 0;
}
