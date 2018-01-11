#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <stdio.h>
#include <map>
# define DEBUG 0
# if DEBUG
# define MIPS_LEFT cout
# define MIPS_RIGHT endl
# else
# define MIPS_LEFT fout
# define MIPS_RIGHT endl
# endif // DEBUG
# define MIPS_OUTPUT(x) MIPS_LEFT << x << MIPS_RIGHT
#include "tar.h"
#include "lexical.h"
#include "item.h"
#include "gram.h"
#include "medi.h"
#include "reg_recorder.h"
#include "livevar_ana.h"
# define OUTPUT_MEDI 1

using namespace std;

FILE* medif;
ofstream fout;
ifstream fin;

// global
const int temp_max = 8;      // the number of registers
REG_MAP reg_regmap;       // reg-recorder map
REG_MAP name_regmap;       // name-recorder map
STRINT_MAP global_addr_map;

// function
STRINT_MAP offset_map;    // variable-offset map
FuncItem* cur_func = NULL;  // current function
int temp_base_addr = 0;     // address records tamps
int int_ptr = 0;
int char_ptr = 0;
int cur_addr = 0;
int para_read_count = 0;

string cur_label = ""; // need not init
vector<string> paras;
set<string> free_temp_set;

/*====================
|       wheels       |
====================*/

template <typename T>
T get_ele(string name, map<string, T> from_map)
{
    typename map<string, T>::iterator it = from_map.find(name);
    if (it != from_map.end())
    {
        return it->second;
    }
    return NULL;
}

bool has_name(string name)
{
    return (name_regmap.find(name) != name_regmap.end());
}

bool is_temp(string name)
{
    return name[0] == '#';
}

int get_temp_no(string name)
{
    name.erase(0, 1);
    int i;
    sscanf(name.c_str(),"%d",&i);
    return i;
}

bool is_num(string str)
{
    int len = str.size();
    int i;
    if (str.at(0) == '-')
    {
        i = 1;
    }
    else
    {
        i = 0;
    }
    for (; i < len; i ++)
    {
        if (str.at(i) < '0' || str.at(i) > '9')
        {
            return false;
        }
    }
    return true;
}

/*====================
|      initials      |
====================*/

void init_global_regs()
{
    map<string, Var_node*>* vn_map = &((*(func_cblock_map[cur_func->get_name()]))[cur_label]->lives);
    map<string, Var_node*>::iterator it = vn_map->begin();
    while (it != vn_map->end())
    {
        if (it->second->regno != -1)
        {
            get_reg(it->first, false);
        }
        it++;
    }
}

void init_reg_map()
{
    for (int i = 0; i < 8; i++)
    {
        stringstream ss;
        ss << "$s" << i;
        string regname = ss.str();
        reg_regmap.insert(REG_MAP::value_type(regname, new Reg_recorder(regname)));
    }
    for (int i = 0; i < 10; i++)
    {
        stringstream ss;
        ss << "$t" << i;
        string regname = ss.str();
        reg_regmap.insert(REG_MAP::value_type(regname, new Reg_recorder(regname)));
    }
}

// @func
void init_func(string funcname)
{
    offset_map.clear();
    cur_func = get_ele(funcname, funcs);
    temp_base_addr = 0;
    int_ptr = 0;
    char_ptr = 0;
    cur_addr = 0;
    para_read_count = 0;
    if (name_regmap.size() > 0)
    {
        error_debug("name_regmap not clear");
    }
    MIPS_OUTPUT(funcname << "_E:");
}

