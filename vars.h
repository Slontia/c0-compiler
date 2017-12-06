

#ifndef VARS_H_INCLUDED
#define VARS_H_INCLUDED

#include <iostream>
#include <fstream>
#define TOKEN_MAX_LENTH 10000

using namespace std;
extern FILE* progf;
extern ofstream fout;

extern char cur_c;	// current char
extern char token[TOKEN_MAX_LENTH];	// store sign
extern int token_len;
extern int num; // currrent integer
typedef enum {
    VOID, CHAR, INT
} Type;

typedef enum {
    CONST, VAR, FUNC
} Kind;
typedef enum {
	NONE,

	IDENT, INTCON, CHARCON, STRCON, ZERO,

	SQUO, DQUO, COMMA, COLON, SEMI, LPAR, RPAR,
	LBKT, RBKT, LBRACE, RBRACE, ASS, ADD, SUB, MUL,
	DIV, EQ, NE, GT, GE, LT, LE, SPACE, TAB, NEWL,

	CHARSY, INTSY, VOIDSY, CONSTSY, IFSY, ELSY, WHILESY,
	SWTSY, CASESY, DFTSY, SCFSY, PRTFST, RTNSY, MAINSY
} Symbol;
extern Symbol symbol;
extern Symbol cur_type;
extern bool skip_type_ident;

#endif // VARS_H_INCLUDED
