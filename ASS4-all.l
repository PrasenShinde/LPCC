%{
#include "y.tab.h"
#include <math.h>
%}

%%
[0-9]+      { yylval.dval = atof(yytext); return NUMBER; }
[a-zA-Z]    { yylval.index = yytext[0] - 'a'; return VARIABLE; }

"sin"       { return SIN; }
"cos"       { return COS; }
"sqrt"      { return SQRT; }

[ \t]       ;
\n          { return '\n'; }

.           { return yytext[0]; }
%%