// @para | @var
void init_var(VarItem* var_item)
{
    if (var_item->isarray())
    {
        if (var_item->get_type() == CHAR)
        {
            if (int_ptr > char_ptr)
            {
                char_ptr = int_ptr;
            }
            (cur_func == NULL ? global_addr_map : offset_map).insert(STRINT_MAP::value_type(var_item->get_name(), char_ptr));
            char_ptr += var_item->get_len();
        }
        else if (var_item->get_type() == INT)
        {
            if (char_ptr > int_ptr)
            {
                int_ptr = round_up(char_ptr, 4);
            }
            (cur_func == NULL ? global_addr_map : offset_map).insert(STRINT_MAP::value_type(var_item->get_name(), int_ptr));
            int_ptr += 4 * var_item->get_len();
        }
        else
        {
            error_debug("unknown type");
        }
    }
    else
    {
        if (var_item->get_type() == CHAR)
        {
            if (char_ptr % 4 == 0 && int_ptr > char_ptr)
            {
                char_ptr = int_ptr;
            }
            (cur_func == NULL ? global_addr_map : offset_map).insert(STRINT_MAP::value_type(var_item->get_name(), char_ptr));
            char_ptr += 1;
        }
        else if (var_item->get_type() == INT)
        {
            if (char_ptr > int_ptr)
            {
                int_ptr = round_up(char_ptr, 4);
            }
            (cur_func == NULL ? global_addr_map : offset_map).insert(STRINT_MAP::value_type(var_item->get_name(), int_ptr));
            int_ptr += 4;
        }
        else
        {
            error_debug("unknown type");
        }
    }
    temp_base_addr = round_up((int_ptr > char_ptr) ? int_ptr : char_ptr, 4);
    cur_addr = temp_base_addr;
}

/*====================
|      function      |
====================*/

void assign_para_tar(string paraname)
{
    para_read_count ++;
    int addr = - para_read_count * 4;
    MIPS_OUTPUT("lw " << get_reg(paraname, true) << ", " << addr << "($fp)");
}

bool is_global_var(string name)
{
    return (!cur_func->has_var(name) && global_vars.find(name) != global_vars.end());
}

Reg_recorder* get_min_use_recorder()
{
    int min_use_count = -1;
    Reg_recorder* rec_selected = NULL;
    REG_MAP::iterator it = reg_regmap.begin();
    while (it != reg_regmap.end())
    {
        Reg_recorder* rec = it->second;
        // cout << rec->regname << " " << rec->use_count << (rec->state == OCCUPIED ? " OCC" : "" + rec->name) << endl;
        if (rec->state != OCCUPIED &&
            (min_use_count == -1 || rec->use_count < min_use_count))
        {
            min_use_count = rec->use_count;
            rec_selected = rec;
        }
        it++;
    }
    // cout << "SEL" << rec_selected->regname << endl;
    return rec_selected;
}

template <class T>
bool set_has_ele(const set<T> &s, const T ele)
{
    return (s.find(ele) != s.end());
}

string get_reg(string name, bool is_def)
{
    if (name == "0")
    {
        return "$0";
    }
    Reg_recorder* rec = NULL;
    // has register
    if (has_name(name))
    {
        // cout << "HAS:" << name << endl;
        rec = name_regmap[name];
        rec->use_count = use_counter++;
        if (rec->state == INACTIVE && is_def) // value may be modified
        {
            rec->state = MODIFIED;
        }
        if (set_has_ele(free_temp_set, name)) // @free
        {
            rec->state = INACTIVE;
        }
        return rec->regname;
    }
    // occupy $t
    int regno = -1;
    if (is_temp(name) &&
        (regno = get_temp_no(name)) < temp_max)
    {
        stringstream ss;
        ss << "$t" << regno;
        // cout << "========" << ss.str() << "========\n";
        rec = reg_regmap[ss.str()];
        rec->clear_and_init();
        rec->name = name; // "#?"
        rec->type = INT; // temp
        rec->global = false;
        rec->offset = -1;
        rec->state = OCCUPIED;
    }
    // occupy $s
    else if ((regno = get_regno(cur_func->get_name(), cur_label, name))
         != -1)
    {
        stringstream ss;
        ss << "$s" << regno;
        rec = reg_regmap[ss.str()];
        rec->clear_and_init();
        rec->name = name;
        rec->type = cur_func->get_var(name)->get_type();
        rec->global = false;
        rec->offset = offset_map[name];
        rec->state = OCCUPIED;
    }
    // select one not be occupied
    else
    {
        rec = get_min_use_recorder();
        if (rec == NULL)
        {
            error_debug("cannot find recorder~");
        }
        rec->clear_and_init();
        rec->name = name;
        rec->state = is_def ? MODIFIED : INACTIVE;
        if (is_temp(name)) // temp
        {
            rec->type = INT;
            rec->global = false;
            rec->offset = temp_base_addr + (get_temp_no(name) - temp_max) * 4;
        }
        else if (cur_func->has_var(name)) // local var
        {
            rec->type = cur_func->get_var(name)->get_type();
            rec->global = false;
            rec->offset = offset_map[name];
        }
        else if (is_global_var(name)) // global var
        {
            rec->type = get_global_var(name)->get_type();
            rec->global = true;
            rec->offset = global_addr_map[name];
        }
        else if (is_num(name)) // const
        {
            rec->type = INT;
            rec->global = false;
            rec->offset = -1;
        }
        else
        {
            error_debug("unknown value type in tar");
        }
    }
    if (!is_def && rec->state != OCCUPIED)
    {
        rec->load();
    }
    name_regmap.insert(REG_MAP::value_type(name, rec));
    return rec->regname;
}

