%{
#include <stdio.h>
#include <math.h>

double sym[26];   // variables a-z

int yylex();
void yyerror(char *s);
%}

%union {
    double dval;
    int index;
}

%token <dval> NUMBER
%token <index> VARIABLE
%token SIN COS SQRT

%type <dval> expr

%left '+' '-'
%left '*' '/'
%right '^'

%%

stmt:
      stmt line
    | line
    ;

line:
      expr '\n'        { printf("Result = %lf\n", $1); }
    | VARIABLE '=' expr '\n' { sym[$1] = $3; }
    ;

expr:
      expr '+' expr    { $$ = $1 + $3; }
    | expr '-' expr    { $$ = $1 - $3; }
    | expr '*' expr    { $$ = $1 * $3; }
    | expr '/' expr    { $$ = $1 / $3; }
    | expr '^' expr    { $$ = pow($1, $3); }

    | '(' expr ')'     { $$ = $2; }

    | SIN '(' expr ')'  { $$ = sin($3); }
    | COS '(' expr ')'  { $$ = cos($3); }
    | SQRT '(' expr ')' { $$ = sqrt($3); }

    | NUMBER           { $$ = $1; }
    | VARIABLE         { $$ = sym[$1]; }
    ;

%%

int main() {
    printf("Enter expressions:\n");
    yyparse();
    return 0;
}

void yyerror(char *s) {
    printf("Error: %s\n", s);
}



yacc -d file-name.y
lex file-name.l
gcc y.tab.c lex.yy.c -o file-name -lm -ll
./file-name


a = 5
b = 3
a + b * 2
sin(0)
sqrt(25)