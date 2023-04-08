%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define bool int
#define false 0  
#define true 1 

int yylex();
int yyerror(const char *);

int operation(int leftId, int rightId, int sign);
bool comparision(int leftId, int rightId, int sign);

char op;
char sign;
int leftVal = 0;
int rightVal = 0;
bool result;

%}
//%glr-parser
//%define lr.type canonical-lr
//%define parse.error verbose

%token ID 

%union{
  int id;
}

%type <id> ID

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

// "0 - 3 < 5 + 0"

%%

p0: ID { leftVal=$1; } p1 {
  result = comparision(leftVal, rightVal, sign);
  printf("Result:%d %c %d = %d\n",leftVal, sign, rightVal, result);
  };
p1: t1 ID { leftVal = operation(leftVal, $2, op); } p1 | p2;
p2: t2 ID { rightVal=$2; }  p3;
p3: t1 ID { rightVal=operation(rightVal, $2, op); } p3 | %empty ;
t1: '+' {op='+';} | '-' {op='-';};
t2: '<' { sign='<'; } | '=' {sign='=';} | '!' '=' {sign= '!';} | '>' {sign='>';};

%%

int operation(int leftId, int rightId, int sign) {
  switch (sign) {
  case '+':
    return leftId + rightId;
  case '-':
    return leftId - rightId;
  }
}

bool comparision(int leftId, int rightId, int sign) {
  switch (sign) {
  case '<':
    return leftId < rightId;
  case '=':
    return leftId == rightId;
  case '!':
    return leftId != rightId;
  case '>':
    return leftId > rightId;
  }
}

int main()
{
  yyparse();
  return 0;
}

int yyerror(const char *s)
{
  fprintf(stderr, "error: %s\n", s);
  return -1;
}
