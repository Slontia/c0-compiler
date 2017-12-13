// 字符串含空格
// 输入字符

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

using namespace std;

FILE* medif;
ofstream fout;
ifstream fin;

typedef map<string, int> STRINT_MAP;

// global
const int reg_count = 8;      // the number of registers
int next_reg = 0;
Reg_recorder reg_recorders[20];  // the information of registers
STRINT_MAP reg_map;       // name-register map
STRINT_MAP global_addr_map;

// function
STRINT_MAP offset_map;    // variable-offset map
FuncItem* cur_func = NULL;  // current function
int temp_base_addr = 0;     // address records tamps
int int_ptr = 0;
int char_ptr = 0;
int cur_addr = 0;
int para_read_count = 0;

vector<string> paras;


template <typename T>
T get_ele(string name, map<string, T> from_map) {
    typename map<string, T>::iterator it = from_map.find(name);
    if (it != from_map.end()) {
        return it->second;
    }
    return NULL;
}

bool is_temp(string name) {
    return name[0] == '#';
}

int get_temp_no(string name) {
    name.erase(0, 1);
    int i;
    sscanf(name.c_str(),"%d",&i);
    return i;
}

bool is_num(string str) {
    int len = str.size();
    int i;
    if (str.at(0) == '-') {
        i = 1;
    } else {
        i = 0;
    }
    for (; i < len; i ++) {
        if (str.at(i) < '0' || str.at(i) > '9') {
            return false;
        }
    }
    return true;
}

void init_reg_map() {
    reg_map.clear();
    for (int i = 0; i < reg_count; i++) {
        Reg_recorder* recorder = &reg_recorders[i];
        if (recorder->active) {
            if (recorder->type == INT) {
                if (recorder->global) {
                    MIPS_OUTPUT("sw $s" << i << ", " << recorder->offset << "($gp)");
                } else {
                    MIPS_OUTPUT("sw $s" << i << ", " << recorder->offset << "($fp)");
                }

            } else {    // CHAR
                if (recorder->global) {
                    MIPS_OUTPUT("sb $s" << i << ", " << recorder->offset << "($gp)");
                } else {
                    MIPS_OUTPUT("sb $s" << i << ", " << recorder->offset << "($fp)");
                }

            }
            recorder->active = false;
        }
    }
}

void init_func(string funcname) {
    offset_map.clear();
    cur_func = get_ele(funcname, funcs);
    temp_base_addr = 0;
    int_ptr = 0;
    char_ptr = 0;
    cur_addr = 0;
    para_read_count = 0;
    init_reg_map();
    MIPS_OUTPUT(funcname << "_E:");
}

void init_var(VarItem* var_item) {
    if (var_item->isarray()) {
        if (var_item->get_type() == CHAR) {
            if (int_ptr > char_ptr) {
                char_ptr = int_ptr;
            }
            (cur_func == NULL ? global_addr_map : offset_map).insert(STRINT_MAP::value_type(var_item->get_name(), char_ptr));
            char_ptr += var_item->get_len();
        } else if (var_item->get_type() == INT) {
            if (char_ptr > int_ptr) {
                int_ptr = round_up(char_ptr, 4);
            }
            (cur_func == NULL ? global_addr_map : offset_map).insert(STRINT_MAP::value_type(var_item->get_name(), int_ptr));
            int_ptr += 4 * var_item->get_len();
        } else {
            error_debug("unknown type");
        }
    } else {
        if (var_item->get_type() == CHAR) {
            if (char_ptr % 4 == 0 && int_ptr > char_ptr) {
                char_ptr = int_ptr;
            }
            (cur_func == NULL ? global_addr_map : offset_map).insert(STRINT_MAP::value_type(var_item->get_name(), char_ptr));
            char_ptr += 1;
        } else if (var_item->get_type() == INT) {
            if (char_ptr > int_ptr) {
                int_ptr = round_up(char_ptr, 4);
            }
            (cur_func == NULL ? global_addr_map : offset_map).insert(STRINT_MAP::value_type(var_item->get_name(), int_ptr));
            int_ptr += 4;
        } else {
            error_debug("unknown type");
        }
    }
    temp_base_addr = round_up((int_ptr > char_ptr) ? int_ptr : char_ptr, 4);
    cur_addr = temp_base_addr;
}

