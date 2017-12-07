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

vector<int> branchs;
int level;
int temp_count = 0;

void init() {

}

void next_branch() {

}

string new_temp() {
    string temp_name = "";
    int temp_count_cpy = temp_count;
    while (temp_count_cpy != 0) {
        temp_name = (string)"" + (char)('0' + temp_count_cpy % 10) + temp_name;
        temp_count_cpy /= 10;
    }
    if (temp_name == "") temp_name = "0";
    temp_name = (string)"t" + temp_name;
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

void invoke_func(FuncItem* func_item, vector<string> paras) {
    int len = paras.size();
    for (int i = 0; i < len; i ++) {
        fout << "push "
             << paras[i]
             << endl;
    }
    fout << new_temp()
         << " = "
         << "RET"
         << endl;
}

void func_return(string v) {
    fout << "ret "
         << v
         << endl;
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

void lable(FuncItem* func_item) {
    branchs[branchs.size()-1] ++;
    MIPS_LEFT << "<=====" << func_item->get_name() << "_L";
    vector<int>::iterator it = branchs.begin();
    while(it != branchs.end()) {
        cout << "_" << *it;
        it ++;
    }
    cout << MIPS_RIGHT;

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