bool is_power(int number)
{
    return (number & number - 1) == 0;
}

int log2(int number)
{
    int result = 0;
    while (number > 1)
    {
        number >>= 1;
        result++;
    }
    return result;
}

void output_shift_mul_div(string op, string tar, string str_cal, int num_cal)
{
    bool nega = num_cal < 0;
    int pos_num_cal = nega ? -num_cal : num_cal;
    string usereg = get_reg(str_cal, false);
    string defreg = get_reg(tar, true);
    if (op == "DIV")
    {
        MIPS_OUTPUT("sra " << defreg << ", " << usereg << ", " << log2(pos_num_cal));
    }
    else if (op == "MUL")
    {
        MIPS_OUTPUT("sll " << defreg << ", " << usereg << ", " << log2(pos_num_cal));
    }
    if (nega)
    {
        MIPS_OUTPUT("sub " << defreg << ", $0, " << defreg);
    }
}

void cal_tar(string op, string tar_str, string cal_str1, string cal_str2)
{
    stringstream mips;
    bool is_cal = true;
    int immed1, immed2;
    bool is_immed1 = is_num(cal_str1);
    bool is_immed2 = is_num(cal_str2);
    if (is_immed1)
    {
        sscanf(cal_str1.c_str(), "%d", &immed1);  // get immediate
    }
    if (is_immed2)
    {
        sscanf(cal_str2.c_str(), "%d", &immed2);  // get immediate
    }
    if (op == "ADD")
    {
        mips << (is_immed2 ? "addi" : "add");
        is_cal = true;
    }
    else if (op == "SUB")
    {
        mips << (is_immed2 ? "addi" : "sub");
        if (is_immed2) immed2 = -immed2;   // turn negative
        is_cal = true;
    }
    else if (op == "MUL")
    {
        if (is_immed1 && is_power(immed1))
        {
            output_shift_mul_div(op, tar_str, cal_str2, immed1);
            return;
        }
        if (is_immed2 && is_power(immed2))
        {
            output_shift_mul_div(op, tar_str, cal_str1, immed2);
            return;
        }
        mips << "mul";
        is_cal = true;
    }
    else if (op == "DIV")
    {
        if (is_immed2 && is_power(immed2))
        {
            output_shift_mul_div(op, tar_str, cal_str1, immed2);
            return;
        }
        mips << "div";
        is_cal = true;
    }
    else if (op == "LE")     // <=
    {
        mips << "sle";
        is_cal = false;
    }
    else if (op == "GE")    // >=
    {
        mips << "sge";
        is_cal = false;
    }
    else if (op == "LT")
    {
        mips << "slt";
        is_cal = false;
    }
    else if (op == "GT")
    {
        mips << "sgt";
        is_cal = false;
    }
    else if (op == "NE")
    {
        mips << "sne";
        is_cal = false;
    }
    else if (op == "EQ")
    {
        mips << "seq";
        is_cal = false;
    }
    else
    {
        error_debug((string)"unknown op \'" + op + "\'");
    }
    string name1 = get_reg(cal_str1, false);
    string name2 = "";
    if (is_immed2 && is_cal)
    {
        stringstream ss;
        ss << immed2;
        name2 = ss.str();
    }
    else
    {
        name2 = get_reg(cal_str2, false);
    }
    if (is_num(tar_str))
    {
        error_debug("tar is number");
    }
    else
    {
        mips << " " << get_reg(tar_str, true) << ", " << name1 << ", " << name2;
    }
    MIPS_OUTPUT(mips.str());
}

