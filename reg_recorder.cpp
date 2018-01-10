# include <iostream>
# include "tar.h"
# include "vars.h"
# include "lexical.h"
# include "reg_recorder.h"
# include "livevar_ana.h"
# include "item.h"
# define DEBUG 0
# if DEBUG
# define MIPS_LEFT cout
# define MIPS_RIGHT endl
# else
# define MIPS_LEFT fout
# define MIPS_RIGHT endl
# endif // DEBUG
# define MIPS_OUTPUT(x) MIPS_LEFT << x << MIPS_RIGHT
using namespace std;

int use_counter = 0;

Reg_recorder::Reg_recorder(string regname)
{
    this->regname = regname;
    this->state = INACTIVE;
}

void Reg_recorder::clear_and_init()
{
    this->save();
    this->init();
    this->use_count = use_counter++;
}

void Reg_recorder::init()
{
    // erase map
    if (has_name(this->name))
    {
        name_regmap.erase(name_regmap.find(this->name)); // map erase
    }
    // init
    this->name = "";
    this->state = INACTIVE;
}

void Reg_recorder::save()
{
    if (this->state == MODIFIED)
    {
        cout << "SAVE" << this->name << endl;
        // store old value
        if (this->global)
        {
            MIPS_OUTPUT(((this->type == CHAR) ? "sb" : "sw") << " "
                        << this->regname << ", " << this->offset
                        << "($gp) # store " << this->name);
        }
        else
        {
            MIPS_OUTPUT(((this->type == CHAR) ? "sb" : "sw") << " "
                        << this->regname << ", " << this->offset
                        << "($fp) # store " << this->name);
        }
    }
}

void Reg_recorder::load()
{
    if (is_num(this->name))
    {
        MIPS_OUTPUT("li " << this->regname << ", " << this->name);
    }
    else if (offset != -1 && this->global)   // is global variable
    {
        MIPS_OUTPUT(((this->type == CHAR) ? "lb" : "lw") << " "
                    << this->regname << ", " << this->offset
                    << "($gp) # load " << this->name);
    }
    else if (offset != -1)
    {
        MIPS_OUTPUT(((this->type == CHAR) ? "lb" : "lw") << " "
                    << this->regname << ", " << this->offset
                    << "($fp) # load " << this->name);
    }
}

// before call
void Reg_recorder::record_occu_regs(list<string>* save_list)
{
    REG_MAP::iterator it = reg_regmap.begin();
    while (it != reg_regmap.end())
    {
        Reg_recorder* rec = it->second;
        if (rec->state == OCCUPIED)
        {
            save_list->push_back(rec->regname);
        }
        it++;
    }
}

// before call
void Reg_recorder::save_occu_regs(list<string>* save_list, int offset)
{
    list<string>::iterator it = save_list->begin();
    while (it != save_list->end())
    {
        MIPS_OUTPUT("sw " << *it << ", " << offset << "($sp)");
        offset += 4;
        it++;
    }
}

// after call
void Reg_recorder::load_occu_regs(list<string>* save_list, int offset)
{
    list<string>::iterator it = save_list->begin();
    while (it != save_list->end())
    {
        MIPS_OUTPUT("lw " << *it << ", " << offset << "($sp)");
        offset += 4;
        it++;
    }
}

// before call | before branch
void Reg_recorder::save_modi_regs()
{
    REG_MAP::iterator it = reg_regmap.begin();
    while (it != reg_regmap.end())
    {
        Reg_recorder* rec = it->second;
        rec->save(); // only MODIFIED can save
        it++;
    }
}

// meet label
void Reg_recorder::clear_and_init_all()
{
    REG_MAP::iterator it = reg_regmap.begin();
    while (it != reg_regmap.end())
    {
        Reg_recorder* rec = it->second;
        rec->clear_and_init();
        it++;
    }
}

// before branch
void Reg_recorder::init_var_occu_regs()
{
    REG_MAP::iterator it = reg_regmap.begin();
    while (it != reg_regmap.end())
    {
        Reg_recorder* rec = it->second;
        if (rec->state == OCCUPIED && rec->name[1] == 's')
        {
            rec->init();
        }
        it++;
    }
}

// before ret
void Reg_recorder::init_all()
{
    REG_MAP::iterator it = reg_regmap.begin();
    while (it != reg_regmap.end())
    {
        Reg_recorder* rec = it->second;
        rec->init();
        it++;
    }
}

// before ret
void Reg_recorder::save_global_modi_regs()
{
    REG_MAP::iterator it = reg_regmap.begin();
    while (it != reg_regmap.end())
    {
        Reg_recorder* rec = it->second;
        if (rec->global)
        {
            rec->save();
        }
        it++;
    }
}

void Reg_recorder::local_modi_regs(void(Reg_recorder::*func)(), bool not_reverse = true)
{
    REG_MAP::iterator it = reg_regmap.begin();
    while (it != reg_regmap.end())
    {
        Reg_recorder* rec = it->second;
        if (is_local_var(cur_func->get_name(), cur_label, rec->name) ^ (!not_reverse))
        {
            if (!not_reverse) cout << "LOCAL" << rec->name << endl;
            (rec->*func)();
        }
        it++;
    }
}

// a, #0, #8, global_a, local_a, not_occup_a


void Reg_recorder::before_branch_jump()
{
    Reg_recorder::local_modi_regs(&Reg_recorder::save, false);
    Reg_recorder::init_var_occu_regs();
    Reg_recorder::local_modi_regs(&Reg_recorder::init, true);
}

void Reg_recorder::before_call()
{

}

void Reg_recorder::after_call()
{

}

void Reg_recorder::before_label()
{
    Reg_recorder::local_modi_regs(&Reg_recorder::save, false);
    Reg_recorder::init_all();
}

void Reg_recorder::before_return()
{
    Reg_recorder::save_global_modi_regs();
    Reg_recorder::init_all();
}
