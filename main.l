%{
  #include "main.tab.h"
  #include <stdio.h>
  #include <string.h>
  int yywrap();

//    ИСХОДНАЯ:
//    1. <P1> ::= i <T1><P1> | <P2>
//    2. <P2> ::= i <T2><P3>
//    3. <P3> ::= i <T1><P3> | i
//    4. <T1> ::= + | -
//    5. <T2> ::= < | = | != | >

// 8-ой Номер:
// P0 ::= id P1
// P1 ::= T1 id P1
// P1 ::= P2
// P2 ::= T2 id P3
// P3 ::= T1 id P3
// P3 ::= E
// T1 ::= +
// T1 ::= -
// T2 ::= <
// T2 ::= =
// T2 ::= !=
// T2 ::= >
%}

%%

[ \t\n]     { /* ignore whitespace */ }
\+ { return '+'; }
\- { return '-'; }
\< { return '<'; }
\= { return '='; }
\! { return '!'; }
\> { return '>'; }

[0-9]+	{ 
  yylval.id = atoi(yytext);  
  return ID; 
}


%%
int yywrap(){
  return 1;
}
