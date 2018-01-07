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
# define DEBUG 1
# if DEBUG
# define MIPS_LEFT cout << "<==="
# define MIPS_RIGHT "===>" << endl
# else
# define MIPS_LEFT fout
# define MIPS_RIGHT endl
# endif // DEBUG
# define MIPS_OUTPUT(x) ;
# define IS_VAR(name) (name[0] == '_' || (name[0] >= 'a' && name[0] <= 'z'))

using namespace std;

typedef map<string, Code_block*> CBLOCK_MAP;
typedef map<string, list<Code_block*> > CBLOCK_LIST_MAP;
typedef map<string, Var_node*> VARNODE_MAP;
CBLOCK_LIST_MAP cblock_list_map;

list<Code_block*> cblock_list;
CBLOCK_MAP cblock_map;
Code_block* cur_cblock;
string cur_funcname = "";
int temp_label_count = 0;
bool first_term = true;
set<Var_node*> var_graph;
list<Var_node*> var_stack;


/*====================
|     Code_block     |
====================*/

void Code_block::print_info()
{
    fout << "label:" << this->label << endl;

    set<string>::iterator it;

    it = this->uses.begin();
    fout << "uses:" << endl;
    while (it != this->uses.end())
    {
        fout << *it << " ";
        it++;
    }

    fout <<endl;

    it = this->defs.begin();
    fout << "defs:" << endl;
    while (it != this->defs.end())
    {
        fout << *it << " ";
        it++;
    }
    fout <<endl;

    VARNODE_MAP::iterator map_it;

    map_it = this->lives.begin();
    fout << "lives:" << endl;
    while (map_it != this->lives.end())
    {
        fout << map_it->first << " ";
        map_it++;
    }
    fout <<endl;

    map_it = this->ins.begin();
    fout << "in:" << endl;
    while (map_it != this->ins.end())
    {
        fout << map_it->first << " ";
        map_it++;
    }
    fout <<endl;

    map_it = this->outs.begin();
    fout << "out:" << endl;
    while (map_it != this->outs.end())
    {
        fout << map_it->first << " ";
        map_it++;
    }
    fout <<endl;

    fout <<endl;
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
    if (IS_VAR(name) && !has_def(name))
    {
        this->uses.insert(name);
    }
}

void Code_block::try_def(string name)
{
    if (IS_VAR(name) && !has_use(name))
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
    int i = 0;
    while (cblock_it != this->nexts.end()) // nexts
    {
        cout << i;
        i++;
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

/*====================
|     in / out       |
====================*/

void finish_function_in_out(string funcname)
{
    bool changed = true;
    while (changed) // term
    {
        changed = false;
        //cout << cblock_list_map[funcname].size() << endl;
        list<Code_block*>::iterator it = cblock_list_map[funcname].begin();
        while (it != cblock_list_map[funcname].end()) // code_blocks
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
void complete_function_varnodes(string funcname)
{
    //cout << funcname << endl;
    set<Var_node*> useless_vns;
    list<Code_block*>::iterator cb_it = cblock_list_map[funcname].begin();
    // put into lives | refresh conflict
    while (cb_it != cblock_list_map[funcname].end()) // code_blocks
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

void reg_distri(string funcname)
{
    set<Var_node*>::iterator it = var_graph.begin();
    while (it != var_graph.end())
    {
        Var_node* vnode = *it;
        vnode->conf_count = vnode->conflicts.size(); // init conflict count
        if (DEBUG) fout << "=============\n" << vnode->name << " " << vnode->conf_count << "\n=============\n" << endl;
        it++;
    }
}

void complete_function(string funcname)
{
    finish_function_in_out(funcname);
    complete_function_varnodes(funcname);
    reg_distri(funcname);
}

void complete_functions()
{
    CBLOCK_LIST_MAP::iterator it = cblock_list_map.begin();
    while (it != cblock_list_map.end())
    {
        complete_function(it->first);
    }
}


/*====================
|     functions      |
====================*/

bool has_code_block(string label)
{
    return (cblock_map.find(label) != cblock_map.end());
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
        cblock_list_map.insert(CBLOCK_LIST_MAP::value_type(cur_funcname, cblock_list));
    }
    complete_function(cur_funcname);
    cblock_list.clear();
    cblock_map.clear();
    var_graph.clear();
    if (var_stack.size() != 0)
    {
        error_debug("stack not clear!");
    }
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
        return cblock_map[label];
    }
    else
    {
        Code_block* cb = new Code_block(label);
        cblock_map[label] = cb;
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
        else if (strs[0] == "@be")
        {
            cur_cblock->try_use(strs[1]);
            cur_cblock->try_use(strs[2]);
            link_code_blocks(cur_cblock, get_code_block(strs[3]));
            string temp_label = set_temp_label();
            link_code_blocks(cur_cblock, get_code_block(temp_label));
            turn_next_block(temp_label);
        }
        else if (strs[0] == "@bz")
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
        else if (strs[0] == "@exit")
        {
        }
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
    fin.open((filename + ".txt").c_str());
    string ass_filename = filename + "_LIVEVAR";
    fout.open((ass_filename + ".txt").c_str());

    livevar_read_medis();
    clear_graph();

    fout.close();
    fin.close();

    return ass_filename;
}
