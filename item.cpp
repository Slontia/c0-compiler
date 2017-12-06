# include "item.h"
# include <iostream>
using namespace std;

void error(string info);

string type2string(Type type) {
    switch (type) {
    case INT: return "int";
    case CHAR: return "char";
    case VOID: return "void";
    }
    return NULL;
}

string kind2string(Kind kind) {
    switch (kind) {
        case FUNC: return "function";
        case CONST: return "constant";
        case VAR: return "variable";
    }
    return NULL;
}

/* Item */

Item::Item(string name, Type type, Kind kind) {
    this->name = name;
    this->type = type;
    this->kind = kind;
}
Type Item::get_type() { return type; }
Kind Item::get_kind() { return kind; }
string Item::get_name() {return name;}


/* Var */

VarItem::VarItem(string name, Type type, int len): Item(name, type, VAR) {
    this->len = len;
}

bool VarItem::isarray() {
    return (len != 0);
}

int VarItem::get_len() {
    return len;
}


/* Const */

ConstItem::ConstItem(string name, Type type, int value): Item(name, type, CONST) {
    this->value = value;
}

int ConstItem::get_value() { return value; }


/* Func */

FuncItem::FuncItem(string name, Type type): Item(name, type, FUNC) {}

void FuncItem::put_para(string name, Type type) {
    if (has_var(name)) {
        error("redefinition of '" + name + "\'");
        return;
    }

    VarItem* var_item = new VarItem(name, type);
    vars.insert(VAR_MAP::value_type(name, var_item));
    paras.push_back(var_item);
}

void FuncItem::put_const(string name, Type type, int value) {
    if (has_const(name)) {
        error("redefinition of '" + name + "\'");
        return;
    }
    ConstItem* const_item = new ConstItem(name, type, value);
    consts.insert(CONST_MAP::value_type(name, const_item));
}

void FuncItem::put_var(string name, Type type, int len) {
    if (has_var(name)) {
        error("redefinition of '" + name + "\'");
        return;
    }
    VarItem* var_item = new VarItem(name, type, len);
    vars.insert(VAR_MAP::value_type(name, var_item));
}

// if not exists, return null
ConstItem* FuncItem::get_const(string name) {
    CONST_MAP::iterator it = consts.find(name);
    if (it != consts.end()) {
        return it->second;
    }
    return NULL;
}

// if not exists, return null
VarItem* FuncItem::get_var(string name) {
    VAR_MAP::iterator it = vars.find(name);
    if (it != vars.end()) {
        return it->second;
    }
    return NULL;
}

bool FuncItem::has_const(string name) {
    CONST_MAP::iterator it = consts.find(name);
    return (it != consts.end());
}

bool FuncItem::has_var(string name) {
    VAR_MAP::iterator it = vars.find(name);
    return (it != vars.end());
}

bool FuncItem::para_check(vector<Type> types) {
    if (types.size() != paras.size()) {
        return false;
    }
    int len = types.size();
    for (int i = 0; i < len; i ++) {
        if (types[i] != paras[i]->get_type()) {
            return false;
        }
    }
    return true;
}












