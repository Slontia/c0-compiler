/*
10 free string
12 div 0
if/switch need not to save
*/

#include "lexical.h"
#include <cstdlib>
#include "vars.h"
#include "gram.h"
#include "item.h"
#include "medi.h"
#include <iostream>

using namespace std;

Symbol symbol;
VAR_MAP global_vars;
CONST_MAP global_consts;
FUNC_MAP funcs;
string name;
FuncItem* this_func = NULL;
Type type;
bool returned;
bool skip_type_ident = false;

int const_value;
bool certain;

Type item(int*, bool*, string*);
Type factor(int*, bool*, string*);
Type expr(int*, bool*, string*);

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

void getsym_check() {
    if (!getsym()) {
        error("unfinished program");
    }
}

void mate(Symbol sym, void (*handle_ptr)() = NULL) {
    if (symbol != sym) {
        error((string)"got " + symbol2string(symbol) + " expected " + symbol2string(sym));
    } else {
        if ((*handle_ptr) != NULL) (*handle_ptr)();
        getsym_check();
    }
}

Type expr(int* value, bool* certain, string* name) {
    Type ex_type = CHAR;
    int cur_value;
    bool cur_certain;
    Symbol cur_op = ADD;
    *value = 0;
    *certain = true;
    string* itm_name = new string();
    bool first_uncertain = true;
    if (symbol == ADD || symbol == SUB) {
        cur_op = symbol;
        ex_type = INT;
        getsym_check();
    }
    do {
        if (item(&cur_value, &cur_certain, itm_name) == INT) {
            ex_type = INT;
        }
        *certain &= cur_certain;
        if (*certain) {
            switch (cur_op) {
            case ADD:
                *value += cur_value;
                break;
            case SUB:
                *value -= cur_value;
                break;
            default: error_debug("expr");
            }
        } else if (first_uncertain) {
            first_uncertain = false;
            *name = new_temp();
            if (*value == 0) {
                if (cur_op == ADD) {
                    assign_medi(*name, *itm_name);
                } else {
                    cal_medi(cur_op, *name, 0, *itm_name);
                }
            } else {
                assign_medi(*name, *value);
                cal_medi(cur_op, *name, *name, *itm_name);
            }

        } else if (!cur_certain) {
            cal_medi(cur_op, *name, *name, *itm_name);
        } else {
            cal_medi(cur_op, *name, *name, cur_value);
        }
        if (symbol == ADD || symbol == SUB) {
            cur_op = symbol;
            ex_type = INT;
            getsym_check();
        } else {
            break;
        }
    } while (true);
    delete(itm_name);
    cout << type2string(ex_type);
    return ex_type;
}

Type item(int* value, bool* certain, string* name) {
    Type it_type = CHAR;
    int cur_value;
    bool cur_certain;
    Symbol cur_op = MUL;
    *value = 1;
    *certain = true;
    string* fac_name = new string();
    bool first_uncertain = true;
    do {
        cout << "TEST";
        if (factor(&cur_value, &cur_certain, fac_name) == INT) {
            it_type = INT;
        }
        *certain &= cur_certain;
        if (*certain) {
            switch(cur_op) {
            case MUL:
                *value *= cur_value;
                break;
            case DIV:
                *value /= cur_value;
                break;
            default: error_debug("item");
            }
        } else if (first_uncertain) {
            first_uncertain = false;
            *name = new_temp();
            if (*value == 1 && cur_op == MUL) {
                assign_medi(*name, *fac_name);
            } else {
                assign_medi(*name, *value);
                cal_medi(cur_op, *name, *name, *fac_name);
            }
        } else if (!cur_certain) {
            cal_medi(cur_op, *name, *name, *fac_name);
        } else {
            cal_medi(cur_op, *name, *name, cur_value);
        }
        if (symbol == MUL || symbol == DIV) {
            cur_op = symbol;
            it_type = INT;
            getsym_check();
        } else {
            break;
        }
        cout << "TEST";
    } while (true);
    delete(fac_name);
    return it_type;
}

VarItem* get_global_var(string name) {
    VAR_MAP::iterator it = global_vars.find(name);
    if (it != global_vars.end()) {
        return it->second;
    } else {
        return NULL;
    }
}

ConstItem* get_global_const(string name) {
    CONST_MAP::iterator it = global_consts.find(name);
    if (it != global_consts.end()) {
        return it->second;
    } else {
        return NULL;
    }
}

FuncItem* get_func(string name) {
    FUNC_MAP::iterator it = funcs.find(name);
    if (it != funcs.end()) {
        return it->second;
    } else {
        return NULL;
    }
}

