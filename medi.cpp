# define DEBUG 1
# define LL
# if DEBUG
# define MIPS_LEFT cout << "<===="
# define MIPS_RIGHT "===>"
# else
# define MIPS_LEFT fout
# define MIPS_RIGHT endl
# endif // DEBUG
# define MIPS_OUTPUT(x) MIPS_LEFT << x << MIPS_RIGHT

# include <iostream>
# include "medi.h"
# include "vars.h"
# include "item.h"
# include "lexical.h"
# include <vector>
# include <cstdlib>
# include <fstream>

using namespace std;

int branch;
int level;
int temp_count = 0;

void init() {

}

void next_branch() {

}

string int2string(int n) {
    string int_str;
    while (n != 0) {
        int_str = (string)"" + (char)('0' + n % 10) + int_str;
        n /= 10;
    }
    if (int_str == "") int_str = "0";
    return int_str;
}

string new_temp() {
    string temp_name = int2string(temp_count);
    temp_name = (string)"#" + temp_name;
    temp_count ++;
    return temp_name;
}

void declare_func_medi(FuncItem* func_item) {
    fout << "func "
         << type2string(func_item->get_type())
         << " "
         << func_item->get_name()
         << endl;
    int len = func_item->paras.size();
    for (int i = 0; i < len; i ++) {
        VarItem* var = func_item->paras[i];
        fout << "para "
             << type2string(var->get_type())
             << " "
             << func_item->get_name() + "_" + var->get_name()
             << endl;
    }
    VAR_MAP::iterator it = func_item->vars.begin();
    while (it != func_item->vars.end()) {
        fout << "var "
             << type2string(it->second->get_type())
             << " "
             << func_item->get_name() + "_" + it->first
             << endl;
    }
}

void invoke_func_medi(string name) {
    MIPS_OUTPUT("call " + name);
}

void func_return(string v) {
    MIPS_OUTPUT("return " << v);
}

void func_return(int v) {
    MIPS_OUTPUT("return " << v);
}

void declare_global_var_medi(VAR_MAP vars) {
    VAR_MAP::iterator it = vars.begin();
    while (it != vars.end()) {
        fout << "var "
             << type2string(it->second->get_type())
             << " global_" + it->first
             << endl;
    }
}

string new_label(FuncItem* func_item, string info) {
    return func_item->get_name() + "_L_" + int2string(branch ++) + "_" + info;
}

void label_medi(string label) {
    MIPS_OUTPUT(label << ":");
}

void cal_medi(Symbol op, string result, string a1, string a2) {
    MIPS_OUTPUT(result << " = " << a1 << " " << symbol2string(op) << " " << a2);
}
void cal_medi(Symbol op, string result, string a1, int a2) {
    MIPS_OUTPUT(result << " = " << a1 << " " << symbol2string(op) << " " << a2);
}

void comp_medi(Symbol op, string a1, string a2) {

}


void comp_medi(Symbol op, string a1, int a2);

void assign_medi(string n1, string n2) {
    MIPS_OUTPUT(n1 << " = " << n2);
}

void assign_medi(string name, int value) {
    MIPS_OUTPUT(name << " = " << value);
}

void push_medi(string name) {
    MIPS_OUTPUT("push " << name);
}
void return_get_medi(string name) {
    MIPS_OUTPUT("get " << name);
}

void branch_zero_medi(string name, string label) {
    MIPS_OUTPUT("bz " << name << " " << label );
}

void branch_equal_medi(string name, int value, string label) {
    MIPS_OUTPUT("be " << name << " " << value << " " << label);
}

void jump_medi(string label) {
    MIPS_OUTPUT("j " << label);
}

void array_get_medi(string array_name, string offset, string result) {
    MIPS_OUTPUT(result << " = " << array_name << " ARGET " << offset);
}

void array_get_medi(string array_name, int offset, string result) {
    MIPS_OUTPUT(result << " = " << array_name << " ARGET " << offset);
}


void array_set_medi(string array_name, string offset) {
    MIPS_OUTPUT();
}


void array_set_medi(string array_name, int offset) {
}