VarItem* get_var_item(string name)
{
    if (cur_func->has_var(name))
    {
        return cur_func->get_var(name);
    }
    else
    {
        return get_global_var(name);
    }
}

int get_var_offset(string name)
{
    STRINT_MAP::iterator it = offset_map.find(name);
    if (it != offset_map.end())
    {
        return it->second;
    }
    return -1;
}

void array_tar(string arr_str, string off_str, string sou_str, bool is_set)
{
    VarItem* item = get_var_item(arr_str);
    Type type;
    if (item == NULL)
    {
        error_debug("unknown array \'" + arr_str + "\'");
    }
    else
    {
        type = item->get_type();
    }
    bool offset_is_immed = is_num(off_str);
    bool value_is_immed = is_num(sou_str);
    // get reg
    string reg;
    reg = get_reg(sou_str, !is_set);
    if (value_is_immed && !is_set)
    {
        error_debug("array to a value");
    }
    // get op
    string op;
    if (type == INT)
    {
        op = is_set ? "sw" : "lw";
    }
    else
    {
        op = is_set ? "sb" : "lb";
    }

    int offset;
    string point_reg;
    STRINT_MAP::iterator it = offset_map.find(arr_str);
    if (it != offset_map.end())
    {
        offset = it->second;
        point_reg = "$fp";
    }
    else
    {
        it = global_addr_map.find(arr_str);
        if (it != global_addr_map.end())
        {
            offset = it->second;
            point_reg = "$gp";
        }
        else
        {
            error_debug("cannot found array");
        }
    }

    if (offset_is_immed)
    {
        int ele_offset;
        sscanf(off_str.c_str(), "%d", &ele_offset);
        if (type == INT)
        {
            ele_offset *= 4;
        }
        MIPS_OUTPUT(op << " " << reg << ", " << offset + ele_offset << "(" << point_reg << ")");
    }
    else
    {
        if (type == INT)
        {
            MIPS_OUTPUT("sll $v0, " << get_reg(off_str, false) << ", 2");  // offset *= 4
            MIPS_OUTPUT("add $v0, $v0, " << point_reg);
        }
        else
        {
            MIPS_OUTPUT("add $v0, " << get_reg(off_str, false) << ", " << point_reg);
        }

        MIPS_OUTPUT("addi $v0, $v0, " << offset);  // add array base
        MIPS_OUTPUT(op << " " << reg << ", ($v0)");
    }
}

void name_handle(vector<string> strs)
{
    int len = strs.size();
    if (len <= 1)
    {
        error_debug("too few strs");
    }
    else if (strs[1] == ":")
    {
        cur_label = strs[0];
        Reg_recorder::before_label();
        init_global_regs();
        MIPS_OUTPUT(strs[0] << ":");    // [MIPS] label
    }
    else if (strs[1] != "=")
    {
        error_debug("without equal, " + strs[0]);
    }
    else if (len == 3)      // assign
    {
        if (is_num(strs[0]))
        {
            error_debug("assign to number");
        }
        if (is_num(strs[2]))
        {
            // [MIPS] li
            MIPS_OUTPUT("li " << get_reg(strs[0], true) << ", " << strs[2]);
        }
        else
        {
            // [MIPS] move
            MIPS_OUTPUT("move " << get_reg(strs[0], true) << ", " << get_reg(strs[2], false));
        }
    }
    else if (len == 5)      // cal
    {
        string op = strs[3];
        string tar_str  = strs[0];
        string cal_str1 = strs[2];
        string cal_str2 = strs[4];
        if (op == "ARGET")
        {
            array_tar(strs[2], strs[4], strs[0], false);
        }
        else if (op == "ARSET")
        {
            array_tar(strs[0], strs[2], strs[4], true);
        }
        else
        {
            cal_tar(op, strs[0], strs[2], strs[4]);
        }

        // immediate number? var(temp)?
    }
    else
    {
        error_debug("too many paras");
    }
}

