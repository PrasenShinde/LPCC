%{
  #include <stdio.h>
%}

%%

"if"|"int"|"else"|"float"        {printf("Keyword: %s",yytext);}
[a-zA-Z_][a-zA-Z0-9_]*           {printf("Identifier: %s",yytext);}
[0-9]+(\.[0-9]+)?                 {printf("Number: %s",yytext);}
"<"|">"|"=="|"<="|">="            {printf("Relational Operator: %s",yytext);}
"+"|"-"|"*"|"%"                   {printf("Arithmetic Operator: %s",yytext);}
[\t\n]                            ;
%%

int yywrap(){
    return 1;
}

int main(){
    yylex();
    return 0;
}