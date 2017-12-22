# define LINE 0
# define DEBUG 0
# if DEBUG
# define MIPS_LEFT cout << "<==="
# define MIPS_RIGHT "===>"
# else
# define MIPS_LEFT (in_switch ? fswt : fout)
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
# include <sstream>

using namespace std;

int branch;
int level;
// int temp_count = 0;
vector<int> temp_counts;
bool in_switch = false;

void init_temp()
{
    if (temp_counts.size() != 1)
    {
        error_debug("temp_counts error");
    }
}

string int2string(int n)
{
    string int_str;
    while (n != 0)
    {
        int_str = (string)"" + (char)('0' + n % 10) + int_str;
        n /= 10;
    }
    if (int_str == "") int_str = "0";
    return int_str;
}

string new_temp()
{
    int last_index = temp_counts.size() - 1;
    int tempno = temp_counts[last_index];   // get last temp
    stringstream temp_name;
    temp_name << "#" << tempno;
    temp_counts[last_index] ++;
    return temp_name.str();
}

string new_label(FuncItem* func_item, string info)
{
    return func_item->get_name() + "_L_" + int2string(branch ++) + "_" + info;
}

void exit_medi()
{
    MIPS_OUTPUT("@exit");
}

void declare_func_medi(FuncItem* func_item)
{
    MIPS_OUTPUT("@func " << func_item->get_name());
}

void declare_para_medi(Type type, string name)
{
    MIPS_OUTPUT("@para " << type2string(type) << " " << name);
}

void declare_var_medi(VarItem* var_item)
{
    if (var_item->isarray())
    {
        MIPS_OUTPUT("@array " << type2string(var_item->get_type()) << "[] " << var_item->get_name() << " " << var_item->get_len());
    }
    else
    {
        MIPS_OUTPUT("@var " << type2string(var_item->get_type()) << " " << var_item->get_name());
    }
}

void invoke_func_medi(string name)
{
    MIPS_OUTPUT("@call " + name);
}

void return_medi(string v)
{
    MIPS_OUTPUT("@ret " << v);
}
void return_medi(int v)
{
    MIPS_OUTPUT("@ret " << v);
}
void return_medi(FuncItem* func_item)
{
    if (func_item->get_type() == VOID)
    {
        MIPS_OUTPUT("@ret");
    }
    else
    {
        MIPS_OUTPUT("@ret 0");
    }
}

void label_medi(string label)
{
    MIPS_OUTPUT(label << " :");
}

void cal_medi(Symbol op, string result, string a1, string a2)
{
    MIPS_OUTPUT(result << " = " << a1 << " " << symbol2string(op) << " " << a2);
}
void cal_medi(Symbol op, string result, string a1, int a2)
{
    MIPS_OUTPUT(result << " = " << a1 << " " << symbol2string(op) << " " << a2);
}
void cal_medi(Symbol op, string result, int a1, string a2)
{
    MIPS_OUTPUT(result << " = " << a1 << " " << symbol2string(op) << " " << a2);
}

void assign_medi(string n1, string n2)
{
    MIPS_OUTPUT(n1 << " = " << n2);
}
void assign_medi(string name, int value)
{
    MIPS_OUTPUT(name << " = " << value);
}

void push_medi(string name)
{
    MIPS_OUTPUT("@push " << name);
}
void push_medi(int name)
{
    MIPS_OUTPUT("@push " << name);
}

void return_get_medi(string name)
{
    MIPS_OUTPUT("@get " << name);
}

void branch_zero_medi(string name, string label)
{
    MIPS_OUTPUT("@bz " << name << " " << label );
}

void branch_equal_medi(string name, int value, string label)
{
    MIPS_OUTPUT("@be " << name << " " << value << " " << label);
}

void jump_medi(string label)
{
    MIPS_OUTPUT("@j " << label);
}

void jump_link_medi(string label)
{
    MIPS_OUTPUT("@jal " << label);
}

void array_get_medi(string array_name, string offset, string result)
{
    MIPS_OUTPUT(result << " = " << array_name << " ARGET " << offset);
}
void array_get_medi(string array_name, int offset, string result)
{
    MIPS_OUTPUT(result << " = " << array_name << " ARGET " << offset);
}

void array_set_medi(string array_name, string offset, string value)
{
    MIPS_OUTPUT(array_name << " = " << offset << " ARSET " << value);
}
void array_set_medi(string array_name, int offset, string value)
{
    MIPS_OUTPUT(array_name << " = " << offset << " ARSET " << value);
}
void array_set_medi(string array_name, string offset, int value)
{
    MIPS_OUTPUT(array_name << " = " << offset << " ARSET " << value);
}
void array_set_medi(string array_name, int offset, int value)
{
    MIPS_OUTPUT(array_name << " = " << offset << " ARSET " << value);
}

vector<string> str_set;

void printf_medi(Type type, string v)
{
    if (type == STRING)
    {
        int len = str_set.size();
        for (int i = 0; i < len; i ++)
        {
            if (str_set[i] == v)
            {
                MIPS_OUTPUT("@printf " << type2string(type) << " " << "S_" << i);
                return;
            }
        }
        if(LINE)
        {
            str_set.push_back("\\n"+v);
        }
        else
        {
            str_set.push_back(v);
        }

        MIPS_OUTPUT("@printf " << type2string(type) << " S_" << len);

    }
    else
    {
        MIPS_OUTPUT("@printf " << type2string(type) << " " << v);
    }
}
void printf_medi(Type type, int v)
{
    MIPS_OUTPUT("@printf " << type2string(type) << " " << v);
}

void scanf_medi(Type type, string v)
{
    MIPS_OUTPUT("@scanf " << type2string(type) << " " << v);
}

void medi(string line)
{
    MIPS_OUTPUT(line);
}
