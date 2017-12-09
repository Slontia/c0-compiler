#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <stdio.h>
#include <map>
# define DEBUG 1
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

// function
STRINT_MAP offset_map;    // variable-offset map
FuncItem* cur_func = NULL;  // current function
int temp_base_addr = 0;     // address records tamps
int int_ptr = 0;
int char_ptr = 0;


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

void init_func(string funcname) {
    offset_map.clear();
    cur_func = get_ele(funcname, funcs);
    temp_base_addr = 0;
    int_ptr = 0;
    char_ptr = 0;
}

void init_var(VarItem* var_item) {
    if (var_item->isarray()) {
        if (var_item->get_type() == CHAR) {
            if (int_ptr > char_ptr) {
                char_ptr = int_ptr;
            }
            offset_map.insert(STRINT_MAP::value_type(var_item->get_name(), char_ptr));
            char_ptr += var_item->get_len();
        } else if (var_item->get_type() == INT) {
            if (char_ptr > int_ptr) {
                int_ptr = round_up(char_ptr, 4);
            }
            offset_map.insert(STRINT_MAP::value_type(var_item->get_name(), int_ptr));
            int_ptr += 4 * var_item->get_len();
        } else {
            error_debug("unknown type");
        }
    } else {
        if (var_item->get_type() == CHAR) {
            if (char_ptr % 4 == 0 && int_ptr > char_ptr) {
                char_ptr = int_ptr;
            }
            offset_map.insert(STRINT_MAP::value_type(var_item->get_name(), char_ptr));
            char_ptr += 1;
        } else if (var_item->get_type() == INT) {
            if (char_ptr > int_ptr) {
                int_ptr = round_up(char_ptr, 4);
            }
            offset_map.insert(STRINT_MAP::value_type(var_item->get_name(), int_ptr));
            int_ptr += 4;
        } else {
            error_debug("unknown type");
        }
    }
    temp_base_addr = (int_ptr > char_ptr) ? int_ptr : char_ptr;
}

// name: "#x" or var_name
int get_reg(string name) {
    bool is_tempname = is_temp(name);
    map<string, int>::iterator it;
    Type type = INT;
    // get type
    if (!is_tempname) {
        type = cur_func->get_var(name)->get_type();
    }
    // whether has got reg
    it = reg_map.find(name);
    if (it != reg_map.end()) {
        return it->second;
    } else {
        Reg_recorder* recorder = &reg_recorders[next_reg];
        // store value
        if (recorder->active) {
            MIPS_OUTPUT((recorder->type == CHAR ? "sb" : "sw") << " $s"
                << next_reg << ", " << recorder->offset << "($fp)");
        } else {
            recorder->active = true;
        }
        // record offset
        if (is_tempname) {
            recorder->offset = temp_base_addr + get_temp_no(name) * 4;
        } else {
            map<string, int>::iterator off_it = offset_map.find(name);
            if (off_it == offset_map.end()) {
                error_debug(name + " not exists");
            } else {
                recorder->offset = off_it->second;
            }
        }
        // load value
        MIPS_OUTPUT((type == CHAR ? "lb" : "lw") << " $s" << next_reg
            << ", " << recorder->offset << "($fp)");
        recorder->type = type;
        recorder->use_count = 0;
        // erase old key
        string last_name = recorder->name;
        if (last_name != "") {
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


bool is_num(string str) {
    int len = str.size();
    for (int i = 0; i < len; i ++) {
        if (str.at(i) < '0' || str.at(i) > '9') {
            return false;
        }
    }
    return true;
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
            MIPS_OUTPUT("li $t1, " << immed2);
            mips << ", t1";
        }
    } else {
        mips << ", $s" << get_reg(cal_str2);
    }

    MIPS_OUTPUT(mips.str());
}


void name_handle(vector<string> strs) {
    int len = strs.size();
    if (len <= 1) {
        error_debug("too few strs");
    } else if (strs[1] == ":") {
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

        } else if (op == "ARSET") {

        } else {
            cal_tar(op, strs[0], strs[2], strs[4]);
        }

        // immediate number? var(temp)?
    } else {
        error_debug("too many paras");
    }
}

void readline() {
    string line;
    while(getline(fin, line)) {
        MIPS_OUTPUT(endl <<"   # " << line << endl);
        istringstream is(line);
        string str;
        vector<string> strs;
        while (is >> str) {
            strs.push_back(str);
        }
        if (strs[0] == "@var" || strs[0] == "@para" || strs[0] == "@array") {
            if (cur_func != NULL) { // in function
                init_var(cur_func->get_var(strs[2]));
            }

        } else if (strs[0] == "@func") {
            init_func(strs[1]);

        } else if (strs[0] == "@push") {

        } else if (strs[0] == "@call") {

        } else if (strs[0] == "@get") {

        } else if (strs[0] == "@ret") {

        } else if (strs[0] == "@be") {
            if (!is_num(strs[2])) {
                error_debug("be not num");
            } else {
                MIPS_OUTPUT("beq $s" << get_reg(strs[1]) << ", " << strs[2] << ", " << strs[3]);
            }

        } else if (strs[0] == "@bz") {
            MIPS_OUTPUT("beq $s" << get_reg(strs[1]) << ", $0, " << strs[2]);

        } else if (strs[0] == "@j") {
            MIPS_OUTPUT("j " << strs[1]);

        } else if (strs[0] == "@printf") {

        } else if (strs[0] == "@scanf") {

        } else {
            name_handle(strs);
        }

    }
}




void tar_main() {
    fin.open("intermediate.txt");
    fout.open("target.txt");

    readline();

    fout.close();
    fin.close();
}
