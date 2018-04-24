#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <sstream>
#include <list>
#include "vars.h"
#include "tar.h"
#include "gram.h"
#include "item.h"
#include "lexical.h"
#include "livevar_ana.h"
# define REG_MAX 8
# define DEBUG 0
# if DEBUG
# define MIPS_LEFT cout << "<==="
# define MIPS_RIGHT "===>" << endl
# else
# define MIPS_LEFT fout
# define MIPS_RIGHT endl
# endif // DEBUG
# define MIPS_OUTPUT(x) MIPS_LEFT << x << MIPS_RIGHT
# define IS_VAR(name) (name[0] == '_' || (name[0] >= 'a' && name[0] <= 'z'))

using namespace std;

ofstream flog;
typedef map<string, Code_block*> CBLOCK_MAP;
typedef map<string, CBLOCK_MAP*> FUNC_CBLOCK_MAP;
typedef map<string, Var_node*> VARNODE_MAP;
FUNC_CBLOCK_MAP func_cblock_map;

list<Code_block*> cblock_list;
CBLOCK_MAP* cblock_map_ptr;
Code_block* cur_cblock;
string cur_funcname = "";
int temp_label_count = 0;
bool first_term = true;
set<Var_node*> var_graph;
list<Var_node*> var_stack;

/*====================
|        extern      |
====================*/

// @REQUIRES: funcname & blockname must be right
int get_regno(string funcname, string cblockname, string varname)
{
    Code_block* cblk = (*(func_cblock_map[funcname]))[cblockname];
    if (cblk->has_live(varname))
    {
        return cblk->lives[varname]->regno;
    }
    else
    {
        return -1; // not in lives
    }
}

bool is_local_var(string funcname, string cblockname, string varname)
{
    Code_block* cblk = (*(func_cblock_map[funcname]))[cblockname];
    //if (varname == "a") cout << "OH!" << cblk->has_live(varname) <<cblk->has_def(varname);
    return (cblk->has_def(varname) && !cblk->has_live(varname));
}


/*====================
|     Code_block     |
====================*/

void Code_block::print_info()
{
    flog << "label:" << this->label << endl;

    set<string>::iterator it;

    it = this->uses.begin();
    flog << "uses:" << endl;
    while (it != this->uses.end())
    {
        flog << *it << " ";
        it++;
    }

    flog <<endl;

    it = this->defs.begin();
    flog << "defs:" << endl;
    while (it != this->defs.end())
    {
        flog << *it << " ";
        it++;
    }
    flog <<endl;

    VARNODE_MAP::iterator map_it;

    map_it = this->lives.begin();
    flog << "lives:" << endl;
    while (map_it != this->lives.end())
    {
        flog << map_it->first << " ";
        map_it++;
    }
    flog <<endl;

    map_it = this->ins.begin();
    flog << "in:" << endl;
    while (map_it != this->ins.end())
    {
        flog << map_it->first << " ";
        map_it++;
    }
    flog <<endl;

    map_it = this->outs.begin();
    flog << "out:" << endl;
    while (map_it != this->outs.end())
    {
        flog << map_it->first << " ";
        map_it++;
    }
    flog <<endl;

    flog <<endl;
}

Code_block::Code_block(string label)
{
    this->label = label;
}

bool Code_block::has_def(string name)
{
    return (this->defs.find(name) != this->defs.end());
}

bool Code_block::has_use(string name)
{
    return (this->uses.find(name) != this->uses.end());
}

bool Code_block::has_in(string name)
{
    return (this->ins.find(name) != this->ins.end());
}

bool Code_block::has_out(string name)
{
    return (this->outs.find(name) != this->outs.end());
}

bool Code_block::has_live(string name)
{
    return (this->lives.find(name) != this->lives.end());
}

void Code_block::try_use(string name)
{
    if (is_local_var(cur_funcname, name) && !has_def(name))
    {
        this->uses.insert(name);
    }
}

void Code_block::try_def(string name)
{
    if (is_local_var(cur_funcname, name) && !has_use(name))
    {
        this->defs.insert(name);
    }
}

/* It combines all variables in the 'ins' of all cblocks
 * in the 'nexts'.
 * if changed, return true
 */
