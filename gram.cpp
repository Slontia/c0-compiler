#include "lexical.h"
#include "vars.h"
#include <iostream>

using namespace std;

Symbol symbol;
bool skip_type_ident = false;
void item();
void factor();
void expr();

typedef enum {
    CONST_STATE, VAR_STATE, FUNC_STATE, FUNC_CONST_STATE, FUNC_VAR_STATE, FUNC_STATEMENT_STATE
}State;

void output_info(string info) {
    cout << info << endl;
}

void mate(Symbol sym) {
    if (symbol != sym) {
        error((string)"got " + symbol2string(symbol) + " expected " + symbol2string(sym));
    } else {
        getsym();
    }
}

void mate_idents() {
    do {
        mate(IDENT);
        if (symbol != COMMA) { // ','
            break;
        }
        getsym();
    } while (true);
}

void expr() {
    if (symbol == ADD || symbol == SUB) {
        getsym();
    }
    do {
        item();
        if (symbol == ADD || symbol == SUB) {
            getsym();
        } else {
            break;
        }
    } while (true);
}

void item() {
    do {
        factor();
        if (symbol == MUL || symbol == DIV) {
            getsym();
        } else {
            break;
        }
    } while (true);
}

void factor() {
    switch(symbol){
        case IDENT:
            getsym();
            if (symbol == LBKT) { // '['
                getsym();
                expr();
                mate(RBKT); // ']'
            } else if (symbol == LPAR) {    // '('
                getsym();
                do {
                    expr();
                    if (symbol != COMMA) { // ','
                        break;
                    }
                    getsym();
                } while (true);
                mate(RPAR); // ')'
            }
            break;

        // '('
        case LPAR:
            getsym();
            expr();
            mate(RPAR); // ')'
            break;

        case INTCON:
            getsym();
            break;

        case CHARCON:
            getsym();
            break;

        case ZERO:
            getsym();
            break;

        default:
            error((string)"unexpected symbol " + symbol2string(symbol) + " in [factor]");
    }

}

void cond() {
    expr();
    switch (symbol){
    case GT:
        getsym();
        break;
    case GE:
        getsym();
        break;
    case LT:
        getsym();
        break;
    case LE:
        getsym();
        break;
    case EQ:
        getsym();
        break;
    case NE:
        getsym();
        break;
    default:
        return; // only expression
    }
    expr();
}



void statement() {
    const int is_var = 0;
    const int is_func = 1;
    int type = -1;
    switch(symbol){
    // if (cond) statement else statement
    case IFSY:
        output_info("If statement begins!");
        // if block
        getsym();
        mate(LPAR); // '('
        cond(); // identify condition
        mate(RPAR); // ')'
        statement();    // statement among if

        output_info("Else statement begins!");
        // else block
        mate(ELSY); // 'else'
        statement();    // statement among else

        output_info("Else statement over!");
        break;

    // switch(expr){case 0:statement [default: statement]}
    case SWTSY:
        output_info("Switch statement begins!");

        getsym();
        mate(LPAR); // '('
        expr(); // expression to switch
        mate(RPAR); // ')'
        mate(LBRACE);   // '{'
        mate(CASESY);   // case
        // cases
        do {
            output_info("Case statement begins!");

            if (symbol == INTCON || symbol == ZERO) {    // int
                getsym();
            } else if (symbol == CHARCON) { // char
                getsym();
            } else {
                error((string)"unexpected symbol " + symbol2string(symbol) + " after [case]");
            }
            mate(COLON);    // :
            statement();
            if (symbol != CASESY) {
                break;
            }
            getsym();
        } while (true);
        if (symbol == DFTSY) {
            output_info("Default statement begins!");
            getsym();
            mate(COLON);    // :
            statement();
        }
        mate(RBRACE);   // ';'
        output_info("Switch statement over!");
        break;

    // while(cond)statement
    case WHILESY:
        output_info("While statement begins!");
        getsym();
        mate(LPAR); // '('
        cond(); // identify condition
        mate(RPAR); // ')'
        statement();    // statement among if
        output_info("While statement over!");
        break;

    // '{'
    case LBRACE:
        getsym();
        while (symbol != RBRACE) {
            statement();
        } // '}'
        getsym();
        break;

    // return[(expr)];
    case RTNSY:
        output_info("This is a return statement!");
        getsym();
        if (symbol != SEMI) {
            mate(LPAR);
            expr();
            mate(RPAR);
            mate(SEMI);
        } else {
            getsym();
        }
        break;

    // read
    case PRTFST:
        output_info("This is a print statement!");
        getsym();
        mate(LPAR); // '('
        if (symbol == STRCON) { // string
            getsym();
            if (symbol == COMMA) {  // ','
                getsym();
                expr();
            }
        } else {
            expr();
        }
        mate(RPAR); // ')'
        mate(SEMI);
        break;

    // write
    case SCFSY:
        output_info("This is a read statement!");
        getsym();
        mate(LPAR);
        mate_idents();
        mate(RPAR);
        mate(SEMI);
        break;

    // assignment | function
    case IDENT:
        getsym();
        if (symbol == LBKT) {   // '['
            getsym();
            type = is_var;
            expr();
            mate(RBKT); // ']'
        } else if (symbol == LPAR) { // '('
            getsym();
            type = is_func;
            do {
                expr();
                if (symbol != COMMA) { // ','
                    break;
                }
                getsym();
            } while (true);
            mate(RPAR); // ')'
        }

        /* look up table (func without parameters? var?) */
        if (symbol == ASS) type = is_var;   // NO

        if (is_func == type) {
            output_info("This is a function invoking statement!");
        } else if (is_var == type) {
            output_info("This is a assign statement!");
            mate(ASS);
            expr();
        } else {
            error_debug("func or var?");
        }
        mate(SEMI); // ';'
        break;

    // ;
    case SEMI:
        getsym();
        break;

    default:
        error((string)"unexpected symbol " + symbol2string(symbol) + " in the beginning of [statement]");
        break;
    }

}

