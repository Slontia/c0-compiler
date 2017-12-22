# include "item.h"
# include "vars.h"
# include "medi.h"
# include <iostream>
using namespace std;

void error(string info);

int round_up(int num, int unit)
{
    if (num % unit == 0)
    {
        return num;
    }
    else
    {
        num /= unit;
        num ++;
        num *= unit;
        return num;
    }
}

string type2string(Type type)
{
    switch (type)
    {
    case INT:
        return "int";
    case CHAR:
        return "char";
    case VOID:
        return "void";
    case STRING:
        return "string";
    }
    return NULL;
}

string kind2string(Kind kind)
{
    switch (kind)
    {
    case FUNC:
        return "function";
    case CONST:
        return "constant";
    case VAR:
        return "variable";
    }
    return NULL;
}

/* Item */

Item::Item(string name, Type type, Kind kind)
{
    this->name = name;
    this->type = type;
    this->kind = kind;
}
Type Item::get_type()
{
    return type;
}
Kind Item::get_kind()
{
    return kind;
}
string Item::get_name()
{
    return name;
}


/* Var */

VarItem::VarItem(string name, Type type, int len): Item(name, type, VAR)
{
    this->len = len;
}

bool VarItem::isarray()
{
    return (len != 0);
}

int VarItem::get_len()
{
    return len;
}


/* Const */

ConstItem::ConstItem(string name, Type type, int value): Item(name, type, CONST)
{
    this->value = value;
}

int ConstItem::get_value()
{
    return value;
}


/* Func */

FuncItem::FuncItem(string name, Type type): Item(name, type, FUNC)
{
    func_size = 0;
}

void FuncItem::add_size(int bytes)
{
    func_size += bytes;
}

int FuncItem::get_size()
{
    return func_size;
}

void FuncItem::move_vars_size()
{
    vars_size = func_size;
}

int FuncItem::get_vars_size()
{
    return vars_size;
}

void FuncItem::put_para(string name, Type type)
{
    if (has_var(name))
    {
        error("redefinition of '" + name + "\'");
        return;
    }
    func_size += 4;
    VarItem* var_item = new VarItem(name, type);
    vars.insert(VAR_MAP::value_type(name, var_item));
    paras.push_back(var_item);
    declare_para_medi(type, name);
}

void FuncItem::put_const(string name, Type type, int value)
{
    if (has_const(name) || has_const(name))
    {
        error("redefinition of '" + name + "\'");
        return;
    }
    else if (name == get_name())
    {
        error((string)"conflicting declaration with function name");
        return;
    }
    ConstItem* const_item = new ConstItem(name, type, value);
    consts.insert(CONST_MAP::value_type(name, const_item));
}

void FuncItem::put_var(string name, Type type, int len)
{
    if (has_var(name) || has_const(name))
    {
        error("redefinition of '" + name + "\'");
        return;
    }
    else if (name == get_name())
    {
        error((string)"conflicting declaration with function name");
        return;
    }
    func_size += (type == CHAR) ? 1 : 4;
    VarItem* var_item = new VarItem(name, type, len);
    vars.insert(VAR_MAP::value_type(name, var_item));
    declare_var_medi(var_item);
}

// if not exists, return null
ConstItem* FuncItem::get_const(string name)
{
    CONST_MAP::iterator it = consts.find(name);
    if (it != consts.end())
    {
        return it->second;
    }
    return NULL;
}

// if not exists, return null
VarItem* FuncItem::get_var(string name)
{
    VAR_MAP::iterator it = vars.find(name);
    if (it != vars.end())
    {
        return it->second;
    }
    return NULL;
}

bool FuncItem::has_const(string name)
{
    CONST_MAP::iterator it = consts.find(name);
    return (it != consts.end());
}

bool FuncItem::has_var(string name)
{
    VAR_MAP::iterator it = vars.find(name);
    return (it != vars.end());
}

bool FuncItem::para_check(vector<Type> types)
{
    if (types.size() != paras.size())
    {
        return false;
    }
    int len = types.size();
    for (int i = 0; i < len; i ++)
    {
        if (types[i] != paras[i]->get_type())
        {
            return false;
        }
    }
    return true;
}

int FuncItem::get_para_count()
{
    return paras.size();
}