bool Code_block::refresh_out()
{
    bool changed = false;
    set<Code_block*>::iterator cblock_it = this->nexts.begin();
    while (cblock_it != this->nexts.end()) // nexts
    {
        Code_block* next_cblock = *cblock_it;
        VARNODE_MAP::iterator var_it = next_cblock->ins.begin();
        while (var_it != next_cblock->ins.end()) // ins of a next
        {
            string name = var_it->first;
            if (!this->has_out(name)) // not in outs
            {
                this->outs.insert(VARNODE_MAP::value_type
                                  (var_it->first, var_it->second));
                changed = true;
            }
            // should not redirect pointer
            // instead, redirect in nodes
            else
            {
                Var_node* in_node_ptr = var_it->second->get_terminal_ptr();
                Var_node* out_node_ptr = this->outs[name]->get_terminal_ptr();
                if (in_node_ptr != out_node_ptr) // different node
                {
                    in_node_ptr->redirect_ptr = out_node_ptr;
                    changed = true; // necessary?
                }
            }
            var_it++;
        }
        cblock_it++;
    }
    return changed;
}

// same value as outs
void Code_block::refresh_in()
{
    // in outs but not in defs
    VARNODE_MAP::iterator out_it = this->outs.begin();
    while (out_it != this->outs.end())
    {
        string name = out_it->first;
        if (!has_in(name) && !has_def(name))
        {
            this->ins.insert(VARNODE_MAP::value_type
                            (out_it->first, out_it->second));
        }
        out_it++;
    }
    if (!first_term)
    {
        return;
    }
    // in uses
    set<string>::iterator use_it = this->uses.begin();
    while (use_it != this->uses.end())
    {
        string name = *use_it;
        if (!has_in(name))
        {
            Var_node* vn = new Var_node(name);
            this->ins.insert(VARNODE_MAP::value_type(name, vn));
        }
        use_it++;
    }
}

/*====================
|     var_node       |
====================*/

Var_node::Var_node(string name)
{
    // cout << "name:" << name << endl;
    this->name = name;
}

Var_node* Var_node::get_terminal_ptr()
{
    Var_node* vn = this;
    while (vn->redirect_ptr != NULL)
    {
        //cout << vn->name << endl;
        vn = vn->redirect_ptr;
    }
    if (vn != this)
    {
        this->redirect_ptr = vn; // refresh
    }
    return vn;
}

void Var_node::set_regno(int reg_max)
{
    // initial
    vector<bool> reg_occupied;
    for (int i = 0; i < reg_max; i++)
    {
        reg_occupied.push_back(false);
    }
    // record
    set<Var_node*>::iterator it = this->conflicts.begin();
    while (it != this->conflicts.end()) // conflict vnodes
    {
        Var_node* vnode = *it;
        if (vnode->regno != -1)
        {
            reg_occupied[vnode->regno] = true;
        }
        it++;
    }
    // select
    for (int i = 0; i < reg_max; i++)
    {
        if (reg_occupied[i] == false)
        {
            this->regno = i;
            return;
        }
    }
    error_debug("cannot distribute!");
}

void Var_node::cut_conflicts()
{
    set<Var_node*>::iterator it = this->conflicts.begin();
    while (it != this->conflicts.end()) // conflicts
    {
        Var_node* conf_vnode = *it;
        conf_vnode->conf_count--; // reduce
        it++;
    }
}

/*====================
|     in / out       |
====================*/

void finish_function_in_out()
{
    bool changed = true;
    while (changed) // term
    {
        changed = false;
        list<Code_block*>::iterator it = cblock_list.begin();
        while (it != cblock_list.end()) // code_blocks
        {
            Code_block* cblock = *it;
            changed |= cblock->refresh_out();
            cblock->refresh_in();
            it++;
        }
    }
}

void complete_set_varnodes(set<Var_node*>* dustbin,
                           Code_block* cblock, VARNODE_MAP* vnmap)
{
    VARNODE_MAP::iterator vn_it;
    // harvest ins
    vn_it = vnmap->begin();
    while (vn_it != vnmap->end())
    {
        string name = vn_it->first;
        Var_node* tmn = vn_it->second->get_terminal_ptr();
        if (tmn != vn_it->second) // useless
        {
            dustbin->insert(vn_it->second); // put into dustbin
            vn_it->second = tmn; // change ptr
        }
        if (!cblock->has_live(name))
        {
            cblock->lives.insert(VARNODE_MAP::value_type
                                 (vn_it->first, vn_it->second)); // put into lives
        }
        vn_it++;
    }
}

void refresh_conflict(Code_block* cblock)
{
    VARNODE_MAP::iterator it = cblock->lives.begin();
    while (it != cblock->lives.end()) // varnodes
    {
        VARNODE_MAP::iterator conf_it = cblock->lives.begin();
        while (conf_it != cblock->lives.end()) // varnodes
        {
            if (conf_it != it) // not self
            {
                it->second->conflicts.insert(conf_it->second);
            }
            conf_it++;
        }
        var_graph.insert(it->second);
        // cout << it->second->name << endl;
        it++;
    }
}