Item* get_item(string name) {
    Item* item;
    if ((item = this_func->get_const(name)) != NULL) return item;
    if ((item = this_func->get_var(name)) != NULL) return item;
    if ((item = get_global_const(name)) != NULL) return item;
    if ((item = get_global_var(name)) != NULL) return item;
    if ((item = get_func(name)) != NULL) return item;
    return NULL;
}


Item* read_ident(string* index_name) {  // address of the pointer to temp_name
    Item* item = NULL;
    name = token;
    if ((item = get_item(name)) == NULL) {
        error((string)"unexpected sign \'" + name + "\'");
        return NULL;
    }
    getsym_check();

    // is array
    if (symbol == LBKT) { // '['
        getsym_check();
        if (item->get_kind() != VAR || !((VarItem*)item)->isarray()) {
            error((string)"\'" + name + "\' is not an array type");
        }
        int index_value;
        bool index_certain;
        expr(&index_value, &index_certain, index_name);
        if (index_certain) {
            *index_name = new_temp();
            assign_medi(*index_name, index_value);
        }

        int len = ((VarItem*)item)->get_len();
        if (index_certain && (index_value < 0 || index_value >= len)) {
            error((string)"index of array \'" + name + "[]\' out of range");
        }
        /* out of range judgment */
        mate(RBKT); // ']'

    // is function with paras
    } else if (symbol == LPAR) {    // '('
        getsym_check();
        vector<Type> para_types;
        string* name = new string();
        do {
            int para_value;
            bool para_certain;
            para_types.push_back(expr(&para_value, &para_certain, name));
            if (para_certain) {
                push_medi(para_value);
            } else {
                push_medi(*name);
            }

            if (symbol != COMMA) { // ','
                break;
            }
            getsym_check();
        } while (true);
        if (item->get_kind() != FUNC || !((FuncItem*)item)->para_check(para_types)) {
            error((string)"parameters to function \'" + item->get_name() +"\' do not match");
        }
        mate(RPAR); // ')'
    }
    return item;
}

Type factor(int* value, bool* certain, string* name) {
    Type fac_type;
    Item* item = NULL;
    *certain = false;
    switch(symbol){
        case IDENT: {
            string* index_name = new string("123");
            item = read_ident(index_name);
            fac_type = item->get_type();
            if (item->get_type() == VOID) {
                error("void value not ignored as it ought to be");
            }
            switch (item->get_kind()) {
            case CONST:
                *value = ((ConstItem*)item)->get_value();
                *certain = true;
                break;

            case VAR:
                if (((VarItem*)item)->isarray()) {
                    *name = new_temp();
                    array_get_medi(item->get_name(), *index_name, *name);
                } else {
                    *name = item->get_name();
                }
                *certain = false;

                break;

            case FUNC:
                invoke_func_medi(item->get_name());
                *name = new_temp();
                return_get_medi(*name);
                *certain = false;
            }
            cout << *index_name;
            delete(index_name);
            break;
        }
        // '(' function with paras
        case LPAR:
            getsym_check();
            fac_type = expr(value, certain, name);
            mate(RPAR); // ')'
            break;

        case ADD:
            getsym_check();
            fac_type = INT;
            mate(INTCON);
            *value = num;
            *certain = true;
            break;

        case SUB:
            getsym_check();
            fac_type = INT;
            mate(INTCON);
            *value = -1 * num;
            *certain = true;
            break;

        case INTCON:

            fac_type = INT;
            *value = num;
            *certain = true;
            getsym_check();
            break;

        case CHARCON:

            fac_type = CHAR;
            *value = num;
            *certain = true;
            getsym_check();
            break;

        case ZERO:

            fac_type = INT;
            *value = 0;
            *certain = true;
            getsym_check();
            break;

        default:
            error((string)"unexpected symbol " + symbol2string(symbol) + " in [factor]");
    }
    return fac_type;
}