void assign_para_tar(string paraname) {
    para_read_count ++;
    int addr = - para_read_count * 4;
    MIPS_OUTPUT("lw $s" << get_reg(paraname) << ", " << addr << "($fp)");
}

// name: "#x" or var_name
int get_reg(string name) {
    bool is_tempname = is_temp(name);
    map<string, int>::iterator it;
    Type type = INT;
    // get type
    if (!is_tempname) {
        if (cur_func->has_var(name)) {
            type = cur_func->get_var(name)->get_type();
        } else {
            type = get_ele(name, global_vars)->get_type();
        }
    }
    // whether has got reg

    it = reg_map.find(name);

    if (it != reg_map.end()) {
        return it->second;
    } else {
        bool keep_active = false;
        Reg_recorder* recorder = &reg_recorders[next_reg];
        // store value
        if (recorder->active) {
            if (recorder->global) {
                MIPS_OUTPUT(((recorder->type == CHAR) ? "sb" : "sw") << " $s"
                    << next_reg << ", " << recorder->offset << "($gp)");
            } else {
                MIPS_OUTPUT(((recorder->type == CHAR) ? "sb" : "sw") << " $s"
                    << next_reg << ", " << recorder->offset << "($fp)");
             }
             keep_active = true;
        } else {
            keep_active = false;
            recorder->active = true;
        }
        // record offset
        if (is_tempname) {
            int offset = temp_base_addr + get_temp_no(name) * 4;
            recorder->offset = offset;
            if (offset + 4 > cur_addr) {
                cur_addr = offset + 4;
            }
            recorder->global = false;
        } else {
            map<string, int>::iterator off_it = offset_map.find(name);
            if (off_it == offset_map.end()) {
                off_it = global_addr_map.find(name);
                if (off_it == global_addr_map.end()) {
                    error_debug(name + " not exists");
                } else {
                    recorder->offset = off_it->second;
                    recorder->global = true;
                }

            } else {
                recorder->offset = off_it->second;
                recorder->global = false;
            }
        }
        // load value
        if (recorder->global) { // is global variable
            MIPS_OUTPUT(((type == CHAR) ? "lb" : "lw") << " $s" << next_reg
                << ", " << recorder->offset << "($gp)");
        } else {
            MIPS_OUTPUT(((type == CHAR) ? "lb" : "lw") << " $s" << next_reg
                << ", " << recorder->offset << "($fp)");
        }

        recorder->type = type;
        recorder->use_count = 0;
        // erase old key
        string last_name = recorder->name;
        if (keep_active) {
            map<string, int>::iterator last_user = reg_map.find(last_name);
            if (last_user == reg_map.end()) {
                error_debug(last_name + " not in map");
            } else {
                reg_map.erase(last_user);
            }
        }
        // insert new key
        recorder->name = name;
        reg_map.insert(map<string, int>::value_type(name, next_reg));
        int return_reg = next_reg;
        next_reg = (next_reg + 1) % reg_count;
        return return_reg;
    }
}