// delete useless varnodes
// add
void complete_function_varnodes()
{
    //cout << funcname << endl;
    set<Var_node*> useless_vns;
    list<Code_block*>::iterator cb_it = cblock_list.begin();
    // put into lives | refresh conflict
    while (cb_it != cblock_list.end()) // code_blocks
    {
        Code_block* cblock = *cb_it;
        complete_set_varnodes(&useless_vns, cblock, &cblock->ins);
        complete_set_varnodes(&useless_vns, cblock, &cblock->outs);
        refresh_conflict(cblock);
        cblock->print_info();
        cb_it++;
    }
    // delete useless var_nodes
    set<Var_node*>::iterator useless_it = useless_vns.begin();
    while (useless_it != useless_vns.end())
    {
        delete(*useless_it);
        useless_it++;
    }
    useless_vns.clear();
}

void init_conflict_count()
{
    set<Var_node*>::iterator it = var_graph.begin();
    while (it != var_graph.end()) // go through var_graph
    {
        Var_node* vnode = *it;
        vnode->conf_count = vnode->conflicts.size(); // init conflict count
        //flog << "=============\n" << vnode->name
        //     << " " << vnode->conf_count << "\n=============\n" << endl;
        it++;
    }
}


// push vnode to stack, reduce conflict count of vnode in conflicts
void push_vnode_stack(set<Var_node*>::iterator it)
{
    Var_node* vnode = *it;
    // push stack
    var_stack.push_front(vnode);
    var_graph.erase(it);
    // reduce conflict count
    vnode->cut_conflicts();
}

// one term of trying push vnodes into stack as many as possible
bool repush_stack(int reg_max)
{
    bool put = false;
    set<Var_node*>::iterator it = var_graph.begin();
    while (it != var_graph.end())
    {
        Var_node* vnode = *it;
        if (vnode->conf_count < reg_max)
        {
            push_vnode_stack(it++);
            put = true;
        }
        else
        {
            it++;
        }
    }
    return put;
}

// @REQUIRES: var_graph not empty
// select one vnode which will not be distributed a reg
// could be optimize
void select_vnode_without_reg()
{
    Var_node* vnode_remove = *(var_graph.begin()); // select one
    // cout << "REMOVE: " << vnode_remove->name << endl;
    flog << "=============\n" << vnode_remove->name
         << "\t" << vnode_remove->conflicts.size() << "\t" << vnode_remove->regno << "\n=============\n" << endl;
    var_graph.erase(vnode_remove); // remove from graph
    vnode_remove->cut_conflicts();
}

void graph_to_stack(int reg_max)
{
    while (true)
    {
        bool put = true;
        do
        {
            put = repush_stack(reg_max);
        } while (put); // push as many as possible
        if (var_graph.empty())
        {
            break; // all moved to stack
        }
        else
        {
            select_vnode_without_reg();
        }
    }
}

void stack_reg_distri(int reg_max)
{
    list<Var_node*>::iterator it = var_stack.begin();
    while (it != var_stack.end())
    {
        Var_node* vnode = *it; // will be distributed with reg
        vnode->set_regno(reg_max);
        flog << "=============\n" << vnode->name
             << "\t" << vnode->conflicts.size() << "\t" << vnode->regno << "\n=============\n" << endl;
        it++;
    }
}

void reg_distri(int reg_max)
{
    init_conflict_count();
    graph_to_stack(reg_max);
    stack_reg_distri(reg_max);
}

void complete_function()
{
    finish_function_in_out();
    complete_function_varnodes();
    reg_distri(REG_MAX);
}


/*====================
|     functions      |
====================*/

bool has_code_block(string label)
{
    return (cblock_map_ptr->find(label) != cblock_map_ptr->end());
}

// redirect use/define information to file (debug)
void print_cblock_list_info()
{
    if (!DEBUG) return;
    list<Code_block*>::iterator it = cblock_list.begin();
    while (it != cblock_list.end())
    {
        Code_block* tcb = *it;
        tcb->print_info();
        it ++;
    }
}

void clear_graph()
{
    //cout << "funcname:" << cur_funcname << endl;
    if (cur_funcname != "")
    {
        //cout << cblock_list.size() << endl;
        func_cblock_map.insert(FUNC_CBLOCK_MAP::value_type(cur_funcname, cblock_map_ptr));
    }
    complete_function();
    cblock_list.clear();
    cblock_map_ptr = new CBLOCK_MAP;
    var_graph.clear();
    var_stack.clear();
}