void cond(int* value, bool* certain, string* name) {
    Symbol cmp_op;
    string* left_name = new string();
    expr(value, certain, left_name);
    switch (symbol){
    case GT:
    case GE:
    case LT:
    case LE:
    case EQ:
    case NE:
        cmp_op = symbol;
        getsym_check();
        break;
    default:
        return; // only expression
    }
    bool left_certain = *certain;
    int left_value = *value;
    string* right_name = new string();
    expr(value, certain, right_name);
    bool right_certain = *certain;
    int right_value = *value;
    if (left_certain && right_certain) { // left certain
        *certain = true;
        switch (cmp_op) {
        case GT:
            *value = (left_value > right_value);
            break;
        case GE:
            *value = (left_value >= right_value);
            break;
        case LT:
            *value = (left_value < right_value);
            break;
        case LE:
            *value = (left_value <= right_value);
            break;
        case EQ:
            *value = (left_value == right_value);
            break;
        case NE:
            *value = (left_value != right_value);
            break;
        default: error_debug("cond");
        }
        return;

    } else if (left_certain && !right_certain){    // left uncertain
        cal_medi(cmp_op, *right_name, left_value, *right_name);
        *name = *right_name;
    } else if (!left_certain && right_certain) {
        cal_medi(cmp_op, *left_name, *left_name, right_value);
        *name = *left_name;
    } else {
        cal_medi(cmp_op, *left_name, *left_name, *right_name);
        *name = *left_name;
    }
    *certain = false;
    delete(right_name);
}