void cal_tar(string op, string tar_str, string cal_str1, string cal_str2) {
    stringstream mips;
    bool is_cal = true;
    int immed1, immed2;
    bool is_immed1 = is_num(cal_str1);
    bool is_immed2 = is_num(cal_str2);
    if (is_immed1) {
        sscanf(cal_str1.c_str(), "%d", &immed1);  // get immediate
    }
    if (is_immed2) {
        sscanf(cal_str2.c_str(), "%d", &immed2);  // get immediate
    }

    if (op == "ADD") {
        mips << (is_immed2 ? "addi" : "add");
        is_cal = true;

    } else if (op == "SUB") {
        mips << (is_immed2 ? "addi" : "sub");
        if (is_immed2) immed2 = -immed2;   // turn negative
        is_cal = true;

    } else if (op == "MUL") {
        mips << "mul";
        is_cal = true;

    } else if (op == "DIV") {
        mips << "div";
        is_cal = true;

    } else if (op == "LE") { // <=
        mips << "sle";
        is_cal = false;

    } else if (op == "GE") {
        mips << "sge";
        is_cal = false;

    } else if (op == "LT") {
        mips << "slt";
        is_cal = false;

    } else if (op == "GT") {
        mips << "sgt";
        is_cal = false;

    } else if (op == "NE") {
        mips << "sne";
        is_cal = false;

    } else if (op == "EQ") {
        mips << "seq";
        is_cal = false;

    } else {
        error_debug((string)"unknown op \'" + op + "\'");
    }

    if (is_num(tar_str)) {
        error_debug("tar is number");
    } else {
        mips << " $s" << get_reg(tar_str);
    }

    if (is_immed1) {
        if (immed1 == 0) {
            mips << ", $0";
        } else if (!is_cal) {
            MIPS_OUTPUT("li $t0, " << immed1);
            mips << ", $t0";
        } else {
            error_debug("cal1 is a number");
        }
    } else {
        mips << ", $s" << get_reg(cal_str1);
    }


    if (is_immed2) {
        if (is_cal) {
            mips << ", " << immed2;
        } else {
            MIPS_OUTPUT("li $t0, " << immed2);
            mips << ", $t0";
        }
    } else {
        mips << ", $s" << get_reg(cal_str2);
    }

    MIPS_OUTPUT(mips.str());
}

VarItem* get_var_item(string name) {
    if (cur_func->has_var(name)) {
        return cur_func->get_var(name);
    } else {
        return get_global_var(name);
    }
}

int get_var_offset(string name) {
    STRINT_MAP::iterator it = offset_map.find(name);
    if (it != offset_map.end()) {
        return it->second;
    }
    cout << name;
    return -1;
}

void array_tar(string arr_str, string off_str, string sou_str, bool is_set) {
    VarItem* item = get_var_item(arr_str);
    Type type;
    if (item == NULL) {
        error_debug("unknown array \'" + arr_str + "\'");
    } else {
        type = item->get_type();
    }
    bool offset_is_immed = is_num(off_str);
    bool value_is_immed = is_num(sou_str);
    // get reg
    string reg;
    if (value_is_immed) {
        reg = "$t0";
        MIPS_OUTPUT("li $t0, " << sou_str);
        if (!is_set) {
            error_debug("array to a value");
        }
    } else {
        stringstream ss;
        ss << "$s" << get_reg(sou_str);
        reg = ss.str();
    }

    // get op
    string op;
    if (type == INT) {
        op = is_set ? "sw" : "lw";
    } else {
        op = is_set ? "sb" : "lb";
    }

    int offset;
    string point_reg;
    STRINT_MAP::iterator it = offset_map.find(arr_str);
    if (it != offset_map.end()) {
        offset = it->second;
        point_reg = "$fp";
    } else {
        it = global_addr_map.find(arr_str);
        if (it != global_addr_map.end()) {
            offset = it->second;
            point_reg = "$gp";
        } else {
            error_debug("cannot found array");
        }
    }

    if (offset_is_immed) {
        int ele_offset;
        sscanf(off_str.c_str(), "%d", &ele_offset);
        if (type == INT) {
            ele_offset *= 4;
        }
        MIPS_OUTPUT(op << " " << reg << ", " << offset + ele_offset << "(" << point_reg << ")");

    } else {
        if (type == INT) {
            MIPS_OUTPUT("sll $t1, $s" << get_reg(off_str) << ", 2");  // offset *= 4
            MIPS_OUTPUT("add $t1, $t1, " << point_reg);
        } else {
            MIPS_OUTPUT("add $t1, $s" << get_reg(off_str) << ", " << point_reg);
        }

        MIPS_OUTPUT("addi $t1, $t1, " << offset);  // add array base
        MIPS_OUTPUT(op << " " << reg << ", ($t1)");
    }
}