void init_graph(string funcname)
{
    clear_graph();
    cur_funcname = funcname;
    temp_label_count = 0;
    first_term = true;
    string first_label_name = set_temp_label(); // output @label
    turn_next_block(first_label_name);  // create and set cur_cblock
}


// create & output & return temp label
string set_temp_label()
{
    stringstream ss;
    ss << temp_label_count++;
    MIPS_OUTPUT("@label " << ss.str());
    return ss.str();
}

// get cblock with label, if not exists, create one
Code_block* get_code_block(string label)
{
    if (has_code_block(label))
    {
        return (*cblock_map_ptr)[label];
    }
    else
    {
        Code_block* cb = new Code_block(label);
        (*cblock_map_ptr)[label] = cb;
        return cb;
    }
}

// set next and prev
void link_code_blocks(Code_block* prev, Code_block* next)
{
    prev->nexts.insert(next);
    next->prevs.insert(prev);
}

// get code_block with label & set cur_block & add to list
void turn_next_block(string label)
{
    cur_cblock = get_code_block(label);
    cblock_list.push_front(cur_cblock);
}


void livevar_read_medis()
{
    string line;
    while(getline(fin, line))
    {
        istringstream is(line);
        string str;
        vector<string> strs;
        while (is >> str)
        {
            strs.push_back(str);
        }
        MIPS_OUTPUT(line);

        if (strs[0] == "@var" || strs[0] == "@array")
        {

        }
        else if (strs[0] == "@para")
        {
        }
        else if (strs[0] == "@func")
        {
            init_graph(strs[1]);
        }
        else if (strs[0] == "@push")
        {
            cur_cblock->try_use(strs[1]);
        }
        else if (strs[0] == "@call")
        {
        }
        else if (strs[0] == "@get")
        {
            cur_cblock->try_def(strs[1]);
        }
        else if (strs[0] == "@ret")
        {
            if (strs.size() > 1)
            {
                cur_cblock->try_use(strs[1]);
            }
        }
        else if (strs[0] == "@be" || strs[0] == "@bne")
        {
            cur_cblock->try_use(strs[1]);
            cur_cblock->try_use(strs[2]);
            link_code_blocks(cur_cblock, get_code_block(strs[3]));
            string temp_label = set_temp_label();
            link_code_blocks(cur_cblock, get_code_block(temp_label));
            turn_next_block(temp_label);
        }
        else if (strs[0] == "@bz" || strs[0] == "@bgtz" || strs[0] == "@bltz" ||
                 strs[0] == "@blez" || strs[0] == "@bgez")
        {
            cur_cblock->try_use(strs[1]);
            link_code_blocks(cur_cblock, get_code_block(strs[2]));
            string temp_label = set_temp_label();
            link_code_blocks(cur_cblock, get_code_block(temp_label));
            turn_next_block(temp_label);
        }
        else if (strs[0] == "@j")
        {
            link_code_blocks(cur_cblock, get_code_block(strs[1]));
        }
        else if (strs[0] == "@jal")
        {
        }
        else if (strs[0] == "@printf")
        {
            if (strs[1] != "string")
            {
                cur_cblock->try_use(strs[2]);
            }
        }
        else if (strs[0] == "@scanf")
        {
            cur_cblock->try_def(strs[2]);
        }
        else if (strs[0] == "@exit") {}
        else if (strs[0] == "@free") {}
        else if (strs[1] == ":")
        {
            link_code_blocks(cur_cblock, get_code_block(strs[0]));
            turn_next_block(strs[0]);
        }
        else if (strs.size() == 3)
        {
            cur_cblock->try_use(strs[2]);
            cur_cblock->try_def(strs[0]);
        }
        else if (strs.size() == 5)
        {
            if (strs[3] != "ARGET")
            {
                cur_cblock->try_use(strs[2]);
            }
            cur_cblock->try_use(strs[4]);
            if (strs[3] != "ARSET")
            {
                cur_cblock->try_def(strs[0]);
            }
        }
        else
        {
            error_debug("cal len not 3 or 5 in livevar");
        }
    }
}

string livevar_main(string filename)
{
    fin.open(filename.c_str());
    string lv_filename = get_filename("LIVEVAR");
    fout.open(lv_filename.c_str());
    flog.open(get_logname().c_str());

    livevar_read_medis();
    clear_graph();

    flog.close();
    fout.close();
    fin.close();

    return lv_filename;
}
