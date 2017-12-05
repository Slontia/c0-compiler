#include "lexical.h"
#include "vars.h"
#include "gram.h"
#include "item.h"
#include <iostream>

using namespace std;

Symbol symbol;
VAR_MAP global_vars;
CONST_MAP global_consts;
FUNC_MAP funcs;
string name;
Type type;
bool skip_type_ident = false;
void item();
void factor();
void expr();

typedef enum {
    CONST_STATE, VAR_STATE, FUNC_STATE, FUNC_CONST_STATE, FUNC_VAR_STATE, FUNC_STATEMENT_STATE
}State;

void output_info(string info) {
    // cout << info << endl;
}

void record_name() {
    token[token_len] = 0;
    name = token;
}

void mate(Symbol sym, void (*handle_ptr)() = NULL) {
    if (symbol != sym) {
        error((string)"got " + symbol2string(symbol) + " expected " + symbol2string(sym));
    } else {
        if ((*handle_ptr) != NULL) (*handle_ptr)();
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

        case ADD:
            getsym();
            mate(INTCON);
            break;

        case SUB:
            getsym();
            mate(INTCON);
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

bool defined(string name) {
    CONST_MAP::iterator itc = global_consts.find(name);
    if (itc != global_consts.end()) {
        error("redefinition of '" + name + "\'");
        return true;
    }
    VAR_MAP::iterator itv = global_vars.find(name);
    if (itv != global_vars.end()) {
        error("redefinition of '" + name + "\'");
        return true;
    }
    return false;
}

void put_global_const(string name, Type type, int value) {
    if (!defined(name))
    global_consts.insert(CONST_MAP::value_type(name, new ConstItem(name, type, value)));
}

void put_global_var(string name, Type type, int len = 0) {
    if (!defined(name))
    global_vars.insert(VAR_MAP::value_type(name, new VarItem(name, type, len)));
}

void declare_const(FuncItem* func = NULL) {
    while (symbol == CONSTSY) {
        getsym();
        switch (symbol) {
        case INTSY:
            getsym();
            do {
                mate(IDENT, &record_name);  // record name
                mate(ASS);
                if (symbol == ZERO) {
                    getsym();
                    if (func == NULL) {
                        put_global_const(name, INT, 0);
                    } else {
                        func->put_const(name, INT, 0);
                    }

                } else {
                    int sign = 1;
                    if (symbol == ADD) {
                        sign = 1;
                        getsym();
                    } else if (symbol == SUB) {
                        sign = -1;
                        getsym();
                    }
                    mate(INTCON);
                    if (func == NULL) {
                        put_global_const(name, INT, sign * num);
                    } else {
                        func->put_const(name, INT, sign * num);
                    }

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
                mate(IDENT, &record_name);
                mate(ASS);
                mate(CHARCON);
                if (func == NULL) {
                    put_global_const(name, CHAR, num);
                } else {
                    func->put_const(name, CHAR, num);
                }

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



void declare_var(FuncItem* func = NULL) {
    bool is_first = true;
    while (true) {
        is_first = true;
        switch (symbol) {
        case INTSY:
            type = INT;
            break;
        case CHARSY:
            type = CHAR;
            break;
        default:
            return;
        }
        getsym();

        do {
            mate(IDENT, &record_name);
            // array '['
            if (is_first) {
                if (LPAR == symbol || LBRACE == symbol) {
                    if (func == NULL) {
                        skip_type_ident = true;
                        return;
                    } else {
                        break;
                    }
                }
                is_first = false;
            }
            if (LBKT == symbol) {
                getsym();
                mate(INTCON);
                if (func == NULL) {
                    put_global_var(name, type, num);
                } else {
                    func->put_var(name, type, num);
                }
                mate(RBKT); // ']'

            } else {
                if (func == NULL) {
                    put_global_var(name, type);
                } else {
                    func->put_var(name, type);
                }
            }

            if (COMMA != symbol) {  // ','
                break;
            }
            getsym();
        } while (true);
        mate(SEMI);
    }
}

void comp_statement(FuncItem* func) {
    mate(LBRACE);   // '{'
    declare_const(func);
    declare_var(func);
    while (symbol != RBRACE) {  // '}'
        statement();
    }
    getsym();
}

void declare_func() {
    const int is_voi = 0;
    const int is_int = 1;
    const int is_char = 2;
    int got_main;
    FuncItem* this_func = NULL;
    while (true) {
        // // cout << "=== NEW FUNCTION ===" << endl;
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
                    this_func = new FuncItem("main", VOID);
                    funcs.insert(FUNC_MAP::value_type("main", this_func));
                    comp_statement(this_func);
                    continue;
                } else {
                    type = VOID;
                }
                break;
            case INTSY:
                getsym();
                type = INT;
                break;
            case CHARSY:
                getsym();
                type = CHAR;
                break;
            default:
                error((string)"unexpected return type " + symbol2string(symbol));
                return;
            }
            mate(IDENT, &record_name);
        }
        this_func = new FuncItem(name, type);
        funcs.insert(FUNC_MAP::value_type(name, this_func));

        if (symbol == LPAR) {
            getsym();
            do {
                switch (symbol) {
                case INTSY:
                    type = INT;
                    getsym();
                    break;
                case CHARSY:
                    type = CHAR;
                    getsym();
                    break;
                default:
                    error((string)"Unexpected parameter type " + symbol2string(symbol));
                }
                mate(IDENT, &record_name);
                this_func->put_para(name, type);
                if (symbol != COMMA) { // ','
                    break;
                }
                getsym();
            } while (true);
            mate(RPAR);
        }

        comp_statement(this_func);
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