void statement() {
    temp_counts.push_back(temp_counts.back());
    switch(symbol){
    // if (cond) statement else statement
    case IFSY: {
        string *cond_name = new string();
        string over_label, else_label;

        // if block
        getsym_check();
        mate(LPAR); // '('
        cond(&const_value, &certain, cond_name); // identify condition
        mate(RPAR); // ')'
//cout << this_func->get_name();
        else_label = new_label(this_func, "else_begin");   // set label
        over_label = new_label(this_func, "else_over");   // set label

        if (certain && const_value == 0) {
            jump_medi(else_label);
        } else if (!certain){

            branch_zero_medi(*cond_name, else_label);
        }

        delete(cond_name);

        output_info("If statement begins!");
        statement();    // statement among if
        jump_medi(over_label);

        output_info("Else statement begins!");
        mate(ELSY); // 'else'
        label_medi(else_label);
        statement();    // statement among else
        label_medi(over_label);

        output_info("Else statement over!");
        break;
    }
    // switch(expr){case 0:statement [default: statement]}
    case SWTSY: {
        map<int, string> label_map;
        output_info("Switch statement begins!");
        getsym_check();
        mate(LPAR); // '('
        string* switch_name = new string();
        type = expr(&const_value, &certain, switch_name); // expression to switch
        bool switch_certain = certain;
        int switch_value = const_value;
        mate(RPAR); // ')'
        mate(LBRACE);   // '{'
        mate(CASESY);   // case
        string switch_label = new_label(this_func, "switch_branch");
        string over_label = new_label(this_func, "switch_over");
        jump_medi(switch_label);

        // cases
        do {
            int sign = 1;
            output_info("Case statement begins!");
            switch (symbol) {
            case INTCON:
            case ZERO: {    // int
                if (type == CHAR) {
                    error((string)"expected type \'char\', got \'int\'");
                }
                getsym_check();
                break;
            }
            case CHARCON: { // char
                if (type == INT) {
                    error((string)"expected type \'int\', got \'char\'");
                }
                getsym_check();
                break;
            }
            case SUB:
                sign = -1;
            case ADD:
                getsym_check();
                mate(INTCON);
                break;

            default:
                error((string)"unexpected symbol " + symbol2string(symbol) + " after [case]");
            }
            num *= sign;    // pos / nega
            mate(COLON);    // :
            string label = new_label(this_func, "case");   // set label
            if (label_map.find(num) != label_map.end()) {
                error("the case has been defined above");
            } else {
                label_map.insert(map<int, string>::value_type(num, label));
            }
            label_medi(label);
            statement();
            jump_medi(over_label);  // jump to over label
            if (symbol != CASESY) {
                break;
            }
            getsym_check();
        } while (true);
        int has_default = false;
        string default_label;
        if (symbol == DFTSY) {
            output_info("Default statement begins!");
            getsym_check();
            mate(COLON);    // :
            default_label = new_label(this_func, "default");   // set label
            label_medi(default_label);
            statement();
            jump_medi(over_label);
            has_default = true;
        }
        mate(RBRACE);   // ';'
        output_info("Switch statement over!");
        label_medi(switch_label);
        map<int, string>::iterator it = label_map.begin();
        if (switch_certain) {
            while (it != label_map.end()) {
                if (switch_value == it->first) {
                    jump_medi(it->second);
                }
                it ++;
            }
        } else {
            while (it != label_map.end()) {
                branch_equal_medi(*switch_name, it->first, it->second);
                it ++;
            }
        }
        if (has_default) {
            jump_medi(default_label);
        }
        label_medi(over_label);
        delete(switch_name);
        break;
    }
    // while(cond)statement
    case WHILESY: {
        output_info("While statement begins!");
        getsym_check();
        mate(LPAR); // '('
        string begin_label = new_label(this_func, "while_begin");
        string over_label = new_label(this_func, "while_over");
        string* cond_name = new string();
        label_medi(begin_label);   // set label
        cond(&const_value, &certain, cond_name); // identify condition

        mate(RPAR); // ')'

        if (certain && const_value == 0) {
            jump_medi(over_label);
        } else if (!certain) {
            branch_zero_medi(*cond_name, over_label);
        }
        statement();    // statement among if
        jump_medi(begin_label);
        output_info("While statement over!");
        label_medi(over_label);
        delete(cond_name);
        break;
    }
    // '{'
    case LBRACE:
        getsym_check();
        //branchs.push_back(0);
        while (symbol != RBRACE) {
            statement();
        } // '}'
        //branchs.pop_back();
        getsym_check();
        break;

    // return[(expr)];
    case RTNSY:
        output_info("This is a return statement!");
        returned = true;
        getsym_check();
        if (symbol != SEMI) {
            mate(LPAR);
            string* return_name = new string();
            int expr_value;
            bool expr_certain;
            Type ex_type = expr(&expr_value, &expr_certain, return_name);
            if (ex_type != this_func->get_type()) {
                error((string)"expected return type \'" + type2string(this_func->get_type()) +
                       "\', actual '" + type2string(ex_type) + "\'");
            }
            if (expr_certain) {
                return_medi(expr_value);
            } else {
                return_medi(*return_name);
            }
            mate(RPAR);
            mate(SEMI);
            delete(return_name);
        } else {
            if (this_func->get_type() != VOID) {
                error((string)"return-statement with no value, in function returning \'" + type2string(this_func->get_type()) + "\'");
            }
            return_medi(this_func);
            getsym_check();
        }
        break;

    // read
    case PRTFST:{
        bool is_expr = false;
        output_info("This is a print statement!");
        getsym_check();
        mate(LPAR); // '('
        if (symbol == STRCON) { // string
            token[token_len] = 0;
            printf_medi(STRING, token);
            getsym_check();
            if (symbol == COMMA) {  // ','
                getsym_check();
                is_expr = true;
            }
        } else {
            is_expr = true;
        }
        if (is_expr) {
            string* print_name = new string();
            Type print_type = expr(&const_value, &certain, print_name);
            if (certain) {
                printf_medi(print_type, const_value);
            } else {
                printf_medi(print_type, *print_name);
            }
            delete(print_name);
        }
        mate(RPAR); // ')'
        mate(SEMI);
        break;
    }
    // write
    case SCFSY:
        output_info("This is a read statement!");
        getsym_check();
        mate(LPAR);
        do {
            mate(IDENT, &record_name);
            Item* item = get_item(name);
            if (item == NULL) {
                error("unexpected identifier \'" + name + "\'");
            } else if (item->get_kind() != VAR || ((VarItem*)item)->isarray()) {
                error("can only write to variables");
            } else {
                scanf_medi(item->get_type(), item->get_name());
            }
            if (symbol != COMMA) { // ','
                break;
            }
            getsym_check();
        } while (true);
        mate(RPAR);
        mate(SEMI);
        break;

    // assignment | function
    case IDENT: {
        string* index_name = new string();
        Item* item = read_ident(index_name);
        if (item == NULL) {
            break;  // not found
        }
        if (SEMI == symbol) {
            output_info("This is a function invoking statement!");
            if (item->get_kind() != FUNC) {
                error((string)"meaning less " + kind2string(item->get_kind()) + " \'" + item->get_name() + "\'");
            }
            invoke_func_medi(item->get_name()); // need not get return value
        } else if (ASS == symbol) {
            output_info("This is a assign statement!");
            getsym_check();
            if (item->get_kind() != VAR) {
                error((string)"assignment of non-var \'" + item->get_name() + "\'");
            }
            string* name = new string();
            if (expr(&const_value, &certain, name) == INT && item->get_type() == CHAR) {
                //error((string)"cannot convert 'int' to 'char'");
            }
            if (certain) {
                if (((VarItem*)item)->isarray()){
                    array_set_medi(item->get_name(), *index_name, const_value);
                } else {
                    assign_medi(item->get_name(), const_value);
                }

            } else {
                if (((VarItem*)item)->isarray()){
                    array_set_medi(item->get_name(), *index_name, *name);
                } else {
                    assign_medi(item->get_name(), *name);
                }

            }

        }
        mate(SEMI); // ';'
        delete(index_name);
        break;
    }

    // ;
    case SEMI:
        getsym_check();
        break;

    default:
        error((string)"unexpected symbol " + symbol2string(symbol) + " in the beginning of the statement");
        break;
    }
    temp_counts.pop_back();
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
    if (defined(name)) return;
    global_consts.insert(CONST_MAP::value_type(name, new ConstItem(name, type, value)));
}

