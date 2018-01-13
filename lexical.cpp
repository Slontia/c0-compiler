#include<iostream>
#include<string.h>
#include <cstdlib>
#include "vars.h"
#define ERROR_EXIT 0
#define OUTPUT_LEX 0
#define DEBUG 0
#define OUTPUT_ERROR_C 0
#define OUTPUT_PROG 0
#define OUTPUT_DEBUG_ERROR 0

using namespace std;

/*===============================
|			  error				|
===============================*/

bool success = true;
char cur_c;	// current char
char token[TOKEN_MAX_LENTH] = {0};	// store sign
int token_len = 0;
int num; // currrent integer
int error_line = 1;

void error_debug(string info)
{
    if (OUTPUT_DEBUG_ERROR) cout << "[D_ERROR] " << info << " in " << error_line << endl;
    if (ERROR_EXIT) exit(0);
}

void error(string info)
{
    cout << "[ERROR] " << info << " in " << error_line << endl;
    success = false;
    if (OUTPUT_ERROR_C) cout << (int)cur_c;
    if (ERROR_EXIT) exit(0);
}

void warning(string info)
{
    cout << "[WARNING] " << info << endl;
}

void suspend_handle()
{
    error("unfinished code");
}

/*===============================
|		 char judgement			|
===============================*/

// space
bool is_space()
{
    return (cur_c == ' ');
}

// \n
bool is_newline()
{
    return (cur_c == '\n');
}

// \t
bool is_tab()
{
    return (cur_c == '\t');
}

// blank character (space, \t ,\n)
bool is_blank()
{
    return (is_space() || is_newline() || is_tab());
}

bool is_letter()
{
    return (
               (cur_c >= 'A' && cur_c <= 'Z') ||
               (cur_c >= 'a' && cur_c <= 'z') ||
               (cur_c == '_')
           );
}

bool is_digit()
{
    return (cur_c >= '0' && cur_c <= '9');
}

bool is_squo()
{
    return (cur_c == '\'');
}

bool is_dquo()
{
    return (cur_c == '\"');
}

bool is_comma()
{
    return (cur_c == ',');
}

bool is_colon()
{
    return (cur_c == ':');
}

bool is_semi()
{
    return (cur_c == ';');
}

bool is_lpar()
{
    return (cur_c == '(');
}

bool is_rpar()
{
    return (cur_c == ')');
}

bool is_lbkt()
{
    return (cur_c == '[');
}

bool is_rbkt()
{
    return (cur_c == ']');
}

bool is_lbrace()
{
    return (cur_c == '{');
}

bool is_rbrace()
{
    return (cur_c == '}');
}

bool is_ass()
{
    return (cur_c == '=');
}

bool is_add()
{
    return (cur_c == '+');
}

bool is_sub()
{
    return (cur_c == '-');
}

bool is_mul()
{
    return (cur_c == '*');
}

bool is_div()
{
    return (cur_c == '/');
}

bool is_gt()
{
    return (cur_c == '>');
}

bool is_lt()
{
    return (cur_c == '<');
}

bool is_excla()
{
    return (cur_c == '!');
}

bool is_string_char()
{
    return (cur_c >= 32 && cur_c <= 126 && cur_c != 34);
}



/*===============================
|			read char			|
===============================*/

void retract()
{
    if (cur_c != 0)
    {
        if (cur_c == '\n') error_line--;
        ungetc(cur_c, progf);
        cur_c = 0;
        return;
    }
    else
    {
        error_debug("multiple retractions");
    }
}

bool readchar()
{
    cur_c = fgetc(progf);
    if (OUTPUT_PROG) cout << cur_c;
    if (cur_c == '\n') {
        error_line++;
    }
    return (cur_c != EOF);
}

bool next_end()
{
    do
    {
        readchar();
    }
    while (is_blank());
    if (cur_c != EOF)
    {
        retract();
        return false;
    }
    return true;
}

/*===============================
|			  token				|
===============================*/

void clear_token()
{
    token_len = 0;
}

void cat_token()
{
    token[token_len++] = cur_c;
}


void to_lowercase()
{
    for (int i = 0; i < token_len; i++)
    {
        if (token[i] >= 'A' && token[i] <= 'Z')
        {
            token[i] += 'a' - 'A';
        }
    }
}

