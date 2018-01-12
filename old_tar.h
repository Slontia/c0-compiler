#ifndef TAR_H_INCLUDED
#define TAR_H_INCLUDED
#include <iostream>
#include <map>
#include "vars.h"
#include "main.h"
#include <vector>

using namespace std;

#if !NEW_TAR

typedef struct {
    int offset = -1;
    int use_count = 0;
    string name = "";
    bool active = false;
    Type type;
    bool global = false;
}Reg_recorder;

class FuncItem;

extern const int reg_count;      // the number of registers
extern int next_reg;
extern Reg_recorder reg_recorders[20];  // the information of registers
extern map<string, int> offset_map;    // variable-offset map
extern map<string, int> reg_map;       // name-register map
extern int temp_base_addr;     // address records tamps
extern FuncItem* cur_func;  // current function

bool is_temp(string name);
int get_temp_no(string name);
int get_reg(string name, vector<string>* conf = NULL);
void name_handle(vector<string> strs);
void readline();

void output();

void tar_main(string);

#endif

#endif // TAR_H_INCLUDED
