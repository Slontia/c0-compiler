#ifndef MEDI_H_INCLUDED
#define MEDI_H_INCLUDED

#include <iostream>
using namespace std;

extern int branch;
extern int level;
extern int temp_count;

void declare_func(FuncItem* func_item);

void invoke_func(FuncItem* func_item, vector<string> paras);

void func_return(string v);

void declare_var(string type, string name);

void lable();

string new_temp();

void cal(Symbol op, string a1, string a2, string result);
void cal(Symbol op, string a1, int a2, string result);



#endif // MEDI_H_INCLUDED