// symbol judgement
Symbol reserver()
{
    token[token_len] = 0; // set tailed
    to_lowercase();
    if (strcmp(token, "char") == 0)
    {
        return CHARSY;
    }
    else if (strcmp(token, "int") == 0)
    {
        return INTSY;
    }
    else if (strcmp(token, "void") == 0)
    {
        return VOIDSY;
    }
    else if (strcmp(token, "const") == 0)
    {
        return CONSTSY;
    }
    else if (strcmp(token, "if") == 0)
    {
        return IFSY;
    }
    else if (strcmp(token, "else") == 0)
    {
        return ELSY;
    }
    else if (strcmp(token, "while") == 0)
    {
        return WHILESY;
    }
    else if (strcmp(token, "switch") == 0)
    {
        return SWTSY;
    }
    else if (strcmp(token, "case") == 0)
    {
        return CASESY;
    }
    else if (strcmp(token, "default") == 0)
    {
        return DFTSY;
    }
    else if (strcmp(token, "scanf") == 0)
    {
        return SCFSY;
    }
    else if (strcmp(token, "printf") == 0)
    {
        return PRTFST;
    }
    else if (strcmp(token, "return") == 0)
    {
        return RTNSY;
    }
    else if (strcmp(token, "main") == 0)
    {
        return MAINSY;
    }
    else  	// return ident if cannot mate any reserved words
    {
        return IDENT;
    }
}

int trans_num()
{
    int num = 0;	// the unsigned integer
    for (int i = 0; i < token_len; i++)
    {
        num *= 10;
        num += token[i] - '0';
    }
    if (DEBUG)
    {
        cout << "read num: " << num << endl;
    }
    return num;
}


/*===============================
|			  getsym			|
===============================*/
string symbol2string(Symbol sym)
{
    switch (sym)
    {
    case IDENT:
        return "IDENT";
    case INTCON:
        return "INTCON";
    case CHARCON:
        return "CHARCON";
    case STRCON:
        return "STRCON";
    case ZERO:
        return "ZERO";
    case SQUO:
        return "SQUO";
    case DQUO:
        return "DQUO";
    case COMMA:
        return "COMMA";
    case COLON:
        return "COLON";
    case SEMI:
        return "SEMI";
    case LPAR:
        return "LPAR";
    case RPAR:
        return "RPAR";
    case LBKT:
        return "LBKT";
    case RBKT:
        return "RBKT";
    case LBRACE:
        return "LBRACE";
    case RBRACE:
        return "RBRACE";
    case ASS:
        return "ASS";
    case ADD:
        return "ADD";
    case SUB:
        return "SUB";
    case MUL:
        return "MUL";
    case DIV:
        return "DIV";
    case EQ:
        return "EQ";
    case NE:
        return "NE";
    case GT:
        return "GT";
    case GE:
        return "GE";
    case LT:
        return "LT";
    case LE:
        return "LE";
    case SPACE:
        return "SPACE";
    case TAB:
        return "TAB";
    case NEWL:
        return "NEWL";
    case INTSY:
        return "INTSY";
    case CHARSY:
        return "CHARSY";
    case VOIDSY:
        return "VOIDSY";
    case CONSTSY:
        return "CONSTSY";
    case IFSY:
        return "IFSY";
    case ELSY:
        return "ELSY";
    case WHILESY:
        return "WHILESY";
    case SWTSY:
        return "SWTSY";
    case CASESY:
        return "CASESY";
    case DFTSY:
        return "DFTSY";
    case SCFSY:
        return "SCFSY";
    case PRTFST:
        return "PRTFST";
    case RTNSY:
        return "RTNSY";
    case MAINSY:
        return "MAINSY";
    default:
        error_debug("unexpected word");
        return "";
    }
}

void sym_handle(Symbol sym, char* sign)
{
    string sym_str = symbol2string(sym);
    if (OUTPUT_LEX)
        cout << sym_str << ' ' << sign << endl;
}

void sym_handle(Symbol sym, char sign)
{
    string sym_str = symbol2string(sym);
    if (OUTPUT_LEX)
        cout << sym_str << ' ' << sign << endl;
}

void sym_handle(Symbol sym, int num)
{
    string sym_str = symbol2string(sym);
    if (OUTPUT_LEX)
        cout << sym_str << ' ' << num << endl;
}

