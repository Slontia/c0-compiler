#ifndef MEDI_H_INCLUDED
#define MEDI_H_INCLUDED

#include <iostream>
#include <vector>
#include "vars.h"
using namespace std;

class FuncItem;
class VarItem;

extern int branch;
extern int level;
extern int temp_count;

extern vector<string> str_set;

void init_temp();
string new_temp();
string new_label(FuncItem* func_item, string info);

void exit_medi();

void declare_func_medi(FuncItem* func_item);

void invoke_func_medi(string name);

void return_medi(string v);
void return_medi(int v);
void return_medi(FuncItem* func_item);

void declare_global_var_medi(vector<VarItem*> vars);

void declare_para_medi(Type type, string name);

void declare_var_medi(VarItem* var_item);

void label_medi(string label);

void cal_medi(Symbol op, string result, string a1, string a2);
void cal_medi(Symbol op, string result, string a1, int a2);
void cal_medi(Symbol op, string result, int a1, string a2);

void assign_medi(string n1, string n2);
void assign_medi(string name, int value);

void push_medi(string name);
void push_medi(int name);

void return_get_medi(string name);

void branch_zero_medi(string name, string label);

void branch_equal_medi(string name, int value, string label);

void jump_medi(string label);

void jump_link_medi(string label);

void array_get_medi(string array_name, string offset, string result);
void array_get_medi(string array_name, int offset, string result);

void array_set_medi(string array_name, string offset, string value);
void array_set_medi(string array_name, int offset, string value);
void array_set_medi(string array_name, string offset, int value);
void array_set_medi(string array_name, int offset, int value);

void printf_medi(Type type, string v);
void printf_medi(Type type, int v);
void printf_medi(Type type, string str);

void scanf_medi(string v);

#endif // MEDI_H_INCLUDED
