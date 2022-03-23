D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
FS			(f|F|l|L)
IS			(u|U|l|L)*

%{
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

typedef struct token_data_ {
  int column_num;
  int line_num;
  char *lexeme;
} TOKEN_DATA;

void token_to_string(int token_type, char * str);
void count();
void comment();
int main();
void parse();
int check_type();
int yylex();

int column = 1;
int line_num=1;

TOKEN_DATA token_data;

%}

%%
"/*"			{ comment(); }
"//"[^\n]*\n		{ line_num++;  }

"auto"			{ count(); return(AUTO); }
"break"			{ count(); return(BREAK); }
"case"			{ count(); return(CASE); }
"char"			{ count(); return(CHAR); }
"const"			{ count(); return(CONST); }
"continue"		{ count(); return(CONTINUE); }
"default"		{ count(); return(DEFAULT); }
"do"			{ count(); return(DO); }
"double"		{ count(); return(DOUBLE); }
"else"			{ count(); return(ELSE); }
"enum"			{ count(); return(ENUM); }
"extern"		{ count(); return(EXTERN); }
"float"			{ count(); return(FLOAT); }
"for"			{ count(); return(FOR); }
"goto"			{ count(); return(GOTO); }
"if"			{ count(); return(IF); }
"int"			{ count(); return(INT); }
"long"			{ count(); return(LONG); }
"register"		{ count(); return(REGISTER); }
"return"		{ count(); return(RETURN); }
"short"			{ count(); return(SHORT); }
"signed"		{ count(); return(SIGNED); }
"sizeof"		{ count(); return(SIZEOF); }
"static"		{ count(); return(STATIC); }
"struct"		{ count(); return(STRUCT); }
"switch"		{ count(); return(SWITCH); }
"typedef"		{ count(); return(TYPEDEF); }
"union"			{ count(); return(UNION); }
"unsigned"		{ count(); return(UNSIGNED); }
"void"			{ count(); return(VOID); }
"volatile"		{ count(); return(VOLATILE); }
"while"			{ count(); return(WHILE); }

{L}({L}|{D})*		{ count(); return(check_type()); }

0[xX]{H}+{IS}?		{ count(); return(CONSTANT); }
0{D}+{IS}?		{ count(); return(CONSTANT); }
{D}+{IS}?		{ count(); return(CONSTANT); }
L?'(\\.|[^\\'])+'	{ count(); return(CONSTANT); }

{D}+{E}{FS}?		{ count(); return(CONSTANT); }
{D}*"."{D}+({E})?{FS}?	{ count(); return(CONSTANT); }
{D}+"."{D}*({E})?{FS}?	{ count(); return(CONSTANT); }

L?\"(\\.|[^\\"])*\"	{ count(); return(STRING_LITERAL); }

"..."			{ count(); return(ELLIPSIS); }
">>="			{ count(); return(RIGHT_ASSIGN); }
"<<="			{ count(); return(LEFT_ASSIGN); }
"+="			{ count(); return(ADD_ASSIGN); }
"-="			{ count(); return(SUB_ASSIGN); }
"*="			{ count(); return(MUL_ASSIGN); }
"/="			{ count(); return(DIV_ASSIGN); }
"%="			{ count(); return(MOD_ASSIGN); }
"&="			{ count(); return(AND_ASSIGN); }
"^="			{ count(); return(XOR_ASSIGN); }
"|="			{ count(); return(OR_ASSIGN); }
">>"			{ count(); return(RIGHT_OP); }
"<<"			{ count(); return(LEFT_OP); }
"++"			{ count(); return(INC_OP); }
"--"			{ count(); return(DEC_OP); }
"->"			{ count(); return(PTR_OP); }
"&&"			{ count(); return(AND_OP); }
"||"			{ count(); return(OR_OP); }
"<="			{ count(); return(LE_OP); }
">="			{ count(); return(GE_OP); }
"=="			{ count(); return(EQ_OP); }
"!="			{ count(); return(NE_OP); }
";"			{ count(); return(';'); }
("{"|"<%")		{ count(); return('{'); }
("}"|"%>")		{ count(); return('}'); }
","			{ count(); return(','); }
":"			{ count(); return(':'); }
"="			{ count(); return('='); }
"("			{ count(); return('('); }
")"			{ count(); return(')'); }
("["|"<:")		{ count(); return('['); }
("]"|":>")		{ count(); return(']'); }
"."			{ count(); return('.'); }
"&"			{ count(); return('&'); }
"!"			{ count(); return('!'); }
"~"			{ count(); return('~'); }
"-"			{ count(); return('-'); }
"+"			{ count(); return('+'); }
"*"			{ count(); return('*'); }
"/"			{ count(); return('/'); }
"%"			{ count(); return('%'); }
"<"			{ count(); return('<'); }
">"			{ count(); return('>'); }
"^"			{ count(); return('^'); }
"|"			{ count(); return('|'); }
"?"			{ count(); return('?'); }

