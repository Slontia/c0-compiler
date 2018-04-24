#ifndef REG_RECORDER_H_INCLUDED
#define REG_RECORDER_H_INCLUDED

#include <iostream>
#include <list>
#include "vars.h"
using namespace std;

extern int use_counter;

typedef enum
{
    OCCUPIED, // cannot use anyway (vars with global regs | temps which no less than 8 | in using)
    MODIFIED, // store before use (be modified)
    INACTIVE // use directly (not be modified)
} Reg_state;

class Reg_recorder
{
public:
    string regname;
    string name; // content name, var/temp/num (final)
    bool global; // final
    Type type; // final
    int offset;
    int use_count = 0; // change
    Reg_state state; // change

    Reg_recorder(string regname);
    void clear_and_init();
    void init();
    void save();
    void load();
    static void record_occu_regs(list<string>* save_list);
    static void save_occu_regs(list<string>* save_list, int offset);
    static void load_occu_regs(list<string>* save_list, int offset);
    static void save_modi_regs();
    static void clear_and_init_all();
    static void init_var_occu_regs();
    static void init_all();
    static void save_global_modi_regs();
    static void before_branch_jump();
    static void before_call();
    static void after_call();
    static void before_label();
    static void before_return();
    static void local_modi_regs(void(Reg_recorder::*func)(), bool not_reverse);

};

#endif // REG_RECORDER_H_INCLUDED
