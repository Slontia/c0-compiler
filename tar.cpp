#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <stdio.h>
#include <map>
#include "tar.h"
#include "lexical.h"
#include "item.h"

using namespace std;

FILE* medif;
ofstream fout;
ifstream fin;

int reg_count = 8;      // the number of registers
int next_reg = 0;
Reg_recorder reg_recorders[20];  // the information of registers
map<string, int> offset_map;    // variable-offset map
map<string, int> reg_map;       // name-register map
int temp_base_addr = 0;     // address records tamps
FuncItem* cur_func = NULL;  // current function

bool is_temp(string name) {
    return name[0] == '#';
}

int get_temp_no(string name) {
    name.erase(0, 1);
    int i;
    sscanf(name.c_str(),"%d",&i);
    return i;
}

bool get_reg(string name) {
    map<string, int>::iterator it = reg_map.find(name);
    if (it != reg_map.end()) {
        return it->second;
    } else {
        if (is_temp(name)) {
            reg_recorders[next_reg].offset = temp_base_addr + get_temp_no(name) * 4;
        } else {
            map<string, int>::iterator it2 = offset_map.find(name);
            if (it == offset_map.end()) {
                error_debug(name + " not exists");
            }
            reg_recorders[next_reg].offset = it->second;
        }
        reg_recorders[next_reg].use_count = 0;
        string last_name = reg_recorders[next_reg].name;
        if (last_name != "") {
            map<string, int>::iterator last_user = reg_map.find(last_name);
            if (last_user == reg_map.end()) {
                error_debug(last_name + " not in map");
            } else {
                reg_map.erase(last_user);
            }
        }
        reg_recorders[next_reg].name = name;
        reg_map.insert(map<string, int>::value_type(name, next_reg));
        next_reg = (next_reg + 1) % reg_count;
    }
}



void name_handle(vector<string> strs) {
    int len = strs.size();
    if (len <= 1) {
        error_debug("too few strs");
    } else if (strs[1] == ":") {
        // label
    } else if (strs[2] != "=") {
        error_debug("without equal");
    } else {
        ? << get_reg(strs[0]);
        // immediate number? var(temp)?
    }
}

void readline() {
    string line;
    while(getline(fin, line)) {
        istringstream is(line);
        string str;
        vector<string> strs;
        while (is >> str) {
            strs.push_back(str);
        }
        if (strs[0] == "@var") {

        }
        else if (strs[0] == "@func") {

        }
        else if (strs[0] == "@para") {

        }
        else if (strs[0] == "@push") {

        }
        else if (strs[0] == "@call") {

        }
        else if (strs[0] == "@get") {

        }
        else if (strs[0] == "@ret") {

        }
        else if (strs[0] == "@be") {

        }
        else if (strs[0] == "@bz") {

        }
        else if (strs[0] == "@j") {

        }
        else if (strs[0] == "@printf") {

        }
        else if (strs[0] == "@scanf") {

        }
        else {

        }

    }
}




void tar_main() {
    fin.open("intermediate.txt");
    fout.open("target.txt");

//readline();

    fout.close();
    fin.close();
}