[ \t\v\n\f]		{ count(); }
.			{ /* ignore bad characters */ }

%%


void comment()
{
	char c, c1;

loop:
	while ((c = input()) != '*' && c != 0){
		if(c=='\n')
			line_num++; 
		continue;
	}
	if ((c1 = input()) != '/' && c != 0)
	{
		unput(c1);
		goto loop;
	}
	
	if (c != 0){
		// ignore it
	}
		
}

void count()
{
	int i;
	token_data.column_num = column;
	token_data.line_num = line_num;
	token_data.lexeme = strdup(yytext);

	for (i = 0; yytext[i] != '\0'; i++) {
		if (yytext[i] == '\n')
			{column = 1;
			line_num++;}
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;
	}
}

int check_type()
{
/*
 pseudo code --- this is what it should check

	if (yytext == type_name)
		return(TYPE_NAME);

	return(IDENTIFIER);
	it actually will only return IDENTIFIER
*/
	return(IDENTIFIER);
}


int yywrap()
{	exit(0);
	return(1);
}

int main(int argc, char *argv[]) {
  FILE *fh;
  FILE *fo;
  if (argc == 2 && (fh = fopen(argv[1], "r")))
    yyin = fh;
  if (argc == 3 && (fo = fopen(argv[2], "w+")))
    yyout = fo;

  printf("Token               Lexeme            Line#     Column#   "
         " \n");
  printf("====================================================================="
         "=\n");

  while (1) {
    int token_type = yylex();
    char token_str[64];
    token_to_string(token_type, token_str);
    printf("%-19s %-19s %-9d %-9d\n", 
           token_str, token_data.lexeme, token_data.line_num, token_data.column_num);
    free(token_data.lexeme);
  }
  return 0;
}

// Converts the token enum to a string
// Param1: yytokentype
// Param2 : pointer to string for output