void name_handle(vector<string> strs) {
    int len = strs.size();
    if (len <= 1) {
        error_debug("too few strs");
    } else if (strs[1] == ":") {
        init_reg_map();
        MIPS_OUTPUT(strs[0] << ":");    // [MIPS] label
    } else if (strs[1] != "=") {
        error_debug("without equal, " + strs[0]);
    } else if (len == 3) {  // assign
        if (is_num(strs[0])) {
            error_debug("assign to number");
        }
        if (is_num(strs[2])) {
            // [MIPS] li
            MIPS_OUTPUT("li $s" << get_reg(strs[0]) << ", " << strs[2]);
        } else {
            // [MIPS] move
            int i = get_reg(strs[0]);
            MIPS_OUTPUT("move $s" << get_reg(strs[0]) << ", $s" << get_reg(strs[2]));
        }
    } else if (len == 5) {  // cal
        string op = strs[3];
        string tar_str  = strs[0];
        string cal_str1 = strs[2];
        string cal_str2 = strs[4];
        if (op == "ARGET") {
            array_tar(strs[2], strs[4], strs[0], false);
        } else if (op == "ARSET") {
            array_tar(strs[0], strs[2], strs[4], true);
        } else {
            cal_tar(op, strs[0], strs[2], strs[4]);
        }

        // immediate number? var(temp)?
    } else {
        error_debug("too many paras");
    }
}

// 将参数保存至基址，清空paras，保存现场（s、fp、ra），将基址保存至fp中，jal至函数标签，还原现场
void call_tar(string funcname) {
    if (funcname != "main") {
        // store paras
        int len = get_func(funcname)->get_para_count();
        for (int i = 0; i < len; i++) {
            int addr = cur_addr + i * 4;
            string paraname = paras.back();
            paras.pop_back();

            if (is_num(paraname)) {
                MIPS_OUTPUT("li $t0, " << paraname);
                MIPS_OUTPUT("sw $t0, " << addr << "($fp)");
            } else {
                MIPS_OUTPUT("sw $s" << get_reg(paraname) << ", " << addr << "($fp)");
            }
        }
        // save regs
        init_reg_map();

        MIPS_OUTPUT("addi $sp, $sp, -8");
        MIPS_OUTPUT("sw $ra, 0($sp)");
        MIPS_OUTPUT("sw $fp, 4($sp)");
        /*
        for (int i = 0; i < reg_count; i ++) {
            MIPS_OUTPUT("addi $sp, $sp, -4");
            MIPS_OUTPUT("sw $s" << i << ", 0($sp)");
        }*/

        // refresh $fp
        MIPS_OUTPUT("addi $fp, $fp, " << round_up(cur_addr, 4) + len * 4);
        // jump
        MIPS_OUTPUT("jal " << funcname << "_E");
        MIPS_OUTPUT("nop");
        // load regs
        /*
        for (int i = reg_count - 1; i >= 0; i --) {
            MIPS_OUTPUT("lw $s" << i << ", 0($sp)");
            MIPS_OUTPUT("addi $sp, $sp, 4");
        }
        */
        MIPS_OUTPUT("lw $ra, 0($sp)");
        MIPS_OUTPUT("lw $fp, 4($sp)");
        MIPS_OUTPUT("addi $sp, $sp, 8");


    } else {
        // refresh $fp
        MIPS_OUTPUT("addi $fp, $fp, " << round_up(cur_addr, 4));
        MIPS_OUTPUT("add $fp, $fp, $gp");
        // jump
        MIPS_OUTPUT("jal " << funcname << "_E");
        MIPS_OUTPUT("nop");
        MIPS_OUTPUT("li $v0, 10");
        MIPS_OUTPUT("syscall");
    }
}

