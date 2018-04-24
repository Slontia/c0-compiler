#ifndef TAR_H_INCLUDED
#define TAR_H_INCLUDED
#include <iostream>
#include <map>
#include <vector>
#include "vars.h"
#include "main.h"

using namespace std;

#if NEW_TAR

class FuncItem;
class Reg_recorder;
typedef map<string, int> STRINT_MAP;
typedef map<string, Reg_recorder*> REG_MAP;
extern REG_MAP reg_regmap;
extern REG_MAP name_regmap;

extern const int reg_count;      // the number of registers
extern int next_reg;
//extern Reg_recorder reg_recorders[20];  // the information of registers
extern map<string, int> offset_map;    // variable-offset map
extern map<string, int> reg_map;       // name-register map
extern int temp_base_addr;     // address records tamps
extern FuncItem* cur_func;  // current function
extern string cur_label;

bool is_num(string str);
bool has_name(string name);
bool is_temp(string name);
int get_temp_no(string name);
string get_reg(string name, bool is_def);
void name_handle(vector<string> strs);
void readline();

void output();

string tar_main(string);

#endif

#endif // TAR_H_INCLUDED