int declare_const() {
    while (symbol == CONSTSY) {
        getsym();
        switch (symbol) {
        case INTSY:
            getsym();
            do {
                mate(IDENT);
                mate(ASS);
                if (symbol == ZERO) {
                    getsym();
                } else {
                    if (symbol == ADD) {
                        getsym();
                    } else if (symbol == SUB) {
                        getsym();
                    }
                    mate(INTCON);
                }
                if (symbol != COMMA) {
                    break;
                }
                getsym();
            } while (true);
            break;
        case CHARSY:
            getsym();
            do {
                mate(IDENT);
                mate(ASS);
                mate(CHARCON);
                if (symbol != COMMA) {
                    break;
                }
                getsym();
            } while (true);
            break;
        default:
            error((string)"unexpected const type " + symbol2string(symbol));
        }
        mate(SEMI);
    }
}

void declare_var() {
    const int is_char = 0;
    const int is_int = 1;
    int type = -1;
    while (true) {
        switch (symbol) {
        case INTSY:
            type = is_int;
            break;
        case CHARSY:
            type = is_char;
            break;
        default:
            return;
        }
        getsym();
        do {
            mate(IDENT);
            // array
            switch (symbol) {
            // '['
            case LBKT:
                getsym();
                mate(INTCON);
                mate(RBKT); // ']'
                break;

            // '(' (function)
            case LPAR:
            // '{' (function)
            case LBRACE:
                skip_type_ident = true;
                return;
            default:
                break;
            }
            if (COMMA != symbol) {  // ','
                break;
            }
            getsym();
        } while (true);
        mate(SEMI);
    }
}

void comp_statement() {
    mate(LBRACE);   // '{'
    declare_const();
    declare_var();
    while (symbol != RBRACE) {  // '}'
        statement();
    }
    getsym();
}

void declare_func() {
    const int is_voi = 0;
    const int is_int = 1;
    const int is_char = 2;
    int type = -1;
    int got_main;
    while (true) {
        // cout << "=== NEW FUNCTION ===" << endl;
        if (skip_type_ident) {
            skip_type_ident = false;
        } else {
            switch (symbol) {
            case VOIDSY:
                getsym();
                if (MAINSY == symbol) {
                    getsym();
                    mate(LPAR);
                    mate(RPAR); // '()'
                    comp_statement();
                    continue;
                } else {
                    type = is_voi;
                }
                break;
            case INTSY:
                getsym();
                type = is_int;
                break;
            case CHARSY:
                getsym();
                type = is_char;
                break;
            default:
                error((string)"unexpected return type " + symbol2string(symbol));
                type = -1;
                return;
            }
            mate(IDENT);
        }

        if (symbol == LPAR) {
            getsym();
            do {
                switch (symbol) {
                case INTSY:
                    getsym();
                    break;
                case CHARSY:
                    getsym();
                    break;
                default:
                    error((string)"Unexpected parameter type " + symbol2string(symbol));
                }
                mate(IDENT);
                if (symbol != COMMA) { // ','
                    break;
                }
                getsym();
            } while (true);
            mate(RPAR);
        }

        comp_statement();
    }
}

int gram_main() {
    getsym();
    cout << "=== CONST BEGIN ===" << endl;
    declare_const();
    cout << "=== VAR BEGIN ===" << endl;
    declare_var();
    cout << "=== FUNC BEGIN ===" << endl;
    declare_func();
}
