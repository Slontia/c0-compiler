#ifndef MEDI_H_INCLUDED
#define MEDI_H_INCLUDED

#include <iostream>
#include <vector>
#include "vars.h"
using namespace std;

class FuncItem;
class VarItem;

extern vector<int> branchs;
extern int level;
extern int temp_count;

void init();

void next_branch();

void declare_func_medi(FuncItem* func_item);

void invoke_func(FuncItem* func_item, vector<string> paras);

void func_return(string v);

void declare_global_var_medi(vector<VarItem*> vars);

void lable(FuncItem* func_item);

string new_temp();

void cal_medi(Symbol op, string result, string a1, string a2);
void cal_medi(Symbol op, string result, string a1, int a2);

void comp_medi(Symbol op, string a1, string a2);
void comp_medi(Symbol op, string a1, int a2);

void jump(Symbol op, string a1, string a2, string label);
void jump(Symbol op, string a1, int a2, string label);

void array_set(string array_name, string index, string result);
void array_set(string array_name, int index, string result);

void assign_medi(string n1, string n2);
void assign_medi(string name, int value);

void push_medi(string name);
void return_get_medi(string name);

#endif // MEDI_H_INCLUDED
