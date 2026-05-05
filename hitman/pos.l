%{
    #include <stdio.h>
%}

%%

"car"|"House"            {printf("Noun: %s",yytext);}
"he"|"she"               {printf("Pronoun: %s",yytext);}
"run"|"go"               {printf("Verb: %s",yytext);}
"running"|"playing"      {printf("Adverb: %s",yytext);}

[a-zA-Z]+                {printf("UnKnown: %s",yytext);}
[\t\n]+                  ;

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter sentence:\n");
    yylex();
    return 0;
}

































sudo apt install flex bison gcc


lex pos.l
gcc lex.yy.c -o pos -ll
./pos