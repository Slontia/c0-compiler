#ifndef ITEM_H_INCLUDED
#define ITEM_H_INCLUDED

#include <iostream>
#include <map>
#include <vector>
#include "vars.h"
using namespace std;

class Item;
class VarItem;
class ConstItem;
class FuncItem;


string type2string(Type type);
string kind2string(Kind kind);

typedef map<string, VarItem*> VAR_MAP;
typedef map<string, ConstItem*> CONST_MAP;
typedef map<string, FuncItem*> FUNC_MAP;

class Item {
private:
    string name;
    Type type;
    Kind kind;

public:
    Item(string name, Type type, Kind kind);

    Type get_type();

    Kind get_kind();

    string get_name();
};



class VarItem : public Item {
private:
    int len;

public :
    VarItem(string name, Type type, int len = 0);

    int get_len();

    bool isarray();
};



class ConstItem : public Item {
private:
    int value;

public:
    ConstItem(string name, Type type, int value);

    int get_value();
};



class FuncItem : public Item {
private:
    vector<VarItem*> paras;
    CONST_MAP consts;
    VAR_MAP vars;
    int func_size;
    int vars_size;

public:
    FuncItem(string name, Type type);

    void put_para(string name, Type type);

    void put_const(string name, Type type, int value);

    void put_var(string name, Type type, int len = 0);

    // if not exists, return null
    ConstItem* get_const(string name);

    // if not exists, return null
    VarItem* get_var(string name);

    bool has_const(string name);

    bool has_var(string name);

    bool para_check(vector<Type> types);

    vector<VarItem*> get_paras();

    void add_size(int bytes);

    int get_size();

    void move_vars_size();

    int get_vars_size();

    int get_para_count();
};

int round_up(int, int);

#endif // ITEM_H_INCLUDED