// 将参数保存至基址，清空paras，保存现场（s、fp、ra），将基址保存至fp中，jal至函数标签，还原现场
void call_tar(string funcname)
{
    if (funcname != "main")
    {
        // store paras
        int len = get_func(funcname)->get_para_count();
        for (int i = 0; i < len; i++)
        {
            int addr = cur_addr + i * 4;
            string paraname = paras.back();
            paras.pop_back();
            MIPS_OUTPUT("sw " << get_reg(paraname, false) << ", " << addr << "($fp)");
        }
        // save regs
        list<string> reg_save_list;
        Reg_recorder::record_occu_regs(&reg_save_list);
        int store_count = 1;
        int stack_offset = (reg_save_list.size() + store_count) * 4;
        MIPS_OUTPUT("addi $sp, $sp, -" << stack_offset);
        MIPS_OUTPUT("sw $ra, 0($sp)");
        Reg_recorder::save_occu_regs(&reg_save_list, store_count * 4);
        Reg_recorder::init_all();

        // refresh $fp
        int fp_offset = round_up(cur_addr, 4) + len * 4;
        MIPS_OUTPUT("addi $fp, $fp, " << fp_offset);
        // jump
        MIPS_OUTPUT("jal " << funcname << "_E");
        //MIPS_OUTPUT("nop");
        // load regs

        MIPS_OUTPUT("addi $fp, $fp, -" << fp_offset);
        MIPS_OUTPUT("lw $ra, 0($sp)");
        Reg_recorder::load_occu_regs(&reg_save_list, store_count * 4);
        MIPS_OUTPUT("addi $sp, $sp, " << stack_offset);
    }
    else
    {
        // refresh $fp
        MIPS_OUTPUT("addi $fp, $fp, " << round_up(cur_addr, 4));
        MIPS_OUTPUT("add $fp, $fp, $gp");
        // jump
        MIPS_OUTPUT("jal " << funcname << "_E");
        //MIPS_OUTPUT("nop");
        MIPS_OUTPUT("li $v0, 10");
        MIPS_OUTPUT("syscall");
    }
}