void token_to_string(int token_type, char *str) {
  switch (token_type) {
  case AUTO:
    sprintf(str, "AUTO");
    break;
  case BREAK:
    sprintf(str, "BREAK");
    break;
  case CASE:
    sprintf(str, "CASE");
    break;
  case CHAR:
    sprintf(str, "CHAR");
    break;
  case CONST:
    sprintf(str, "CONST");
    break;
  case CONTINUE:
    sprintf(str, "CONTINUE");
    break;
  case DEFAULT:
    sprintf(str, "DEFAULT");
    break;
  case DO:
    sprintf(str, "DO");
    break;
  case DOUBLE:
    sprintf(str, "DOUBLE");
    break;
  case ELSE:
    sprintf(str, "ELSE");
    break;
  case ENUM:
    sprintf(str, "ENUM");
    break;
  case EXTERN:
    sprintf(str, "EXTERN");
    break;
  case FLOAT:
    sprintf(str, "FLOAT");
    break;
  case FOR:
    sprintf(str, "FOR");
    break;
  case GOTO:
    sprintf(str, "GOTO");
    break;
  case IF:
    sprintf(str, "IF");
    break;
  case INT:
    sprintf(str, "INT");
    break;
  case LONG:
    sprintf(str, "LONG");
    break;
  case REGISTER:
    sprintf(str, "REGISTER");
    break;
  case RETURN:
    sprintf(str, "RETURN");
    break;
  case SHORT:
    sprintf(str, "SHORT");
    break;
  case SIGNED:
    sprintf(str, "SIGNED");
    break;
  case SIZEOF:
    sprintf(str, "SIZEOF");
    break;
  case STATIC:
    sprintf(str, "STATIC");
    break;
  case STRUCT:
    sprintf(str, "STRUCT");
    break;
  case SWITCH:
    sprintf(str, "SWITCH");
    break;
  case TYPEDEF:
    sprintf(str, "TYPEDEF");
    break;
  case UNION:
    sprintf(str, "UNION");
    break;
  case UNSIGNED:
    sprintf(str, "UNSIGNED");
    break;
  case VOID:
    sprintf(str, "VOID");
    break;
  case VOLATILE:
    sprintf(str, "VOLATILE");
    break;
  case WHILE:
    sprintf(str, "WHILE");
    break;
  case IDENTIFIER:
    sprintf(str, "IDENTIFIER");
    break;
  case CONSTANT:
    sprintf(str, "CONSTANT");
    break;
  case STRING_LITERAL:
    sprintf(str, "STRING_LITERAL");
    break;
  case ELLIPSIS:
    sprintf(str, "ELLIPSIS");
    break;
  case RIGHT_ASSIGN:
    sprintf(str, "RIGHT_ASSIGN");
    break;
  case LEFT_ASSIGN:
    sprintf(str, "LEFT_ASSIGN");
    break;
  case ADD_ASSIGN:
    sprintf(str, "ADD_ASSIGN");
    break;
  case SUB_ASSIGN:
    sprintf(str, "SUB_ASSIGN");
    break;
  case MUL_ASSIGN:
    sprintf(str, "MUL_ASSIGN");
    break;
  case DIV_ASSIGN:
    sprintf(str, "DIV_ASSIGN");
    break;
  case MOD_ASSIGN:
    sprintf(str, "MOD_ASSIGN");
    break;
  case AND_ASSIGN:
    sprintf(str, "AND_ASSIGN");
    break;
  case XOR_ASSIGN:
    sprintf(str, "XOR_ASSIGN");
    break;
  case OR_ASSIGN:
    sprintf(str, "OR_ASSIGN");
    break;
  case RIGHT_OP:
    sprintf(str, "RIGHT_OP");
    break;
  case LEFT_OP:
    sprintf(str, "LEFT_OP");
    break;
  case INC_OP:
    sprintf(str, "INC_OP");
    break;
  case DEC_OP:
    sprintf(str, "DEC_OP");
    break;
  case PTR_OP:
    sprintf(str, "PTR_OP");
    break;
  case AND_OP:
    sprintf(str, "AND_OP");
    break;
  case OR_OP:
    sprintf(str, "OR_OP");
    break;
  case LE_OP:
    sprintf(str, "LE_OP");
    break;
  case GE_OP:
    sprintf(str, "GE_OP");
    break;
  case EQ_OP:
    sprintf(str, "EQ_OP");
    break;
  case NE_OP:
    sprintf(str, "NE_OP");
    break;
  case ';':
    sprintf(str, ";");
    break;
  case '{':
    sprintf(str, "{");
    break;
  case '}':
    sprintf(str, "}");
    break;
  case ',':
    sprintf(str, ",");
    break;
  case ':':
    sprintf(str, ":");
    break;
  case '=':
    sprintf(str, "=");
    break;
  case '(':
    sprintf(str, "(");
    break;
  case ')':
    sprintf(str, ")");
    break;
  case '[':
    sprintf(str, "[");
    break;
  case ']':
    sprintf(str, "]");
    break;
  case '.':
    sprintf(str, ".");
    break;
  case '&':
    sprintf(str, "&");
    break;
  case '!':
    sprintf(str, "!");
    break;
  case '~':
    sprintf(str, "~");
    break;
  case '-':
    sprintf(str, "-");
    break;
  case '+':
    sprintf(str, "+");
    break;
  case '*':
    sprintf(str, "*");
    break;
  case '/':
    sprintf(str, "/");
    break;
  case '%':
    sprintf(str, "%%");
    break;
  case '<':
    sprintf(str, "<");
    break;
  case '>':
    sprintf(str, ">");
    break;
  case '^':
    sprintf(str, "^");
    break;
  case '|':
    sprintf(str, "|");
    break;
  case '?':
    sprintf(str, "?");
    break;
  default:
    printf("NO TOKEN %d\n", token_type);
    assert(0);
    break;
  }
  return;
}