void put_global_var(string name, Type type, int len = 0) {
    if (defined(name)) return;
    VarItem* var_item = new VarItem(name, type, len);
    global_vars.insert(VAR_MAP::value_type(name, var_item));
    declare_var_medi(var_item);
}

void declare_const(FuncItem* func = NULL) {
    while (symbol == CONSTSY) {
        getsym_check();
        switch (symbol) {
        case INTSY:
            getsym_check();
            do {
                mate(IDENT, &record_name);  // record name
                mate(ASS);
                if (symbol == ZERO) {
                    getsym_check();
                    if (func == NULL) {
                        put_global_const(name, INT, 0);
                    } else {
                        func->put_const(name, INT, 0);
                    }

                } else {
                    int sign = 1;
                    if (symbol == ADD) {
                        sign = 1;
                        getsym_check();
                    } else if (symbol == SUB) {
                        sign = -1;
                        getsym_check();
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
                getsym_check();
            } while (true);
            break;
        case CHARSY:
            getsym_check();
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
                getsym_check();
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
        getsym_check();

        do {
            mate(IDENT, &record_name);
            // array '[' | func '('
            if (is_first) {
                if (LPAR == symbol || LBRACE == symbol) {
                    if (func == NULL) {
                        skip_type_ident = true;
                        return; // turn to function declaration
                    } else {
                        break;
                    }
                }
                is_first = false;
            }
            if (LBKT == symbol) {
                getsym_check();
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
            getsym_check();
        } while (true);
        mate(SEMI);
    }
}

void comp_statement(FuncItem* func) {
    init_temp();
    mate(LBRACE);   // '{'
    declare_const(func);
    declare_var(func);
    func->move_vars_size();
    returned = false;
    branch = 0;
    while (symbol != RBRACE) {  // '}'
        statement();
    }
    return_medi(func);
    if (!returned && func->get_type() != VOID) {
        error((string)"function returning \'" + type2string(func->get_type()) + "\' without a return-statement");
    }
    if (func->get_name() == "main") {
        if (!next_end()) {
            error("there\'re something behind \'main\'");
        }

    } else {
        if (!getsym()) {
            error("undefined reference \'main\'");
        }
    }

}

void declare_func() {
    this_func = NULL;
    while (true) {
        if (skip_type_ident) {
            skip_type_ident = false;
        } else {
            switch (symbol) {
            case VOIDSY:
                getsym_check();
                if (MAINSY == symbol) {
                    getsym_check();
                    mate(LPAR);
                    mate(RPAR); // '()'
                    this_func = new FuncItem("main", VOID);
                    funcs.insert(FUNC_MAP::value_type("main", this_func));
                    declare_func_medi(this_func);
                    comp_statement(this_func);
                    return; // finish
                } else {
                    type = VOID;
                }
                break;
            case INTSY:
                getsym_check();
                type = INT;
                break;
            case CHARSY:
                getsym_check();
                type = CHAR;
                break;
            default:
                error((string)"unexpected return type " + symbol2string(symbol));
                return;
            }
            mate(IDENT, &record_name);
        }
        this_func = new FuncItem(name, type);
        declare_func_medi(this_func);
        funcs.insert(FUNC_MAP::value_type(name, this_func));

        if (symbol == LPAR) {
            getsym_check();
            do {
                switch (symbol) {
                case INTSY:
                    type = INT;
                    getsym_check();
                    break;
                case CHARSY:
                    type = CHAR;
                    getsym_check();
                    break;
                default:
                    error((string)"Unexpected parameter type " + symbol2string(symbol));
                }
                mate(IDENT, &record_name);
                this_func->put_para(name, type);
                if (symbol != COMMA) { // ','
                    break;
                }
                getsym_check();
            } while (true);
            mate(RPAR);
        }
        comp_statement(this_func);
    }
}


FILE* progf;

int gram_main() {
    progf = fopen("prog_huaiwei.txt", "r");
    fout.open("intermediate.txt");

    getsym_check();
    cout << "=== CONST BEGIN ===" << endl;
    declare_const();
    cout << "=== VAR BEGIN ===" << endl;
    declare_var();
    invoke_func_medi("main");
    exit_medi();
    temp_counts.push_back(0);
    cout << "=== FUNC BEGIN ===" << endl;
    declare_func();
    cout << "=== SUCCESS! ===" << endl;

    fout.close();
    fclose(progf);
    return 0;
}
