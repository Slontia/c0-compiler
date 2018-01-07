#ifndef LIVEVAR_ANA_H_INCLUDED
#define LIVEVAR_ANA_H_INCLUDED

#include <iostream>
#include <set>
using namespace std;

class Code_block;
extern map<string, map<string, Code_block*>*> func_cblock_map;

class Var_node
{
public:
    string name;
    Var_node* redirect_ptr = NULL;
    set<Var_node*> conflicts;
    int conf_count = 0;
    int regno = -1;
    Var_node(string name);
    Var_node* get_terminal_ptr();
    void set_regno(int reg_max);
};

class Code_block
{
public:
    string label;
    set<Code_block*> prevs;
    set<Code_block*> nexts;
    set<string> uses;
    set<string> defs;
    map<string, Var_node*> ins; // same values as outs
    map<string, Var_node*> outs; // can be enlarge, but not modified
    map<string, Var_node*> lives; // ins | outs

    Code_block(string label);
    void print_info();
    bool has_def(string name);
    bool has_use(string name);
    bool has_in(string name);
    bool has_out(string name);
    bool has_live(string name);
    void try_use(string name);
    void try_def(string name);
    bool refresh_out();
    void refresh_in();
};

int get_regno(string funcname, string cblockname, string varname);
string livevar_main(string filename);
string set_temp_label();
void turn_next_block(string label);

#endif // LIVEVAR_ANA_H_INCLUDED