bool getsym()
{
    clear_token();
    do
    {
        readchar();
    }
    while (is_blank());
    if (cur_c == EOF)
    {
        return false;
    }

    if (is_letter())
    {
        bool meet_eof;
        while (is_letter() || is_digit())
        {
            cat_token();
            if (!readchar()) return false;
        }
        retract();
        symbol = reserver();
        token[token_len] = 0; // set tailed
        sym_handle(symbol, token);

    }
    else if (is_digit())
    {
        bool is_zero = false;
        if (cur_c == '0')
        {
            is_zero = true;
        }
        while (is_digit())
        {
            cat_token();
            if (!readchar()) return false;
        }
        retract();
        num = trans_num();
        if (is_zero && num != 0)
        {
            symbol = INTCON;
            error("unexpected leading zero");
        }
        else if (is_zero)
        {
            symbol = ZERO;
        }
        else
        {
            symbol = INTCON;
        }
        sym_handle(symbol, num);

    }
    else if (is_squo())  	// record char
    {
        // mate char
        symbol = CHARCON;
        num = -1;
        if (!readchar()) return false;
        if (
            is_add() || is_sub() || is_mul() || is_div() ||
            is_letter() || is_digit()
        )
        {
            num = (int)cur_c;
        }
        else if (is_squo())
        {
            sym_handle(symbol, num);
            error("empty char");
            return true;	// is ''
        }
        else
        {
            error("invalid char");
        }

        // mate '
        if (!readchar()) return false;
        if (!is_squo())
        {
            num = -1;
            error("multiple chars");
            do
            {
                if (!readchar()) return false;
            }
            while (!is_squo());
        }
        sym_handle(symbol, num);

    }
    else if (is_dquo())
    {
        symbol = STRCON;

        // mate string
        while (true)
        {
            if (!readchar()) return false;
            if (is_dquo())   // "
            {
                token[token_len] = 0; // set tailed
                sym_handle(symbol, token);
                break;
            }
            else if (!is_string_char())
            {
                error("invalid char in string");
                continue;
            }
            else
            {
                cat_token();
            }
        }

    }
    else if (is_excla())     // !
    {
        cat_token();
        if (!readchar()) return false;
        if (is_ass())   // =
        {
            cat_token();
            symbol = NE;
            token[token_len] = 0;
            sym_handle(symbol, token);
        }
        else
        {
            retract();
            error("unexpected token \'!\'");
        }

    }
    else if (is_ass())
    {
        if (!readchar()) return false;
        if (is_ass())
        {
            symbol = EQ;
            sym_handle(symbol, token);
        }
        else
        {
            retract();
            symbol = ASS ;
            sym_handle(symbol, cur_c);
        }

    }
    else if (is_gt())     // >
    {
        cat_token();
        if (!readchar()) return false;
        if (is_ass())   // =
        {
            cat_token();
            symbol = GE;
        }
        else
        {
            retract();
            symbol = GT;
        }
        token[token_len] = 0;
        sym_handle(symbol, token);

    }
    else if (is_lt())     // <
    {
        cat_token();
        if (!readchar()) return false;
        if (is_ass())   // =
        {
            cat_token();
            symbol = LE;
        }
        else
        {
            retract();
            symbol = LT;
        }
        token[token_len] = 0;
        sym_handle(symbol, token);

    }
    else if (is_comma())
    {
        symbol = COMMA;
        sym_handle(symbol, cur_c);
    }
    else if (is_colon())
    {
        symbol = COLON;
        sym_handle(symbol, cur_c);
    }
    else if (is_semi())
    {
        symbol = SEMI ;
        sym_handle(symbol, cur_c);
    }
    else if (is_lpar())
    {
        symbol = LPAR ;
        sym_handle(symbol, cur_c);
    }
    else if (is_rpar())
    {
        symbol = RPAR ;
        sym_handle(symbol, cur_c);
    }
    else if (is_lbkt())
    {
        symbol = LBKT ;
        sym_handle(symbol, cur_c);
    }
    else if (is_rbkt())
    {
        symbol = RBKT ;
        sym_handle(symbol, cur_c);
    }
    else if (is_lbrace())
    {
        symbol = LBRACE ;
        sym_handle(symbol, cur_c);
    }
    else if (is_rbrace())
    {
        symbol = RBRACE ;
        sym_handle(symbol, cur_c);
    }
    else if (is_add())
    {
        symbol = ADD  ;
        sym_handle(symbol, cur_c);
    }
    else if (is_sub())
    {
        symbol = SUB  ;
        sym_handle(symbol, cur_c);
    }
    else if (is_mul())
    {
        symbol = MUL  ;
        sym_handle(symbol, cur_c);
    }
    else if (is_div())
    {
        symbol = DIV  ;
        sym_handle(symbol, cur_c);
    }
    else
    {
        error((string)"unexpected token \'" + cur_c + "\'");
        return getsym();    // skip
    }
    return true;
}

int lexical_main()
{
    while(true)
    {
        getsym();
    }
    return 0;
}