void readline() {
    string line;
    while(getline(fin, line)) {
        MIPS_OUTPUT("   # " << line);
        istringstream is(line);
        string str;
        vector<string> strs;
        while (is >> str) {
            strs.push_back(str);
        }
        // para: 从基址中按顺序读取数值，存储至参数对应的地址中(fp之前) OK
        if (strs[0] == "@var" || strs[0] == "@array") {
            if (cur_func != NULL) { // in function
                init_var(cur_func->get_var(strs[2]));
            } else {
                init_var(get_global_var(strs[2]));
            }

        } else if (strs[0] == "@para") {
            init_var(cur_func->get_var(strs[2]));
            assign_para_tar(strs[2]);

        } else if (strs[0] == "@func") { // 初始化函数信息，生成标签    OK
            init_func(strs[1]);

        } else if (strs[0] == "@push") { // 将参数保存至vector中（不直接存储是因为还要走表达式）   OK
            paras.push_back(strs[1]);

        } else if (strs[0] == "@call") {
            call_tar(strs[1]);

        } else if (strs[0] == "@get") { // 保存v寄存器的值 OK
            if (is_num(strs[1])) {
                error_debug("num get");
            } else {
                MIPS_OUTPUT("move $s" << get_reg(strs[1]) << ", $v0");
            }

        } else if (strs[0] == "@ret") { // v寄存器赋值，跳转至ra OK
            init_reg_map();
            if (strs.size() == 2) {
                if (is_num(strs[1])) {
                    MIPS_OUTPUT("li $v0, " << strs[1]);
                } else {
                    MIPS_OUTPUT("move $v0, $s" << get_reg(strs[1]));
                }
            }
            MIPS_OUTPUT("jr $ra");
            MIPS_OUTPUT("nop");

        } else if (strs[0] == "@be") {
            init_reg_map();
            if (!is_num(strs[2])) {
                error_debug("be not num");
            } else {
                MIPS_OUTPUT("beq $s" << get_reg(strs[1]) << ", " << strs[2] << ", " << strs[3]);
                MIPS_OUTPUT("nop");
            }

        } else if (strs[0] == "@bz") {
            init_reg_map();
            MIPS_OUTPUT("beq $s" << get_reg(strs[1]) << ", $0, " << strs[2]);
            MIPS_OUTPUT("nop");

        } else if (strs[0] == "@j") {
            init_reg_map();
            MIPS_OUTPUT("j " << strs[1]);
            MIPS_OUTPUT("nop");

        } else if (strs[0] == "@jal") {
            init_reg_map();
            MIPS_OUTPUT("jal " << strs[1]);
            MIPS_OUTPUT("nop");

        } else if (strs[0] == "@printf") {
            bool is_immed = is_num(strs[2]);
            if (strs[1] == "string") {
                MIPS_OUTPUT("li $v0, 4");
                MIPS_OUTPUT("la $a0, " << strs[2]);
                MIPS_OUTPUT("syscall");
            } else if (strs[1] == "int") {
                MIPS_OUTPUT("li $v0, 1");
                if (is_immed) {
                    MIPS_OUTPUT("li $a0, " << strs[2]);
                } else {
                    MIPS_OUTPUT("move $a0, $s" << get_reg(strs[2]));
                }
                MIPS_OUTPUT("syscall");

            } else if (strs[1] == "char") {
                MIPS_OUTPUT("li $v0, 11");
                if (is_immed) {
                    MIPS_OUTPUT("li $a0, " << strs[2]);
                } else {
                    MIPS_OUTPUT("move $a0, $s" << get_reg(strs[2]));
                }
                MIPS_OUTPUT("syscall");
            }

        } else if (strs[0] == "@scanf") {
            if (strs[1] == "int") {
                MIPS_OUTPUT("li $v0, 5");
            } else if (strs[1] == "char") {
                MIPS_OUTPUT("li $v0, 12");
            }
            MIPS_OUTPUT("syscall");
            MIPS_OUTPUT("move $s" << get_reg(strs[2]) << ", $v0");

        } else if (strs[0] == "@exit") {

        } else {
            name_handle(strs);
        }
    }
}


void set_data_str() {
    MIPS_OUTPUT(".data");
    int len = str_set.size();
    for (int i = 0; i < len; i ++) {
        MIPS_OUTPUT("S_" << i << ": .asciiz \"" << str_set[i] << "\"");
    }
    MIPS_OUTPUT(".space 4");
    MIPS_OUTPUT("over_S:");
    MIPS_OUTPUT(".text");
    MIPS_OUTPUT("la $gp, " << "over_S");
    MIPS_OUTPUT("andi $gp, $gp, 0xFFFFFFFC");
}

void tar_main() {
    fin.open("intermediate.txt");
    fout.open("target.asm");

    set_data_str();
    readline();

    fout.close();
    fin.close();
}
