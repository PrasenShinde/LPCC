%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(char *s);
%}

%token NUMBER

%left '+' '-'
%left '*' '/'
%right '^'

%%

input:
      input line
    | line
    ;

line:
      expr '\n'   { printf("Result = %d\n", $1); }
    ;

expr:
      expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { $$ = $1 / $3; }
    | expr '^' expr   { $$ = pow($1, $3); }
    | '(' expr ')'    { $$ = $2; }
    | NUMBER          { $$ = $1; }
    ;

%%

int main() {
    printf("Enter arithmetic expressions:\n");
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


Input:
2 + 3 * 4