void readline()
{
    string line;
    while(getline(fin, line))
    {
        if (OUTPUT_MEDI) MIPS_OUTPUT("   # " << line);
        istringstream is(line);
        string str;
        vector<string> strs;
        while (is >> str)
        {
            strs.push_back(str);
        }
        // para: 从基址中按顺序读取数值，存储至参数对应的地址中(fp之前) OK
        if (strs[0] == "@var" || strs[0] == "@array")
        {
            if (cur_func != NULL)   // in function
            {
                init_var(cur_func->get_var(strs[2]));
            }
            else
            {
                init_var(get_global_var(strs[2]));
            }
        }
        else if (strs[0] == "@para")
        {
            init_var(cur_func->get_var(strs[2]));
            assign_para_tar(strs[2]);
        }
        else if (strs[0] == "@func")     // 初始化函数信息，生成标签    OK
        {
            init_func(strs[1]);
        }
        else if (strs[0] == "@label")
        {
            cur_label = strs[1];
            init_global_regs();
        }
        else if (strs[0] == "@push")     // 将参数保存至vector中（不直接存储是因为还要走表达式）   OK
        {
            paras.push_back(strs[1]);
        }
        else if (strs[0] == "@call")
        {
            call_tar(strs[1]);
        }
        else if (strs[0] == "@get")     // 保存v寄存器的值 OK
        {
            if (is_num(strs[1]))
            {
                error_debug("num get");
            }
            else
            {
                MIPS_OUTPUT("move " << get_reg(strs[1], true) << ", $v0");
            }
        }
        else if (strs[0] == "@ret")     // v寄存器赋值，跳转至ra OK
        {
            if (strs.size() == 2)
            {
                if (is_num(strs[1]))
                {
                    MIPS_OUTPUT("li $v0, " << strs[1]);
                }
                else
                {
                    MIPS_OUTPUT("move $v0, " << get_reg(strs[1], false));
                }
            }
            Reg_recorder::before_return();
            MIPS_OUTPUT("jr $ra");
            //MIPS_OUTPUT("nop");
        }
        else if (strs[0] == "@be" || strs[0] == "@bne")
        {
            string br_op = "";
            string name1 = "";
            string name2 = "";
            if (strs[0] == "@be") br_op = "beq";
            else if (strs[0] == "@bne") br_op = "bne";
            if (!is_num(strs[2]))
            {
                name1 = get_reg(strs[1], false);
                name2 = get_reg(strs[2], false);
            }
            else if (strs[2] == "0")
            {
                name1 = get_reg(strs[1], false);
                name2 = "$0";
            }
            else
            {
                name1 = get_reg(strs[1], false);
                name2 = strs[2];
            }
            Reg_recorder::before_branch_jump();
            MIPS_OUTPUT(br_op << " " << name1 << ", " << name2 << ", " << strs[3]);
        }
        else if (strs[0] == "@bz")
        {
            Reg_recorder::before_branch_jump();
            MIPS_OUTPUT("beq " << get_reg(strs[1], false) << ", $0, " << strs[2]);
            //MIPS_OUTPUT("nop");
        }
        else if (strs[0] == "@bgtz" || strs[0] == "@bgez" ||
                 strs[0] == "@blez" || strs[0] == "@bltz")
        {
            Reg_recorder::before_branch_jump();
            MIPS_OUTPUT(strs[0].substr(1) << " " << get_reg(strs[1], false) << ", " << strs[2]);
        }
        else if (strs[0] == "@j")
        {
            Reg_recorder::before_branch_jump();
            MIPS_OUTPUT("j " << strs[1]);
            //MIPS_OUTPUT("nop");
        }
        else if (strs[0] == "@jal")
        {
            MIPS_OUTPUT("jal " << strs[1]);
            //MIPS_OUTPUT("nop");
        }
        else if (strs[0] == "@printf")
        {
            bool is_immed = is_num(strs[2]);
            if (strs[1] == "string")
            {
                MIPS_OUTPUT("li $v0, 4");
                MIPS_OUTPUT("la $a0, " << strs[2]);
                MIPS_OUTPUT("syscall");
            }
            else if (strs[1] == "int")
            {
                MIPS_OUTPUT("li $v0, 1");
                if (is_immed)
                {
                    MIPS_OUTPUT("li $a0, " << strs[2]);
                }
                else
                {
                    MIPS_OUTPUT("move $a0, " << get_reg(strs[2], false));
                }
                MIPS_OUTPUT("syscall");
            }
            else if (strs[1] == "char")
            {
                MIPS_OUTPUT("li $v0, 11");
                if (is_immed)
                {
                    MIPS_OUTPUT("li $a0, " << strs[2]);
                }
                else
                {
                    MIPS_OUTPUT("move $a0, " << get_reg(strs[2], false));
                }
                MIPS_OUTPUT("syscall");
            }
        }
        else if (strs[0] == "@scanf")
        {
            if (strs[1] == "int")
            {
                MIPS_OUTPUT("li $v0, 5");
            }
            else if (strs[1] == "char")
            {
                MIPS_OUTPUT("li $v0, 12");
            }
            MIPS_OUTPUT("syscall");
            MIPS_OUTPUT("move " << get_reg(strs[2], true) << ", $v0");
        }
        else if (strs[0] == "@exit")
        {

        }
        else if (strs[0] == "@free")
        {
            free_temp_set.insert(strs[1]);
        }
        else
        {
            name_handle(strs);
        }
    }
}

void set_data_str()
{
    MIPS_OUTPUT(".data");
    int len = str_set.size();
    for (int i = 0; i < len; i ++)
    {
        MIPS_OUTPUT("S_" << i << ": .asciiz \"" << str_set[i] << "\"");
    }
    MIPS_OUTPUT(".space 4");
    MIPS_OUTPUT("over_S:");
    MIPS_OUTPUT(".text");
    MIPS_OUTPUT("la $gp, " << "over_S");
    MIPS_OUTPUT("andi $gp, $gp, 0xFFFFFFFC");
}

string tar_main(string filename)
{
    fin.open(filename.c_str());
    string tar_filename = get_tarname();
    fout.open(tar_filename.c_str());

    init_reg_map();
    set_data_str();
    readline();

    fout.close();
    fin.close();
    return tar_filename;
}
